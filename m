From: Pat LaVarre <p.lavarre@ieee.org>
Subject: Re: [PATCH] atapi request sense work
Date: 21 May 2004 19:11:41 -0600
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <1085188300.3658.18.camel@patibmrh9>
References: <1084717146.3576.3.camel@patibmrh9> <40AD7FB2.10506@pobox.com><1
	 085153750.6103.33.camel@patibmrh9><200405211746.35015.bzolnier@elka.pw.ed
	u	 .	pl><1085162347.4791.24.camel@patibmrh9><1085170025.3083.91.camel@pati
	bm	r h9> <40AE79E1.9020005@pobox.com><1085182749.3122.15.camel@patibmrh9> <
	40AE9493.1040701@pobox.com><1085186021.4510.0.camel@patibmrh9>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from email-out1.iomega.com ([147.178.1.82]:62975 "EHLO
	email.iomega.com") by vger.kernel.org with ESMTP id S264798AbUEVBLv
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 21 May 2004 21:11:51 -0400
In-Reply-To: <1085186021.4510.0.camel@patibmrh9>
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org

Jeff G:

> Open-ioctl-close of /dev/scd$n now mostly works.
> 
> (Read/ write still has issues I will report separately.)

Ah, never mind there for now.  Digging a little, I see plug 'n play
(e.g. the determination of DVD/ CD disc rewritable or not) may go weird
while yet we neglect to auto sense.  Moving on ...

To my newbie surprise, I have more good news.  Teaching my -bk8 kernel
toclear x04 ATA_DMA_INTR, means my kernel no longer needs my lab hack of
the bk8.good.always.patch.

Failure is ok now, though not yet autosensed.

Sorry to say, failure is ok only if I do NOT apply your autosense
patch.  Still here applying that provokes an indefinite series of
/var/log/messages that begin, for example

kernel: ata_sg_clean: unmapping 1 sg elements
kernel:   Vendor: Iomega    Model: RRD               Rev: 74.B
kernel:   Type:   CD-ROM                             ANSI SCSI revision: 00
kernel: ata_scsi_dump_cdb: CDB (2:0,0,0) 00 00 00 00 00 00 00 00 00
kernel: ata_scsi_translate: ENTER
kernel: ata_dev_select: ENTER, ata2: device 0, wait 1
kernel: ata_tf_load_pio: feat 0x0 nsect 0x0 lba 0x0 0x0 0x0
kernel: ata_tf_load_pio: device 0xA0
kernel: ata_exec_command_pio: ata2: cmd 0xA0
kernel: ata_scsi_translate: EXIT
kernel: atapi_packet_task: busy wait
kernel: atapi_packet_task: send cdb
kernel: ata_host_intr: BUS_NODATA (drv_stat 0x51 host_stat 0x24)
kernel: ata_dma_complete: ENTER
kernel: ata_dma_complete: host 2, host_stat==0x24, drv_stat==0x51
kernel: ata_scsi_error: ENTER
kernel: ata_eng_timeout: ENTER
kernel: ata_tf_load_pio: feat 0x0 nsect 0x0 lba 0x0 0x60 0x0
kernel: ata_tf_load_pio: device 0xA0
kernel: ata_exec: ata2: cmd 0xA0
kernel: ata_exec_command_pio: ata2: cmd 0xA0
kernel: atapi_error: send cdb
kernel: ata_eng_timeout: EXIT
kernel: ata_scsi_error: EXIT
kernel: ata_scsi_dump_cdb: CDB (2:0,0,0) 00 00 00 00 00 00 00 00 00
kernel: ata_scsi_translate: ENTER
kernel: ata_scsi_dump_cdb: CDB (2:0,0,0) 00 00 00 00 00 00 00 00 00
kernel: ata_scsi_translate: ENTER
kernel: ata_scsi_dump_cdb: CDB (2:0,0,0) 00 00 00 00 00 00 00 00 00
kernel: ata_scsi_translate: ENTER
...

I think a significant variable may be whether I have other /dev/scd*
devices present and various modules more or less autoloaded.  I don't
imagine those variables change whether auto sense works or not, but I do
think they change whether Linux itself catches a unit attention or
whether I have to ask to capture a unit attention.

Real life intrudes, bye for now, I'll post again when next I make
progress and/or feel stuck.

Pat LaVarre


