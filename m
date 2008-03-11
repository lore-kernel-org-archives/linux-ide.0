From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 8/9] libata: kill port_info->sht and ->irq_handler
Date: Tue, 11 Mar 2008 21:06:04 +0900
Message-ID: <12052371683661-git-send-email-htejun@gmail.com>
References: <12052371651181-git-send-email-htejun@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.180]:45241 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757336AbYCKMGV (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 11 Mar 2008 08:06:21 -0400
Received: by wa-out-1112.google.com with SMTP id v27so2814301wah.23
        for <linux-ide@vger.kernel.org>; Tue, 11 Mar 2008 05:06:21 -0700 (PDT)
In-Reply-To: <12052371651181-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, linux-ide@vger.kernel.org, liml@rtr.ca, alan@lxorguk.ukuu.org.uk, kngregertsen@norway.atmel.com, sonic.adi@gmail.com, rmk@arm.linux.org.uk, alessandro.zummo@towertech
Cc: Tejun Heo <htejun@gmail.com>

libata core layer doesn't care about sht or ->irq_handler.  Those are
only of interest to the LLD during initialization.  This is confusing
and has caused several drivers to have duplicate unused initializers
for these fields.

Currently only sata_nv uses these fields.  Make sata_nv use
->private_data, which is supposed to carry LLD-specific information,
instead and kill ->sht and ->irq_handler.  nv_pi_priv structure is
defined and struct literals are used to initialize private_data.
Notational overhead is negligible.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/sata_nv.c  |   29 +++++++++++++++++------------
 include/linux/libata.h |    2 --
 2 files changed, 17 insertions(+), 14 deletions(-)

diff --git a/drivers/ata/sata_nv.c b/drivers/ata/sata_nv.c
index 7b7ba0e..5637b08 100644
--- a/drivers/ata/sata_nv.c
+++ b/drivers/ata/sata_nv.c
@@ -466,58 +466,61 @@ static struct ata_port_operations nv_swncq_ops = {
 	.port_start		= nv_swncq_port_start,
 };
 
+struct nv_pi_priv {
+	irq_handler_t			irq_handler;
+	struct scsi_host_template	*sht;
+};
+
+#define NV_PI_PRIV(_irq_handler, _sht) \
+	&(struct nv_pi_priv){ .irq_handler = _irq_handler, .sht = _sht }
+
 static const struct ata_port_info nv_port_info[] = {
 	/* generic */
 	{
-		.sht		= &nv_sht,
 		.flags		= ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY,
 		.pio_mask	= NV_PIO_MASK,
 		.mwdma_mask	= NV_MWDMA_MASK,
 		.udma_mask	= NV_UDMA_MASK,
 		.port_ops	= &nv_generic_ops,
-		.irq_handler	= nv_generic_interrupt,
+		.private_data	= NV_PI_PRIV(nv_generic_interrupt, &nv_sht),
 	},
 	/* nforce2/3 */
 	{
-		.sht		= &nv_sht,
 		.flags		= ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY,
 		.pio_mask	= NV_PIO_MASK,
 		.mwdma_mask	= NV_MWDMA_MASK,
 		.udma_mask	= NV_UDMA_MASK,
 		.port_ops	= &nv_nf2_ops,
-		.irq_handler	= nv_nf2_interrupt,
+		.private_data	= NV_PI_PRIV(nv_nf2_interrupt, &nv_sht),
 	},
 	/* ck804 */
 	{
-		.sht		= &nv_sht,
 		.flags		= ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY,
 		.pio_mask	= NV_PIO_MASK,
 		.mwdma_mask	= NV_MWDMA_MASK,
 		.udma_mask	= NV_UDMA_MASK,
 		.port_ops	= &nv_ck804_ops,
-		.irq_handler	= nv_ck804_interrupt,
+		.private_data	= NV_PI_PRIV(nv_ck804_interrupt, &nv_sht),
 	},
 	/* ADMA */
 	{
-		.sht		= &nv_adma_sht,
 		.flags		= ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
 				  ATA_FLAG_MMIO | ATA_FLAG_NCQ,
 		.pio_mask	= NV_PIO_MASK,
 		.mwdma_mask	= NV_MWDMA_MASK,
 		.udma_mask	= NV_UDMA_MASK,
 		.port_ops	= &nv_adma_ops,
-		.irq_handler	= nv_adma_interrupt,
+		.private_data	= NV_PI_PRIV(nv_adma_interrupt, &nv_adma_sht),
 	},
 	/* SWNCQ */
 	{
-		.sht		= &nv_swncq_sht,
 		.flags	        = ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
 				  ATA_FLAG_NCQ,
 		.pio_mask	= NV_PIO_MASK,
 		.mwdma_mask	= NV_MWDMA_MASK,
 		.udma_mask	= NV_UDMA_MASK,
 		.port_ops	= &nv_swncq_ops,
-		.irq_handler	= nv_swncq_interrupt,
+		.private_data	= NV_PI_PRIV(nv_swncq_interrupt, &nv_swncq_sht),
 	},
 };
 
@@ -2316,6 +2319,7 @@ static int nv_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 {
 	static int printed_version;
 	const struct ata_port_info *ppi[] = { NULL, NULL };
+	struct nv_pi_priv *ipriv;
 	struct ata_host *host;
 	struct nv_host_priv *hpriv;
 	int rc;
@@ -2352,6 +2356,7 @@ static int nv_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	}
 
 	ppi[0] = &nv_port_info[type];
+	ipriv = ppi[0]->private_data;
 	rc = ata_pci_prepare_sff_host(pdev, ppi, &host);
 	if (rc)
 		return rc;
@@ -2390,8 +2395,8 @@ static int nv_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 		nv_swncq_host_init(host);
 
 	pci_set_master(pdev);
-	return ata_host_activate(host, pdev->irq, ppi[0]->irq_handler,
-				 IRQF_SHARED, ppi[0]->sht);
+	return ata_host_activate(host, pdev->irq, ipriv->irq_handler,
+				 IRQF_SHARED, ipriv->sht);
 }
 
 #ifdef CONFIG_PM
diff --git a/include/linux/libata.h b/include/linux/libata.h
index e24b94c..4f61beb 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -746,14 +746,12 @@ struct ata_port_operations {
 };
 
 struct ata_port_info {
-	struct scsi_host_template	*sht;
 	unsigned long		flags;
 	unsigned long		link_flags;
 	unsigned long		pio_mask;
 	unsigned long		mwdma_mask;
 	unsigned long		udma_mask;
 	struct ata_port_operations *port_ops;
-	irq_handler_t		irq_handler;
 	void 			*private_data;
 };
 
-- 
1.5.2.4

