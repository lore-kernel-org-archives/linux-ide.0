From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 09/10] ahci: move host flags over to pi.private_data
Date: Sun, 23 Sep 2007 13:19:55 +0900
Message-ID: <1190521195914-git-send-email-htejun@gmail.com>
References: <1190521193410-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.183]:10667 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752752AbXIWEUK (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 23 Sep 2007 00:20:10 -0400
Received: by wa-out-1112.google.com with SMTP id v27so1547080wah
        for <linux-ide@vger.kernel.org>; Sat, 22 Sep 2007 21:20:10 -0700 (PDT)
In-Reply-To: <1190521193410-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Private pi.flags area is full and we need more private flags.  Move
host private flags over to pi.private_data.  During initialization,
these flags are copied to hpriv->flags.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/ahci.c |   63 ++++++++++++++++++++++++++++-----------------------
 1 files changed, 35 insertions(+), 28 deletions(-)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index d06a8b3..1111dc2 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -169,14 +169,16 @@ enum {
 	PORT_CMD_ICC_PARTIAL	= (0x2 << 28), /* Put i/f in partial state */
 	PORT_CMD_ICC_SLUMBER	= (0x6 << 28), /* Put i/f in slumber state */
 
+	/* hpriv->flags bits */
+	AHCI_HFLAG_NO_NCQ		= (1 << 0),
+	AHCI_HFLAG_IGN_IRQ_IF_ERR	= (1 << 1), /* ignore IRQ_IF_ERR */
+	AHCI_HFLAG_IGN_SERR_INTERNAL	= (1 << 2), /* ignore SERR_INTERNAL */
+	AHCI_HFLAG_32BIT_ONLY		= (1 << 3), /* force 32bit */
+	AHCI_HFLAG_MV_PATA		= (1 << 4), /* PATA port */
+	AHCI_HFLAG_NO_MSI		= (1 << 5), /* no PCI MSI */
+
 	/* ap->flags bits */
-	AHCI_FLAG_NO_NCQ		= (1 << 24),
-	AHCI_FLAG_IGN_IRQ_IF_ERR	= (1 << 25), /* ignore IRQ_IF_ERR */
-	AHCI_FLAG_IGN_SERR_INTERNAL	= (1 << 27), /* ignore SERR_INTERNAL */
-	AHCI_FLAG_32BIT_ONLY		= (1 << 28), /* force 32bit */
-	AHCI_FLAG_MV_PATA		= (1 << 29), /* PATA port */
-	AHCI_FLAG_NO_MSI		= (1 << 30), /* no PCI MSI */
-	AHCI_FLAG_NO_HOTPLUG		= (1 << 31), /* ignore PxSERR.DIAG.N */
+	AHCI_FLAG_NO_HOTPLUG		= (1 << 24), /* ignore PxSERR.DIAG.N */
 
 	AHCI_FLAG_COMMON		= ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
 					  ATA_FLAG_MMIO | ATA_FLAG_PIO_DMA |
@@ -200,6 +202,7 @@ struct ahci_sg {
 };
 
 struct ahci_host_priv {
+	unsigned int		flags;		/* AHCI_HFLAG_* */
 	u32			cap;		/* cap to use */
 	u32			port_map;	/* port map to use */
 	u32			saved_cap;	/* saved initial cap */
@@ -341,6 +344,8 @@ static const struct ata_port_operations ahci_vt8251_ops = {
 	.port_stop		= ahci_port_stop,
 };
 
+#define AHCI_HFLAGS(flags)	.private_data	= (void *)(flags)
+
 static const struct ata_port_info ahci_port_info[] = {
 	/* board_ahci */
 	{
@@ -352,7 +357,8 @@ static const struct ata_port_info ahci_port_info[] = {
 	},
 	/* board_ahci_vt8251 */
 	{
-		.flags		= AHCI_FLAG_COMMON | AHCI_FLAG_NO_NCQ,
+		AHCI_HFLAGS	(AHCI_HFLAG_NO_NCQ),
+		.flags		= AHCI_FLAG_COMMON,
 		.link_flags	= AHCI_LFLAG_COMMON | ATA_LFLAG_HRST_TO_RESUME,
 		.pio_mask	= 0x1f, /* pio0-4 */
 		.udma_mask	= ATA_UDMA6,
@@ -360,7 +366,8 @@ static const struct ata_port_info ahci_port_info[] = {
 	},
 	/* board_ahci_ign_iferr */
 	{
-		.flags		= AHCI_FLAG_COMMON | AHCI_FLAG_IGN_IRQ_IF_ERR,
+		AHCI_HFLAGS	(AHCI_HFLAG_IGN_IRQ_IF_ERR),
+		.flags		= AHCI_FLAG_COMMON,
 		.link_flags	= AHCI_LFLAG_COMMON,
 		.pio_mask	= 0x1f, /* pio0-4 */
 		.udma_mask	= ATA_UDMA6,
@@ -368,9 +375,9 @@ static const struct ata_port_info ahci_port_info[] = {
 	},
 	/* board_ahci_sb600 */
 	{
-		.flags		= AHCI_FLAG_COMMON |
-				  AHCI_FLAG_IGN_SERR_INTERNAL |
-				  AHCI_FLAG_32BIT_ONLY,
+		AHCI_HFLAGS	(AHCI_HFLAG_IGN_SERR_INTERNAL |
+				 AHCI_HFLAG_32BIT_ONLY),
+		.flags		= AHCI_FLAG_COMMON,
 		.link_flags	= AHCI_LFLAG_COMMON,
 		.pio_mask	= 0x1f, /* pio0-4 */
 		.udma_mask	= ATA_UDMA6,
@@ -378,11 +385,10 @@ static const struct ata_port_info ahci_port_info[] = {
 	},
 	/* board_ahci_mv */
 	{
-		.sht		= &ahci_sht,
+		AHCI_HFLAGS	(AHCI_HFLAG_NO_NCQ | AHCI_HFLAG_NO_MSI |
+				 AHCI_HFLAG_MV_PATA),
 		.flags		= ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
-				  ATA_FLAG_MMIO | ATA_FLAG_PIO_DMA |
-				  AHCI_FLAG_NO_NCQ | AHCI_FLAG_NO_MSI |
-				  AHCI_FLAG_MV_PATA,
+				  ATA_FLAG_MMIO | ATA_FLAG_PIO_DMA,
 		.link_flags	= AHCI_LFLAG_COMMON,
 		.pio_mask	= 0x1f, /* pio0-4 */
 		.udma_mask	= ATA_UDMA6,
@@ -534,7 +540,6 @@ static inline void __iomem *ahci_port_base(struct ata_port *ap)
 /**
  *	ahci_save_initial_config - Save and fixup initial config values
  *	@pdev: target PCI device
- *	@pi: associated ATA port info
  *	@hpriv: host private area to store config values
  *
  *	Some registers containing configuration info might be setup by
@@ -548,7 +553,6 @@ static inline void __iomem *ahci_port_base(struct ata_port *ap)
  *	None.
  */
 static void ahci_save_initial_config(struct pci_dev *pdev,
-				     const struct ata_port_info *pi,
 				     struct ahci_host_priv *hpriv)
 {
 	void __iomem *mmio = pcim_iomap_table(pdev)[AHCI_PCI_BAR];
@@ -562,13 +566,13 @@ static void ahci_save_initial_config(struct pci_dev *pdev,
 	hpriv->saved_port_map = port_map = readl(mmio + HOST_PORTS_IMPL);
 
 	/* some chips have errata preventing 64bit use */
-	if ((cap & HOST_CAP_64) && (pi->flags & AHCI_FLAG_32BIT_ONLY)) {
+	if ((cap & HOST_CAP_64) && (hpriv->flags & AHCI_HFLAG_32BIT_ONLY)) {
 		dev_printk(KERN_INFO, &pdev->dev,
 			   "controller can't do 64bit DMA, forcing 32bit\n");
 		cap &= ~HOST_CAP_64;
 	}
 
-	if ((cap & HOST_CAP_NCQ) && (pi->flags & AHCI_FLAG_NO_NCQ)) {
+	if ((cap & HOST_CAP_NCQ) && (hpriv->flags & AHCI_HFLAG_NO_NCQ)) {
 		dev_printk(KERN_INFO, &pdev->dev,
 			   "controller can't do NCQ, turning off CAP_NCQ\n");
 		cap &= ~HOST_CAP_NCQ;
@@ -579,7 +583,7 @@ static void ahci_save_initial_config(struct pci_dev *pdev,
 	 * is asserted through the standard AHCI port
 	 * presence register, as bit 4 (counting from 0)
 	 */
-	if (pi->flags & AHCI_FLAG_MV_PATA) {
+	if (hpriv->flags & AHCI_HFLAG_MV_PATA) {
 		dev_printk(KERN_ERR, &pdev->dev,
 			   "MV_AHCI HACK: port_map %x -> %x\n",
 			   hpriv->port_map,
@@ -913,13 +917,14 @@ static void ahci_port_init(struct pci_dev *pdev, struct ata_port *ap,
 
 static void ahci_init_controller(struct ata_host *host)
 {
+	struct ahci_host_priv *hpriv = host->private_data;
 	struct pci_dev *pdev = to_pci_dev(host->dev);
 	void __iomem *mmio = host->iomap[AHCI_PCI_BAR];
 	int i;
 	void __iomem *port_mmio;
 	u32 tmp;
 
-	if (host->ports[0]->flags & AHCI_FLAG_MV_PATA) {
+	if (hpriv->flags & AHCI_HFLAG_MV_PATA) {
 		port_mmio = __ahci_port_base(host, 4);
 
 		writel(0, port_mmio + PORT_IRQ_MASK);
@@ -1301,6 +1306,7 @@ static void ahci_qc_prep(struct ata_queued_cmd *qc)
 
 static void ahci_error_intr(struct ata_port *ap, u32 irq_stat)
 {
+	struct ahci_host_priv *hpriv = ap->host->private_data;
 	struct ahci_port_priv *pp = ap->private_data;
 	struct ata_eh_info *host_ehi = &ap->link.eh_info;
 	struct ata_link *link = NULL;
@@ -1328,7 +1334,7 @@ static void ahci_error_intr(struct ata_port *ap, u32 irq_stat)
 	host_ehi->serror |= serror;
 
 	/* some controllers set IRQ_IF_ERR on device errors, ignore it */
-	if (ap->flags & AHCI_FLAG_IGN_IRQ_IF_ERR)
+	if (hpriv->flags & AHCI_HFLAG_IGN_IRQ_IF_ERR)
 		irq_stat &= ~PORT_IRQ_IF_ERR;
 
 	if (irq_stat & PORT_IRQ_TF_ERR) {
@@ -1341,7 +1347,7 @@ static void ahci_error_intr(struct ata_port *ap, u32 irq_stat)
 		else
 			active_ehi->err_mask |= AC_ERR_DEV;
 
-		if (ap->flags & AHCI_FLAG_IGN_SERR_INTERNAL)
+		if (hpriv->flags & AHCI_HFLAG_IGN_SERR_INTERNAL)
 			host_ehi->serror &= ~SERR_INTERNAL;
 	}
 
@@ -1971,15 +1977,16 @@ static int ahci_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	if (rc)
 		return rc;
 
-	if ((pi.flags & AHCI_FLAG_NO_MSI) || pci_enable_msi(pdev))
-		pci_intx(pdev, 1);
-
 	hpriv = devm_kzalloc(dev, sizeof(*hpriv), GFP_KERNEL);
 	if (!hpriv)
 		return -ENOMEM;
+	hpriv->flags |= (unsigned long)pi.private_data;
+
+	if ((hpriv->flags & AHCI_HFLAG_NO_MSI) || pci_enable_msi(pdev))
+		pci_intx(pdev, 1);
 
 	/* save initial config */
-	ahci_save_initial_config(pdev, &pi, hpriv);
+	ahci_save_initial_config(pdev, hpriv);
 
 	/* prepare host */
 	if (hpriv->cap & HOST_CAP_NCQ)
-- 
1.5.0.3


