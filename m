From: Borislav Petkov <bbpetkov@yahoo.de>
Subject: [PATCH 2/9] ahci.c conversion
Date: Thu, 29 Jun 2006 18:09:38 +0200
Message-ID: <20060629160938.GC23122@zmei.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp106.plus.mail.re2.yahoo.com ([206.190.53.31]:51593 "HELO
	smtp106.plus.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1750834AbWF2QLQ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 29 Jun 2006 12:11:16 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide <linux-ide@vger.kernel.org>
Cc: Jeff Garzik <jgarzik@pobox.com>, Tejun Heo <htejun@gmail.com>

This converts the relevant places of ahci.c to the new scheme.

Signed-off-by: <petkov@math.uni-muenster.de>

--- libata-dev/drivers/scsi/ahci.c.orig	2006-06-28 09:13:10.000000000 +0200
+++ libata-dev/drivers/scsi/ahci.c	2006-06-29 17:29:06.000000000 +0200
@@ -617,10 +617,10 @@ static int ahci_softreset(struct ata_por
 	u8 *fis;
 	int rc;
 
-	DPRINTK("ENTER\n");
+	ata_port_printk(ap, ATA_MSG_TRACE, "%s: ENTER\n", __FUNCTION__);
 
 	if (ata_port_offline(ap)) {
-		DPRINTK("PHY reports no device\n");
+		ata_port_printk(ap, ATA_MSG_CMD, "PHY reports no device\n");
 		*class = ATA_DEV_NONE;
 		return 0;
 	}
@@ -702,13 +702,14 @@ static int ahci_softreset(struct ata_por
 		*class = ahci_dev_classify(ap);
 	}
 
-	DPRINTK("EXIT, class=%u\n", *class);
+	ata_port_printk(ap, ATA_MSG_TRACE, "%s: EXIT, class=%u\n", 
+			__FUNCTION__, *class);
 	return 0;
 
  fail_restart:
 	ahci_start_engine(ap);
  fail:
-	ata_port_printk(ap, KERN_ERR, "softreset failed (%s)\n", reason);
+	ata_port_printk(ap, ATA_MSG_ERR, "softreset failed (%s)\n", reason);
 	return rc;
 }
 
@@ -719,7 +720,7 @@ static int ahci_hardreset(struct ata_por
 	struct ata_taskfile tf;
 	int rc;
 
-	DPRINTK("ENTER\n");
+	ata_port_printk(ap, ATA_MSG_TRACE, "%s: ENTER\n", __FUNCTION__);
 
 	ahci_stop_engine(ap);
 
@@ -737,7 +738,8 @@ static int ahci_hardreset(struct ata_por
 	if (*class == ATA_DEV_UNKNOWN)
 		*class = ATA_DEV_NONE;
 
-	DPRINTK("EXIT, rc=%d, class=%u\n", rc, *class);
+	ata_port_printk(ap, ATA_MSG_TRACE, "%s: EXIT, rc=%d, class=%u\n", 
+			__FUNCTION__, rc, *class);
 	return rc;
 }
 
@@ -779,9 +781,10 @@ static unsigned int ahci_fill_sg(struct 
 {
 	struct scatterlist *sg;
 	struct ahci_sg *ahci_sg;
+	struct ata_port *ap = qc->ap;
 	unsigned int n_sg = 0;
 
-	VPRINTK("ENTER\n");
+	ata_port_printk(ap, ATA_MSG_TRACE, "%s: ENTER\n", __FUNCTION__);
 
 	/*
 	 * Next, the S/G list.
@@ -950,7 +953,7 @@ static void ahci_host_intr(struct ata_po
 	}
 
 	if (ata_ratelimit())
-		ata_port_printk(ap, KERN_INFO, "spurious interrupt "
+		ata_port_printk(ap, ATA_MSG_DRV, "spurious interrupt "
 				"(irq_stat 0x%x active_tag %d sactive 0x%x)\n",
 				status, ap->active_tag, ap->sactive);
 }

		
___________________________________________________________ 
Telefonate ohne weitere Kosten vom PC zum PC: http://messenger.yahoo.de

