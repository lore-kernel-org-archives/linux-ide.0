From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 26/27] libata: don't use ap->ioaddr in non-SFF drivers
Date: Tue, 25 Mar 2008 22:17:04 +0900
Message-ID: <1206451029510-git-send-email-htejun@gmail.com>
References: <1206451025926-git-send-email-htejun@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.225]:15861 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755115AbYCYNRq (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 25 Mar 2008 09:17:46 -0400
Received: by wx-out-0506.google.com with SMTP id h31so3539223wxd.4
        for <linux-ide@vger.kernel.org>; Tue, 25 Mar 2008 06:17:45 -0700 (PDT)
In-Reply-To: <1206451025926-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, linux-ide@vger.kernel.org, liml@rtr.ca, alan@lxorguk.ukuu.org.uk, James.Bottomley@HansenPartnership.com, brking@us.ibm.com, ashish.kalra@freescale.com, leoli@freescale.com
Cc: Tejun Heo <htejun@gmail.com>

ap->ioaddr is to carry addresses for TF and BMDMA registers of a SFF
controller, don't abuse it in non-SFF controllers.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/ahci.c       |   15 ++++-------
 drivers/ata/sata_fsl.c   |    5 ----
 drivers/ata/sata_sil24.c |   60 +++++++++++++++++++++++----------------------
 3 files changed, 36 insertions(+), 44 deletions(-)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 9642a71..6281f7f 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -1179,7 +1179,7 @@ static void ahci_fill_cmd_slot(struct ahci_port_priv *pp, unsigned int tag,
 
 static int ahci_kick_engine(struct ata_port *ap, int force_restart)
 {
-	void __iomem *port_mmio = ap->ioaddr.cmd_addr;
+	void __iomem *port_mmio = ahci_port_base(ap);
 	struct ahci_host_priv *hpriv = ap->host->private_data;
 	u8 status = readl(port_mmio + PORT_TFDATA) & 0xFF;
 	u32 tmp;
@@ -1255,8 +1255,8 @@ static int ahci_exec_polled_cmd(struct ata_port *ap, int pmp,
 
 static int ahci_check_ready(struct ata_link *link)
 {
-	void __iomem *mmio = link->ap->ioaddr.cmd_addr;
-	u8 status = readl(mmio + PORT_TFDATA) & 0xFF;
+	void __iomem *port_mmio = ahci_port_base(link->ap);
+	u8 status = readl(port_mmio + PORT_TFDATA) & 0xFF;
 
 	if (!(status & ATA_BUSY))
 		return 1;
@@ -1616,7 +1616,7 @@ static void ahci_error_intr(struct ata_port *ap, u32 irq_stat)
 
 static void ahci_port_intr(struct ata_port *ap)
 {
-	void __iomem *port_mmio = ap->ioaddr.cmd_addr;
+	void __iomem *port_mmio = ahci_port_base(ap);
 	struct ata_eh_info *ehi = &ap->link.eh_info;
 	struct ahci_port_priv *pp = ap->private_data;
 	struct ahci_host_priv *hpriv = ap->host->private_data;
@@ -2210,7 +2210,6 @@ static int ahci_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	for (i = 0; i < host->n_ports; i++) {
 		struct ata_port *ap = host->ports[i];
-		void __iomem *port_mmio = ahci_port_base(ap);
 
 		ata_port_pbar_desc(ap, AHCI_PCI_BAR, -1, "abar");
 		ata_port_pbar_desc(ap, AHCI_PCI_BAR,
@@ -2219,12 +2218,8 @@ static int ahci_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 		/* set initial link pm policy */
 		ap->pm_policy = NOT_AVAILABLE;
 
-		/* standard SATA port setup */
-		if (hpriv->port_map & (1 << i))
-			ap->ioaddr.cmd_addr = port_mmio;
-
 		/* disabled/not-implemented port */
-		else
+		if (!(hpriv->port_map & (1 << i)))
 			ap->ops = &ata_dummy_port_ops;
 	}
 
diff --git a/drivers/ata/sata_fsl.c b/drivers/ata/sata_fsl.c
index cfe4677..b4b2e0c 100644
--- a/drivers/ata/sata_fsl.c
+++ b/drivers/ata/sata_fsl.c
@@ -1225,11 +1225,6 @@ static int sata_fsl_probe(struct of_device *ofdev,
 	/* host->iomap is not used currently */
 	host->private_data = host_priv;
 
-	/* setup port(s) */
-
-	host->ports[0]->ioaddr.cmd_addr = host_priv->hcr_base;
-	host->ports[0]->ioaddr.scr_addr = host_priv->ssr_base;
-
 	/* initialize host controller */
 	sata_fsl_init_controller(host);
 
diff --git a/drivers/ata/sata_sil24.c b/drivers/ata/sata_sil24.c
index 15a4067..6039614 100644
--- a/drivers/ata/sata_sil24.c
+++ b/drivers/ata/sata_sil24.c
@@ -467,9 +467,19 @@ static int sil24_tag(int tag)
 	return tag;
 }
 
+static unsigned long sil24_port_offset(struct ata_port *ap)
+{
+	return ap->port_no * PORT_REGS_SIZE;
+}
+
+static void __iomem *sil24_port_base(struct ata_port *ap)
+{
+	return ap->host->iomap[SIL24_PORT_BAR] + sil24_port_offset(ap);
+}
+
 static void sil24_dev_config(struct ata_device *dev)
 {
-	void __iomem *port = dev->link->ap->ioaddr.cmd_addr;
+	void __iomem *port = sil24_port_base(dev->link->ap);
 
 	if (dev->cdb_len == 16)
 		writel(PORT_CS_CDB16, port + PORT_CTRL_STAT);
@@ -479,7 +489,7 @@ static void sil24_dev_config(struct ata_device *dev)
 
 static void sil24_read_tf(struct ata_port *ap, int tag, struct ata_taskfile *tf)
 {
-	void __iomem *port = ap->ioaddr.cmd_addr;
+	void __iomem *port = sil24_port_base(ap);
 	struct sil24_prb __iomem *prb;
 	u8 fis[6 * 4];
 
@@ -497,7 +507,7 @@ static int sil24_scr_map[] = {
 
 static int sil24_scr_read(struct ata_port *ap, unsigned sc_reg, u32 *val)
 {
-	void __iomem *scr_addr = ap->ioaddr.scr_addr;
+	void __iomem *scr_addr = sil24_port_base(ap) + PORT_SCONTROL;
 
 	if (sc_reg < ARRAY_SIZE(sil24_scr_map)) {
 		void __iomem *addr;
@@ -510,7 +520,7 @@ static int sil24_scr_read(struct ata_port *ap, unsigned sc_reg, u32 *val)
 
 static int sil24_scr_write(struct ata_port *ap, unsigned sc_reg, u32 val)
 {
-	void __iomem *scr_addr = ap->ioaddr.scr_addr;
+	void __iomem *scr_addr = sil24_port_base(ap) + PORT_SCONTROL;
 
 	if (sc_reg < ARRAY_SIZE(sil24_scr_map)) {
 		void __iomem *addr;
@@ -523,7 +533,7 @@ static int sil24_scr_write(struct ata_port *ap, unsigned sc_reg, u32 val)
 
 static void sil24_config_port(struct ata_port *ap)
 {
-	void __iomem *port = ap->ioaddr.cmd_addr;
+	void __iomem *port = sil24_port_base(ap);
 
 	/* configure IRQ WoC */
 	if (ap->flags & SIL24_FLAG_PCIX_IRQ_WOC)
@@ -548,7 +558,7 @@ static void sil24_config_port(struct ata_port *ap)
 
 static void sil24_config_pmp(struct ata_port *ap, int attached)
 {
-	void __iomem *port = ap->ioaddr.cmd_addr;
+	void __iomem *port = sil24_port_base(ap);
 
 	if (attached)
 		writel(PORT_CS_PMP_EN, port + PORT_CTRL_STAT);
@@ -558,7 +568,7 @@ static void sil24_config_pmp(struct ata_port *ap, int attached)
 
 static void sil24_clear_pmp(struct ata_port *ap)
 {
-	void __iomem *port = ap->ioaddr.cmd_addr;
+	void __iomem *port = sil24_port_base(ap);
 	int i;
 
 	writel(PORT_CS_PMP_RESUME, port + PORT_CTRL_CLR);
@@ -573,7 +583,7 @@ static void sil24_clear_pmp(struct ata_port *ap)
 
 static int sil24_init_port(struct ata_port *ap)
 {
-	void __iomem *port = ap->ioaddr.cmd_addr;
+	void __iomem *port = sil24_port_base(ap);
 	struct sil24_port_priv *pp = ap->private_data;
 	u32 tmp;
 
@@ -601,7 +611,7 @@ static int sil24_exec_polled_cmd(struct ata_port *ap, int pmp,
 				 int is_cmd, u32 ctrl,
 				 unsigned long timeout_msec)
 {
-	void __iomem *port = ap->ioaddr.cmd_addr;
+	void __iomem *port = sil24_port_base(ap);
 	struct sil24_port_priv *pp = ap->private_data;
 	struct sil24_prb *prb = &pp->cmd_block[0].ata.prb;
 	dma_addr_t paddr = pp->cmd_block_dma;
@@ -706,7 +716,7 @@ static int sil24_hardreset(struct ata_link *link, unsigned int *class,
 			   unsigned long deadline)
 {
 	struct ata_port *ap = link->ap;
-	void __iomem *port = ap->ioaddr.cmd_addr;
+	void __iomem *port = sil24_port_base(ap);
 	struct sil24_port_priv *pp = ap->private_data;
 	int did_port_rst = 0;
 	const char *reason;
@@ -884,7 +894,7 @@ static unsigned int sil24_qc_issue(struct ata_queued_cmd *qc)
 {
 	struct ata_port *ap = qc->ap;
 	struct sil24_port_priv *pp = ap->private_data;
-	void __iomem *port = ap->ioaddr.cmd_addr;
+	void __iomem *port = sil24_port_base(ap);
 	unsigned int tag = sil24_tag(qc->tag);
 	dma_addr_t paddr;
 	void __iomem *activate;
@@ -939,7 +949,7 @@ static int sil24_pmp_hardreset(struct ata_link *link, unsigned int *class,
 
 static void sil24_freeze(struct ata_port *ap)
 {
-	void __iomem *port = ap->ioaddr.cmd_addr;
+	void __iomem *port = sil24_port_base(ap);
 
 	/* Port-wide IRQ mask in HOST_CTRL doesn't really work, clear
 	 * PORT_IRQ_ENABLE instead.
@@ -949,7 +959,7 @@ static void sil24_freeze(struct ata_port *ap)
 
 static void sil24_thaw(struct ata_port *ap)
 {
-	void __iomem *port = ap->ioaddr.cmd_addr;
+	void __iomem *port = sil24_port_base(ap);
 	u32 tmp;
 
 	/* clear IRQ */
@@ -962,7 +972,7 @@ static void sil24_thaw(struct ata_port *ap)
 
 static void sil24_error_intr(struct ata_port *ap)
 {
-	void __iomem *port = ap->ioaddr.cmd_addr;
+	void __iomem *port = sil24_port_base(ap);
 	struct sil24_port_priv *pp = ap->private_data;
 	struct ata_queued_cmd *qc = NULL;
 	struct ata_link *link;
@@ -1089,7 +1099,7 @@ static void sil24_error_intr(struct ata_port *ap)
 
 static inline void sil24_host_intr(struct ata_port *ap)
 {
-	void __iomem *port = ap->ioaddr.cmd_addr;
+	void __iomem *port = sil24_port_base(ap);
 	u32 slot_stat, qc_active;
 	int rc;
 
@@ -1209,6 +1219,9 @@ static int sil24_port_start(struct ata_port *ap)
 
 	ap->private_data = pp;
 
+	ata_port_pbar_desc(ap, SIL24_HOST_BAR, -1, "host");
+	ata_port_pbar_desc(ap, SIL24_PORT_BAR, sil24_port_offset(ap), "port");
+
 	return 0;
 }
 
@@ -1227,7 +1240,8 @@ static void sil24_init_controller(struct ata_host *host)
 	/* init ports */
 	for (i = 0; i < host->n_ports; i++) {
 		struct ata_port *ap = host->ports[i];
-		void __iomem *port = ap->ioaddr.cmd_addr;
+		void __iomem *port = sil24_port_base(ap);
+
 
 		/* Initial PHY setting */
 		writel(0x20c, port + PORT_PHY_CFG);
@@ -1260,7 +1274,7 @@ static int sil24_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	const struct ata_port_info *ppi[] = { &pi, NULL };
 	void __iomem * const *iomap;
 	struct ata_host *host;
-	int i, rc;
+	int rc;
 	u32 tmp;
 
 	/* cause link error if sil24_cmd_block is sized wrongly */
@@ -1300,18 +1314,6 @@ static int sil24_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 		return -ENOMEM;
 	host->iomap = iomap;
 
-	for (i = 0; i < host->n_ports; i++) {
-		struct ata_port *ap = host->ports[i];
-		size_t offset = ap->port_no * PORT_REGS_SIZE;
-		void __iomem *port = iomap[SIL24_PORT_BAR] + offset;
-
-		host->ports[i]->ioaddr.cmd_addr = port;
-		host->ports[i]->ioaddr.scr_addr = port + PORT_SCONTROL;
-
-		ata_port_pbar_desc(ap, SIL24_HOST_BAR, -1, "host");
-		ata_port_pbar_desc(ap, SIL24_PORT_BAR, offset, "port");
-	}
-
 	/* configure and activate the device */
 	if (!pci_set_dma_mask(pdev, DMA_64BIT_MASK)) {
 		rc = pci_set_consistent_dma_mask(pdev, DMA_64BIT_MASK);
-- 
1.5.2.4

