From: bugme-daemon@bugzilla.kernel.org
Subject: [Bug 9728] New: Serverworks initialisation fails
Date: Thu, 10 Jan 2008 17:59:51 -0800 (PST)
Message-ID: <bug-9728-11633@http.bugzilla.kernel.org/>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp2.linux-foundation.org ([207.189.120.14]:40807 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751746AbYAKB7x (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 10 Jan 2008 20:59:53 -0500
Received: from picon.linux-foundation.org (picon.linux-foundation.org [207.189.120.79])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m0B1xpdR008198
	for <linux-ide@vger.kernel.org>; Thu, 10 Jan 2008 17:59:52 -0800
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=9728

           Summary: Serverworks initialisation fails
           Product: IO/Storage
           Version: 2.5
     KernelVersion: 2.6.24-rc7-g88fb61e4
          Platform: All
        OS/Version: Linux
              Tree: Mainline
            Status: NEW
          Severity: blocking
          Priority: P1
         Component: IDE
        AssignedTo: io_ide@kernel-bugs.osdl.org
        ReportedBy: trond.myklebust@fys.uio.no
        Regression: 1


Latest working kernel version: 2.6.24-rc7
Earliest failing kernel version: 2.6.24-rc7-g88fb61e4
Distribution: Fedora Core 7
Hardware Environment: Dell PowerEdge 2650
Software Environment:
Problem Description:

Oops when starting udev...

Starting udev: BUG: unable to handle kernel paging request at virtual address
2d6d3a65
printing eip: c04e1af1 *pde = 00000000 
Oops: 0000 [#1] PREEMPT SMP 
Modules linked in: evdev evbug rtc_cmos pcspkr floppy rtc_core rtc_lib shpchp
pci_hotplug serverworks tg3 generic i2c_piix4 i2c_core

Pid: 1820, comm: modprobe Not tainted (2.6.24-rc7-g88fb61e4 #2)
EIP: 0060:[<c04e1af1>] EFLAGS: 00210286 CPU: 0
EIP is at strstr+0x11/0x34
EAX: 00000000 EBX: 2d6d3a65 ECX: ffffffff EDX: 2d6d3a65
ESI: c0513f75 EDI: 2d6d3a65 EBP: f65bccec ESP: f65bcce0
 DS: 007b ES: 007b FS: 00d8 GS: 0033 SS: 0068
Process modprobe (pid: 1820, ti=f65bc000 task=f795a2f0 task.ti=f65bc000)
Stack: f8921a44 00000001 00000000 f65bcd00 c054a0b9 f892e394 f892e080 f892e5f8 
       f65bcd20 f892133b c04d7c9d f892da80 f891d339 f892e394 f892e080 f892e5f8 
       f65bcd64 f891d11f f891d339 f891bc38 f892e080 00000000 00000001 00000000 
Call Trace:
 [<c0405170>] show_trace_log_lvl+0x1a/0x2f
 [<c0405222>] show_stack_log_lvl+0x9d/0xa5
 [<c04052cd>] show_registers+0xa3/0x1df
 [<c040552a>] die+0x121/0x204
 [<c05b40dd>] do_page_fault+0x557/0x63e
 [<c05b278a>] error_code+0x72/0x78
 [<c054a0b9>] dmi_check_system+0x2f/0x58
 [<f892133b>] ide_acpi_init+0x28/0x195 [ide_core]
 [<f891d11f>] hwif_init+0x324/0x37c [ide_core]
 [<f891d29a>] ide_device_add+0x3b/0xa6 [ide_core]
 [<f891ee9a>] ide_setup_pci_device+0x36/0x40 [ide_core]
 [<f885f11c>] svwks_init_one+0x5b/0x62 [serverworks]
 [<c04eada1>] pci_device_probe+0x39/0x5b
 [<c05369a8>] driver_probe_device+0xe9/0x16a
 [<c0536b43>] __driver_attach+0x6c/0xa5
 [<c0535e92>] bus_for_each_dev+0x36/0x5b
 [<c05367f3>] driver_attach+0x19/0x1b
 [<c05361b1>] bus_add_driver+0x73/0x1aa
 [<c0536d29>] driver_register+0x67/0x6c
 [<c04eaef9>] __pci_register_driver+0x56/0x83
 [<f890f017>] svwks_ide_init+0x17/0x19 [serverworks]
 [<c0447f1e>] sys_init_module+0x15da/0x1715
 [<c04040b2>] sysenter_past_esp+0x5f/0xa5
 =======================
Code: e5 89 c1 89 c8 eb 06 80 38 00 74 07 40 4a 83 fa ff 75 f4 29 c8 5d c3 90
90 90 55 89 e5 57 56 53 89 c6 89 d3 31 c0 83 c9 ff 89 
EIP: [<c04e1af1>] strstr+0x11/0x34 SS:ESP 0068:f65bcce0
---[ end trace f0316f13333e9ff3 ]---
udevd-event[1819]: run_program: '/sbin/modprobe' abnormal exit


Steps to reproduce: Just boot...


-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are the assignee for the bug, or are watching the assignee.
