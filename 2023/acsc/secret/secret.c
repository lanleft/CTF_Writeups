#include <linux/module.h>
#include <linux/kernel.h>
#include <linux/cdev.h>
#include <linux/fs.h>
#include <linux/uaccess.h>
#include <linux/slab.h>

#define DEVICE_NAME "secret"
#define CMD_ADD 0x01C029
#define CMD_GET 0x01C07b
#define CMD_SET 0x01C082
#define CMD_DEL 0x01C087

MODULE_LICENSE("GPL");
MODULE_AUTHOR("ptr-yudai");
MODULE_DESCRIPTION("ACSC 2023");

struct root_t {
  struct mutex mutex;
  u64 item_cnt;
  struct node_t *top;
};

struct node_t {
  struct node_t *next;
  u64 value;
  u64 key;
};

struct request_t {
  u64 value;
  u64 key;
};

/**
 * Open this driver
 */
static int module_open(struct inode *inode, struct file *filp)
{
  /* Allocate the root */
  struct root_t *root = kmalloc(sizeof(struct root_t), GFP_KERNEL);
  if (!root) return -ENOMEM;

  mutex_init(&root->mutex);
  root->item_cnt = 0;

  filp->private_data = (void*)root;
  return 0;
}

/**
 * Handle ioctl request
 */
static long module_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
{
  struct request_t req;
  long ret = 0;
  u64 i = 0;

  struct root_t *root = (struct root_t*)filp->private_data;
  mutex_lock(&root->mutex);

  /* Get request from user */
  if (copy_from_user(&req, (void*)arg, sizeof(req))) {
    ret = -EINVAL;
    goto out;
  }

  switch (cmd) {
    case CMD_ADD: {
      /* Allocate a node */
      struct node_t *new;
      if (!(new = (struct node_t*)kmalloc(sizeof(struct node_t), GFP_KERNEL))) {
        ret = -ENOMEM;
        goto out;
      }

      /* Set a secret key */
      root->item_cnt++;
      get_random_bytes(&new->key, sizeof(new->key));
      new->value = req.value ^ new->key;

      /* Return the key and encrypted value */
      req.value = new->value;
      req.key   = new->key;
      if (copy_to_user((void*)arg, &req, sizeof(req))) {
        kfree(new);
        ret = -EINVAL;
        goto out;
      }

      /* Insert this node */
      new->next = root->top;
      root->top = new;
      break;
    }

    case CMD_GET: {
      /* Find the node by key */
      struct node_t *cur = root->top;
      for (i = 0; i < root->item_cnt; i++) {
        if (cur->key == req.key) break;
        cur = cur->next;
      }
      if (i == root->item_cnt) {
        ret = -EACCES;
        goto out;
      }

      /* Return the decrypted value */
      req.value = cur->value ^ cur->key;
      if (copy_to_user((void*)arg, &req, sizeof(req))) {
        ret = -EINVAL;
        goto out;
      }
      break;
    }

    case CMD_SET: {
      /* Find the node by key */
      struct node_t *cur = root->top;
      for (i = 0; i < root->item_cnt; i++) {
        if (cur->key == req.key) break;
        cur = cur->next;
      }
      if (i == root->item_cnt) {
        ret = -EACCES;
        goto out;
      }

      /* Update key and value */
      get_random_bytes(&cur->key, sizeof(cur->key));
      cur->value = req.value ^ cur->key;

      /* Return the key and encrypted value */
      req.value = cur->value;
      req.key   = cur->key;
      if (copy_to_user((void*)arg, &req, sizeof(req))) {
        ret = -EINVAL;
        goto out;
      }
      break;
    }

    case CMD_DEL: {
      /* Find the node by key */
      struct node_t *prev = NULL, *cur = root->top;
      for (i = 0; i < root->item_cnt; i++) {
        if (cur->key == req.key) break;
        prev = cur;
        cur = cur->next;
      }
      if (i == root->item_cnt) {
        ret = -EACCES;
        goto out;
      }

      /* Delete this node */
      if (prev == NULL) {
        root->top = cur->next;
      } else {
        prev->next = cur->next;
      }
      kfree(cur);
      root->item_cnt--;
    }
  }

 out:
  mutex_unlock(&root->mutex);
  return ret;
}

/**
 * Close this driver
 */
static int module_close(struct inode *inode, struct file *filp)
{
  struct root_t *root = (struct root_t*)filp->private_data;
  struct node_t *cur = root->top;
  mutex_lock(&root->mutex);

  for (u64 i = 0; i < root->item_cnt; i++) {
    struct node_t *t = cur;
    cur = cur->next;
    kfree(t);
  }

  kfree(root);
  return 0;
}

static struct file_operations module_fops = {
  .owner = THIS_MODULE,
  .unlocked_ioctl = module_ioctl,
  .open = module_open,
  .release = module_close,
};

static dev_t dev_id;
static struct cdev c_dev;

static int __init module_initialize(void)
{
  if (alloc_chrdev_region(&dev_id, 0, 1, DEVICE_NAME))
    return -EBUSY;

  cdev_init(&c_dev, &module_fops);
  c_dev.owner = THIS_MODULE;

  if (cdev_add(&c_dev, dev_id, 1)) {
    unregister_chrdev_region(dev_id, 1);
    return -EBUSY;
  }

  return 0;
}

static void __exit module_cleanup(void)
{
  cdev_del(&c_dev);
  unregister_chrdev_region(dev_id, 1);
}

module_init(module_initialize);
module_exit(module_cleanup);
