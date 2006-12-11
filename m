From: Andrew Morton <akpm@osdl.org>
Subject: ata kmap_atomic abuse
Date: Mon, 11 Dec 2006 00:13:14 -0800
Message-ID: <20061211001314.9ecb17a2.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.25]:57359 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762648AbWLKIN2 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 11 Dec 2006 03:13:28 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org

[  231.948000] SCSI device sda: 195371568 512-byte hdwr sectors (100030 MB)
[  232.232000] ata1.00: configured for UDMA/33
[  232.404000] WARNING (1) at arch/i386/mm/highmem.c:47 kmap_atomic()
[  232.404000]  [<c01162e6>] kmap_atomic+0xa9/0x1ab
[  232.404000]  [<c0242c81>] ata_scsi_rbuf_get+0x1c/0x30
[  232.404000]  [<c0242caf>] ata_scsi_rbuf_fill+0x1a/0x87
[  232.404000]  [<c0243ab2>] ata_scsiop_mode_sense+0x0/0x309
[  232.404000]  [<c01729d5>] end_bio_bh_io_sync+0x0/0x37
[  232.404000]  [<c02311c6>] scsi_done+0x0/0x16
[  232.404000]  [<c02311c6>] scsi_done+0x0/0x16
[  232.404000]  [<c0242dcc>] ata_scsi_simulate+0xb0/0x13f
[  232.404000]  [<c0140f12>] mempool_free+0x4a/0x4e
[  232.404000]  [<c02311c6>] scsi_done+0x0/0x16
[  232.404000]  [<c0244451>] ata_scsi_queuecmd+0xa5/0xe1
[  232.404000]  [<c0231817>] scsi_dispatch_cmd+0x1b3/0x226
[  232.404000]  [<c0236284>] scsi_request_fn+0x250/0x2c2
[  232.404000]  [<c01bd7e2>] as_completed_request+0x1ce/0x1db
[  232.404000]  [<c01b9d00>] blk_run_queue+0x2a/0x4b
[  232.404000]  [<c0235025>] scsi_next_command+0x25/0x2f
[  232.404000]  [<c023519e>] scsi_end_request+0x8c/0x96
[  232.404000]  [<c023533f>] scsi_io_completion+0x15a/0x329
[  232.404000]  [<c023ec39>] ata_hsm_move+0x719/0x729
[  232.404000]  [<c023a2e1>] sd_rw_intr+0x209/0x233
[  232.404000]  [<c0110000>] wakeup_pmode_return+0x0/0x55
[  232.404000]  [<c0231164>] scsi_finish_command+0x81/0x88
[  232.404000]  [<c01b9c4f>] blk_done_softirq+0x4a/0x55
[  232.404000]  [<c011d564>] __do_softirq+0x35/0x75
[  232.404000]  [<c011d5c6>] do_softirq+0x22/0x26
[  232.404000]  [<c0104f1a>] do_IRQ+0x67/0x81
[  232.404000]  [<c010352f>] common_interrupt+0x23/0x28
[  232.404000]  =======================

It's using KM_USER0 from softirq.
