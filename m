From: Pat LaVarre <p.lavarre@ieee.org>
Subject: Re: SATA ATAPI work in progress
Date: 14 May 2004 18:02:43 -0600
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <1084579362.3271.5.camel@patibmrh9>
References: <1084393233.3999.2.camel@patibmrh9> <40A28BB6.7090204@pobox.com>
	<1084403654.3196.31.camel@patibmrh9>  <40A3E595.8000003@pobox.com><108455 9
	000.4017.52.camel@patibmrh9>  <40A51604.8070208@pobox.com><1084578453.5343.
	26.camel@patibmrh9>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="=-dOQL8CzDdMkNezq1RvDR"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from email-out1.iomega.com ([147.178.1.82]:21122 "EHLO
	email.iomega.com") by vger.kernel.org with ESMTP id S264668AbUEOADK
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 14 May 2004 20:03:10 -0400
In-Reply-To: <1084578453.5343.26.camel@patibmrh9>
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org


--=-dOQL8CzDdMkNezq1RvDR
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

> > Applying patch.[12345] in order to linux-2.6.6-bk1/ here yielded:
> > ...
> > kernel: ata_tf_load_pio: feat 0x1 nsect 0x0 lba 0x0 0x0 0x0
> > kernel: ata_tf_load_pio: device 0xA0
> > kernel: ata_exec_command_pio: ata2: cmd 0xA0
> > kernel: ata_scsi_translate: EXIT
> > kernel: atapi_packet_task: busy wait
> > kernel: atapi_packet_task: send cdb
> > kernel: ata_scsi_error: ENTER
> > kernel: ata_eng_timeout: ENTER
> > kernel: ata2: unknown timeout, cmd 0xa0 stat 0xd0
> > ...
> > Next I will try
> > o x1F1 Features = x05 Dma In and x01 Dma Out because ...

Results follow.  Much improved now, yes?

Pat LaVarre

kernel: ata_scsi_dump_cdb: CDB (2:0,0,0) 12 00 00 00 24 00 00 00 46
kernel: ata_scsi_translate: ENTER
kernel: ata_sg_setup_one: mapped buffer of 36 bytes for read
kernel: ata_fill_sg: PRD[0] = (0x49EE54, 0x24)
kernel: ata_dev_select: ENTER, ata2: device 0, wait 1
kernel: ata_tf_load_pio: feat 0x5 nsect 0x0 lba 0x0 0x0 0x0
kernel: ata_tf_load_pio: device 0xA0
kernel: ata_exec_command_pio: ata2: cmd 0xA0
kernel: ata_scsi_translate: EXIT
kernel: atapi_packet_task: busy wait
kernel: atapi_packet_task: send cdb
kernel: irq 18: nobody cared!
kernel: Call Trace:
kernel:  [<c0107f83>] __report_bad_irq+0x2a/0x8b
kernel:  [<c010806d>] note_interrupt+0x6f/0x9f
kernel:  [<c01083a1>] do_IRQ+0x175/0x1a6
kernel:  [<c0103aae>] default_idle+0x0/0x2d
kernel:  [<c01065c0>] common_interrupt+0x18/0x20
kernel:  [<c0103aae>] default_idle+0x0/0x2d
kernel:  [<c0103ad8>] default_idle+0x2a/0x2d
kernel:  [<c0103b4c>] cpu_idle+0x37/0x40
kernel:  [<c044289c>] start_kernel+0x1b1/0x202
kernel:  [<c0442428>] unknown_bootoption+0x0/0x129
kernel:
kernel: handlers:
kernel: [<df9675a0>] (ata_interrupt+0x0/0x1a5 [libata])
kernel: Disabling IRQ #18
kernel: ata_scsi_error: ENTER
kernel: ata_eng_timeout: ENTER
kernel: ata2: unknown timeout, cmd 0xa0 stat 0x50
kernel: ata_sg_clean: unmapping 1 sg elements
kernel: ata_eng_timeout: EXIT
kernel: ata_scsi_error: EXIT
kernel: ata_scsi_dump_cdb: CDB (2:0,0,0) 12 00 00 00 c0 00 00 00 46

diff -Nurp o/drivers/scsi linux-2.6.6-bk1/drivers/scsi/libata-scsi.c
--- o/drivers/scsi/libata-scsi.c	2004-05-14 18:00:22.472765072 -0600
+++ linux-2.6.6-bk1/drivers/scsi/libata-scsi.c	2004-05-14 17:51:38.000000000 -0600
@@ -920,6 +920,9 @@ static unsigned int atapi_xlat(struct at
 		qc->flags |= ATA_QCFLAG_SG; /* data is present; dma-map it */
 		qc->tf.protocol = ATA_PROT_ATAPI_DMA;
 		qc->tf.feature |= ATAPI_PKT_DMA;
+		if (cmd->sc_data_direction != SCSI_DATA_WRITE) {
+			qc->tf.feature |= 0x04; /* Silicon Image DMADIR */
+		}
 	}
 
 	return 0;


--=-dOQL8CzDdMkNezq1RvDR
Content-Disposition: attachment; filename=pel.patch.6
Content-Type: text/x-patch; name=pel.patch.6; charset=UTF-8
Content-Transfer-Encoding: 7bit

diff -Nurp o/drivers/scsi linux-2.6.6-bk1/drivers/scsi/libata-scsi.c
--- o/drivers/scsi/libata-scsi.c	2004-05-14 18:00:22.472765072 -0600
+++ linux-2.6.6-bk1/drivers/scsi/libata-scsi.c	2004-05-14 17:51:38.000000000 -0600
@@ -920,6 +920,9 @@ static unsigned int atapi_xlat(struct at
 		qc->flags |= ATA_QCFLAG_SG; /* data is present; dma-map it */
 		qc->tf.protocol = ATA_PROT_ATAPI_DMA;
 		qc->tf.feature |= ATAPI_PKT_DMA;
+		if (cmd->sc_data_direction != SCSI_DATA_WRITE) {
+			qc->tf.feature |= 0x04; /* Silicon Image DMADIR */
+		}
 	}
 
 	return 0;

--=-dOQL8CzDdMkNezq1RvDR--

