From: Phillip Jordan <phillip.m.jordan@gmail.com>
Subject: [PATCH 2.6.16.4 1/2] sata_promise: alternative PATA support on pdc2037x
 without libata interface changes
Date: Fri, 21 Apr 2006 01:09:07 +0100
Message-ID: <444822A3.60906@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nproxy.gmail.com ([64.233.182.190]:53785 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932151AbWDUAJO (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 20 Apr 2006 20:09:14 -0400
Received: by nproxy.gmail.com with SMTP id l24so244123nfc
        for <linux-ide@vger.kernel.org>; Thu, 20 Apr 2006 17:09:13 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org, jgarzik@pobox.com

Add support for detecting the cable bit for PATA ports in the
sata_promise driver.

Signed-off-by: Phil Jordan <phillip.m.jordan@gmail.com>

---
Notes:
* Use together with alternative PATA support patch. (2/2)
* Based on current libata development branch and PATA support patch by
Erik Benada from early 2005 (?)

phil

--- sata_promise.c	2006-04-12 21:27:57.000000000 +0100
+++ sata_promise.c	2006-04-16 22:27:00.000000000 +0100
@@ -96,6 +96,7 @@ static void pdc_tf_load_mmio(struct ata_
 static void pdc_exec_command_mmio(struct ata_port *ap, const struct
ata_taskfile *tf);
 static void pdc_irq_clear(struct ata_port *ap);
 static int pdc_qc_issue_prot(struct ata_queued_cmd *qc);
+static void pdc_pata_cbl_detect(struct ata_port *ap);


 static struct scsi_host_template pdc_ata_sht = {
@@ -326,11 +339,25 @@ static void pdc_sata_phy_reset(struct at
 	sata_phy_reset(ap);
 }

+static void pdc_pata_cbl_detect(struct ata_port *ap)
+{
+	u8 tmp;
+	void *mmio = (void *) ap->ioaddr.cmd_addr + PDC_CTLSTAT + 0x03;
+
+	tmp = readb(mmio);
+
+	if (tmp & 0x01) {
+		ap->cbl = ATA_CBL_PATA40;
+		ap->udma_mask &= ATA_UDMA_MASK_40C;
+	} else {
+		ap->cbl = ATA_CBL_PATA80;
+	}
+}
+
 static void pdc_pata_phy_reset(struct ata_port *ap)
 {
-	/* FIXME: add cable detect.  Don't assume 40-pin cable */
-	ap->cbl = ATA_CBL_PATA40;
-	ap->udma_mask &= ATA_UDMA_MASK_40C;
+	/* FIX: added cable detect.  Don't assume 40-pin cable */
+	pdc_pata_cbl_detect(ap);

 	pdc_reset_port(ap);
 	ata_port_probe(ap);
