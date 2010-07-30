From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 16481] New: WARNING: Unbalanced enable for IRQ 19
Date: Fri, 30 Jul 2010 00:01:16 GMT
Message-ID: <bug-16481-11633@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from demeter.kernel.org ([140.211.167.39]:56945 "EHLO
	demeter.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755295Ab0G3ABR (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 29 Jul 2010 20:01:17 -0400
Received: from demeter.kernel.org (localhost.localdomain [127.0.0.1])
	by demeter.kernel.org (8.14.4/8.14.3) with ESMTP id o6U01GAR019999
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-ide@vger.kernel.org>; Fri, 30 Jul 2010 00:01:16 GMT
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=16481

           Summary: WARNING: Unbalanced enable for IRQ 19
           Product: IO/Storage
           Version: 2.5
    Kernel Version: 2.6.35-rc5
          Platform: All
        OS/Version: Linux
              Tree: Mainline
            Status: NEW
          Severity: low
          Priority: P1
         Component: IDE
        AssignedTo: io_ide@kernel-bugs.osdl.org
        ReportedBy: jan-kb@goneko.de
        Regression: No


This warning isn't new, and I don't get it on every boot.  See
http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=590327 for some more info.

2.6.35-rc5-amd64 (Debian 2.6.35~rc5-1~experimental.1):
[    1.572006] ------------[ cut here ]------------
[    1.572042] WARNING: at
/build/buildd-linux-2.6_2.6.35~rc5-1~experimental.1-i386-gQzGH6/linux-2.6-2.6.35~rc5/debian/build/source_i386_none/kernel/irq/manage.c:290
enable_irq+0x3e/0x64()
[    1.572085] Hardware name: EP45T-EXTREME 
[    1.572115] Unbalanced enable for IRQ 19 
[    1.572144] Modules linked in: hid uhci_hcd ahci libahci sym53c8xx(+)
scsi_transport_spi libata e1000(+) it8213(+) firewire_ohci firewire_core
crc_itu_t scsi_mod ide_core r8169 mii ehci_hcd thermal thermal_sys igb dca
usbcore nls_base
[    1.572731] Pid: 209, comm: modprobe Not tainted 2.6.35-rc5-amd64 #1
[    1.572759] Call Trace:
[    1.572788]  [<ffffffff810441f3>] ? warn_slowpath_common+0x78/0x8c
[    1.572817]  [<ffffffff810442a6>] ? warn_slowpath_fmt+0x45/0x4a
[    1.572850]  [<ffffffffa001e388>] ? do_probe+0x1ce/0x1ea [ide_core]
[    1.572879]  [<ffffffff8108be75>] ? enable_irq+0x3e/0x64
[    1.572910]  [<ffffffffa001e900>] ? ide_probe_port+0x55c/0x589 [ide_core]
[    1.572942]  [<ffffffffa001ef1a>] ? ide_host_register+0x273/0x60f [ide_core]
[    1.572974]  [<ffffffffa002300d>] ? ide_pci_init_two+0x5b6/0x680 [ide_core]
[    1.573004]  [<ffffffff8118222c>] ? idr_get_empty_slot+0x16a/0x250
[    1.573033]  [<ffffffff81036ad8>] ? update_curr+0xb1/0x159
[    1.573062]  [<ffffffff8118222c>] ? idr_get_empty_slot+0x16a/0x250
[    1.573090]  [<ffffffff8118240b>] ? ida_get_new_above+0xf9/0x1b7 
[    1.573120]  [<ffffffff811374ca>] ? sysfs_find_dirent+0x2f/0x44
[    1.573148]  [<ffffffff81137eb6>] ? sysfs_addrm_finish+0x29/0xb8 
[    1.573178]  [<ffffffff81198181>] ? local_pci_probe+0x12/0x16
[    1.573206]  [<ffffffff81198f70>] ? pci_device_probe+0xc2/0xef 
[    1.573236]  [<ffffffff8121c1ea>] ? driver_sysfs_add+0x42/0x69 
[    1.573264]  [<ffffffff8121c32b>] ? driver_probe_device+0xa8/0x138
[    1.573292]  [<ffffffff8121c40a>] ? __driver_attach+0x4f/0x6f
[    1.573321]  [<ffffffff8121c3bb>] ? __driver_attach+0x0/0x6f
[    1.573349]  [<ffffffff8121b9d8>] ? bus_for_each_dev+0x44/0x78 
[    1.573377]  [<ffffffff8121be30>] ? bus_add_driver+0xa8/0x1f0
[    1.573406]  [<ffffffff8121c6b1>] ? driver_register+0x90/0xf8
[    1.573434]  [<ffffffff811991ba>] ? __pci_register_driver+0x4e/0xbe
[    1.573464]  [<ffffffff8105f283>] ? __blocking_notifier_call_chain+0x58/0x63
[    1.573493]  [<ffffffffa0079000>] ? it8213_ide_init+0x0/0x20 [it8213]
[    1.573523]  [<ffffffff81002064>] ? do_one_initcall+0x63/0x175 
[    1.573552]  [<ffffffff8107086e>] ? sys_init_module+0x97/0x1d5 
[    1.573581]  [<ffffffff81031342>] ? ia32_sysret+0x0/0x5
[    1.573609] ---[ end trace 45eb7d0c4325a91a ]---
[    1.573661] hda: host max PIO4 wanted PIO255(auto-tune) selected PIO4
[    1.573808] hda: UDMA/100 mode selected
[    1.574046] ide0 at 0xd200-0xd207,0xd302 on irq 19

-- 
Configure bugmail: https://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are watching the assignee of the bug.
