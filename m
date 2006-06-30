From: Borislav Petkov <bbpetkov@yahoo.de>
Subject: [PATCH 2/9] ahci.c conversion
Date: Fri, 30 Jun 2006 08:45:38 +0200
Message-ID: <20060630064538.GA17218@zmei.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp106.plus.mail.re2.yahoo.com ([206.190.53.31]:40329 "HELO
	smtp106.plus.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1751201AbWF3GqG (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 30 Jun 2006 02:46:06 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide <linux-ide@vger.kernel.org>
Cc: Jeff Garzik <jgarzik@pobox.com>, Tejun Heo <htejun@gmail.com>

This converts the relevant places of ahci.c to the new scheme.

Signed-off-by: <petkov@math.uni-muenster.de>

diff --git a/drivers/scsi/ahci.c b/drivers/scsi/ahci.c
index f059467..facddbd 100644
--- a/drivers/scsi/ahci.c
+++ b/drivers/scsi/ahci.c
@@ -617,10 +617,10 @@ static int ahci_softreset(struct ata_por
 	u8 *fis;
 	int rc;
 
-	DPRINTK("ENTER\n");
+	ata_port_printk(ap, ATA_MSG_TRACE, "%s: ENTER\n", __FUNCTION__);
 
 	if (ata_port_offline(ap)) {
-		DPRINTK("PHY reports no device\n");
+		ata_port_printk(ap, ATA_MSG_DEBUG, "PHY reports no device\n");
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
+		ata_port_printk(ap, ATA_MSG_INFO, "spurious interrupt "
 				"(irq_stat 0x%x active_tag %d sactive 0x%x)\n",
 				status, ap->active_tag, ap->sactive);
 }

	

	
		
___________________________________________________________ 
Gesendet von Yahoo! Mail - Jetzt mit 1GB Speicher kostenlos - Hier anmelden: http://mail.yahoo.de

