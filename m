From: Pat LaVarre <p.lavarre@ieee.org>
Subject: Re: [PATCH] atapi request sense work
Date: 02 Jun 2004 17:53:10 -0600
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <1086220390.3285.2.camel@patibmrh9>
References: <068F5E91-B237-11D8-819C-000393A22C62@ieee.org><1085930101.3135.
	4.camel@patibmrh9>  <1086019779.3144.6.camel@patibmrh9><1086134487.12245.0.
	camel@patibmrh9>  <1086209532.8016.2.camel@patibmrh9><1086215808.16228.6.ca
	mel@patibmrh9>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from email-out2.iomega.com ([147.178.1.83]:21216 "EHLO
	email.iomega.com") by vger.kernel.org with ESMTP id S264108AbUFBXxP
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 2 Jun 2004 19:53:15 -0400
In-Reply-To: <1086215808.16228.6.camel@patibmrh9>
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org


I'm delighted to report also atapi_sense_pio worked when I tried it
here, provided I tried it immediately after op xA1 ATA_CMD_ID_ATAPI, and
provided I omitted all reference to struct ata_queued_cmd * qc.

My successful dmesg were:

ata_dev_identify: atapi_sense_pio
ata_tf_load_pio: feat 0x0 nsect 0x0 lba 0x0 0x60 0x0
ata_tf_load_pio: device 0xA0
ata_exec: ata2: cmd 0xA0
ata_exec_command_pio: ata2: cmd 0xA0
atapi_sense_pio: send 0xC bytes of cdb
atapi_sense_pio: 0x0020 = len
atapi_sense_pio: sense x 6 29 00 00000000
atapi_sense_pio: sense injected without error
atapi_sense_pio: EXIT

Pat LaVarre

P.S.

The specific default choice of x60 = 96 = SCSI_SENSE_BUFFERSIZE does
matter.  The device I have rounds that down to x20 (32), and the code
Jeff wrote accepts the rounding down and survives.  But for the sake of
compatibility, I also tried the elsewhere popular default of x12 (18):

- u8 max = min(0xFF, SCSI_SENSE_BUFFERSIZE);
+ u8 max = min(0x12, SCSI_SENSE_BUFFERSIZE);

Given that not-cleanly-divisible-by-four suggestion of x12 (18), my
device agrees to copy in precisely that many bytes, which then leads to
such trouble as:

kernel: ATA: abnormal status 0x58 on port 0xE007

Rumour tells me many devices round down to x12 (18) bytes of sense data,
rather than x20 (32).  Either that rumour is wrong, or I've broken the
source myself, or else we'll have to fix this someday.

diff -urp o/include/linux/ata.h linux-2.6.7-rc2-pel/include/linux/ata.h
diff -urp o/include/linux/libata.h linux-2.6.7-rc2-pel/include/linux/libata.h
diff -urp o/drivers/scsi/libata-core.c linux-2.6.7-rc2-pel/drivers/scsi/libata-core.c
--- o/drivers/scsi/libata-core.c	2004-05-30 08:53:41.000000000 -0600
+++ linux-2.6.7-rc2-pel/drivers/scsi/libata-core.c	2004-06-02 17:32:18.000000000 -0600
@@ -938,6 +938,77 @@ static inline void ata_dump_id(struct at
 }
 
 /**
+ *	atapi_sense_pio - FIXME
+ */
+
+static void atapi_sense_pio(struct ata_port *ap)
+{
+        unsigned char sense[SCSI_SENSE_BUFFERSIZE];
+	struct ata_taskfile tf;
+	u8 status;
+	u8 max = min(0xFF, SCSI_SENSE_BUFFERSIZE);
+	u16 len;
+	const u8 request_sense_cdb[16] = {
+		REQUEST_SENSE, 0, 0, 0, max, 0,
+	};
+	u8 err = ata_chk_err(ap); /* fetch before ata_tf_to_host */
+
+	ata_tf_init(ap, &tf, 0); /* FIXME: qc->dev->devno */
+	tf.flags |= ATA_TFLAG_ISADDR | ATA_TFLAG_DEVICE;
+	tf.protocol = ATA_PROT_ATAPI;
+	tf.ctl |= ATA_NIEN;
+	tf.lbam = max;
+	tf.command = ATA_CMD_PACKET;
+	ata_tf_to_host(ap, &tf);
+
+	if (ata_busy_sleep(ap, ATA_TMOUT_CDB_QUICK, ATA_TMOUT_CDB))
+		goto sense_not;
+
+	status = ata_chk_status(ap);
+	if ((status & ATA_DRQ) == 0)
+		goto sense_not;
+
+	/* FIXME: mmio-ize */
+	DPRINTK("send 0x%X bytes of cdb\n", ap->host->max_cmd_len);
+	outsl(ap->ioaddr.data_addr, request_sense_cdb,
+	      ap->host->max_cmd_len / 4);
+
+	if (ata_busy_sleep(ap, ATA_TMOUT_CDB_QUICK, ATA_TMOUT_CDB))
+		goto sense_not;
+
+	status = ata_chk_status(ap);
+	if ((status & ATA_DRQ) == 0)
+		goto sense_not;
+
+	ap->ops->tf_read(ap, &tf);
+	len = tf.lbam;
+	len |= ((u16)tf.lbah) << 8;
+	DPRINTK("0x%04X = len\n", len);
+
+	if (!len || (len % 4) || (max < len))
+		printk(KERN_WARNING "ata%u: surprise ATAPI length %u\n",
+		       ap->id, len);
+	memset(sense, 0, sizeof(sense));
+	insl(ap->ioaddr.data_addr, sense, (len + 4 - 1) / 4);
+
+	if ((sense[0] & 0x7e) != 0x70) {
+		DPRINTK("sense unintelligible");
+		sense[0] = 0x70;
+		sense[2] = err >> 4;
+	} else {
+		DPRINTK("sense x %X %02X %02X %02X%02X%02X%02X\n",
+			(sense[2] & 0x0F), sense[0xC], sense[0xD],
+			sense[3], sense[4], sense[5], sense[6]);
+	}
+
+	if (ata_busy_sleep(ap, ATA_TMOUT_CDB_QUICK, ATA_TMOUT_CDB))
+		goto sense_not;
+	DPRINTK("sense injected without error\n");
+sense_not:
+	DPRINTK("EXIT\n");
+}
+
+/**
  *	ata_dev_identify - obtain IDENTIFY x DEVICE page
  *	@ap: port on which device we wish to probe resides
  *	@device: device bus address, starting at zero
@@ -1057,6 +1128,8 @@ retry:
 		       status);
 		goto err_out;
 	}
+	DPRINTK("atapi_sense_pio\n");
+	atapi_sense_pio(ap);
 
 	ata_irq_on(ap);	/* re-enable interrupts */
 
diff -urp o/drivers/scsi/libata-scsi.c linux-2.6.7-rc2-pel/drivers/scsi/libata-scsi.c


