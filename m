From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 49151] NULL pointer dereference in pata_acpi
Date: Mon, 22 Oct 2012 12:15:50 +0000 (UTC)
Message-ID: <20121022121550.599BF11FAE0@bugzilla.kernel.org>
References: <bug-49151-11633@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:56525 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751451Ab2JVMP4 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 22 Oct 2012 08:15:56 -0400
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id F1C6720267
	for <linux-ide@vger.kernel.org>; Mon, 22 Oct 2012 12:15:54 +0000 (UTC)
Received: from bugzilla.kernel.org (bugzilla.kernel.org [198.145.19.217])
	by mail.kernel.org (Postfix) with ESMTP id 07A2420257
	for <linux-ide@vger.kernel.org>; Mon, 22 Oct 2012 12:15:53 +0000 (UTC)
In-Reply-To: <bug-49151-11633@https.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=49151


Anton Boyarshinov <boyarsh@altlinux.org> changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |boyarsh@altlinux.org




--- Comment #6 from Anton Boyarshinov <boyarsh@altlinux.org>  2012-10-22 12:15:50 ---
Thank you for responce!
There is a log with both patches applied. System boots and works.
-------------------------
[    1.108357] ata3: PATA max UDMA/133 cmd 0xf80 ctl 0xf00 bmdma 0xb800 irq 21
[    1.108363] ata4: PATA max UDMA/133 cmd 0xe80 ctl 0xe00 bmdma 0xb808 irq 21
[    1.264255] ------------[ cut here ]------------
[    1.264303] WARNING: at drivers/ata/libata-core.c:2928
ata_timing_find_mode+0x6a/0x80 [libata]()
[    1.264307] Hardware name: ATLANT \xffffffd52 4800/251
[    1.264312] ata_timing_find_mode: unable to find timing for xfer_mode 0x0
[    1.264315] Modules linked in: ahci libahci pata_acpi libata scsi_mod
[    1.264332] Pid: 547, comm: scsi_eh_2 Not tainted 3.6.3-un-def-alt1 #1
[    1.264336] Call Trace:
[    1.264353]  [<ffffffff81059b2a>] warn_slowpath_common+0x7a/0xb0
[    1.264361]  [<ffffffff81059c01>] warn_slowpath_fmt+0x41/0x50
[    1.264380]  [<ffffffffa0097b4a>] ata_timing_find_mode+0x6a/0x80 [libata]
[    1.264391]  [<ffffffffa0037282>] pacpi_set_dmamode+0x42/0xf0 [pata_acpi]
[    1.264401]  [<ffffffffa00373fa>] pacpi_qc_issue+0x5a/0x7c [pata_acpi]
[    1.264421]  [<ffffffffa00997af>] ata_qc_issue+0x1ff/0x370 [libata]
[    1.264433]  [<ffffffff81047e73>] ? default_spin_lock_flags+0x13/0x20
[    1.264453]  [<ffffffffa0099c61>] ata_exec_internal_sg+0x341/0x640 [libata]
[    1.264475]  [<ffffffffa00aaf27>] ? ata_sff_dev_classify+0x67/0x110 [libata]
[    1.264494]  [<ffffffffa0099fd4>] ata_exec_internal+0x74/0xb0 [libata]
[    1.264514]  [<ffffffffa00ab450>] ? ata_sff_wait_after_reset+0x140/0x140
[libata]
[    1.264533]  [<ffffffffa009a0b5>] ata_do_dev_read_id+0x25/0x30 [libata]
[    1.264553]  [<ffffffffa00a5d8c>] ? ata_eh_reset+0x24c/0xc80 [libata]
[    1.264571]  [<ffffffffa009a3e4>] ata_dev_read_id+0x324/0x5a0 [libata]
[    1.264590]  [<ffffffffa00ab450>] ? ata_sff_wait_after_reset+0x140/0x140
[libata]
[    1.264599]  [<ffffffff81047e73>] ? default_spin_lock_flags+0x13/0x20
[    1.264619]  [<ffffffffa00a7164>] ata_eh_recover+0x824/0x13e0 [libata]
[    1.264629]  [<ffffffff810993e1>] ? load_balance+0x611/0x8c0
[    1.264649]  [<ffffffffa00aae20>] ? ata_sff_drain_fifo+0x80/0x80 [libata]
[    1.264668]  [<ffffffffa00ab450>] ? ata_sff_wait_after_reset+0x140/0x140
[libata]
[    1.264677]  [<ffffffffa00371c0>] ? pacpi_port_start+0xa0/0xa0 [pata_acpi]
[    1.264687]  [<ffffffff814acf39>] ? _raw_spin_lock_irq+0x39/0x50
[    1.264696]  [<ffffffff810789cb>] ? wait_on_work+0x1fb/0x210
[    1.264705]  [<ffffffffa00371c0>] ? pacpi_port_start+0xa0/0xa0 [pata_acpi]
[    1.264724]  [<ffffffffa00ab450>] ? ata_sff_wait_after_reset+0x140/0x140
[libata]
[    1.264744]  [<ffffffffa00a869d>] ata_do_eh+0x4d/0xc0 [libata]
[    1.264763]  [<ffffffffa00aae20>] ? ata_sff_drain_fifo+0x80/0x80 [libata]
[    1.264782]  [<ffffffffa00ab450>] ? ata_sff_wait_after_reset+0x140/0x140
[libata]
[    1.264802]  [<ffffffffa00aabee>] ata_sff_error_handler+0xce/0x130 [libata]
[    1.264821]  [<ffffffffa00aacdf>] ata_bmdma_error_handler+0x8f/0x150
[libata]
[    1.264841]  [<ffffffffa00a82a9>] ata_scsi_port_error_handler+0x499/0x770
[libata]
[    1.264861]  [<ffffffffa00a8613>] ata_scsi_error+0x93/0xd0 [libata]
[    1.264896]  [<ffffffffa0007eba>] scsi_error_handler+0x12a/0x720 [scsi_mod]
[    1.264915]  [<ffffffffa0007d90>] ? scsi_eh_get_sense+0x210/0x210 [scsi_mod]
[    1.264933]  [<ffffffffa0007d90>] ? scsi_eh_get_sense+0x210/0x210 [scsi_mod]
[    1.264940]  [<ffffffff8107f386>] kthread+0x96/0xa0
[    1.264950]  [<ffffffff814b5804>] kernel_thread_helper+0x4/0x10
[    1.264957]  [<ffffffff8107f2f0>] ? kthread_freezable_should_stop+0x80/0x80
[    1.264964]  [<ffffffff814b5800>] ? gs_change+0x13/0x13
[    1.264969] ---[ end trace a98d36ed22847d07 ]---
[    1.264972] ------------[ cut here ]------------
[    1.264980] WARNING: at drivers/ata/pata_acpi.c:149
pacpi_set_dmamode+0xdf/0xf0 [pata_acpi]()
[    1.264983] Hardware name: ATLANT \xffffffd52 4800/251
[    1.264987] pacpi_set_dmamode: ata_timing_find_mode gives NULL
[    1.264989] Modules linked in: ahci libahci pata_acpi libata scsi_mod
[    1.265002] Pid: 547, comm: scsi_eh_2 Tainted: G        W   
3.6.3-un-def-alt1 #1
[    1.265005] Call Trace:
[    1.265013]  [<ffffffff81059b2a>] warn_slowpath_common+0x7a/0xb0
[    1.265020]  [<ffffffff81059c01>] warn_slowpath_fmt+0x41/0x50
[    1.265030]  [<ffffffffa003731f>] pacpi_set_dmamode+0xdf/0xf0 [pata_acpi]
[    1.265038]  [<ffffffffa00373fa>] pacpi_qc_issue+0x5a/0x7c [pata_acpi]
[    1.265057]  [<ffffffffa00997af>] ata_qc_issue+0x1ff/0x370 [libata]
[    1.265065]  [<ffffffff81047e73>] ? default_spin_lock_flags+0x13/0x20
[    1.265084]  [<ffffffffa0099c61>] ata_exec_internal_sg+0x341/0x640 [libata]
[    1.265104]  [<ffffffffa00aaf27>] ? ata_sff_dev_classify+0x67/0x110 [libata]
[    1.265123]  [<ffffffffa0099fd4>] ata_exec_internal+0x74/0xb0 [libata]
[    1.265142]  [<ffffffffa00ab450>] ? ata_sff_wait_after_reset+0x140/0x140
[libata]
[    1.265161]  [<ffffffffa009a0b5>] ata_do_dev_read_id+0x25/0x30 [libata]
[    1.265180]  [<ffffffffa00a5d8c>] ? ata_eh_reset+0x24c/0xc80 [libata]
[    1.265198]  [<ffffffffa009a3e4>] ata_dev_read_id+0x324/0x5a0 [libata]
[    1.265217]  [<ffffffffa00ab450>] ? ata_sff_wait_after_reset+0x140/0x140
[libata]
[    1.265226]  [<ffffffff81047e73>] ? default_spin_lock_flags+0x13/0x20
[    1.265246]  [<ffffffffa00a7164>] ata_eh_recover+0x824/0x13e0 [libata]
[    1.265254]  [<ffffffff810993e1>] ? load_balance+0x611/0x8c0
[    1.265273]  [<ffffffffa00aae20>] ? ata_sff_drain_fifo+0x80/0x80 [libata]
[    1.265292]  [<ffffffffa00ab450>] ? ata_sff_wait_after_reset+0x140/0x140
[libata]
[    1.265301]  [<ffffffffa00371c0>] ? pacpi_port_start+0xa0/0xa0 [pata_acpi]
[    1.265308]  [<ffffffff814acf39>] ? _raw_spin_lock_irq+0x39/0x50
[    1.265315]  [<ffffffff810789cb>] ? wait_on_work+0x1fb/0x210
[    1.265324]  [<ffffffffa00371c0>] ? pacpi_port_start+0xa0/0xa0 [pata_acpi]
[    1.265343]  [<ffffffffa00ab450>] ? ata_sff_wait_after_reset+0x140/0x140
[libata]
[    1.265363]  [<ffffffffa00a869d>] ata_do_eh+0x4d/0xc0 [libata]
[    1.265382]  [<ffffffffa00aae20>] ? ata_sff_drain_fifo+0x80/0x80 [libata]
[    1.265401]  [<ffffffffa00ab450>] ? ata_sff_wait_after_reset+0x140/0x140
[libata]
[    1.265420]  [<ffffffffa00aabee>] ata_sff_error_handler+0xce/0x130 [libata]
[    1.265440]  [<ffffffffa00aacdf>] ata_bmdma_error_handler+0x8f/0x150
[libata]
[    1.265460]  [<ffffffffa00a82a9>] ata_scsi_port_error_handler+0x499/0x770
[libata]
[    1.265480]  [<ffffffffa00a8613>] ata_scsi_error+0x93/0xd0 [libata]
[    1.265499]  [<ffffffffa0007eba>] scsi_error_handler+0x12a/0x720 [scsi_mod]
[    1.265518]  [<ffffffffa0007d90>] ? scsi_eh_get_sense+0x210/0x210 [scsi_mod]
[    1.265535]  [<ffffffffa0007d90>] ? scsi_eh_get_sense+0x210/0x210 [scsi_mod]
[    1.265542]  [<ffffffff8107f386>] kthread+0x96/0xa0
[    1.265550]  [<ffffffff814b5804>] kernel_thread_helper+0x4/0x10
[    1.265558]  [<ffffffff8107f2f0>] ? kthread_freezable_should_stop+0x80/0x80
[    1.265565]  [<ffffffff814b5800>] ? gs_change+0x13/0x13
[    1.265568] ---[ end trace a98d36ed22847d08 ]---

-- 
Configure bugmail: https://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are watching the assignee of the bug.
