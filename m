From: Pat LaVarre <p.lavarre@ieee.org>
Subject: Re: [PATCH] atapi request sense work
Date: 30 May 2004 09:15:01 -0600
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <1085930101.3135.4.camel@patibmrh9>
References: <068F5E91-B237-11D8-819C-000393A22C62@ieee.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from email-out2.iomega.com ([147.178.1.83]:59072 "EHLO
	email.iomega.com") by vger.kernel.org with ESMTP id S262361AbUE3PPG
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 30 May 2004 11:15:06 -0400
In-Reply-To: <068F5E91-B237-11D8-819C-000393A22C62@ieee.org>
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org

>  > > ata_tf_load_pio: feat 0x0 nsect 0x0 lba 0x0 0x12 0x0
>  > > ata_tf_load_pio: device 0xA0
>  > > ata_exec: cmd 0xA0
> 
> ... try ...
> b) Add an unsolicited ATA op x00 "NOP" after every CDB.

Ah.  Progress.

Yes in fact we have NOT yet explained how to insert an ATA op x00 "NOP".

Instead, my kernel goes down during modprobe ata-piix if I try the
following, in 2.6.7-rc2 plus ata_check_bmdma.  Transcribed by hand from
`tail -f /var/log/messages` running in parallel with modprobe, the last
now were:

atapi_error: err x00
atapi_error: ata_tf_to_host
ata_tf_load_pio: feat 0x0 nsect 0x0 lba 0x0 0x0 0x0
ata_tf_load_pio: device 0xA0
ata_exec: ata2: cmd 0x0

I lost my kernel no matter if the patch included the unbalanced
sourceline:

ata_irq_on(ap);

Pat LaVarre

diff -urp o/include/linux/ata.h linux-2.6.7-rc2-pel/include/linux/ata.h
diff -urp o/include/linux/libata.h linux-2.6.7-rc2-pel/include/linux/libata.h
diff -urp o/drivers/scsi/libata-core.c linux-2.6.7-rc2-pel/drivers/scsi/libata-core.c
--- o/drivers/scsi/libata-core.c	2004-05-30 08:53:41.000000000 -0600
+++ linux-2.6.7-rc2-pel/drivers/scsi/libata-core.c	2004-05-30 09:01:18.000000000 -0600
@@ -2294,6 +2294,44 @@ struct ata_queued_cmd *ata_qc_new_init(s
 	return qc;
 }
 
+static void atapi_error(struct ata_queued_cmd *qc)
+{
+	struct ata_port *ap = qc->ap;
+	u8 err = ata_chk_err(ap);
+	struct ata_taskfile tf;
+	struct scsi_cmnd *cmd = qc->scsicmd;
+	u8 status;
+	DPRINTK("err x%02X\n", err);
+
+	ata_tf_init(ap, &tf, qc->dev->devno);
+	tf.flags |= ATA_TFLAG_ISADDR | ATA_TFLAG_DEVICE;
+	tf.protocol = ATA_PROT_ATAPI;
+	tf.ctl |= ATA_NIEN;
+	tf.command = 0x00; /* FIXME: ATA_CMD_NOP */
+	DPRINTK("ata_tf_to_host\n");
+	ata_tf_to_host(ap, &tf);
+
+	DPRINTK("ata_busy_sleep\n");
+	if (ata_busy_sleep(ap, ATA_TMOUT_CDB_QUICK, ATA_TMOUT_CDB))
+		goto err_out;
+
+	DPRINTK("ata_chk_status\n");
+	status = ata_chk_status(ap);
+	if ((status & ATA_DRQ) == 0)
+		goto err_out;
+
+out:
+	DPRINTK("out:\n");
+	ata_irq_on(ap);
+	DPRINTK("GOOD\n");
+	cmd->result = SAM_STAT_GOOD; /* FIXME */
+	return;
+
+err_out:
+	DPRINTK("err_out:\n");
+	goto out; /* above */
+}
+
 /**
  *	ata_qc_complete - Complete an active ATA command
  *	@qc: Command to complete
@@ -2324,6 +2362,7 @@ void ata_qc_complete(struct ata_queued_c
 		} else {
 			cmd->result = SAM_STAT_GOOD;
 		}
+		atapi_error(qc);
 
 		qc->scsidone(cmd);
 	}
diff -urp o/drivers/scsi/libata-scsi.c linux-2.6.7-rc2-pel/drivers/scsi/libata-scsi.c


