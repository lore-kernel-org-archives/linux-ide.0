From: Christoph Hellwig <hch@lst.de>
Subject: libata warning booting current Linux git HEAD on qemu git HEAD
Date: Thu, 17 Sep 2009 15:09:09 +0200
Message-ID: <20090917130909.GA19810@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.210]:38136 "EHLO verein.lst.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753650AbZIQNJM (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 17 Sep 2009 09:09:12 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: qemu-devel@nongnu.org, linux-ide@vger.kernel.org

I guess libata required some more standards compliance again that qemu
doesn't provide yet:

[    5.163280] WARNING: at
/home/hch/work/linux-2.6/drivers/ata/libata-core.c:5027
ata_qc_complete+0x168/0x1d0()
[    5.164692] Hardware name: 
[    5.164692] Modules linked in:
[    5.164692] Pid: 195, comm: ata/0 Not tainted 2.6.31-xfs #364
[    5.164692] Call Trace:
[    5.164692]  [<c086083f>] ? printk+0x18/0x1a
[    5.164692]  [<c06e72a8>] ? ata_qc_complete+0x168/0x1d0
[    5.164692]  [<c016118c>] warn_slowpath_common+0x6c/0xc0
[    5.164692]  [<c06e72a8>] ? ata_qc_complete+0x168/0x1d0
[    5.164692]  [<c01611f5>] warn_slowpath_null+0x15/0x20
[    5.164692]  [<c06e72a8>] ata_qc_complete+0x168/0x1d0
[    5.164692]  [<c06f3709>] ata_do_link_abort+0x99/0xe0
[    5.164692]  [<c06f4f30>] ? ata_sff_error_handler+0x0/0x1c0
[    5.164692]  [<c06f375a>] ata_port_abort+0xa/0x10
[    5.164692]  [<c06f377e>] ata_port_freeze+0x1e/0x40
[    5.164692]  [<c06f5899>] ata_hsm_qc_complete+0xf9/0x100
[    5.164692]  [<c06f5aa9>] ata_sff_hsm_move+0x209/0x6b0
[    5.164692]  [<c0131928>] ? sched_clock+0x8/0x10
[    5.164692]  [<c018aacd>] ? lock_release_holdtime+0x2d/0x200
[    5.164692]  [<c06f6a3f>] ata_pio_task+0x2f/0x100
[    5.164692]  [<c01734a5>] worker_thread+0x195/0x290
[    5.164692]  [<c0173440>] ? worker_thread+0x130/0x290
[    5.164692]  [<c06f6a10>] ? ata_pio_task+0x0/0x100
[    5.164692]  [<c0177c20>] ? autoremove_wake_function+0x0/0x50
[    5.164692]  [<c0173310>] ? worker_thread+0x0/0x290
[    5.164692]  [<c0177914>] kthread+0x74/0x80
[    5.164692]  [<c01778a0>] ? kthread+0x0/0x80
[    5.164692]  [<c012ce47>] kernel_thread_helper+0x7/0x10
[    5.164692] ---[ end trace 564c33a31f9b3362 ]---
[    5.206177] ata2.00: ATAPI: QEMU DVD-ROM, 0.11.50, max UDMA/100
[    5.209679] ata2.00: configured for MWDMA2

