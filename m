From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 09/10] sata_inic162x: add cardbus support
Date: Wed, 30 Apr 2008 16:35:16 +0900
Message-ID: <12095409192606-git-send-email-htejun@gmail.com>
References: <12095409172824-git-send-email-htejun@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.179]:38540 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755817AbYD3Hfb (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 30 Apr 2008 03:35:31 -0400
Received: by py-out-1112.google.com with SMTP id u52so616522pyb.10
        for <linux-ide@vger.kernel.org>; Wed, 30 Apr 2008 00:35:30 -0700 (PDT)
In-Reply-To: <12095409172824-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

When attached to cardbus, mmio region is at BAR 1.  Other than that,
everything else is the same.  Add support for it.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/sata_inic162x.c |   36 ++++++++++++++++++++++++------------
 1 files changed, 24 insertions(+), 12 deletions(-)

diff --git a/drivers/ata/sata_inic162x.c b/drivers/ata/sata_inic162x.c
index ee67d6e..bfbd34b 100644
--- a/drivers/ata/sata_inic162x.c
+++ b/drivers/ata/sata_inic162x.c
@@ -31,7 +31,8 @@
 #define DRV_VERSION	"0.3"
 
 enum {
-	MMIO_BAR		= 5,
+	MMIO_BAR_PCI		= 5,
+	MMIO_BAR_CARDBUS	= 1,
 
 	NR_PORTS		= 2,
 
@@ -197,6 +198,7 @@ struct inic_pkt {
 } __packed;
 
 struct inic_host_priv {
+	void __iomem	*mmio_base;
 	u16		cached_hctl;
 };
 
@@ -221,7 +223,9 @@ static const int scr_map[] = {
 
 static void __iomem *inic_port_base(struct ata_port *ap)
 {
-	return ap->host->iomap[MMIO_BAR] + ap->port_no * PORT_SIZE;
+	struct inic_host_priv *hpriv = ap->host->private_data;
+
+	return hpriv->mmio_base + ap->port_no * PORT_SIZE;
 }
 
 static void inic_reset_port(void __iomem *port_base)
@@ -378,11 +382,11 @@ static void inic_host_intr(struct ata_port *ap)
 static irqreturn_t inic_interrupt(int irq, void *dev_instance)
 {
 	struct ata_host *host = dev_instance;
-	void __iomem *mmio_base = host->iomap[MMIO_BAR];
+	struct inic_host_priv *hpriv = host->private_data;
 	u16 host_irq_stat;
 	int i, handled = 0;;
 
-	host_irq_stat = readw(mmio_base + HOST_IRQ_STAT);
+	host_irq_stat = readw(hpriv->mmio_base + HOST_IRQ_STAT);
 
 	if (unlikely(!(host_irq_stat & HIRQ_GLOBAL)))
 		goto out;
@@ -776,7 +780,6 @@ static int inic_pci_device_resume(struct pci_dev *pdev)
 {
 	struct ata_host *host = dev_get_drvdata(&pdev->dev);
 	struct inic_host_priv *hpriv = host->private_data;
-	void __iomem *mmio_base = host->iomap[MMIO_BAR];
 	int rc;
 
 	rc = ata_pci_device_do_resume(pdev);
@@ -784,7 +787,7 @@ static int inic_pci_device_resume(struct pci_dev *pdev)
 		return rc;
 
 	if (pdev->dev.power.power_state.event == PM_EVENT_SUSPEND) {
-		rc = init_controller(mmio_base, hpriv->cached_hctl);
+		rc = init_controller(hpriv->mmio_base, hpriv->cached_hctl);
 		if (rc)
 			return rc;
 	}
@@ -802,6 +805,7 @@ static int inic_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	struct ata_host *host;
 	struct inic_host_priv *hpriv;
 	void __iomem * const *iomap;
+	int mmio_bar;
 	int i, rc;
 
 	if (!printed_version++)
@@ -815,22 +819,30 @@ static int inic_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	host->private_data = hpriv;
 
-	/* acquire resources and fill host */
+	/* Acquire resources and fill host.  Note that PCI and cardbus
+	 * use different BARs.
+	 */
 	rc = pcim_enable_device(pdev);
 	if (rc)
 		return rc;
 
-	rc = pcim_iomap_regions(pdev, 1 << MMIO_BAR, DRV_NAME);
+	if (pci_resource_flags(pdev, MMIO_BAR_PCI) & IORESOURCE_MEM)
+		mmio_bar = MMIO_BAR_PCI;
+	else
+		mmio_bar = MMIO_BAR_CARDBUS;
+
+	rc = pcim_iomap_regions(pdev, 1 << mmio_bar, DRV_NAME);
 	if (rc)
 		return rc;
 	host->iomap = iomap = pcim_iomap_table(pdev);
-	hpriv->cached_hctl = readw(iomap[MMIO_BAR] + HOST_CTL);
+	hpriv->mmio_base = iomap[mmio_bar];
+	hpriv->cached_hctl = readw(hpriv->mmio_base + HOST_CTL);
 
 	for (i = 0; i < NR_PORTS; i++) {
 		struct ata_port *ap = host->ports[i];
 
-		ata_port_pbar_desc(ap, MMIO_BAR, -1, "mmio");
-		ata_port_pbar_desc(ap, MMIO_BAR, i * PORT_SIZE, "port");
+		ata_port_pbar_desc(ap, mmio_bar, -1, "mmio");
+		ata_port_pbar_desc(ap, mmio_bar, i * PORT_SIZE, "port");
 	}
 
 	/* Set dma_mask.  This devices doesn't support 64bit addressing. */
@@ -860,7 +872,7 @@ static int inic_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 		return rc;
 	}
 
-	rc = init_controller(iomap[MMIO_BAR], hpriv->cached_hctl);
+	rc = init_controller(hpriv->mmio_base, hpriv->cached_hctl);
 	if (rc) {
 		dev_printk(KERN_ERR, &pdev->dev,
 			   "failed to initialize controller\n");
-- 
1.5.2.4

