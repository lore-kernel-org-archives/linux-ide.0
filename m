From: bugme-daemon@bugzilla.kernel.org
Subject: [Bug 10943] machine doesn't shutdown when ahci sata driver is compiled as module
Date: Fri,  8 Aug 2008 10:30:45 -0700 (PDT)
Message-ID: <20080808173045.BD67711D109@picon.linux-foundation.org>
References: <bug-10943-11633@http.bugzilla.kernel.org/>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:42495 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751008AbYHHRbQ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 8 Aug 2008 13:31:16 -0400
Received: from picon.linux-foundation.org (picon.linux-foundation.org [140.211.169.79])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m78HUj7J008115
	for <linux-ide@vger.kernel.org>; Fri, 8 Aug 2008 10:30:46 -0700
In-Reply-To: <bug-10943-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=10943





------- Comment #17 from gfpadovan@gmail.com  2008-08-08 10:30 -------
Look! There is an error on device_add for sd 0:0:0:0:
This was on the first dmesg I put here. I don't know what this error means.

[    8.954419] sd 0:0:0:0:  dev=f70d4284 prev=f70ada90 next=f70ada90
[    8.954434] ------------[ cut here ]------------
[    8.954437] WARNING: at fs/sysfs/dir.c:463 sysfs_add_one+0x27/0x2f()
[    8.954440] sysfs: duplicate filename '0:0:0:0' can not be created
[    8.954443] Modules linked in: tg3 libphy e1000 xfs jfs raid10 raid456
async_memcpy async_xor xor async_tx raid1 rai
d0 dm_snapshot dm_mirror dm_log dm_mod scsi_wait_scan pdc_adma ata_piix ahci
sata_qstor sata_vsc sata_uli sata_sis sata
_sx4 sata_nv sata_via sata_svw sata_sil24 sata_sil sata_promise pata_sl82c105
pata_cs5535 pata_cs5520 pata_via pata_mar
vell pata_sis pata_netcell pata_sc1200 pata_triflex pata_ali pcmcia_core
pata_efar pata_rz1000 pata_sil680 pata_pdc2027
x pata_mpiix sbp2 ohci1394 ieee1394 sl811_hcd
[    8.954500] Pid: 6280, comm: scsi_scan_0 Not tainted 2.6.27-rc1 #48
[    8.954505]  [<c011db96>] warn_slowpath+0x61/0x84
[    8.954512]  [<c02e4456>] scsi_device_dev_release_usercontext+0x129/0x13f
[    8.954519]  [<c012adde>] execute_in_process_context+0x16/0x38
[    8.954524]  [<c02bd462>] device_release+0x31/0x4d
[    8.954530]  [<c0260461>] kobject_release+0x3c/0x4e
[    8.954536]  [<c0260425>] kobject_release+0x0/0x4e
[    8.954540]  [<c025fb02>] idr_get_empty_slot+0x129/0x206
[    8.954545]  [<c025fcc0>] ida_get_new_above+0xe1/0x162
[    8.954550]  [<c01a43ab>] sysfs_ilookup_test+0x0/0xd
[    8.954555]  [<c017a1f5>] ifind+0x22/0x74
[    8.954559]  [<c017a241>] ifind+0x6e/0x74
[    8.954563]  [<c01a45bb>] sysfs_find_dirent+0x13/0x23
[    8.954567]  [<c01a464e>] sysfs_add_one+0x27/0x2f
[    8.954572]  [<c01a4aa4>] create_dir+0x3c/0x6c
[    8.954576]  [<c01a4afd>] sysfs_create_dir+0x29/0x3b
[    8.954580]  [<c0260482>] kobject_get+0xf/0x13
[    8.954584]  [<c026058d>] kobject_add_internal+0xb1/0x14a
[    8.954589]  [<c026090f>] kobject_add+0x4a/0x4e
[    8.954594]  [<c02bdb23>] device_add+0xa3/0x525
[    8.954598]  [<c02c13b6>] attribute_container_device_trigger+0x81/0x89
[    8.954604]  [<c02e320c>] scsi_scan_host_selected+0xaa/0xdf
[    8.954608]  [<c0260482>] kobject_get+0xf/0x13
[    8.954613]  [<c02e40fd>] scsi_sysfs_add_sdev+0x96/0x1a9
[    8.954617]  [<c02e3303>] do_scan_async+0x6c/0x127
[    8.954622]  [<c02e3297>] do_scan_async+0x0/0x127
[    8.954626]  [<c012d0cc>] kthread+0x38/0x60
[    8.954631]  [<c012d094>] kthread+0x0/0x60
[    8.954635]  [<c01037df>] kernel_thread_helper+0x7/0x10
[    8.954640]  =======================
[    8.954643] ---[ end trace fb7e35af3b626296 ]---
[    8.954647] kobject_add_internal failed for 0:0:0:0 with -EEXIST, don't try
to register things with the same name in the same directory.
[    8.954652] Pid: 6280, comm: scsi_scan_0 Tainted: G        W 2.6.27-rc1 #48
[    8.954655]  [<c02605f0>] kobject_add_internal+0x114/0x14a
[    8.954660]  [<c026090f>] kobject_add+0x4a/0x4e
[    8.954664]  [<c02bdb23>] device_add+0xa3/0x525
[    8.954668]  [<c02c13b6>] attribute_container_device_trigger+0x81/0x89
[    8.954673]  [<c02e320c>] scsi_scan_host_selected+0xaa/0xdf
[    8.954677]  [<c0260482>] kobject_get+0xf/0x13
[    8.954682]  [<c02e40fd>] scsi_sysfs_add_sdev+0x96/0x1a9
[    8.954686]  [<c02e3303>] do_scan_async+0x6c/0x127
[    8.954690]  [<c02e3297>] do_scan_async+0x0/0x127
[    8.954694]  [<c012d0cc>] kthread+0x38/0x60
[    8.954698]  [<c012d094>] kthread+0x0/0x60
[    8.954702]  [<c01037df>] kernel_thread_helper+0x7/0x10
[    8.954707]  =======================
[    8.954709] error 1
[    9.097510] kjournald starting.  Commit interval 5 seconds
[    9.097529] EXT3-fs: mounted filesystem with ordered data mode.
[   11.947144] sd 0:0:0:0: Attached scsi generic sg0 type 0


-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are on the CC list for the bug, or are watching someone who is.
