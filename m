From: Pat LaVarre <p.lavarre@ieee.org>
Subject: Re: [PATCH] atapi request sense work
Date: 21 May 2004 14:07:05 -0600
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <1085170025.3083.91.camel@patibmrh9>
References: <1084717146.3576.3.camel@patibmrh9> <40AD7FB2.10506@pobox.com><1
	085153750.6103.33.camel@patibmrh9><200405211746.35015.bzolnier@elka.pw.edu.
	pl><1085162347.4791.24.camel@patibmrh9>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from email-out1.iomega.com ([147.178.1.82]:717 "EHLO
	email.iomega.com") by vger.kernel.org with ESMTP id S266005AbUEUUHN
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 21 May 2004 16:07:13 -0400
Received: from royntex01.iomegacorp.com (edison [10.1.1.82])
	by email.iomega.com (Postfix) with ESMTP id A7C8718D9
	for <linux-ide@vger.kernel.org>; Fri, 21 May 2004 14:07:12 -0600 (MDT)
In-Reply-To: <1085162347.4791.24.camel@patibmrh9>
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Without auto sense, we read and write ok ...

But when I try a no-data op x00 "TEST UNIT READY", I get:

kernel: ata_scsi_dump_cdb: CDB (2:0,0,0) 00 00 00 00 00 00 47 c0 01
kernel: ata_scsi_translate: ENTER
kernel: ata_dev_select: ENTER, ata2: device 0, wait 1
kernel: ata_tf_load_pio: feat 0x0 nsect 0x0 lba 0x0 0x0 0x0
kernel: ata_tf_load_pio: device 0xA0
kernel: ata_exec_command_pio: ata2: cmd 0xA0
kernel: ata_scsi_translate: EXIT
kernel: atapi_packet_task: busy wait
kernel: atapi_packet_task: send cdb
kernel: ata_host_intr: BUS_NODATA (drv_stat 0x50)
kernel: irq 18: nobody cared!
kernel:  [<c01081d7>] __report_bad_irq+0x2a/0x8b
kernel:  [<c01082c1>] note_interrupt+0x6f/0x9f
kernel:  [<c01085f5>] do_IRQ+0x175/0x1a6
kernel:  [<c0103c9e>] default_idle+0x0/0x2d
kernel:  [<c01067b8>] common_interrupt+0x18/0x20
kernel:  [<c0103c9e>] default_idle+0x0/0x2d
kernel:  [<c0103cc8>] default_idle+0x2a/0x2d
kernel:  [<c0103d3c>] cpu_idle+0x37/0x40
kernel:  [<c011de99>] printk+0x198/0x1f1
kernel: 
kernel: handlers:
kernel: [<df9986a8>] (ata_interrupt+0x0/0x1b9 [libata])
kernel: Disabling IRQ #18

Pat LaVarre


