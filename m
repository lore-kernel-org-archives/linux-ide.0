From: Wu Fengguang <fengguang.wu@intel.com>
Subject: [mmotm 2009-04-30] ata: failed to IDENTIFY
Date: Sun, 10 May 2009 19:47:59 +0800
Message-ID: <20090510114759.GA7577@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:47278 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751083AbZEJLsN (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 10 May 2009 07:48:13 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org, jgarzik@pobox.com
Cc: Tejun Heo <htejun@gmail.com>

Hi,

I got this warning message for mmotm 2009-04-30.
linux-next 20090417 and 20090504 are all OK.

[ 5981.492777] ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 frozen
[ 5981.499939] ata1.00: cmd e7/00:00:00:00:00/00:00:00:00:00/a0 tag 0
[ 5981.499942]          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
[ 5981.513751] ata1.00: status: { DRDY }
[ 5981.517525] ata1: hard resetting link
[ 5981.852721] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[ 5986.860644] ------------[ cut here ]------------
[ 5986.864611] WARNING: at drivers/ata/libata-core.c:4957 warn_slowpath_null+0x17/0x20()
[ 5986.864611] Hardware name: HP Compaq 6910p
[ 5986.864611] Modules linked in: drm iwlagn iwlcore snd_hda_codec_analog snd_hda_intel snd_hda_codec snd_hwdep snd_pcm snd_seq snd_o
[ 5986.864611] Pid: 1123, comm: scsi_eh_0 Not tainted 2.6.30-rc4-mm1 #223
[ 5986.864611] Call Trace:
[ 5986.864611]  [<ffffffff810493c8>] warn_slowpath_fmt+0xd8/0x130
[ 5986.864611]  [<ffffffff81012ad0>] ? native_sched_clock+0x20/0x70
[ 5986.864611]  [<ffffffff81012ad0>] ? native_sched_clock+0x20/0x70
[ 5986.864611]  [<ffffffff81012b29>] ? sched_clock+0x9/0x10
[ 5986.864611]  [<ffffffff8105e958>] ? __cancel_work_timer+0xc8/0x250
[ 5986.864611]  [<ffffffff81012ad0>] ? native_sched_clock+0x20/0x70
[ 5986.864611]  [<ffffffff8154bcc0>] ? _spin_unlock_irq+0x30/0x40
[ 5986.864611]  [<ffffffff8107673d>] ? trace_hardirqs_on_caller+0x16d/0x1c0
[ 5986.864611]  [<ffffffff81049437>] warn_slowpath_null+0x17/0x20
[ 5986.864611]  [<ffffffff8134da26>] ata_qc_complete+0x1e6/0x260
[ 5986.864611]  [<ffffffff8135ad9a>] ata_do_link_abort+0xaa/0x100
[ 5986.864611]  [<ffffffff8135ae00>] ata_port_abort+0x10/0x20
[ 5986.864611]  [<ffffffff8135ae3f>] ata_port_freeze+0x2f/0x50
[ 5986.864611]  [<ffffffff8134ea12>] ata_exec_internal_sg+0x582/0x600
[ 5986.864611]  [<ffffffff8154901b>] ? wait_for_common+0x16b/0x190
[ 5986.864611]  [<ffffffff8134eb0f>] ata_exec_internal+0x7f/0xb0
[ 5986.864611]  [<ffffffff8134eefa>] ata_do_dev_read_id+0x2a/0x30
[ 5986.864611]  [<ffffffff8134f256>] ata_dev_read_id+0x356/0x530
[ 5986.864611]  [<ffffffff8134f5c8>] ata_dev_reread_id+0x48/0x1e0
[ 5986.864611]  [<ffffffff81012ad0>] ? native_sched_clock+0x20/0x70
[ 5986.864611]  [<ffffffff81012b29>] ? sched_clock+0x9/0x10
[ 5986.864611]  [<ffffffff8154bd14>] ? _spin_unlock_irqrestore+0x44/0x80
[ 5986.864611]  [<ffffffff8107673d>] ? trace_hardirqs_on_caller+0x16d/0x1c0
[ 5986.864611]  [<ffffffff81350e62>] ata_dev_revalidate+0x112/0x190
[ 5986.864611]  [<ffffffff81359f2d>] ata_eh_recover+0x6bd/0xee0
[ 5986.864611]  [<ffffffff81363d50>] ? ahci_postreset+0x0/0x60
[ 5986.864611]  [<ffffffff81363080>] ? ahci_hardreset+0x0/0x160
[ 5986.864611]  [<ffffffff81362f80>] ? ahci_softreset+0x0/0x60
[ 5986.864611]  [<ffffffff8134d220>] ? ata_std_prereset+0x0/0xd0
[ 5986.864611]  [<ffffffff8135fb3b>] sata_pmp_error_handler+0xeb/0xc50
[ 5986.864611]  [<ffffffff81012ad0>] ? native_sched_clock+0x20/0x70
[ 5986.864611]  [<ffffffff81012b29>] ? sched_clock+0x9/0x10
[ 5986.864611]  [<ffffffff81363d3a>] ahci_error_handler+0x4a/0x60
[ 5986.864611]  [<ffffffff8135b5a5>] ata_scsi_error+0x495/0x820
[ 5986.864611]  [<ffffffff81335d7d>] scsi_error_handler+0xed/0x3d0
[ 5986.864611]  [<ffffffff81335c90>] ? scsi_error_handler+0x0/0x3d0
[ 5986.864611]  [<ffffffff81062dc6>] kthread+0xa6/0xc0
[ 5986.864611]  [<ffffffff8100d20a>] child_rip+0xa/0x20
[ 5986.864611]  [<ffffffff8100cbd0>] ? restore_args+0x0/0x30
[ 5986.864611]  [<ffffffff81062d20>] ? kthread+0x0/0xc0
[ 5986.864611]  [<ffffffff8100d200>] ? child_rip+0x0/0x20
[ 5986.864611] ---[ end trace 87eb9470166678e1 ]---
[ 5986.864611] ata1.00: qc timeout (cmd 0xec)
[ 5987.153668] ata1.00: failed to IDENTIFY (I/O error, err_mask=0x4)
[ 5987.159861] ata1.00: revalidation failed (errno=-5)
[ 5987.164854] ata1: hard resetting link
[ 5987.500647] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[ 5997.508508] ata1.00: qc timeout (cmd 0xec)
[ 5997.512720] ata1.00: failed to IDENTIFY (I/O error, err_mask=0x4)
[ 5997.518913] ata1.00: revalidation failed (errno=-5)
[ 5997.523893] ata1: limiting SATA link speed to 1.5 Gbps
[ 5997.529149] ata1: hard resetting link
[ 5997.860516] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[ 6027.868126] ata1.00: qc timeout (cmd 0xec)
[ 6027.872339] ata1.00: failed to IDENTIFY (I/O error, err_mask=0x4)
[ 6027.878530] ata1.00: revalidation failed (errno=-5)
[ 6027.883507] ata1.00: disabled
[ 6027.886603] ata1: hard resetting link
[ 6028.220134] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[ 6028.226450] ata1: EH complete
[ 6028.229748] sd 0:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[ 6028.237583] Restarting system.
[ 6028.240745] machine restart

Thanks,
Fengguang
