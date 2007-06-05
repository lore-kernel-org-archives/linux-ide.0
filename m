From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 2.6.22-rc4] libata: SiS180 pata support
Date: Tue, 5 Jun 2007 19:19:12 -0400
Message-ID: <20070605231912.GW31565@havoc.gtf.org>
References: <200706060104.18055.uwe.koziolek@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from havoc.gtf.org ([69.61.125.42]:45321 "EHLO havoc.gtf.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1765383AbXFEXTO (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 5 Jun 2007 19:19:14 -0400
Content-Disposition: inline
In-Reply-To: <200706060104.18055.uwe.koziolek@gmx.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Uwe Koziolek <uwe.koziolek@gmx.net>
Cc: Alan <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org


Nevermind, I did it myself:

This ensures that we can easily make changes specific to the PATA port
on the newer SATA chips, and also does what I've been requesting -- use
the standard ata_bmdma_error_handler(), rather than creating custom code
that achieves the same effect.


diff --git a/drivers/ata/pata_sis.c b/drivers/ata/pata_sis.c
index ec3ae93..0752104 100644
--- a/drivers/ata/pata_sis.c
+++ b/drivers/ata/pata_sis.c
@@ -560,6 +560,40 @@ static const struct ata_port_operations sis_133_ops = {
 	.port_start		= ata_port_start,
 };
 
+static const struct ata_port_operations sis_133_for_sata_ops = {
+	.port_disable		= ata_port_disable,
+	.set_piomode		= sis_133_set_piomode,
+	.set_dmamode		= sis_133_set_dmamode,
+	.mode_filter		= ata_pci_default_filter,
+
+	.tf_load		= ata_tf_load,
+	.tf_read		= ata_tf_read,
+	.check_status		= ata_check_status,
+	.exec_command		= ata_exec_command,
+	.dev_select		= ata_std_dev_select,
+
+	.freeze			= ata_bmdma_freeze,
+	.thaw			= ata_bmdma_thaw,
+	.error_handler		= ata_bmdma_error_handler,
+	.post_internal_cmd	= ata_bmdma_post_internal_cmd,
+	.cable_detect		= sis_133_cable_detect,
+
+	.bmdma_setup		= ata_bmdma_setup,
+	.bmdma_start		= ata_bmdma_start,
+	.bmdma_stop		= ata_bmdma_stop,
+	.bmdma_status		= ata_bmdma_status,
+	.qc_prep		= ata_qc_prep,
+	.qc_issue		= ata_qc_issue_prot,
+	.data_xfer		= ata_data_xfer,
+
+	.irq_handler		= ata_interrupt,
+	.irq_clear		= ata_bmdma_irq_clear,
+	.irq_on			= ata_irq_on,
+	.irq_ack		= ata_irq_ack,
+
+	.port_start		= ata_port_start,
+};
+
 static const struct ata_port_operations sis_133_early_ops = {
 	.port_disable		= ata_port_disable,
 	.set_piomode		= sis_100_set_piomode,
@@ -733,13 +767,20 @@ static const struct ata_port_info sis_info100_early = {
 	.pio_mask	= 0x1f,	/* pio0-4 */
 	.port_ops	= &sis_66_ops,
 };
-const struct ata_port_info sis_info133 = {
+static const struct ata_port_info sis_info133 = {
 	.sht		= &sis_sht,
 	.flags		= ATA_FLAG_SLAVE_POSS | ATA_FLAG_SRST,
 	.pio_mask	= 0x1f,	/* pio0-4 */
 	.udma_mask	= ATA_UDMA6,
 	.port_ops	= &sis_133_ops,
 };
+static const struct ata_port_info sis_info133_for_sata = {
+	.sht		= &sis_sht,
+	.flags		= ATA_FLAG_SLAVE_POSS | ATA_FLAG_SRST,
+	.pio_mask	= 0x1f,	/* pio0-4 */
+	.udma_mask	= ATA_UDMA6,
+	.port_ops	= &sis_133_for_sata_ops,
+};
 static const struct ata_port_info sis_info133_early = {
 	.sht		= &sis_sht,
 	.flags		= ATA_FLAG_SLAVE_POSS | ATA_FLAG_SRST,
@@ -749,7 +790,7 @@ static const struct ata_port_info sis_info133_early = {
 };
 
 /* Privately shared with the SiS180 SATA driver, not for use elsewhere */
-EXPORT_SYMBOL_GPL(sis_info133);
+EXPORT_SYMBOL_GPL(sis_info133_for_sata);
 
 static void sis_fixup(struct pci_dev *pdev, struct sis_chipset *sis)
 {
diff --git a/drivers/ata/sata_sis.c b/drivers/ata/sata_sis.c
index 221099d..40afa39 100644
--- a/drivers/ata/sata_sis.c
+++ b/drivers/ata/sata_sis.c
@@ -293,11 +293,11 @@ static int sis_init_one (struct pci_dev *pdev, const struct pci_device_id *ent)
 		/* The PATA-handling is provided by pata_sis */
 		switch (pmr & 0x30) {
 		case 0x10:
-			ppi[1] = &sis_info133;
+			ppi[1] = &sis_info133_for_sata;
 			break;
 
 		case 0x30:
-			ppi[0] = &sis_info133;
+			ppi[0] = &sis_info133_for_sata;
 			break;
 		}
 		if ((pmr & SIS_PMR_COMBINED) == 0) {
diff --git a/drivers/ata/sis.h b/drivers/ata/sis.h
index 0f2208d..f7f3eeb 100644
--- a/drivers/ata/sis.h
+++ b/drivers/ata/sis.h
@@ -2,4 +2,4 @@
 struct ata_port_info;
 
 /* pata_sis.c */
-extern const struct ata_port_info sis_info133;
+extern const struct ata_port_info sis_info133_for_sata;
