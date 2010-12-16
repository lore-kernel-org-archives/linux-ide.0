From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 16481] WARNING: Unbalanced enable for IRQ 19
Date: Thu, 16 Dec 2010 20:39:54 GMT
Message-ID: <201012162039.oBGKdsk6023539@demeter2.kernel.org>
References: <bug-16481-11633@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from demeter2.kernel.org ([140.211.167.42]:43300 "EHLO
	demeter2.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755423Ab0LPUjz (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 16 Dec 2010 15:39:55 -0500
Received: from demeter2.kernel.org (localhost.localdomain [127.0.0.1])
	by demeter2.kernel.org (8.14.4/8.14.3) with ESMTP id oBGKdsFa023540
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-ide@vger.kernel.org>; Thu, 16 Dec 2010 20:39:54 GMT
In-Reply-To: <bug-16481-11633@https.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=16481





--- Comment #1 from Daniel Smolik <marvin@mydatex.cz>  2010-12-16 20:39:53 ---
 4.003160] ------------[ cut here ]------------
[    4.003171] WARNING: at kernel/irq/manage.c:290 __enable_irq+0x2f/0x55()
[    4.003174] Hardware name: P55A-UD3
[    4.003176] Unbalanced enable for IRQ 19
[    4.003179] Modules linked in: snd_hda_codec_nvhdmi snd_hda_codec_realtek
snd_hda_intel snd_hda_codec nouveau snd_hwdep snd_pcm ttm option snd_timer
usb_wwan snd usbserial drm_kms_helper r8169 xhci_hcd drm uhci_hcd it8213(+)
parport_pc mii ide_core soundcore snd_page_alloc ehci_hcd usbcore tpm_tis
i2c_algo_bit video parport tpm output tpm_bios evdev i2c_i801 pcspkr i2c_core
shpchp nls_base processor button pci_hotplug ext4 mbcache jbd2 crc16 sd_mod
crc_t10dif ahci libahci libata scsi_mod thermal thermal_sys
[    4.003230] Pid: 496, comm: modprobe Not tainted 2.6.36.2 #1
[    4.003233] Call Trace:
[    4.003239]  [<c1034bad>] ? warn_slowpath_common+0x6a/0x7b
[    4.003245]  [<c107314d>] ? __enable_irq+0x2f/0x55
[    4.003250]  [<c1034c24>] ? warn_slowpath_fmt+0x28/0x2c
[    4.003255]  [<c107314d>] ? __enable_irq+0x2f/0x55
[    4.003259]  [<c1073415>] ? enable_irq+0x31/0x4c
[    4.003270]  [<fb915145>] ? ide_probe_port+0x4b7/0x4de [ide_core]
[    4.003280]  [<fb915641>] ? ide_host_register+0x204/0x4e7 [ide_core]
[    4.003290]  [<fb918f0b>] ? ide_pci_init_two+0x4b6/0x560 [ide_core]
[    4.003298]  [<c1019b31>] ? native_smp_send_reschedule+0x3a/0x3b
[    4.003303]  [<c1027abf>] ? resched_task+0x56/0x58
[    4.003312]  [<c113b340>] ? idr_get_empty_slot+0x149/0x217
[    4.003314]  [<c113b340>] ? idr_get_empty_slot+0x149/0x217
[    4.003316]  [<c113b4df>] ? ida_get_new_above+0xd1/0x16c
[    4.003319]  [<c10fd8a6>] ? sysfs_find_dirent+0x25/0x36
[    4.003322]  [<c11caf09>] ? __pm_runtime_set_status+0x134/0x14c
[    4.003326]  [<fb918fbf>] ? ide_pci_init_one+0xa/0xc [ide_core]
[    4.003328]  [<c114d4ee>] ? local_pci_probe+0x34/0x74
[    4.003330]  [<c114def1>] ? pci_device_probe+0x41/0x63
[    4.003333]  [<c11c6464>] ? driver_probe_device+0x8c/0x110
[    4.003335]  [<c11c6528>] ? __driver_attach+0x40/0x5b
[    4.003337]  [<c11c5cc5>] ? bus_for_each_dev+0x37/0x5f
[    4.003339]  [<c11c631a>] ? driver_attach+0x11/0x13
[    4.003340]  [<c11c64e8>] ? __driver_attach+0x0/0x5b
[    4.003342]  [<c11c6040>] ? bus_add_driver+0x87/0x1bb
[    4.003344]  [<c113bf94>] ? kset_find_obj+0x20/0x4a
[    4.003347]  [<fc59e000>] ? it8213_ide_init+0x0/0x14 [it8213]
[    4.003349]  [<c11c6744>] ? driver_register+0x7a/0xd9
[    4.003351]  [<fc59e000>] ? it8213_ide_init+0x0/0x14 [it8213]
[    4.003353]  [<c114e0bc>] ? __pci_register_driver+0x33/0x89
[    4.003355]  [<fc59e000>] ? it8213_ide_init+0x0/0x14 [it8213]
[    4.003357]  [<c1003069>] ? do_one_initcall+0x68/0x10f
[    4.003360]  [<c105d5e5>] ? sys_init_module+0xc86/0xe15
[    4.003365]  [<c100845f>] ? sysenter_do_call+0x12/0x28
[    4.003366] ---[ end trace ac817a1ed0b76f1f ]---

-- 
Configure bugmail: https://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are watching the assignee of the bug.
