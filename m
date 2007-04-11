From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 10/12] libata: convert the remaining SATA drivers to new init model
Date: Wed, 11 Apr 2007 15:42:05 +0900
Message-ID: <1176273725684-git-send-email-htejun@gmail.com>
References: <1176273724198-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.234]:40961 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753278AbXDKGmQ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 11 Apr 2007 02:42:16 -0400
Received: by nz-out-0506.google.com with SMTP id s1so57272nze
        for <linux-ide@vger.kernel.org>; Tue, 10 Apr 2007 23:42:16 -0700 (PDT)
In-Reply-To: <1176273724198-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org, brking@linux.vnet.ibm.com
Cc: Tejun Heo <htejun@gmail.com>

Convert ahci, sata_sil, sata_sil24, sata_svw, sata_qstor, sata_mv,
sata_sx4, sata_vsc and sata_inic162x to new init model.

Now that host and ap are available during intialization, functions are
converted to take either host or ap instead of low level parameters
which were inevitable for functions shared between init and other
paths.  This simplifies code quite a bit.

* init_one()'s now follow more consistent init order

* ahci_setup_port() and ahci_host_init() collapsed into
  ahci_init_one() for init order consistency

* sata_vsc uses port_info instead of setting fields manually

* in sata_svw, k2_board_info converted to port_info (info is now in
  port flags).  port number is honored now.

Tested on ICH7/8 AHCI, jmb360, sil3112, 3114, 3124 and 3132.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/ahci.c          |  327 ++++++++++++++++++-------------------------
 drivers/ata/sata_inic162x.c |   78 ++++-------
 drivers/ata/sata_mv.c       |  105 ++++++---------
 drivers/ata/sata_qstor.c    |   62 +++------
 drivers/ata/sata_sil.c      |   89 +++++-------
 drivers/ata/sata_sil24.c    |  111 ++++++----------
 drivers/ata/sata_svw.c      |  107 +++++++--------
 drivers/ata/sata_sx4.c      |  150 +++++++++-----------
 drivers/ata/sata_vsc.c      |   72 ++++------
 9 files changed, 444 insertions(+), 657 deletions(-)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index fb9f692..faa7588 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -211,7 +211,6 @@ static u32 ahci_scr_read (struct ata_port *ap, unsigned int sc_reg);
 static void ahci_scr_write (struct ata_port *ap, unsigned int sc_reg, u32 val);
 static int ahci_init_one (struct pci_dev *pdev, const struct pci_device_id *ent);
 static unsigned int ahci_qc_issue(struct ata_queued_cmd *qc);
-static irqreturn_t ahci_interrupt (int irq, void *dev_instance);
 static void ahci_irq_clear(struct ata_port *ap);
 static int ahci_port_start(struct ata_port *ap);
 static void ahci_port_stop(struct ata_port *ap);
@@ -265,7 +264,6 @@ static const struct ata_port_operations ahci_ops = {
 	.qc_prep		= ahci_qc_prep,
 	.qc_issue		= ahci_qc_issue,
 
-	.irq_handler		= ahci_interrupt,
 	.irq_clear		= ahci_irq_clear,
 	.irq_on			= ata_dummy_irq_on,
 	.irq_ack		= ata_dummy_irq_ack,
@@ -300,7 +298,6 @@ static const struct ata_port_operations ahci_vt8251_ops = {
 	.qc_prep		= ahci_qc_prep,
 	.qc_issue		= ahci_qc_issue,
 
-	.irq_handler		= ahci_interrupt,
 	.irq_clear		= ahci_irq_clear,
 	.irq_on			= ata_dummy_irq_on,
 	.irq_ack		= ata_dummy_irq_ack,
@@ -326,7 +323,6 @@ static const struct ata_port_operations ahci_vt8251_ops = {
 static const struct ata_port_info ahci_port_info[] = {
 	/* board_ahci */
 	{
-		.sht		= &ahci_sht,
 		.flags		= ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
 				  ATA_FLAG_MMIO | ATA_FLAG_PIO_DMA |
 				  ATA_FLAG_SKIP_D2H_BSY,
@@ -336,7 +332,6 @@ static const struct ata_port_info ahci_port_info[] = {
 	},
 	/* board_ahci_pi */
 	{
-		.sht		= &ahci_sht,
 		.flags		= ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
 				  ATA_FLAG_MMIO | ATA_FLAG_PIO_DMA |
 				  ATA_FLAG_SKIP_D2H_BSY | AHCI_FLAG_HONOR_PI,
@@ -346,7 +341,6 @@ static const struct ata_port_info ahci_port_info[] = {
 	},
 	/* board_ahci_vt8251 */
 	{
-		.sht		= &ahci_sht,
 		.flags		= ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
 				  ATA_FLAG_MMIO | ATA_FLAG_PIO_DMA |
 				  ATA_FLAG_SKIP_D2H_BSY |
@@ -357,7 +351,6 @@ static const struct ata_port_info ahci_port_info[] = {
 	},
 	/* board_ahci_ign_iferr */
 	{
-		.sht		= &ahci_sht,
 		.flags		= ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
 				  ATA_FLAG_MMIO | ATA_FLAG_PIO_DMA |
 				  ATA_FLAG_SKIP_D2H_BSY |
@@ -473,15 +466,18 @@ static inline int ahci_nr_ports(u32 cap)
 	return (cap & 0x1f) + 1;
 }
 
-static inline void __iomem *ahci_port_base(void __iomem *base,
-					   unsigned int port)
+static inline void __iomem *ahci_port_base(struct ata_port *ap)
 {
-	return base + 0x100 + (port * 0x80);
+	void __iomem *mmio = ap->host->iomap[AHCI_PCI_BAR];
+
+	return mmio + 0x100 + (ap->port_no * 0x80);
 }
 
 /**
  *	ahci_save_initial_config - Save and fixup initial config values
- *	@probe_ent: probe_ent of target device
+ *	@pdev: target PCI device
+ *	@pi: associated ATA port info
+ *	@hpriv: host private area to store config values
  *
  *	Some registers containing configuration info might be setup by
  *	BIOS and might be cleared on reset.  This function saves the
@@ -493,10 +489,11 @@ static inline void __iomem *ahci_port_base(void __iomem *base,
  *	LOCKING:
  *	None.
  */
-static void ahci_save_initial_config(struct ata_probe_ent *probe_ent)
+static void ahci_save_initial_config(struct pci_dev *pdev,
+				     const struct ata_port_info *pi,
+				     struct ahci_host_priv *hpriv)
 {
-	struct ahci_host_priv *hpriv = probe_ent->private_data;
-	void __iomem *mmio = probe_ent->iomap[AHCI_PCI_BAR];
+	void __iomem *mmio = pcim_iomap_table(pdev)[AHCI_PCI_BAR];
 	u32 cap, port_map;
 	int i;
 
@@ -509,7 +506,7 @@ static void ahci_save_initial_config(struct ata_probe_ent *probe_ent)
 	/* fixup zero port_map */
 	if (!port_map) {
 		port_map = (1 << ahci_nr_ports(hpriv->cap)) - 1;
-		dev_printk(KERN_WARNING, probe_ent->dev,
+		dev_printk(KERN_WARNING, &pdev->dev,
 			   "PORTS_IMPL is zero, forcing 0x%x\n", port_map);
 
 		/* write the fixed up value to the PI register */
@@ -517,7 +514,7 @@ static void ahci_save_initial_config(struct ata_probe_ent *probe_ent)
 	}
 
 	/* cross check port_map and cap.n_ports */
-	if (probe_ent->port_flags & AHCI_FLAG_HONOR_PI) {
+	if (pi->flags & AHCI_FLAG_HONOR_PI) {
 		u32 tmp_port_map = port_map;
 		int n_ports = ahci_nr_ports(cap);
 
@@ -532,7 +529,7 @@ static void ahci_save_initial_config(struct ata_probe_ent *probe_ent)
 		 * port_map is used to determine number of ports.
 		 */
 		if (n_ports || tmp_port_map)
-			dev_printk(KERN_WARNING, probe_ent->dev,
+			dev_printk(KERN_WARNING, &pdev->dev,
 				   "nr_ports (%u) and implemented port map "
 				   "(0x%x) don't match\n",
 				   ahci_nr_ports(cap), port_map);
@@ -548,17 +545,18 @@ static void ahci_save_initial_config(struct ata_probe_ent *probe_ent)
 
 /**
  *	ahci_restore_initial_config - Restore initial config
- *	@mmio: MMIO base for the host
- *	@hpriv: host private data
+ *	@host: target ATA host
  *
  *	Restore initial config stored by ahci_save_initial_config().
  *
  *	LOCKING:
  *	None.
  */
-static void ahci_restore_initial_config(void __iomem *mmio,
-					struct ahci_host_priv *hpriv)
+static void ahci_restore_initial_config(struct ata_host *host)
 {
+	struct ahci_host_priv *hpriv = host->private_data;
+	void __iomem *mmio = host->iomap[AHCI_PCI_BAR];
+
 	writel(hpriv->saved_cap, mmio + HOST_CAP);
 	writel(hpriv->saved_port_map, mmio + HOST_PORTS_IMPL);
 	(void) readl(mmio + HOST_PORTS_IMPL);	/* flush */
@@ -598,8 +596,9 @@ static void ahci_scr_write (struct ata_port *ap, unsigned int sc_reg_in,
 	writel(val, ap->ioaddr.scr_addr + (sc_reg * 4));
 }
 
-static void ahci_start_engine(void __iomem *port_mmio)
+static void ahci_start_engine(struct ata_port *ap)
 {
+	void __iomem *port_mmio = ahci_port_base(ap);
 	u32 tmp;
 
 	/* start DMA */
@@ -609,8 +608,9 @@ static void ahci_start_engine(void __iomem *port_mmio)
 	readl(port_mmio + PORT_CMD); /* flush */
 }
 
-static int ahci_stop_engine(void __iomem *port_mmio)
+static int ahci_stop_engine(struct ata_port *ap)
 {
+	void __iomem *port_mmio = ahci_port_base(ap);
 	u32 tmp;
 
 	tmp = readl(port_mmio + PORT_CMD);
@@ -632,19 +632,23 @@ static int ahci_stop_engine(void __iomem *port_mmio)
 	return 0;
 }
 
-static void ahci_start_fis_rx(void __iomem *port_mmio, u32 cap,
-			      dma_addr_t cmd_slot_dma, dma_addr_t rx_fis_dma)
+static void ahci_start_fis_rx(struct ata_port *ap)
 {
+	void __iomem *port_mmio = ahci_port_base(ap);
+	struct ahci_host_priv *hpriv = ap->host->private_data;
+	struct ahci_port_priv *pp = ap->private_data;
 	u32 tmp;
 
 	/* set FIS registers */
-	if (cap & HOST_CAP_64)
-		writel((cmd_slot_dma >> 16) >> 16, port_mmio + PORT_LST_ADDR_HI);
-	writel(cmd_slot_dma & 0xffffffff, port_mmio + PORT_LST_ADDR);
+	if (hpriv->cap & HOST_CAP_64)
+		writel((pp->cmd_slot_dma >> 16) >> 16,
+		       port_mmio + PORT_LST_ADDR_HI);
+	writel(pp->cmd_slot_dma & 0xffffffff, port_mmio + PORT_LST_ADDR);
 
-	if (cap & HOST_CAP_64)
-		writel((rx_fis_dma >> 16) >> 16, port_mmio + PORT_FIS_ADDR_HI);
-	writel(rx_fis_dma & 0xffffffff, port_mmio + PORT_FIS_ADDR);
+	if (hpriv->cap & HOST_CAP_64)
+		writel((pp->rx_fis_dma >> 16) >> 16,
+		       port_mmio + PORT_FIS_ADDR_HI);
+	writel(pp->rx_fis_dma & 0xffffffff, port_mmio + PORT_FIS_ADDR);
 
 	/* enable FIS reception */
 	tmp = readl(port_mmio + PORT_CMD);
@@ -655,8 +659,9 @@ static void ahci_start_fis_rx(void __iomem *port_mmio, u32 cap,
 	readl(port_mmio + PORT_CMD);
 }
 
-static int ahci_stop_fis_rx(void __iomem *port_mmio)
+static int ahci_stop_fis_rx(struct ata_port *ap)
 {
+	void __iomem *port_mmio = ahci_port_base(ap);
 	u32 tmp;
 
 	/* disable FIS reception */
@@ -673,14 +678,16 @@ static int ahci_stop_fis_rx(void __iomem *port_mmio)
 	return 0;
 }
 
-static void ahci_power_up(void __iomem *port_mmio, u32 cap)
+static void ahci_power_up(struct ata_port *ap)
 {
+	struct ahci_host_priv *hpriv = ap->host->private_data;
+	void __iomem *port_mmio = ahci_port_base(ap);
 	u32 cmd;
 
 	cmd = readl(port_mmio + PORT_CMD) & ~PORT_CMD_ICC_MASK;
 
 	/* spin up device */
-	if (cap & HOST_CAP_SSS) {
+	if (hpriv->cap & HOST_CAP_SSS) {
 		cmd |= PORT_CMD_SPIN_UP;
 		writel(cmd, port_mmio + PORT_CMD);
 	}
@@ -690,11 +697,13 @@ static void ahci_power_up(void __iomem *port_mmio, u32 cap)
 }
 
 #ifdef CONFIG_PM
-static void ahci_power_down(void __iomem *port_mmio, u32 cap)
+static void ahci_power_down(struct ata_port *ap)
 {
+	struct ahci_host_priv *hpriv = ap->host->private_data;
+	void __iomem *port_mmio = ahci_port_base(ap);
 	u32 cmd, scontrol;
 
-	if (!(cap & HOST_CAP_SSS))
+	if (!(hpriv->cap & HOST_CAP_SSS))
 		return;
 
 	/* put device into listen mode, first set PxSCTL.DET to 0 */
@@ -709,29 +718,28 @@ static void ahci_power_down(void __iomem *port_mmio, u32 cap)
 }
 #endif
 
-static void ahci_init_port(void __iomem *port_mmio, u32 cap,
-			   dma_addr_t cmd_slot_dma, dma_addr_t rx_fis_dma)
+static void ahci_init_port(struct ata_port *ap)
 {
 	/* enable FIS reception */
-	ahci_start_fis_rx(port_mmio, cap, cmd_slot_dma, rx_fis_dma);
+	ahci_start_fis_rx(ap);
 
 	/* enable DMA */
-	ahci_start_engine(port_mmio);
+	ahci_start_engine(ap);
 }
 
-static int ahci_deinit_port(void __iomem *port_mmio, u32 cap, const char **emsg)
+static int ahci_deinit_port(struct ata_port *ap, const char **emsg)
 {
 	int rc;
 
 	/* disable DMA */
-	rc = ahci_stop_engine(port_mmio);
+	rc = ahci_stop_engine(ap);
 	if (rc) {
 		*emsg = "failed to stop engine";
 		return rc;
 	}
 
 	/* disable FIS reception */
-	rc = ahci_stop_fis_rx(port_mmio);
+	rc = ahci_stop_fis_rx(ap);
 	if (rc) {
 		*emsg = "failed stop FIS RX";
 		return rc;
@@ -740,9 +748,10 @@ static int ahci_deinit_port(void __iomem *port_mmio, u32 cap, const char **emsg)
 	return 0;
 }
 
-static int ahci_reset_controller(void __iomem *mmio, struct pci_dev *pdev,
-				 struct ahci_host_priv *hpriv)
+static int ahci_reset_controller(struct ata_host *host)
 {
+	struct pci_dev *pdev = to_pci_dev(host->dev);
+	void __iomem *mmio = host->iomap[AHCI_PCI_BAR];
 	u32 tmp;
 
 	/* global controller reset */
@@ -759,7 +768,7 @@ static int ahci_reset_controller(void __iomem *mmio, struct pci_dev *pdev,
 
 	tmp = readl(mmio + HOST_CTL);
 	if (tmp & HOST_RESET) {
-		dev_printk(KERN_ERR, &pdev->dev,
+		dev_printk(KERN_ERR, host->dev,
 			   "controller reset failed (0x%x)\n", tmp);
 		return -EIO;
 	}
@@ -769,7 +778,7 @@ static int ahci_reset_controller(void __iomem *mmio, struct pci_dev *pdev,
 	(void) readl(mmio + HOST_CTL);	/* flush */
 
 	/* some registers might be cleared on reset.  restore initial values */
-	ahci_restore_initial_config(mmio, hpriv);
+	ahci_restore_initial_config(host);
 
 	if (pdev->vendor == PCI_VENDOR_ID_INTEL) {
 		u16 tmp16;
@@ -783,23 +792,23 @@ static int ahci_reset_controller(void __iomem *mmio, struct pci_dev *pdev,
 	return 0;
 }
 
-static void ahci_init_controller(void __iomem *mmio, struct pci_dev *pdev,
-				 int n_ports, unsigned int port_flags,
-				 struct ahci_host_priv *hpriv)
+static void ahci_init_controller(struct ata_host *host)
 {
+	struct pci_dev *pdev = to_pci_dev(host->dev);
+	void __iomem *mmio = host->iomap[AHCI_PCI_BAR];
 	int i, rc;
 	u32 tmp;
 
-	for (i = 0; i < n_ports; i++) {
-		void __iomem *port_mmio = ahci_port_base(mmio, i);
+	for (i = 0; i < host->n_ports; i++) {
+		struct ata_port *ap = host->ports[i];
+		void __iomem *port_mmio = ahci_port_base(ap);
 		const char *emsg = NULL;
 
-		if ((port_flags & AHCI_FLAG_HONOR_PI) &&
-		    !(hpriv->port_map & (1 << i)))
+		if (ata_port_is_dummy(ap))
 			continue;
 
 		/* make sure port is not active */
-		rc = ahci_deinit_port(port_mmio, hpriv->cap, &emsg);
+		rc = ahci_deinit_port(ap, &emsg);
 		if (rc)
 			dev_printk(KERN_WARNING, &pdev->dev,
 				   "%s (%d)\n", emsg, rc);
@@ -827,7 +836,7 @@ static void ahci_init_controller(void __iomem *mmio, struct pci_dev *pdev,
 
 static unsigned int ahci_dev_classify(struct ata_port *ap)
 {
-	void __iomem *port_mmio = ap->ioaddr.cmd_addr;
+	void __iomem *port_mmio = ahci_port_base(ap);
 	struct ata_taskfile tf;
 	u32 tmp;
 
@@ -877,8 +886,7 @@ static int ahci_clo(struct ata_port *ap)
 static int ahci_softreset(struct ata_port *ap, unsigned int *class)
 {
 	struct ahci_port_priv *pp = ap->private_data;
-	void __iomem *mmio = ap->host->iomap[AHCI_PCI_BAR];
-	void __iomem *port_mmio = ahci_port_base(mmio, ap->port_no);
+	void __iomem *port_mmio = ahci_port_base(ap);
 	const u32 cmd_fis_len = 5; /* five dwords */
 	const char *reason = NULL;
 	struct ata_taskfile tf;
@@ -895,7 +903,7 @@ static int ahci_softreset(struct ata_port *ap, unsigned int *class)
 	}
 
 	/* prepare for SRST (AHCI-1.1 10.4.1) */
-	rc = ahci_stop_engine(port_mmio);
+	rc = ahci_stop_engine(ap);
 	if (rc) {
 		reason = "failed to stop engine";
 		goto fail_restart;
@@ -915,7 +923,7 @@ static int ahci_softreset(struct ata_port *ap, unsigned int *class)
 	}
 
 	/* restart engine */
-	ahci_start_engine(port_mmio);
+	ahci_start_engine(ap);
 
 	ata_tf_init(ap->device, &tf);
 	fis = pp->cmd_tbl;
@@ -974,7 +982,7 @@ static int ahci_softreset(struct ata_port *ap, unsigned int *class)
 	return 0;
 
  fail_restart:
-	ahci_start_engine(port_mmio);
+	ahci_start_engine(ap);
  fail:
 	ata_port_printk(ap, KERN_ERR, "softreset failed (%s)\n", reason);
 	return rc;
@@ -985,13 +993,11 @@ static int ahci_hardreset(struct ata_port *ap, unsigned int *class)
 	struct ahci_port_priv *pp = ap->private_data;
 	u8 *d2h_fis = pp->rx_fis + RX_FIS_D2H_REG;
 	struct ata_taskfile tf;
-	void __iomem *mmio = ap->host->iomap[AHCI_PCI_BAR];
-	void __iomem *port_mmio = ahci_port_base(mmio, ap->port_no);
 	int rc;
 
 	DPRINTK("ENTER\n");
 
-	ahci_stop_engine(port_mmio);
+	ahci_stop_engine(ap);
 
 	/* clear D2H reception area to properly wait for D2H FIS */
 	ata_tf_init(ap->device, &tf);
@@ -1000,7 +1006,7 @@ static int ahci_hardreset(struct ata_port *ap, unsigned int *class)
 
 	rc = sata_std_hardreset(ap, class);
 
-	ahci_start_engine(port_mmio);
+	ahci_start_engine(ap);
 
 	if (rc == 0 && ata_port_online(ap))
 		*class = ahci_dev_classify(ap);
@@ -1013,20 +1019,18 @@ static int ahci_hardreset(struct ata_port *ap, unsigned int *class)
 
 static int ahci_vt8251_hardreset(struct ata_port *ap, unsigned int *class)
 {
-	void __iomem *mmio = ap->host->iomap[AHCI_PCI_BAR];
-	void __iomem *port_mmio = ahci_port_base(mmio, ap->port_no);
 	int rc;
 
 	DPRINTK("ENTER\n");
 
-	ahci_stop_engine(port_mmio);
+	ahci_stop_engine(ap);
 
 	rc = sata_port_hardreset(ap, sata_ehc_deb_timing(&ap->eh_context));
 
 	/* vt8251 needs SError cleared for the port to operate */
 	ahci_scr_write(ap, SCR_ERROR, ahci_scr_read(ap, SCR_ERROR));
 
-	ahci_start_engine(port_mmio);
+	ahci_start_engine(ap);
 
 	DPRINTK("EXIT, rc=%d, class=%u\n", rc, *class);
 
@@ -1038,7 +1042,7 @@ static int ahci_vt8251_hardreset(struct ata_port *ap, unsigned int *class)
 
 static void ahci_postreset(struct ata_port *ap, unsigned int *class)
 {
-	void __iomem *port_mmio = ap->ioaddr.cmd_addr;
+	void __iomem *port_mmio = ahci_port_base(ap);
 	u32 new_tmp, tmp;
 
 	ata_std_postreset(ap, class);
@@ -1206,8 +1210,7 @@ static void ahci_error_intr(struct ata_port *ap, u32 irq_stat)
 
 static void ahci_host_intr(struct ata_port *ap)
 {
-	void __iomem *mmio = ap->host->iomap[AHCI_PCI_BAR];
-	void __iomem *port_mmio = ahci_port_base(mmio, ap->port_no);
+	void __iomem *port_mmio = ap->ioaddr.cmd_addr;
 	struct ata_eh_info *ehi = &ap->eh_info;
 	struct ahci_port_priv *pp = ap->private_data;
 	u32 status, qc_active;
@@ -1358,7 +1361,7 @@ static irqreturn_t ahci_interrupt(int irq, void *dev_instance)
 static unsigned int ahci_qc_issue(struct ata_queued_cmd *qc)
 {
 	struct ata_port *ap = qc->ap;
-	void __iomem *port_mmio = ap->ioaddr.cmd_addr;
+	void __iomem *port_mmio = ahci_port_base(ap);
 
 	if (qc->tf.protocol == ATA_PROT_NCQ)
 		writel(1 << qc->tag, port_mmio + PORT_SCR_ACT);
@@ -1370,8 +1373,7 @@ static unsigned int ahci_qc_issue(struct ata_queued_cmd *qc)
 
 static void ahci_freeze(struct ata_port *ap)
 {
-	void __iomem *mmio = ap->host->iomap[AHCI_PCI_BAR];
-	void __iomem *port_mmio = ahci_port_base(mmio, ap->port_no);
+	void __iomem *port_mmio = ahci_port_base(ap);
 
 	/* turn IRQ off */
 	writel(0, port_mmio + PORT_IRQ_MASK);
@@ -1380,7 +1382,7 @@ static void ahci_freeze(struct ata_port *ap)
 static void ahci_thaw(struct ata_port *ap)
 {
 	void __iomem *mmio = ap->host->iomap[AHCI_PCI_BAR];
-	void __iomem *port_mmio = ahci_port_base(mmio, ap->port_no);
+	void __iomem *port_mmio = ahci_port_base(ap);
 	u32 tmp;
 
 	/* clear IRQ */
@@ -1394,13 +1396,10 @@ static void ahci_thaw(struct ata_port *ap)
 
 static void ahci_error_handler(struct ata_port *ap)
 {
-	void __iomem *mmio = ap->host->iomap[AHCI_PCI_BAR];
-	void __iomem *port_mmio = ahci_port_base(mmio, ap->port_no);
-
 	if (!(ap->pflags & ATA_PFLAG_FROZEN)) {
 		/* restart engine */
-		ahci_stop_engine(port_mmio);
-		ahci_start_engine(port_mmio);
+		ahci_stop_engine(ap);
+		ahci_start_engine(ap);
 	}
 
 	/* perform recovery */
@@ -1410,13 +1409,10 @@ static void ahci_error_handler(struct ata_port *ap)
 
 static void ahci_vt8251_error_handler(struct ata_port *ap)
 {
-	void __iomem *mmio = ap->host->iomap[AHCI_PCI_BAR];
-	void __iomem *port_mmio = ahci_port_base(mmio, ap->port_no);
-
 	if (!(ap->pflags & ATA_PFLAG_FROZEN)) {
 		/* restart engine */
-		ahci_stop_engine(port_mmio);
-		ahci_start_engine(port_mmio);
+		ahci_stop_engine(ap);
+		ahci_start_engine(ap);
 	}
 
 	/* perform recovery */
@@ -1427,36 +1423,29 @@ static void ahci_vt8251_error_handler(struct ata_port *ap)
 static void ahci_post_internal_cmd(struct ata_queued_cmd *qc)
 {
 	struct ata_port *ap = qc->ap;
-	void __iomem *mmio = ap->host->iomap[AHCI_PCI_BAR];
-	void __iomem *port_mmio = ahci_port_base(mmio, ap->port_no);
 
 	if (qc->flags & ATA_QCFLAG_FAILED)
 		qc->err_mask |= AC_ERR_OTHER;
 
 	if (qc->err_mask) {
 		/* make DMA engine forget about the failed command */
-		ahci_stop_engine(port_mmio);
-		ahci_start_engine(port_mmio);
+		ahci_stop_engine(ap);
+		ahci_start_engine(ap);
 	}
 }
 
 #ifdef CONFIG_PM
 static int ahci_port_suspend(struct ata_port *ap, pm_message_t mesg)
 {
-	struct ahci_host_priv *hpriv = ap->host->private_data;
-	struct ahci_port_priv *pp = ap->private_data;
-	void __iomem *mmio = ap->host->iomap[AHCI_PCI_BAR];
-	void __iomem *port_mmio = ahci_port_base(mmio, ap->port_no);
 	const char *emsg = NULL;
 	int rc;
 
-	rc = ahci_deinit_port(port_mmio, hpriv->cap, &emsg);
+	rc = ahci_deinit_port(ap, &emsg);
 	if (rc == 0)
-		ahci_power_down(port_mmio, hpriv->cap);
+		ahci_power_down(ap);
 	else {
 		ata_port_printk(ap, KERN_ERR, "%s (%d)\n", emsg, rc);
-		ahci_init_port(port_mmio, hpriv->cap,
-			       pp->cmd_slot_dma, pp->rx_fis_dma);
+		ahci_init_port(ap);
 	}
 
 	return rc;
@@ -1464,13 +1453,8 @@ static int ahci_port_suspend(struct ata_port *ap, pm_message_t mesg)
 
 static int ahci_port_resume(struct ata_port *ap)
 {
-	struct ahci_port_priv *pp = ap->private_data;
-	struct ahci_host_priv *hpriv = ap->host->private_data;
-	void __iomem *mmio = ap->host->iomap[AHCI_PCI_BAR];
-	void __iomem *port_mmio = ahci_port_base(mmio, ap->port_no);
-
-	ahci_power_up(port_mmio, hpriv->cap);
-	ahci_init_port(port_mmio, hpriv->cap, pp->cmd_slot_dma, pp->rx_fis_dma);
+	ahci_power_up(ap);
+	ahci_init_port(ap);
 
 	return 0;
 }
@@ -1498,8 +1482,6 @@ static int ahci_pci_device_suspend(struct pci_dev *pdev, pm_message_t mesg)
 static int ahci_pci_device_resume(struct pci_dev *pdev)
 {
 	struct ata_host *host = dev_get_drvdata(&pdev->dev);
-	struct ahci_host_priv *hpriv = host->private_data;
-	void __iomem *mmio = host->iomap[AHCI_PCI_BAR];
 	int rc;
 
 	rc = ata_pci_device_do_resume(pdev);
@@ -1507,12 +1489,11 @@ static int ahci_pci_device_resume(struct pci_dev *pdev)
 		return rc;
 
 	if (pdev->dev.power.power_state.event == PM_EVENT_SUSPEND) {
-		rc = ahci_reset_controller(mmio, pdev, hpriv);
+		rc = ahci_reset_controller(host);
 		if (rc)
 			return rc;
 
-		ahci_init_controller(mmio, pdev, host->n_ports,
-				     host->ports[0]->flags, hpriv);
+		ahci_init_controller(host);
 	}
 
 	ata_host_resume(host);
@@ -1524,10 +1505,7 @@ static int ahci_pci_device_resume(struct pci_dev *pdev)
 static int ahci_port_start(struct ata_port *ap)
 {
 	struct device *dev = ap->host->dev;
-	struct ahci_host_priv *hpriv = ap->host->private_data;
 	struct ahci_port_priv *pp;
-	void __iomem *mmio = ap->host->iomap[AHCI_PCI_BAR];
-	void __iomem *port_mmio = ahci_port_base(mmio, ap->port_no);
 	void *mem;
 	dma_addr_t mem_dma;
 	int rc;
@@ -1575,60 +1553,29 @@ static int ahci_port_start(struct ata_port *ap)
 	ap->private_data = pp;
 
 	/* power up port */
-	ahci_power_up(port_mmio, hpriv->cap);
+	ahci_power_up(ap);
 
 	/* initialize port */
-	ahci_init_port(port_mmio, hpriv->cap, pp->cmd_slot_dma, pp->rx_fis_dma);
+	ahci_init_port(ap);
 
 	return 0;
 }
 
 static void ahci_port_stop(struct ata_port *ap)
 {
-	struct ahci_host_priv *hpriv = ap->host->private_data;
-	void __iomem *mmio = ap->host->iomap[AHCI_PCI_BAR];
-	void __iomem *port_mmio = ahci_port_base(mmio, ap->port_no);
 	const char *emsg = NULL;
 	int rc;
 
 	/* de-initialize port */
-	rc = ahci_deinit_port(port_mmio, hpriv->cap, &emsg);
+	rc = ahci_deinit_port(ap, &emsg);
 	if (rc)
 		ata_port_printk(ap, KERN_WARNING, "%s (%d)\n", emsg, rc);
 }
 
-static void ahci_setup_port(struct ata_ioports *port, void __iomem *base,
-			    unsigned int port_idx)
+static int ahci_configure_dma_masks(struct pci_dev *pdev, int using_dac)
 {
-	VPRINTK("ENTER, base==0x%lx, port_idx %u\n", base, port_idx);
-	base = ahci_port_base(base, port_idx);
-	VPRINTK("base now==0x%lx\n", base);
-
-	port->cmd_addr		= base;
-	port->scr_addr		= base + PORT_SCR;
-
-	VPRINTK("EXIT\n");
-}
-
-static int ahci_host_init(struct ata_probe_ent *probe_ent)
-{
-	struct ahci_host_priv *hpriv = probe_ent->private_data;
-	struct pci_dev *pdev = to_pci_dev(probe_ent->dev);
-	void __iomem *mmio = probe_ent->iomap[AHCI_PCI_BAR];
-	unsigned int i, using_dac;
 	int rc;
 
-	rc = ahci_reset_controller(mmio, pdev, hpriv);
-	if (rc)
-		return rc;
-
-	probe_ent->n_ports = fls(hpriv->port_map);
-	probe_ent->dummy_port_mask = ~hpriv->port_map;
-
-	VPRINTK("cap 0x%x  port_map 0x%x  n_ports %d\n",
-		hpriv->cap, hpriv->port_map, probe_ent->n_ports);
-
-	using_dac = hpriv->cap & HOST_CAP_64;
 	if (using_dac &&
 	    !pci_set_dma_mask(pdev, DMA_64BIT_MASK)) {
 		rc = pci_set_consistent_dma_mask(pdev, DMA_64BIT_MASK);
@@ -1654,23 +1601,14 @@ static int ahci_host_init(struct ata_probe_ent *probe_ent)
 			return rc;
 		}
 	}
-
-	for (i = 0; i < probe_ent->n_ports; i++)
-		ahci_setup_port(&probe_ent->port[i], mmio, i);
-
-	ahci_init_controller(mmio, pdev, probe_ent->n_ports,
-			     probe_ent->port_flags, hpriv);
-
-	pci_set_master(pdev);
-
 	return 0;
 }
 
-static void ahci_print_info(struct ata_probe_ent *probe_ent)
+static void ahci_print_info(struct ata_host *host)
 {
-	struct ahci_host_priv *hpriv = probe_ent->private_data;
-	struct pci_dev *pdev = to_pci_dev(probe_ent->dev);
-	void __iomem *mmio = probe_ent->iomap[AHCI_PCI_BAR];
+	struct ahci_host_priv *hpriv = host->private_data;
+	struct pci_dev *pdev = to_pci_dev(host->dev);
+	void __iomem *mmio = host->iomap[AHCI_PCI_BAR];
 	u32 vers, cap, impl, speed;
 	const char *speed_s;
 	u16 cc;
@@ -1740,11 +1678,12 @@ static void ahci_print_info(struct ata_probe_ent *probe_ent)
 static int ahci_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 {
 	static int printed_version;
-	unsigned int board_idx = (unsigned int) ent->driver_data;
+	struct ata_port_info pi = ahci_port_info[ent->driver_data];
+	const struct ata_port_info *ppi[] = { &pi, NULL };
 	struct device *dev = &pdev->dev;
-	struct ata_probe_ent *probe_ent;
 	struct ahci_host_priv *hpriv;
-	int rc;
+	struct ata_host *host;
+	int i, rc;
 
 	VPRINTK("ENTER\n");
 
@@ -1753,6 +1692,7 @@ static int ahci_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	if (!printed_version++)
 		dev_printk(KERN_DEBUG, &pdev->dev, "version " DRV_VERSION "\n");
 
+	/* acquire resources */
 	rc = pcim_enable_device(pdev);
 	if (rc)
 		return rc;
@@ -1766,46 +1706,49 @@ static int ahci_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	if (pci_enable_msi(pdev))
 		pci_intx(pdev, 1);
 
-	probe_ent = devm_kzalloc(dev, sizeof(*probe_ent), GFP_KERNEL);
-	if (probe_ent == NULL)
-		return -ENOMEM;
-
-	probe_ent->dev = pci_dev_to_dev(pdev);
-	INIT_LIST_HEAD(&probe_ent->node);
-
 	hpriv = devm_kzalloc(dev, sizeof(*hpriv), GFP_KERNEL);
 	if (!hpriv)
 		return -ENOMEM;
 
-	probe_ent->sht		= ahci_port_info[board_idx].sht;
-	probe_ent->port_flags	= ahci_port_info[board_idx].flags;
-	probe_ent->pio_mask	= ahci_port_info[board_idx].pio_mask;
-	probe_ent->udma_mask	= ahci_port_info[board_idx].udma_mask;
-	probe_ent->port_ops	= ahci_port_info[board_idx].port_ops;
+	/* save initial config */
+	ahci_save_initial_config(pdev, &pi, hpriv);
 
-       	probe_ent->irq = pdev->irq;
-       	probe_ent->irq_flags = IRQF_SHARED;
-	probe_ent->iomap = pcim_iomap_table(pdev);
-	probe_ent->private_data = hpriv;
+	/* prepare host */
+	if (!(pi.flags & AHCI_FLAG_NO_NCQ) && (hpriv->cap & HOST_CAP_NCQ))
+		pi.flags |= ATA_FLAG_NCQ;
 
-	/* initialize adapter */
-	ahci_save_initial_config(probe_ent);
+	host = ata_host_alloc_pinfo(&pdev->dev, ppi, fls(hpriv->port_map));
+	if (!host)
+		return -ENOMEM;
+	host->iomap = pcim_iomap_table(pdev);
+	host->private_data = hpriv;
+
+	for (i = 0; i < host->n_ports; i++) {
+		if (hpriv->port_map & (1 << i)) {
+			struct ata_port *ap = host->ports[i];
+			void __iomem *port_mmio = ahci_port_base(ap);
+
+			ap->ioaddr.cmd_addr = port_mmio;
+			ap->ioaddr.scr_addr = port_mmio + PORT_SCR;
+		} else
+			host->ports[i]->ops = &ata_dummy_port_ops;
+	}
 
-	rc = ahci_host_init(probe_ent);
+	/* initialize adapter */
+	rc = ahci_configure_dma_masks(pdev, hpriv->cap & HOST_CAP_64);
 	if (rc)
 		return rc;
 
-	if (!(probe_ent->port_flags & AHCI_FLAG_NO_NCQ) &&
-	    (hpriv->cap & HOST_CAP_NCQ))
-		probe_ent->port_flags |= ATA_FLAG_NCQ;
-
-	ahci_print_info(probe_ent);
+	rc = ahci_reset_controller(host);
+	if (rc)
+		return rc;
 
-	if (!ata_device_add(probe_ent))
-		return -ENODEV;
+	ahci_init_controller(host);
+	ahci_print_info(host);
 
-	devm_kfree(dev, probe_ent);
-	return 0;
+	pci_set_master(pdev);
+	return ata_host_activate(host, pdev->irq, ahci_interrupt, IRQF_SHARED,
+				 &ahci_sht);
 }
 
 static int __init ahci_init(void)
diff --git a/drivers/ata/sata_inic162x.c b/drivers/ata/sata_inic162x.c
index 11c3079..7dea21d 100644
--- a/drivers/ata/sata_inic162x.c
+++ b/drivers/ata/sata_inic162x.c
@@ -559,7 +559,6 @@ static struct ata_port_operations inic_port_ops = {
 	.bmdma_stop		= inic_bmdma_stop,
 	.bmdma_status		= inic_bmdma_status,
 
-	.irq_handler		= inic_interrupt,
 	.irq_clear		= inic_irq_clear,
 	.irq_on			= ata_irq_on,
 	.irq_ack		= ata_irq_ack,
@@ -580,7 +579,6 @@ static struct ata_port_operations inic_port_ops = {
 };
 
 static struct ata_port_info inic_port_info = {
-	.sht			= &inic_sht,
 	/* For some reason, ATA_PROT_ATAPI is broken on this
 	 * controller, and no, PIO_POLLING does't fix it.  It somehow
 	 * manages to report the wrong ireason and ignoring ireason
@@ -661,8 +659,8 @@ static int inic_pci_device_resume(struct pci_dev *pdev)
 static int inic_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 {
 	static int printed_version;
-	struct ata_port_info *pinfo = &inic_port_info;
-	struct ata_probe_ent *probe_ent;
+	const struct ata_port_info *ppi[] = { &inic_port_info, NULL };
+	struct ata_host *host;
 	struct inic_host_priv *hpriv;
 	void __iomem * const *iomap;
 	int i, rc;
@@ -670,6 +668,15 @@ static int inic_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	if (!printed_version++)
 		dev_printk(KERN_DEBUG, &pdev->dev, "version " DRV_VERSION "\n");
 
+	/* alloc host */
+	host = ata_host_alloc_pinfo(&pdev->dev, ppi, NR_PORTS);
+	hpriv = devm_kzalloc(&pdev->dev, sizeof(*hpriv), GFP_KERNEL);
+	if (!host || !hpriv)
+		return -ENOMEM;
+
+	host->private_data = hpriv;
+
+	/* acquire resources and fill host */
 	rc = pcim_enable_device(pdev);
 	if (rc)
 		return rc;
@@ -677,7 +684,22 @@ static int inic_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	rc = pcim_iomap_regions(pdev, 0x3f, DRV_NAME);
 	if (rc)
 		return rc;
-	iomap = pcim_iomap_table(pdev);
+	host->iomap = iomap = pcim_iomap_table(pdev);
+
+	for (i = 0; i < NR_PORTS; i++) {
+		struct ata_ioports *port = &host->ports[i]->ioaddr;
+		void __iomem *port_base = iomap[MMIO_BAR] + i * PORT_SIZE;
+
+		port->cmd_addr = iomap[2 * i];
+		port->altstatus_addr =
+		port->ctl_addr = (void __iomem *)
+			((unsigned long)iomap[2 * i + 1] | ATA_PCI_CTL_OFS);
+		port->scr_addr = port_base + PORT_SCR;
+
+		ata_std_ports(port);
+	}
+
+	hpriv->cached_hctl = readw(iomap[MMIO_BAR] + HOST_CTL);
 
 	/* Set dma_mask.  This devices doesn't support 64bit addressing. */
 	rc = pci_set_dma_mask(pdev, DMA_32BIT_MASK);
@@ -694,43 +716,6 @@ static int inic_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 		return rc;
 	}
 
-	probe_ent = devm_kzalloc(&pdev->dev, sizeof(*probe_ent), GFP_KERNEL);
-	hpriv = devm_kzalloc(&pdev->dev, sizeof(*hpriv), GFP_KERNEL);
-	if (!probe_ent || !hpriv)
-		return -ENOMEM;
-
-	probe_ent->dev = &pdev->dev;
-	INIT_LIST_HEAD(&probe_ent->node);
-
-	probe_ent->sht			= pinfo->sht;
-	probe_ent->port_flags		= pinfo->flags;
-	probe_ent->pio_mask		= pinfo->pio_mask;
-	probe_ent->mwdma_mask		= pinfo->mwdma_mask;
-	probe_ent->udma_mask		= pinfo->udma_mask;
-	probe_ent->port_ops		= pinfo->port_ops;
-	probe_ent->n_ports		= NR_PORTS;
-
-	probe_ent->irq = pdev->irq;
-	probe_ent->irq_flags = IRQF_SHARED;
-
-	probe_ent->iomap = iomap;
-
-	for (i = 0; i < NR_PORTS; i++) {
-		struct ata_ioports *port = &probe_ent->port[i];
-		void __iomem *port_base = iomap[MMIO_BAR] + i * PORT_SIZE;
-
-		port->cmd_addr = iomap[2 * i];
-		port->altstatus_addr =
-		port->ctl_addr = (void __iomem *)
-			((unsigned long)iomap[2 * i + 1] | ATA_PCI_CTL_OFS);
-		port->scr_addr = port_base + PORT_SCR;
-
-		ata_std_ports(port);
-	}
-
-	probe_ent->private_data = hpriv;
-	hpriv->cached_hctl = readw(iomap[MMIO_BAR] + HOST_CTL);
-
 	rc = init_controller(iomap[MMIO_BAR], hpriv->cached_hctl);
 	if (rc) {
 		dev_printk(KERN_ERR, &pdev->dev,
@@ -739,13 +724,8 @@ static int inic_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	}
 
 	pci_set_master(pdev);
-
-	if (!ata_device_add(probe_ent))
-		return -ENODEV;
-
-	devm_kfree(&pdev->dev, probe_ent);
-
-	return 0;
+	return ata_host_activate(host, pdev->irq, inic_interrupt, IRQF_SHARED,
+				 &inic_sht);
 }
 
 static const struct pci_device_id inic_pci_tbl[] = {
diff --git a/drivers/ata/sata_mv.c b/drivers/ata/sata_mv.c
index 10cad5d..cb9b9ac 100644
--- a/drivers/ata/sata_mv.c
+++ b/drivers/ata/sata_mv.c
@@ -347,7 +347,6 @@ static void mv_port_stop(struct ata_port *ap);
 static void mv_qc_prep(struct ata_queued_cmd *qc);
 static void mv_qc_prep_iie(struct ata_queued_cmd *qc);
 static unsigned int mv_qc_issue(struct ata_queued_cmd *qc);
-static irqreturn_t mv_interrupt(int irq, void *dev_instance);
 static void mv_eng_timeout(struct ata_port *ap);
 static int mv_init_one(struct pci_dev *pdev, const struct pci_device_id *ent);
 
@@ -410,7 +409,6 @@ static const struct ata_port_operations mv5_ops = {
 
 	.eng_timeout		= mv_eng_timeout,
 
-	.irq_handler		= mv_interrupt,
 	.irq_clear		= mv_irq_clear,
 	.irq_on			= ata_irq_on,
 	.irq_ack		= ata_irq_ack,
@@ -440,7 +438,6 @@ static const struct ata_port_operations mv6_ops = {
 
 	.eng_timeout		= mv_eng_timeout,
 
-	.irq_handler		= mv_interrupt,
 	.irq_clear		= mv_irq_clear,
 	.irq_on			= ata_irq_on,
 	.irq_ack		= ata_irq_ack,
@@ -470,7 +467,6 @@ static const struct ata_port_operations mv_iie_ops = {
 
 	.eng_timeout		= mv_eng_timeout,
 
-	.irq_handler		= mv_interrupt,
 	.irq_clear		= mv_irq_clear,
 	.irq_on			= ata_irq_on,
 	.irq_ack		= ata_irq_ack,
@@ -484,35 +480,30 @@ static const struct ata_port_operations mv_iie_ops = {
 
 static const struct ata_port_info mv_port_info[] = {
 	{  /* chip_504x */
-		.sht		= &mv_sht,
 		.flags		= MV_COMMON_FLAGS,
 		.pio_mask	= 0x1f,	/* pio0-4 */
 		.udma_mask	= 0x7f,	/* udma0-6 */
 		.port_ops	= &mv5_ops,
 	},
 	{  /* chip_508x */
-		.sht		= &mv_sht,
 		.flags		= (MV_COMMON_FLAGS | MV_FLAG_DUAL_HC),
 		.pio_mask	= 0x1f,	/* pio0-4 */
 		.udma_mask	= 0x7f,	/* udma0-6 */
 		.port_ops	= &mv5_ops,
 	},
 	{  /* chip_5080 */
-		.sht		= &mv_sht,
 		.flags		= (MV_COMMON_FLAGS | MV_FLAG_DUAL_HC),
 		.pio_mask	= 0x1f,	/* pio0-4 */
 		.udma_mask	= 0x7f,	/* udma0-6 */
 		.port_ops	= &mv5_ops,
 	},
 	{  /* chip_604x */
-		.sht		= &mv_sht,
 		.flags		= (MV_COMMON_FLAGS | MV_6XXX_FLAGS),
 		.pio_mask	= 0x1f,	/* pio0-4 */
 		.udma_mask	= 0x7f,	/* udma0-6 */
 		.port_ops	= &mv6_ops,
 	},
 	{  /* chip_608x */
-		.sht		= &mv_sht,
 		.flags		= (MV_COMMON_FLAGS | MV_6XXX_FLAGS |
 				   MV_FLAG_DUAL_HC),
 		.pio_mask	= 0x1f,	/* pio0-4 */
@@ -520,14 +511,12 @@ static const struct ata_port_info mv_port_info[] = {
 		.port_ops	= &mv6_ops,
 	},
 	{  /* chip_6042 */
-		.sht		= &mv_sht,
 		.flags		= (MV_COMMON_FLAGS | MV_6XXX_FLAGS),
 		.pio_mask	= 0x1f,	/* pio0-4 */
 		.udma_mask	= 0x7f,	/* udma0-6 */
 		.port_ops	= &mv_iie_ops,
 	},
 	{  /* chip_7042 */
-		.sht		= &mv_sht,
 		.flags		= (MV_COMMON_FLAGS | MV_6XXX_FLAGS),
 		.pio_mask	= 0x1f,	/* pio0-4 */
 		.udma_mask	= 0x7f,	/* udma0-6 */
@@ -2099,9 +2088,10 @@ static void mv_port_init(struct ata_ioports *port,  void __iomem *port_mmio)
 		readl(port_mmio + EDMA_ERR_IRQ_MASK_OFS));
 }
 
-static int mv_chip_id(struct pci_dev *pdev, struct mv_host_priv *hpriv,
-		      unsigned int board_idx)
+static int mv_chip_id(struct ata_host *host, unsigned int board_idx)
 {
+	struct pci_dev *pdev = to_pci_dev(host->dev);
+	struct mv_host_priv *hpriv = host->private_data;
 	u8 rev_id;
 	u32 hp_flags = hpriv->hp_flags;
 
@@ -2199,8 +2189,8 @@ static int mv_chip_id(struct pci_dev *pdev, struct mv_host_priv *hpriv,
 
 /**
  *      mv_init_host - Perform some early initialization of the host.
- *	@pdev: host PCI device
- *      @probe_ent: early data struct representing the host
+ *	@host: ATA host to initialize
+ *      @board_idx: controller index
  *
  *      If possible, do an early global reset of the host.  Then do
  *      our port init and clear/unmask all/relevant host interrupts.
@@ -2208,24 +2198,23 @@ static int mv_chip_id(struct pci_dev *pdev, struct mv_host_priv *hpriv,
  *      LOCKING:
  *      Inherited from caller.
  */
-static int mv_init_host(struct pci_dev *pdev, struct ata_probe_ent *probe_ent,
-			unsigned int board_idx)
+static int mv_init_host(struct ata_host *host, unsigned int board_idx)
 {
 	int rc = 0, n_hc, port, hc;
-	void __iomem *mmio = probe_ent->iomap[MV_PRIMARY_BAR];
-	struct mv_host_priv *hpriv = probe_ent->private_data;
+	struct pci_dev *pdev = to_pci_dev(host->dev);
+	void __iomem *mmio = host->iomap[MV_PRIMARY_BAR];
+	struct mv_host_priv *hpriv = host->private_data;
 
 	/* global interrupt mask */
 	writel(0, mmio + HC_MAIN_IRQ_MASK_OFS);
 
-	rc = mv_chip_id(pdev, hpriv, board_idx);
+	rc = mv_chip_id(host, board_idx);
 	if (rc)
 		goto done;
 
-	n_hc = mv_get_hc_count(probe_ent->port_flags);
-	probe_ent->n_ports = MV_PORTS_PER_HC * n_hc;
+	n_hc = mv_get_hc_count(host->ports[0]->flags);
 
-	for (port = 0; port < probe_ent->n_ports; port++)
+	for (port = 0; port < host->n_ports; port++)
 		hpriv->ops->read_preamp(hpriv, port, mmio);
 
 	rc = hpriv->ops->reset_hc(hpriv, mmio, n_hc);
@@ -2236,7 +2225,7 @@ static int mv_init_host(struct pci_dev *pdev, struct ata_probe_ent *probe_ent,
 	hpriv->ops->reset_bus(pdev, mmio);
 	hpriv->ops->enable_leds(hpriv, mmio);
 
-	for (port = 0; port < probe_ent->n_ports; port++) {
+	for (port = 0; port < host->n_ports; port++) {
 		if (IS_60XX(hpriv)) {
 			void __iomem *port_mmio = mv_port_base(mmio, port);
 
@@ -2249,9 +2238,9 @@ static int mv_init_host(struct pci_dev *pdev, struct ata_probe_ent *probe_ent,
 		hpriv->ops->phy_errata(hpriv, mmio, port);
 	}
 
-	for (port = 0; port < probe_ent->n_ports; port++) {
+	for (port = 0; port < host->n_ports; port++) {
 		void __iomem *port_mmio = mv_port_base(mmio, port);
-		mv_port_init(&probe_ent->port[port], port_mmio);
+		mv_port_init(&host->ports[port]->ioaddr, port_mmio);
 	}
 
 	for (hc = 0; hc < n_hc; hc++) {
@@ -2290,17 +2279,17 @@ done:
 
 /**
  *      mv_print_info - Dump key info to kernel log for perusal.
- *      @probe_ent: early data struct representing the host
+ *      @host: ATA host to print info about
  *
  *      FIXME: complete this.
  *
  *      LOCKING:
  *      Inherited from caller.
  */
-static void mv_print_info(struct ata_probe_ent *probe_ent)
+static void mv_print_info(struct ata_host *host)
 {
-	struct pci_dev *pdev = to_pci_dev(probe_ent->dev);
-	struct mv_host_priv *hpriv = probe_ent->private_data;
+	struct pci_dev *pdev = to_pci_dev(host->dev);
+	struct mv_host_priv *hpriv = host->private_data;
 	u8 rev_id, scc;
 	const char *scc_s;
 
@@ -2319,7 +2308,7 @@ static void mv_print_info(struct ata_probe_ent *probe_ent)
 
 	dev_printk(KERN_INFO, &pdev->dev,
 	       "%u slots %u ports %s mode IRQ via %s\n",
-	       (unsigned)MV_MAX_Q_DEPTH, probe_ent->n_ports,
+	       (unsigned)MV_MAX_Q_DEPTH, host->n_ports,
 	       scc_s, (MV_HP_FLAG_MSI & hpriv->hp_flags) ? "MSI" : "INTx");
 }
 
@@ -2334,54 +2323,42 @@ static void mv_print_info(struct ata_probe_ent *probe_ent)
 static int mv_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 {
 	static int printed_version = 0;
-	struct device *dev = &pdev->dev;
-	struct ata_probe_ent *probe_ent;
-	struct mv_host_priv *hpriv;
 	unsigned int board_idx = (unsigned int)ent->driver_data;
-	int rc;
+	const struct ata_port_info *ppi[] = { &mv_port_info[board_idx], NULL };
+	struct ata_host *host;
+	struct mv_host_priv *hpriv;
+	int n_ports, rc;
 
 	if (!printed_version++)
 		dev_printk(KERN_INFO, &pdev->dev, "version " DRV_VERSION "\n");
 
+	/* allocate host */
+	n_ports = mv_get_hc_count(ppi[0]->flags) * MV_PORTS_PER_HC;
+
+	host = ata_host_alloc_pinfo(&pdev->dev, ppi, n_ports);
+	hpriv = devm_kzalloc(&pdev->dev, sizeof(*hpriv), GFP_KERNEL);
+	if (!host || !hpriv)
+		return -ENOMEM;
+	host->private_data = hpriv;
+
+	/* acquire resources */
 	rc = pcim_enable_device(pdev);
 	if (rc)
 		return rc;
-	pci_set_master(pdev);
 
 	rc = pcim_iomap_regions(pdev, 1 << MV_PRIMARY_BAR, DRV_NAME);
 	if (rc == -EBUSY)
 		pcim_pin_device(pdev);
 	if (rc)
 		return rc;
+	host->iomap = pcim_iomap_table(pdev);
 
 	rc = pci_go_64(pdev);
 	if (rc)
 		return rc;
 
-	probe_ent = devm_kzalloc(dev, sizeof(*probe_ent), GFP_KERNEL);
-	if (probe_ent == NULL)
-		return -ENOMEM;
-
-	probe_ent->dev = pci_dev_to_dev(pdev);
-	INIT_LIST_HEAD(&probe_ent->node);
-
-	hpriv = devm_kzalloc(dev, sizeof(*hpriv), GFP_KERNEL);
-	if (!hpriv)
-		return -ENOMEM;
-
-	probe_ent->sht = mv_port_info[board_idx].sht;
-	probe_ent->port_flags = mv_port_info[board_idx].flags;
-	probe_ent->pio_mask = mv_port_info[board_idx].pio_mask;
-	probe_ent->udma_mask = mv_port_info[board_idx].udma_mask;
-	probe_ent->port_ops = mv_port_info[board_idx].port_ops;
-
-	probe_ent->irq = pdev->irq;
-	probe_ent->irq_flags = IRQF_SHARED;
-	probe_ent->iomap = pcim_iomap_table(pdev);
-	probe_ent->private_data = hpriv;
-
 	/* initialize adapter */
-	rc = mv_init_host(pdev, probe_ent, board_idx);
+	rc = mv_init_host(host, board_idx);
 	if (rc)
 		return rc;
 
@@ -2390,13 +2367,11 @@ static int mv_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 		pci_intx(pdev, 1);
 
 	mv_dump_pci_cfg(pdev, 0x68);
-	mv_print_info(probe_ent);
-
-	if (ata_device_add(probe_ent) == 0)
-		return -ENODEV;
+	mv_print_info(host);
 
-	devm_kfree(dev, probe_ent);
-	return 0;
+	pci_set_master(pdev);
+	return ata_host_activate(host, pdev->irq, mv_interrupt, IRQF_SHARED,
+				 &mv_sht);
 }
 
 static int __init mv_init(void)
diff --git a/drivers/ata/sata_qstor.c b/drivers/ata/sata_qstor.c
index 8786b45..f5a05de 100644
--- a/drivers/ata/sata_qstor.c
+++ b/drivers/ata/sata_qstor.c
@@ -114,7 +114,6 @@ struct qs_port_priv {
 static u32 qs_scr_read (struct ata_port *ap, unsigned int sc_reg);
 static void qs_scr_write (struct ata_port *ap, unsigned int sc_reg, u32 val);
 static int qs_ata_init_one (struct pci_dev *pdev, const struct pci_device_id *ent);
-static irqreturn_t qs_intr (int irq, void *dev_instance);
 static int qs_port_start(struct ata_port *ap);
 static void qs_host_stop(struct ata_host *host);
 static void qs_phy_reset(struct ata_port *ap);
@@ -158,7 +157,6 @@ static const struct ata_port_operations qs_ata_ops = {
 	.qc_issue		= qs_qc_issue,
 	.data_xfer		= ata_data_xfer,
 	.eng_timeout		= qs_eng_timeout,
-	.irq_handler		= qs_intr,
 	.irq_clear		= qs_irq_clear,
 	.irq_on			= ata_irq_on,
 	.irq_ack		= ata_irq_ack,
@@ -173,7 +171,6 @@ static const struct ata_port_operations qs_ata_ops = {
 static const struct ata_port_info qs_port_info[] = {
 	/* board_2068_idx */
 	{
-		.sht		= &qs_ata_sht,
 		.flags		= ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
 				  ATA_FLAG_SATA_RESET |
 				  //FIXME ATA_FLAG_SRST |
@@ -530,16 +527,16 @@ static void qs_host_stop(struct ata_host *host)
 	writeb(QS_CNFG3_GSRST, mmio_base + QS_HCF_CNFG3); /* global reset */
 }
 
-static void qs_host_init(unsigned int chip_id, struct ata_probe_ent *pe)
+static void qs_host_init(struct ata_host *host, unsigned int chip_id)
 {
-	void __iomem *mmio_base = pe->iomap[QS_MMIO_BAR];
+	void __iomem *mmio_base = host->iomap[QS_MMIO_BAR];
 	unsigned int port_no;
 
 	writeb(0, mmio_base + QS_HCT_CTRL); /* disable host interrupts */
 	writeb(QS_CNFG3_GSRST, mmio_base + QS_HCF_CNFG3); /* global reset */
 
 	/* reset each channel in turn */
-	for (port_no = 0; port_no < pe->n_ports; ++port_no) {
+	for (port_no = 0; port_no < host->n_ports; ++port_no) {
 		u8 __iomem *chan = mmio_base + (port_no * 0x4000);
 		writeb(QS_CTR1_RDEV|QS_CTR1_RCHN, chan + QS_CCT_CTR1);
 		writeb(QS_CTR0_REG, chan + QS_CCT_CTR0);
@@ -547,7 +544,7 @@ static void qs_host_init(unsigned int chip_id, struct ata_probe_ent *pe)
 	}
 	writeb(QS_SERD3_PHY_ENA, mmio_base + QS_HVS_SERD3); /* enable phy */
 
-	for (port_no = 0; port_no < pe->n_ports; ++port_no) {
+	for (port_no = 0; port_no < host->n_ports; ++port_no) {
 		u8 __iomem *chan = mmio_base + (port_no * 0x4000);
 		/* set FIFO depths to same settings as Windows driver */
 		writew(32, chan + QS_CFC_HUFT);
@@ -607,14 +604,20 @@ static int qs_ata_init_one(struct pci_dev *pdev,
 				const struct pci_device_id *ent)
 {
 	static int printed_version;
-	struct ata_probe_ent *probe_ent;
-	void __iomem * const *iomap;
 	unsigned int board_idx = (unsigned int) ent->driver_data;
+	const struct ata_port_info *ppi[] = { &qs_port_info[board_idx], NULL };
+	struct ata_host *host;
 	int rc, port_no;
 
 	if (!printed_version++)
 		dev_printk(KERN_DEBUG, &pdev->dev, "version " DRV_VERSION "\n");
 
+	/* alloc host */
+	host = ata_host_alloc_pinfo(&pdev->dev, ppi, QS_PORTS);
+	if (!host)
+		return -ENOMEM;
+
+	/* acquire resources and fill host */
 	rc = pcim_enable_device(pdev);
 	if (rc)
 		return rc;
@@ -625,47 +628,24 @@ static int qs_ata_init_one(struct pci_dev *pdev,
 	rc = pcim_iomap_regions(pdev, 1 << QS_MMIO_BAR, DRV_NAME);
 	if (rc)
 		return rc;
-	iomap = pcim_iomap_table(pdev);
+	host->iomap = pcim_iomap_table(pdev);
 
-	rc = qs_set_dma_masks(pdev, iomap[QS_MMIO_BAR]);
+	rc = qs_set_dma_masks(pdev, host->iomap[QS_MMIO_BAR]);
 	if (rc)
 		return rc;
 
-	probe_ent = devm_kzalloc(&pdev->dev, sizeof(*probe_ent), GFP_KERNEL);
-	if (probe_ent == NULL)
-		return -ENOMEM;
-
-	probe_ent->dev = pci_dev_to_dev(pdev);
-	INIT_LIST_HEAD(&probe_ent->node);
-
-	probe_ent->sht		= qs_port_info[board_idx].sht;
-	probe_ent->port_flags	= qs_port_info[board_idx].flags;
-	probe_ent->pio_mask	= qs_port_info[board_idx].pio_mask;
-	probe_ent->mwdma_mask	= qs_port_info[board_idx].mwdma_mask;
-	probe_ent->udma_mask	= qs_port_info[board_idx].udma_mask;
-	probe_ent->port_ops	= qs_port_info[board_idx].port_ops;
-
-	probe_ent->irq		= pdev->irq;
-	probe_ent->irq_flags	= IRQF_SHARED;
-	probe_ent->iomap	= iomap;
-	probe_ent->n_ports	= QS_PORTS;
-
-	for (port_no = 0; port_no < probe_ent->n_ports; ++port_no) {
+	for (port_no = 0; port_no < host->n_ports; ++port_no) {
 		void __iomem *chan =
-			probe_ent->iomap[QS_MMIO_BAR] + (port_no * 0x4000);
-		qs_ata_setup_port(&probe_ent->port[port_no], chan);
+			host->iomap[QS_MMIO_BAR] + (port_no * 0x4000);
+		qs_ata_setup_port(&host->ports[port_no]->ioaddr, chan);
 	}
 
-	pci_set_master(pdev);
-
 	/* initialize adapter */
-	qs_host_init(board_idx, probe_ent);
+	qs_host_init(host, board_idx);
 
-	if (ata_device_add(probe_ent) != QS_PORTS)
-		return -EIO;
-
-	devm_kfree(&pdev->dev, probe_ent);
-	return 0;
+	pci_set_master(pdev);
+	return ata_host_activate(host, pdev->irq, qs_intr, IRQF_SHARED,
+				 &qs_ata_sht);
 }
 
 static int __init qs_ata_init(void)
diff --git a/drivers/ata/sata_sil.c b/drivers/ata/sata_sil.c
index 466b05b..0a1e417 100644
--- a/drivers/ata/sata_sil.c
+++ b/drivers/ata/sata_sil.c
@@ -118,7 +118,6 @@ static void sil_dev_config(struct ata_device *dev);
 static u32 sil_scr_read (struct ata_port *ap, unsigned int sc_reg);
 static void sil_scr_write (struct ata_port *ap, unsigned int sc_reg, u32 val);
 static int sil_set_mode (struct ata_port *ap, struct ata_device **r_failed);
-static irqreturn_t sil_interrupt(int irq, void *dev_instance);
 static void sil_freeze(struct ata_port *ap);
 static void sil_thaw(struct ata_port *ap);
 
@@ -209,7 +208,6 @@ static const struct ata_port_operations sil_ops = {
 	.thaw			= sil_thaw,
 	.error_handler		= ata_bmdma_error_handler,
 	.post_internal_cmd	= ata_bmdma_post_internal_cmd,
-	.irq_handler		= sil_interrupt,
 	.irq_clear		= ata_bmdma_irq_clear,
 	.irq_on			= ata_irq_on,
 	.irq_ack		= ata_irq_ack,
@@ -221,7 +219,6 @@ static const struct ata_port_operations sil_ops = {
 static const struct ata_port_info sil_port_info[] = {
 	/* sil_3112 */
 	{
-		.sht		= &sil_sht,
 		.flags		= SIL_DFL_PORT_FLAGS | SIL_FLAG_MOD15WRITE,
 		.pio_mask	= 0x1f,			/* pio0-4 */
 		.mwdma_mask	= 0x07,			/* mwdma0-2 */
@@ -230,7 +227,6 @@ static const struct ata_port_info sil_port_info[] = {
 	},
 	/* sil_3112_no_sata_irq */
 	{
-		.sht		= &sil_sht,
 		.flags		= SIL_DFL_PORT_FLAGS | SIL_FLAG_MOD15WRITE |
 				  SIL_FLAG_NO_SATA_IRQ,
 		.pio_mask	= 0x1f,			/* pio0-4 */
@@ -240,7 +236,6 @@ static const struct ata_port_info sil_port_info[] = {
 	},
 	/* sil_3512 */
 	{
-		.sht		= &sil_sht,
 		.flags		= SIL_DFL_PORT_FLAGS | SIL_FLAG_RERR_ON_DMA_ACT,
 		.pio_mask	= 0x1f,			/* pio0-4 */
 		.mwdma_mask	= 0x07,			/* mwdma0-2 */
@@ -249,7 +244,6 @@ static const struct ata_port_info sil_port_info[] = {
 	},
 	/* sil_3114 */
 	{
-		.sht		= &sil_sht,
 		.flags		= SIL_DFL_PORT_FLAGS | SIL_FLAG_RERR_ON_DMA_ACT,
 		.pio_mask	= 0x1f,			/* pio0-4 */
 		.mwdma_mask	= 0x07,			/* mwdma0-2 */
@@ -598,10 +592,10 @@ static void sil_dev_config(struct ata_device *dev)
 	}
 }
 
-static void sil_init_controller(struct pci_dev *pdev,
-				int n_ports, unsigned long port_flags,
-				void __iomem *mmio_base)
+static void sil_init_controller(struct ata_host *host)
 {
+	struct pci_dev *pdev = to_pci_dev(host->dev);
+	void __iomem *mmio_base = host->iomap[SIL_MMIO_BAR];
 	u8 cls;
 	u32 tmp;
 	int i;
@@ -611,7 +605,7 @@ static void sil_init_controller(struct pci_dev *pdev,
 	if (cls) {
 		cls >>= 3;
 		cls++;  /* cls = (line_size/8)+1 */
-		for (i = 0; i < n_ports; i++)
+		for (i = 0; i < host->n_ports; i++)
 			writew(cls << 8 | cls,
 			       mmio_base + sil_port[i].fifo_cfg);
 	} else
@@ -619,10 +613,10 @@ static void sil_init_controller(struct pci_dev *pdev,
 			   "cache line size not set.  Driver may not function\n");
 
 	/* Apply R_ERR on DMA activate FIS errata workaround */
-	if (port_flags & SIL_FLAG_RERR_ON_DMA_ACT) {
+	if (host->ports[0]->flags & SIL_FLAG_RERR_ON_DMA_ACT) {
 		int cnt;
 
-		for (i = 0, cnt = 0; i < n_ports; i++) {
+		for (i = 0, cnt = 0; i < host->n_ports; i++) {
 			tmp = readl(mmio_base + sil_port[i].sfis_cfg);
 			if ((tmp & 0x3) != 0x01)
 				continue;
@@ -635,7 +629,7 @@ static void sil_init_controller(struct pci_dev *pdev,
 		}
 	}
 
-	if (n_ports == 4) {
+	if (host->n_ports == 4) {
 		/* flip the magic "make 4 ports work" bit */
 		tmp = readl(mmio_base + sil_port[2].bmdma);
 		if ((tmp & SIL_INTR_STEERING) == 0)
@@ -647,15 +641,26 @@ static void sil_init_controller(struct pci_dev *pdev,
 static int sil_init_one (struct pci_dev *pdev, const struct pci_device_id *ent)
 {
 	static int printed_version;
-	struct device *dev = &pdev->dev;
-	struct ata_probe_ent *probe_ent;
+	int board_id = ent->driver_data;
+	const struct ata_port_info *ppi[] = { &sil_port_info[board_id], NULL };
+	struct ata_host *host;
 	void __iomem *mmio_base;
-	int rc;
+	int n_ports, rc;
 	unsigned int i;
 
 	if (!printed_version++)
 		dev_printk(KERN_DEBUG, &pdev->dev, "version " DRV_VERSION "\n");
 
+	/* allocate host */
+	n_ports = 2;
+	if (board_id == sil_3114)
+		n_ports = 4;
+
+	host = ata_host_alloc_pinfo(&pdev->dev, ppi, n_ports);
+	if (!host)
+		return -ENOMEM;
+
+	/* acquire resources and fill host */
 	rc = pcim_enable_device(pdev);
 	if (rc)
 		return rc;
@@ -665,6 +670,7 @@ static int sil_init_one (struct pci_dev *pdev, const struct pci_device_id *ent)
 		pcim_pin_device(pdev);
 	if (rc)
 		return rc;
+	host->iomap = pcim_iomap_table(pdev);
 
 	rc = pci_set_dma_mask(pdev, ATA_DMA_MASK);
 	if (rc)
@@ -673,45 +679,25 @@ static int sil_init_one (struct pci_dev *pdev, const struct pci_device_id *ent)
 	if (rc)
 		return rc;
 
-	probe_ent = devm_kzalloc(dev, sizeof(*probe_ent), GFP_KERNEL);
-	if (probe_ent == NULL)
-		return -ENOMEM;
+	mmio_base = host->iomap[SIL_MMIO_BAR];
 
-	INIT_LIST_HEAD(&probe_ent->node);
-	probe_ent->dev = pci_dev_to_dev(pdev);
-	probe_ent->port_ops = sil_port_info[ent->driver_data].port_ops;
-	probe_ent->sht = sil_port_info[ent->driver_data].sht;
-	probe_ent->n_ports = (ent->driver_data == sil_3114) ? 4 : 2;
-	probe_ent->pio_mask = sil_port_info[ent->driver_data].pio_mask;
-	probe_ent->mwdma_mask = sil_port_info[ent->driver_data].mwdma_mask;
-	probe_ent->udma_mask = sil_port_info[ent->driver_data].udma_mask;
-       	probe_ent->irq = pdev->irq;
-       	probe_ent->irq_flags = IRQF_SHARED;
-	probe_ent->port_flags = sil_port_info[ent->driver_data].flags;
-
-	probe_ent->iomap = pcim_iomap_table(pdev);
-
-	mmio_base = probe_ent->iomap[SIL_MMIO_BAR];
-
-	for (i = 0; i < probe_ent->n_ports; i++) {
-		probe_ent->port[i].cmd_addr = mmio_base + sil_port[i].tf;
-		probe_ent->port[i].altstatus_addr =
-		probe_ent->port[i].ctl_addr = mmio_base + sil_port[i].ctl;
-		probe_ent->port[i].bmdma_addr = mmio_base + sil_port[i].bmdma;
-		probe_ent->port[i].scr_addr = mmio_base + sil_port[i].scr;
-		ata_std_ports(&probe_ent->port[i]);
+	for (i = 0; i < host->n_ports; i++) {
+		struct ata_ioports *ioaddr = &host->ports[i]->ioaddr;
+
+		ioaddr->cmd_addr = mmio_base + sil_port[i].tf;
+		ioaddr->altstatus_addr =
+		ioaddr->ctl_addr = mmio_base + sil_port[i].ctl;
+		ioaddr->bmdma_addr = mmio_base + sil_port[i].bmdma;
+		ioaddr->scr_addr = mmio_base + sil_port[i].scr;
+		ata_std_ports(ioaddr);
 	}
 
-	sil_init_controller(pdev, probe_ent->n_ports, probe_ent->port_flags,
-			    mmio_base);
+	/* initialize and activate */
+	sil_init_controller(host);
 
 	pci_set_master(pdev);
-
-	if (!ata_device_add(probe_ent))
-		return -ENODEV;
-
-	devm_kfree(dev, probe_ent);
-	return 0;
+	return ata_host_activate(host, pdev->irq, sil_interrupt, IRQF_SHARED,
+				 &sil_sht);
 }
 
 #ifdef CONFIG_PM
@@ -724,8 +710,7 @@ static int sil_pci_device_resume(struct pci_dev *pdev)
 	if (rc)
 		return rc;
 
-	sil_init_controller(pdev, host->n_ports, host->ports[0]->flags,
-			    host->iomap[SIL_MMIO_BAR]);
+	sil_init_controller(host);
 	ata_host_resume(host);
 
 	return 0;
diff --git a/drivers/ata/sata_sil24.c b/drivers/ata/sata_sil24.c
index 6698c74..9d96206 100644
--- a/drivers/ata/sata_sil24.c
+++ b/drivers/ata/sata_sil24.c
@@ -331,7 +331,6 @@ static void sil24_tf_read(struct ata_port *ap, struct ata_taskfile *tf);
 static void sil24_qc_prep(struct ata_queued_cmd *qc);
 static unsigned int sil24_qc_issue(struct ata_queued_cmd *qc);
 static void sil24_irq_clear(struct ata_port *ap);
-static irqreturn_t sil24_interrupt(int irq, void *dev_instance);
 static void sil24_freeze(struct ata_port *ap);
 static void sil24_thaw(struct ata_port *ap);
 static void sil24_error_handler(struct ata_port *ap);
@@ -401,7 +400,6 @@ static const struct ata_port_operations sil24_ops = {
 	.qc_prep		= sil24_qc_prep,
 	.qc_issue		= sil24_qc_issue,
 
-	.irq_handler		= sil24_interrupt,
 	.irq_clear		= sil24_irq_clear,
 	.irq_on			= ata_dummy_irq_on,
 	.irq_ack		= ata_dummy_irq_ack,
@@ -424,10 +422,9 @@ static const struct ata_port_operations sil24_ops = {
 #define SIL24_NPORTS2FLAG(nports)	((((unsigned)(nports) - 1) & 0x3) << 30)
 #define SIL24_FLAG2NPORTS(flag)		((((flag) >> 30) & 0x3) + 1)
 
-static struct ata_port_info sil24_port_info[] = {
+static const struct ata_port_info sil24_port_info[] = {
 	/* sil_3124 */
 	{
-		.sht		= &sil24_sht,
 		.flags		= SIL24_COMMON_FLAGS | SIL24_NPORTS2FLAG(4) |
 				  SIL24_FLAG_PCIX_IRQ_WOC,
 		.pio_mask	= 0x1f,			/* pio0-4 */
@@ -437,7 +434,6 @@ static struct ata_port_info sil24_port_info[] = {
 	},
 	/* sil_3132 */
 	{
-		.sht		= &sil24_sht,
 		.flags		= SIL24_COMMON_FLAGS | SIL24_NPORTS2FLAG(2),
 		.pio_mask	= 0x1f,			/* pio0-4 */
 		.mwdma_mask	= 0x07,			/* mwdma0-2 */
@@ -446,7 +442,6 @@ static struct ata_port_info sil24_port_info[] = {
 	},
 	/* sil_3131/sil_3531 */
 	{
-		.sht		= &sil24_sht,
 		.flags		= SIL24_COMMON_FLAGS | SIL24_NPORTS2FLAG(1),
 		.pio_mask	= 0x1f,			/* pio0-4 */
 		.mwdma_mask	= 0x07,			/* mwdma0-2 */
@@ -964,11 +959,10 @@ static int sil24_port_start(struct ata_port *ap)
 	return 0;
 }
 
-static void sil24_init_controller(struct pci_dev *pdev, int n_ports,
-				  unsigned long port_flags,
-				  void __iomem *host_base,
-				  void __iomem *port_base)
+static void sil24_init_controller(struct ata_host *host)
 {
+	void __iomem *host_base = host->iomap[SIL24_HOST_BAR];
+	void __iomem *port_base = host->iomap[SIL24_PORT_BAR];
 	u32 tmp;
 	int i;
 
@@ -979,7 +973,7 @@ static void sil24_init_controller(struct pci_dev *pdev, int n_ports,
 	writel(0, host_base + HOST_CTRL);
 
 	/* init ports */
-	for (i = 0; i < n_ports; i++) {
+	for (i = 0; i < host->n_ports; i++) {
 		void __iomem *port = port_base + i * PORT_REGS_SIZE;
 
 		/* Initial PHY setting */
@@ -993,12 +987,12 @@ static void sil24_init_controller(struct pci_dev *pdev, int n_ports,
 						PORT_CS_PORT_RST,
 						PORT_CS_PORT_RST, 10, 100);
 			if (tmp & PORT_CS_PORT_RST)
-				dev_printk(KERN_ERR, &pdev->dev,
+				dev_printk(KERN_ERR, host->dev,
 				           "failed to clear port RST\n");
 		}
 
 		/* Configure IRQ WoC */
-		if (port_flags & SIL24_FLAG_PCIX_IRQ_WOC)
+		if (host->ports[0]->flags & SIL24_FLAG_PCIX_IRQ_WOC)
 			writel(PORT_CS_IRQ_WOC, port + PORT_CTRL_STAT);
 		else
 			writel(PORT_CS_IRQ_WOC, port + PORT_CTRL_CLR);
@@ -1026,18 +1020,17 @@ static void sil24_init_controller(struct pci_dev *pdev, int n_ports,
 static int sil24_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 {
 	static int printed_version = 0;
-	struct device *dev = &pdev->dev;
-	unsigned int board_id = (unsigned int)ent->driver_data;
-	struct ata_port_info *pinfo = &sil24_port_info[board_id];
-	struct ata_probe_ent *probe_ent;
-	void __iomem *host_base;
-	void __iomem *port_base;
+	struct ata_port_info pi = sil24_port_info[ent->driver_data];
+	const struct ata_port_info *ppi[] = { &pi, NULL };
+	void __iomem * const *iomap;
+	struct ata_host *host;
 	int i, rc;
 	u32 tmp;
 
 	if (!printed_version++)
 		dev_printk(KERN_DEBUG, &pdev->dev, "version " DRV_VERSION "\n");
 
+	/* acquire resources */
 	rc = pcim_enable_device(pdev);
 	if (rc)
 		return rc;
@@ -1047,33 +1040,36 @@ static int sil24_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 				DRV_NAME);
 	if (rc)
 		return rc;
+	iomap = pcim_iomap_table(pdev);
 
-	/* allocate & init probe_ent */
-	probe_ent = devm_kzalloc(dev, sizeof(*probe_ent), GFP_KERNEL);
-	if (!probe_ent)
-		return -ENOMEM;
+	/* apply workaround for completion IRQ loss on PCI-X errata */
+	if (pi.flags & SIL24_FLAG_PCIX_IRQ_WOC) {
+		tmp = readl(iomap[SIL24_HOST_BAR] + HOST_CTRL);
+		if (tmp & (HOST_CTRL_TRDY | HOST_CTRL_STOP | HOST_CTRL_DEVSEL))
+			dev_printk(KERN_INFO, &pdev->dev,
+				   "Applying completion IRQ loss on PCI-X "
+				   "errata fix\n");
+		else
+			pi.flags &= ~SIL24_FLAG_PCIX_IRQ_WOC;
+	}
 
-	probe_ent->dev = pci_dev_to_dev(pdev);
-	INIT_LIST_HEAD(&probe_ent->node);
+	/* allocate and fill host */
+	host = ata_host_alloc_pinfo(&pdev->dev, ppi,
+				    SIL24_FLAG2NPORTS(ppi[0]->flags));
+	if (!host)
+		return -ENOMEM;
+	host->iomap = iomap;
 
-	probe_ent->sht		= pinfo->sht;
-	probe_ent->port_flags	= pinfo->flags;
-	probe_ent->pio_mask	= pinfo->pio_mask;
-	probe_ent->mwdma_mask	= pinfo->mwdma_mask;
-	probe_ent->udma_mask	= pinfo->udma_mask;
-	probe_ent->port_ops	= pinfo->port_ops;
-	probe_ent->n_ports	= SIL24_FLAG2NPORTS(pinfo->flags);
+	for (i = 0; i < host->n_ports; i++) {
+		void __iomem *port = iomap[SIL24_PORT_BAR] + i * PORT_REGS_SIZE;
 
-	probe_ent->irq = pdev->irq;
-	probe_ent->irq_flags = IRQF_SHARED;
-	probe_ent->iomap = pcim_iomap_table(pdev);
+		host->ports[i]->ioaddr.cmd_addr = port;
+		host->ports[i]->ioaddr.scr_addr = port + PORT_SCONTROL;
 
-	host_base = probe_ent->iomap[SIL24_HOST_BAR];
-	port_base = probe_ent->iomap[SIL24_PORT_BAR];
+		ata_std_ports(&host->ports[i]->ioaddr);
+	}
 
-	/*
-	 * Configure the device
-	 */
+	/* configure and activate the device */
 	if (!pci_set_dma_mask(pdev, DMA_64BIT_MASK)) {
 		rc = pci_set_consistent_dma_mask(pdev, DMA_64BIT_MASK);
 		if (rc) {
@@ -1099,36 +1095,11 @@ static int sil24_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 		}
 	}
 
-	/* Apply workaround for completion IRQ loss on PCI-X errata */
-	if (probe_ent->port_flags & SIL24_FLAG_PCIX_IRQ_WOC) {
-		tmp = readl(host_base + HOST_CTRL);
-		if (tmp & (HOST_CTRL_TRDY | HOST_CTRL_STOP | HOST_CTRL_DEVSEL))
-			dev_printk(KERN_INFO, &pdev->dev,
-				   "Applying completion IRQ loss on PCI-X "
-				   "errata fix\n");
-		else
-			probe_ent->port_flags &= ~SIL24_FLAG_PCIX_IRQ_WOC;
-	}
-
-	for (i = 0; i < probe_ent->n_ports; i++) {
-		void __iomem *port = port_base + i * PORT_REGS_SIZE;
-
-		probe_ent->port[i].cmd_addr = port;
-		probe_ent->port[i].scr_addr = port + PORT_SCONTROL;
-
-		ata_std_ports(&probe_ent->port[i]);
-	}
-
-	sil24_init_controller(pdev, probe_ent->n_ports, probe_ent->port_flags,
-			      host_base, port_base);
+	sil24_init_controller(host);
 
 	pci_set_master(pdev);
-
-	if (!ata_device_add(probe_ent))
-		return -ENODEV;
-
-	devm_kfree(dev, probe_ent);
-	return 0;
+	return ata_host_activate(host, pdev->irq, sil24_interrupt, IRQF_SHARED,
+				 &sil24_sht);
 }
 
 #ifdef CONFIG_PM
@@ -1136,7 +1107,6 @@ static int sil24_pci_device_resume(struct pci_dev *pdev)
 {
 	struct ata_host *host = dev_get_drvdata(&pdev->dev);
 	void __iomem *host_base = host->iomap[SIL24_HOST_BAR];
-	void __iomem *port_base = host->iomap[SIL24_PORT_BAR];
 	int rc;
 
 	rc = ata_pci_device_do_resume(pdev);
@@ -1146,8 +1116,7 @@ static int sil24_pci_device_resume(struct pci_dev *pdev)
 	if (pdev->dev.power.power_state.event == PM_EVENT_SUSPEND)
 		writel(HOST_CTRL_GLOBAL_RST, host_base + HOST_CTRL);
 
-	sil24_init_controller(pdev, host->n_ports, host->ports[0]->flags,
-			      host_base, port_base);
+	sil24_init_controller(host);
 
 	ata_host_resume(host);
 
diff --git a/drivers/ata/sata_svw.c b/drivers/ata/sata_svw.c
index b121195..cc07aac 100644
--- a/drivers/ata/sata_svw.c
+++ b/drivers/ata/sata_svw.c
@@ -56,7 +56,9 @@
 #define DRV_VERSION	"2.1"
 
 enum {
-	K2_FLAG_NO_ATAPI_DMA		= (1 << 29),
+	/* ap->flags bits */
+	K2_FLAG_SATA_8_PORTS		= (1 << 24),
+	K2_FLAG_NO_ATAPI_DMA		= (1 << 25),
 
 	/* Taskfile registers offsets */
 	K2_SATA_TF_CMD_OFFSET		= 0x00,
@@ -90,17 +92,6 @@ enum {
 	board_svw8			= 1,
 };
 
-static const struct k2_board_info {
-	unsigned int		n_ports;
-	unsigned long		port_flags;
-} k2_board_info[] = {
-	/* board_svw4 */
-	{ 4, K2_FLAG_NO_ATAPI_DMA },
-
-	/* board_svw8 */
-	{ 8, K2_FLAG_NO_ATAPI_DMA },
-};
-
 static u8 k2_stat_check_status(struct ata_port *ap);
 
 
@@ -354,7 +345,6 @@ static const struct ata_port_operations k2_sata_ops = {
 	.thaw			= ata_bmdma_thaw,
 	.error_handler		= ata_bmdma_error_handler,
 	.post_internal_cmd	= ata_bmdma_post_internal_cmd,
-	.irq_handler		= ata_interrupt,
 	.irq_clear		= ata_bmdma_irq_clear,
 	.irq_on			= ata_irq_on,
 	.irq_ack		= ata_irq_ack,
@@ -363,6 +353,28 @@ static const struct ata_port_operations k2_sata_ops = {
 	.port_start		= ata_port_start,
 };
 
+static const struct ata_port_info k2_port_info[] = {
+	/* board_svw4 */
+	{
+		.flags		= ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
+				  ATA_FLAG_MMIO | K2_FLAG_NO_ATAPI_DMA,
+		.pio_mask	= 0x1f,
+		.mwdma_mask	= 0x07,
+		.udma_mask	= 0x7f,
+		.port_ops	= &k2_sata_ops,
+	},
+	/* board_svw8 */
+	{
+		.flags		= ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
+				  ATA_FLAG_MMIO | K2_FLAG_NO_ATAPI_DMA |
+				  K2_FLAG_SATA_8_PORTS,
+		.pio_mask	= 0x1f,
+		.mwdma_mask	= 0x07,
+		.udma_mask	= 0x7f,
+		.port_ops	= &k2_sata_ops,
+	},
+};
+
 static void k2_sata_setup_port(struct ata_ioports *port, void __iomem *base)
 {
 	port->cmd_addr		= base + K2_SATA_TF_CMD_OFFSET;
@@ -386,17 +398,24 @@ static void k2_sata_setup_port(struct ata_ioports *port, void __iomem *base)
 static int k2_sata_init_one (struct pci_dev *pdev, const struct pci_device_id *ent)
 {
 	static int printed_version;
-	struct device *dev = &pdev->dev;
-	struct ata_probe_ent *probe_ent;
+	const struct ata_port_info *ppi[] =
+		{ &k2_port_info[ent->driver_data], NULL };
+	struct ata_host *host;
 	void __iomem *mmio_base;
-	const struct k2_board_info *board_info =
-			&k2_board_info[ent->driver_data];
-	int rc;
-	int i;
+	int n_ports, i, rc;
 
 	if (!printed_version++)
 		dev_printk(KERN_DEBUG, &pdev->dev, "version " DRV_VERSION "\n");
 
+	/* allocate host */
+	n_ports = 4;
+	if (ppi[0]->flags & K2_FLAG_SATA_8_PORTS)
+		n_ports = 8;
+
+	host = ata_host_alloc_pinfo(&pdev->dev, ppi, n_ports);
+	if (!host)
+		return -ENOMEM;
+
 	/*
 	 * If this driver happens to only be useful on Apple's K2, then
 	 * we should check that here as it has a normal Serverworks ID
@@ -404,6 +423,7 @@ static int k2_sata_init_one (struct pci_dev *pdev, const struct pci_device_id *e
 	rc = pcim_enable_device(pdev);
 	if (rc)
 		return rc;
+
 	/*
 	 * Check if we have resources mapped at all (second function may
 	 * have been disabled by firmware)
@@ -417,6 +437,15 @@ static int k2_sata_init_one (struct pci_dev *pdev, const struct pci_device_id *e
 		pcim_pin_device(pdev);
 	if (rc)
 		return rc;
+	host->iomap = pcim_iomap_table(pdev);
+	mmio_base = host->iomap[5];
+
+	/* different controllers have different number of ports - currently 4 or 8 */
+	/* All ports are on the same function. Multi-function device is no
+	 * longer available. This should not be seen in any system. */
+	for (i = 0; i < host->n_ports; i++)
+		k2_sata_setup_port(&host->ports[i]->ioaddr,
+				   mmio_base + i * K2_SATA_PORT_OFFSET);
 
 	rc = pci_set_dma_mask(pdev, ATA_DMA_MASK);
 	if (rc)
@@ -425,38 +454,6 @@ static int k2_sata_init_one (struct pci_dev *pdev, const struct pci_device_id *e
 	if (rc)
 		return rc;
 
-	probe_ent = devm_kzalloc(dev, sizeof(*probe_ent), GFP_KERNEL);
-	if (probe_ent == NULL)
-		return -ENOMEM;
-
-	probe_ent->dev = pci_dev_to_dev(pdev);
-	INIT_LIST_HEAD(&probe_ent->node);
-
-	probe_ent->sht = &k2_sata_sht;
-	probe_ent->port_flags = ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
-				ATA_FLAG_MMIO | board_info->port_flags;
-	probe_ent->port_ops = &k2_sata_ops;
-	probe_ent->n_ports = 4;
-	probe_ent->irq = pdev->irq;
-	probe_ent->irq_flags = IRQF_SHARED;
-	probe_ent->iomap = pcim_iomap_table(pdev);
-
-	/* We don't care much about the PIO/UDMA masks, but the core won't like us
-	 * if we don't fill these
-	 */
-	probe_ent->pio_mask = 0x1f;
-	probe_ent->mwdma_mask = 0x7;
-	probe_ent->udma_mask = 0x7f;
-
-	mmio_base = probe_ent->iomap[5];
-
-	/* different controllers have different number of ports - currently 4 or 8 */
-	/* All ports are on the same function. Multi-function device is no
-	 * longer available. This should not be seen in any system. */
-	for (i = 0; i < board_info->n_ports; i++)
-		k2_sata_setup_port(&probe_ent->port[i],
-				   mmio_base + i * K2_SATA_PORT_OFFSET);
-
 	/* Clear a magic bit in SCR1 according to Darwin, those help
 	 * some funky seagate drives (though so far, those were already
 	 * set by the firmware on the machines I had access to)
@@ -469,12 +466,8 @@ static int k2_sata_init_one (struct pci_dev *pdev, const struct pci_device_id *e
 	writel(0x0, mmio_base + K2_SATA_SIM_OFFSET);
 
 	pci_set_master(pdev);
-
-	if (!ata_device_add(probe_ent))
-		return -ENODEV;
-
-	devm_kfree(dev, probe_ent);
-	return 0;
+	return ata_host_activate(host, pdev->irq, ata_interrupt, IRQF_SHARED,
+				 &k2_sata_sht);
 }
 
 /* 0x240 is device ID for Apple K2 device
diff --git a/drivers/ata/sata_sx4.c b/drivers/ata/sata_sx4.c
index 1a081c3..3a4f445 100644
--- a/drivers/ata/sata_sx4.c
+++ b/drivers/ata/sata_sx4.c
@@ -151,24 +151,23 @@ struct pdc_host_priv {
 
 
 static int pdc_sata_init_one (struct pci_dev *pdev, const struct pci_device_id *ent);
-static irqreturn_t pdc20621_interrupt (int irq, void *dev_instance);
 static void pdc_eng_timeout(struct ata_port *ap);
 static void pdc_20621_phy_reset (struct ata_port *ap);
 static int pdc_port_start(struct ata_port *ap);
 static void pdc20621_qc_prep(struct ata_queued_cmd *qc);
 static void pdc_tf_load_mmio(struct ata_port *ap, const struct ata_taskfile *tf);
 static void pdc_exec_command_mmio(struct ata_port *ap, const struct ata_taskfile *tf);
-static unsigned int pdc20621_dimm_init(struct ata_probe_ent *pe);
-static int pdc20621_detect_dimm(struct ata_probe_ent *pe);
-static unsigned int pdc20621_i2c_read(struct ata_probe_ent *pe,
+static unsigned int pdc20621_dimm_init(struct ata_host *host);
+static int pdc20621_detect_dimm(struct ata_host *host);
+static unsigned int pdc20621_i2c_read(struct ata_host *host,
 				      u32 device, u32 subaddr, u32 *pdata);
-static int pdc20621_prog_dimm0(struct ata_probe_ent *pe);
-static unsigned int pdc20621_prog_dimm_global(struct ata_probe_ent *pe);
+static int pdc20621_prog_dimm0(struct ata_host *host);
+static unsigned int pdc20621_prog_dimm_global(struct ata_host *host);
 #ifdef ATA_VERBOSE_DEBUG
-static void pdc20621_get_from_dimm(struct ata_probe_ent *pe,
+static void pdc20621_get_from_dimm(struct ata_host *host,
 				   void *psource, u32 offset, u32 size);
 #endif
-static void pdc20621_put_to_dimm(struct ata_probe_ent *pe,
+static void pdc20621_put_to_dimm(struct ata_host *host,
 				 void *psource, u32 offset, u32 size);
 static void pdc20621_irq_clear(struct ata_port *ap);
 static unsigned int pdc20621_qc_issue_prot(struct ata_queued_cmd *qc);
@@ -204,7 +203,6 @@ static const struct ata_port_operations pdc_20621_ops = {
 	.qc_issue		= pdc20621_qc_issue_prot,
 	.data_xfer		= ata_data_xfer,
 	.eng_timeout		= pdc_eng_timeout,
-	.irq_handler		= pdc20621_interrupt,
 	.irq_clear		= pdc20621_irq_clear,
 	.irq_on			= ata_irq_on,
 	.irq_ack		= ata_irq_ack,
@@ -214,7 +212,6 @@ static const struct ata_port_operations pdc_20621_ops = {
 static const struct ata_port_info pdc_port_info[] = {
 	/* board_20621 */
 	{
-		.sht		= &pdc_sata_sht,
 		.flags		= ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
 				  ATA_FLAG_SRST | ATA_FLAG_MMIO |
 				  ATA_FLAG_NO_ATAPI | ATA_FLAG_PIO_POLLING,
@@ -882,15 +879,15 @@ static void pdc_sata_setup_port(struct ata_ioports *port, void __iomem *base)
 
 
 #ifdef ATA_VERBOSE_DEBUG
-static void pdc20621_get_from_dimm(struct ata_probe_ent *pe, void *psource,
+static void pdc20621_get_from_dimm(struct ata_host *host, void *psource,
 				   u32 offset, u32 size)
 {
 	u32 window_size;
 	u16 idx;
 	u8 page_mask;
 	long dist;
-	void __iomem *mmio = pe->iomap[PDC_MMIO_BAR];
-	void __iomem *dimm_mmio = pe->iomap[PDC_DIMM_BAR];
+	void __iomem *mmio = host->iomap[PDC_MMIO_BAR];
+	void __iomem *dimm_mmio = host->iomap[PDC_DIMM_BAR];
 
 	/* hard-code chip #0 */
 	mmio += PDC_CHIP0_OFS;
@@ -937,15 +934,15 @@ static void pdc20621_get_from_dimm(struct ata_probe_ent *pe, void *psource,
 #endif
 
 
-static void pdc20621_put_to_dimm(struct ata_probe_ent *pe, void *psource,
+static void pdc20621_put_to_dimm(struct ata_host *host, void *psource,
 				 u32 offset, u32 size)
 {
 	u32 window_size;
 	u16 idx;
 	u8 page_mask;
 	long dist;
-	void __iomem *mmio = pe->iomap[PDC_MMIO_BAR];
-	void __iomem *dimm_mmio = pe->iomap[PDC_DIMM_BAR];
+	void __iomem *mmio = host->iomap[PDC_MMIO_BAR];
+	void __iomem *dimm_mmio = host->iomap[PDC_DIMM_BAR];
 
 	/* hard-code chip #0 */
 	mmio += PDC_CHIP0_OFS;
@@ -987,10 +984,10 @@ static void pdc20621_put_to_dimm(struct ata_probe_ent *pe, void *psource,
 }
 
 
-static unsigned int pdc20621_i2c_read(struct ata_probe_ent *pe, u32 device,
+static unsigned int pdc20621_i2c_read(struct ata_host *host, u32 device,
 				      u32 subaddr, u32 *pdata)
 {
-	void __iomem *mmio = pe->iomap[PDC_MMIO_BAR];
+	void __iomem *mmio = host->iomap[PDC_MMIO_BAR];
 	u32 i2creg  = 0;
 	u32 status;
 	u32 count =0;
@@ -1023,17 +1020,17 @@ static unsigned int pdc20621_i2c_read(struct ata_probe_ent *pe, u32 device,
 }
 
 
-static int pdc20621_detect_dimm(struct ata_probe_ent *pe)
+static int pdc20621_detect_dimm(struct ata_host *host)
 {
 	u32 data=0 ;
-  	if (pdc20621_i2c_read(pe, PDC_DIMM0_SPD_DEV_ADDRESS,
+	if (pdc20621_i2c_read(host, PDC_DIMM0_SPD_DEV_ADDRESS,
 			     PDC_DIMM_SPD_SYSTEM_FREQ, &data)) {
    		if (data == 100)
 			return 100;
   	} else
 		return 0;
 
-   	if (pdc20621_i2c_read(pe, PDC_DIMM0_SPD_DEV_ADDRESS, 9, &data)) {
+	if (pdc20621_i2c_read(host, PDC_DIMM0_SPD_DEV_ADDRESS, 9, &data)) {
 		if(data <= 0x75)
 			return 133;
    	} else
@@ -1043,13 +1040,13 @@ static int pdc20621_detect_dimm(struct ata_probe_ent *pe)
 }
 
 
-static int pdc20621_prog_dimm0(struct ata_probe_ent *pe)
+static int pdc20621_prog_dimm0(struct ata_host *host)
 {
 	u32 spd0[50];
 	u32 data = 0;
    	int size, i;
    	u8 bdimmsize;
-	void __iomem *mmio = pe->iomap[PDC_MMIO_BAR];
+	void __iomem *mmio = host->iomap[PDC_MMIO_BAR];
 	static const struct {
 		unsigned int reg;
 		unsigned int ofs;
@@ -1072,7 +1069,7 @@ static int pdc20621_prog_dimm0(struct ata_probe_ent *pe)
 	mmio += PDC_CHIP0_OFS;
 
 	for(i=0; i<ARRAY_SIZE(pdc_i2c_read_data); i++)
-		pdc20621_i2c_read(pe, PDC_DIMM0_SPD_DEV_ADDRESS,
+		pdc20621_i2c_read(host, PDC_DIMM0_SPD_DEV_ADDRESS,
 				  pdc_i2c_read_data[i].reg,
 				  &spd0[pdc_i2c_read_data[i].ofs]);
 
@@ -1108,11 +1105,11 @@ static int pdc20621_prog_dimm0(struct ata_probe_ent *pe)
 }
 
 
-static unsigned int pdc20621_prog_dimm_global(struct ata_probe_ent *pe)
+static unsigned int pdc20621_prog_dimm_global(struct ata_host *host)
 {
 	u32 data, spd0;
 	int error, i;
-	void __iomem *mmio = pe->iomap[PDC_MMIO_BAR];
+	void __iomem *mmio = host->iomap[PDC_MMIO_BAR];
 
 	/* hard-code chip #0 */
    	mmio += PDC_CHIP0_OFS;
@@ -1129,7 +1126,7 @@ static unsigned int pdc20621_prog_dimm_global(struct ata_probe_ent *pe)
 	readl(mmio + PDC_SDRAM_CONTROL_OFFSET);
 
 	/* Turn on for ECC */
-	pdc20621_i2c_read(pe, PDC_DIMM0_SPD_DEV_ADDRESS,
+	pdc20621_i2c_read(host, PDC_DIMM0_SPD_DEV_ADDRESS,
 			  PDC_DIMM_SPD_TYPE, &spd0);
 	if (spd0 == 0x02) {
 		data |= (0x01 << 16);
@@ -1156,7 +1153,7 @@ static unsigned int pdc20621_prog_dimm_global(struct ata_probe_ent *pe)
 }
 
 
-static unsigned int pdc20621_dimm_init(struct ata_probe_ent *pe)
+static unsigned int pdc20621_dimm_init(struct ata_host *host)
 {
 	int speed, size, length;
 	u32 addr,spd0,pci_status;
@@ -1166,7 +1163,7 @@ static unsigned int pdc20621_dimm_init(struct ata_probe_ent *pe)
 	u32 ticks=0;
 	u32 clock=0;
 	u32 fparam=0;
-	void __iomem *mmio = pe->iomap[PDC_MMIO_BAR];
+	void __iomem *mmio = host->iomap[PDC_MMIO_BAR];
 
 	/* hard-code chip #0 */
    	mmio += PDC_CHIP0_OFS;
@@ -1225,18 +1222,18 @@ static unsigned int pdc20621_dimm_init(struct ata_probe_ent *pe)
 	   Read SPD of DIMM by I2C interface,
 	   and program the DIMM Module Controller.
 	*/
- 	if (!(speed = pdc20621_detect_dimm(pe))) {
+	if (!(speed = pdc20621_detect_dimm(host))) {
 		printk(KERN_ERR "Detect Local DIMM Fail\n");
 		return 1;	/* DIMM error */
    	}
    	VPRINTK("Local DIMM Speed = %d\n", speed);
 
    	/* Programming DIMM0 Module Control Register (index_CID0:80h) */
-   	size = pdc20621_prog_dimm0(pe);
+	size = pdc20621_prog_dimm0(host);
    	VPRINTK("Local DIMM Size = %dMB\n",size);
 
    	/* Programming DIMM Module Global Control Register (index_CID0:88h) */
-   	if (pdc20621_prog_dimm_global(pe)) {
+	if (pdc20621_prog_dimm_global(host)) {
 		printk(KERN_ERR "Programming DIMM Module Global Control Register Fail\n");
 		return 1;
    	}
@@ -1249,20 +1246,20 @@ static unsigned int pdc20621_dimm_init(struct ata_probe_ent *pe)
   				'9','8','0','3','1','6','1','2',0,0};
 		u8 test_parttern2[40] = {0};
 
-		pdc20621_put_to_dimm(pe, (void *) test_parttern2, 0x10040, 40);
-		pdc20621_put_to_dimm(pe, (void *) test_parttern2, 0x40, 40);
+		pdc20621_put_to_dimm(host, (void *) test_parttern2, 0x10040, 40);
+		pdc20621_put_to_dimm(host, (void *) test_parttern2, 0x40, 40);
 
-		pdc20621_put_to_dimm(pe, (void *) test_parttern1, 0x10040, 40);
-		pdc20621_get_from_dimm(pe, (void *) test_parttern2, 0x40, 40);
+		pdc20621_put_to_dimm(host, (void *) test_parttern1, 0x10040, 40);
+		pdc20621_get_from_dimm(host, (void *) test_parttern2, 0x40, 40);
 		printk(KERN_ERR "%x, %x, %s\n", test_parttern2[0],
 		       test_parttern2[1], &(test_parttern2[2]));
-		pdc20621_get_from_dimm(pe, (void *) test_parttern2, 0x10040,
+		pdc20621_get_from_dimm(host, (void *) test_parttern2, 0x10040,
 				       40);
 		printk(KERN_ERR "%x, %x, %s\n", test_parttern2[0],
 		       test_parttern2[1], &(test_parttern2[2]));
 
-		pdc20621_put_to_dimm(pe, (void *) test_parttern1, 0x40, 40);
-		pdc20621_get_from_dimm(pe, (void *) test_parttern2, 0x40, 40);
+		pdc20621_put_to_dimm(host, (void *) test_parttern1, 0x40, 40);
+		pdc20621_get_from_dimm(host, (void *) test_parttern2, 0x40, 40);
 		printk(KERN_ERR "%x, %x, %s\n", test_parttern2[0],
 		       test_parttern2[1], &(test_parttern2[2]));
 	}
@@ -1270,14 +1267,14 @@ static unsigned int pdc20621_dimm_init(struct ata_probe_ent *pe)
 
 	/* ECC initiliazation. */
 
-	pdc20621_i2c_read(pe, PDC_DIMM0_SPD_DEV_ADDRESS,
+	pdc20621_i2c_read(host, PDC_DIMM0_SPD_DEV_ADDRESS,
 			  PDC_DIMM_SPD_TYPE, &spd0);
 	if (spd0 == 0x02) {
 		VPRINTK("Start ECC initialization\n");
 		addr = 0;
 		length = size * 1024 * 1024;
 		while (addr < length) {
-			pdc20621_put_to_dimm(pe, (void *) &tmp, addr,
+			pdc20621_put_to_dimm(host, (void *) &tmp, addr,
 					     sizeof(u32));
 			addr += sizeof(u32);
 		}
@@ -1287,10 +1284,10 @@ static unsigned int pdc20621_dimm_init(struct ata_probe_ent *pe)
 }
 
 
-static void pdc_20621_init(struct ata_probe_ent *pe)
+static void pdc_20621_init(struct ata_host *host)
 {
 	u32 tmp;
-	void __iomem *mmio = pe->iomap[PDC_MMIO_BAR];
+	void __iomem *mmio = host->iomap[PDC_MMIO_BAR];
 
 	/* hard-code chip #0 */
 	mmio += PDC_CHIP0_OFS;
@@ -1321,15 +1318,25 @@ static void pdc_20621_init(struct ata_probe_ent *pe)
 static int pdc_sata_init_one (struct pci_dev *pdev, const struct pci_device_id *ent)
 {
 	static int printed_version;
-	struct ata_probe_ent *probe_ent;
+	const struct ata_port_info *ppi[] =
+		{ &pdc_port_info[ent->driver_data], NULL };
+	struct ata_host *host;
 	void __iomem *base;
 	struct pdc_host_priv *hpriv;
-	unsigned int board_idx = (unsigned int) ent->driver_data;
 	int rc;
 
 	if (!printed_version++)
 		dev_printk(KERN_DEBUG, &pdev->dev, "version " DRV_VERSION "\n");
 
+	/* allocate host */
+	host = ata_host_alloc_pinfo(&pdev->dev, ppi, 4);
+	hpriv = devm_kzalloc(&pdev->dev, sizeof(*hpriv), GFP_KERNEL);
+	if (!host || !hpriv)
+		return -ENOMEM;
+
+	host->private_data = hpriv;
+
+	/* acquire resources and fill host */
 	rc = pcim_enable_device(pdev);
 	if (rc)
 		return rc;
@@ -1340,7 +1347,15 @@ static int pdc_sata_init_one (struct pci_dev *pdev, const struct pci_device_id *
 		pcim_pin_device(pdev);
 	if (rc)
 		return rc;
+	host->iomap = pcim_iomap_table(pdev);
+
+	base = host->iomap[PDC_MMIO_BAR] + PDC_CHIP0_OFS;
+	pdc_sata_setup_port(&host->ports[0]->ioaddr, base + 0x200);
+	pdc_sata_setup_port(&host->ports[1]->ioaddr, base + 0x280);
+	pdc_sata_setup_port(&host->ports[2]->ioaddr, base + 0x300);
+	pdc_sata_setup_port(&host->ports[3]->ioaddr, base + 0x380);
 
+	/* configure and activate */
 	rc = pci_set_dma_mask(pdev, ATA_DMA_MASK);
 	if (rc)
 		return rc;
@@ -1348,50 +1363,13 @@ static int pdc_sata_init_one (struct pci_dev *pdev, const struct pci_device_id *
 	if (rc)
 		return rc;
 
-	probe_ent = devm_kzalloc(&pdev->dev, sizeof(*probe_ent), GFP_KERNEL);
-	if (probe_ent == NULL)
+	if (pdc20621_dimm_init(host))
 		return -ENOMEM;
-
-	probe_ent->dev = pci_dev_to_dev(pdev);
-	INIT_LIST_HEAD(&probe_ent->node);
-
-	hpriv = devm_kzalloc(&pdev->dev, sizeof(*hpriv), GFP_KERNEL);
-	if (!hpriv)
-		return -ENOMEM;
-
-	probe_ent->sht		= pdc_port_info[board_idx].sht;
-	probe_ent->port_flags	= pdc_port_info[board_idx].flags;
-	probe_ent->pio_mask	= pdc_port_info[board_idx].pio_mask;
-	probe_ent->mwdma_mask	= pdc_port_info[board_idx].mwdma_mask;
-	probe_ent->udma_mask	= pdc_port_info[board_idx].udma_mask;
-	probe_ent->port_ops	= pdc_port_info[board_idx].port_ops;
-
-       	probe_ent->irq = pdev->irq;
-       	probe_ent->irq_flags = IRQF_SHARED;
-	probe_ent->iomap = pcim_iomap_table(pdev);
-
-	probe_ent->private_data = hpriv;
-	base = probe_ent->iomap[PDC_MMIO_BAR] + PDC_CHIP0_OFS;
-
-	probe_ent->n_ports = 4;
-	pdc_sata_setup_port(&probe_ent->port[0], base + 0x200);
-	pdc_sata_setup_port(&probe_ent->port[1], base + 0x280);
-	pdc_sata_setup_port(&probe_ent->port[2], base + 0x300);
-	pdc_sata_setup_port(&probe_ent->port[3], base + 0x380);
+	pdc_20621_init(host);
 
 	pci_set_master(pdev);
-
-	/* initialize adapter */
-	/* initialize local dimm */
-	if (pdc20621_dimm_init(probe_ent))
-		return -ENOMEM;
-	pdc_20621_init(probe_ent);
-
-	if (!ata_device_add(probe_ent))
-		return -ENODEV;
-
-	devm_kfree(&pdev->dev, probe_ent);
-	return 0;
+	return ata_host_activate(host, pdev->irq, pdc20621_interrupt,
+				 IRQF_SHARED, &pdc_sata_sht);
 }
 
 
diff --git a/drivers/ata/sata_vsc.c b/drivers/ata/sata_vsc.c
index 170bad1..80126f8 100644
--- a/drivers/ata/sata_vsc.c
+++ b/drivers/ata/sata_vsc.c
@@ -333,7 +333,6 @@ static const struct ata_port_operations vsc_sata_ops = {
 	.thaw			= vsc_thaw,
 	.error_handler		= ata_bmdma_error_handler,
 	.post_internal_cmd	= ata_bmdma_post_internal_cmd,
-	.irq_handler		= vsc_sata_interrupt,
 	.irq_clear		= ata_bmdma_irq_clear,
 	.irq_on			= ata_irq_on,
 	.irq_ack		= ata_irq_ack,
@@ -367,30 +366,50 @@ static void __devinit vsc_sata_setup_port(struct ata_ioports *port,
 
 static int __devinit vsc_sata_init_one (struct pci_dev *pdev, const struct pci_device_id *ent)
 {
+	static const struct ata_port_info pi = {
+		.flags		= ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
+				  ATA_FLAG_MMIO,
+		.pio_mask	= 0x1f,
+		.mwdma_mask	= 0x07,
+		.udma_mask	= 0x7f,
+		.port_ops	= &vsc_sata_ops,
+	};
+	const struct ata_port_info *ppi[] = { &pi, NULL };
 	static int printed_version;
-	struct ata_probe_ent *probe_ent;
+	struct ata_host *host;
 	void __iomem *mmio_base;
-	int rc;
+	int i, rc;
 	u8 cls;
 
 	if (!printed_version++)
 		dev_printk(KERN_DEBUG, &pdev->dev, "version " DRV_VERSION "\n");
 
+	/* allocate host */
+	host = ata_host_alloc_pinfo(&pdev->dev, ppi, 4);
+	if (!host)
+		return -ENOMEM;
+
 	rc = pcim_enable_device(pdev);
 	if (rc)
 		return rc;
 
-	/*
-	 * Check if we have needed resource mapped.
-	 */
+	/* check if we have needed resource mapped */
 	if (pci_resource_len(pdev, 0) == 0)
 		return -ENODEV;
 
+	/* map IO regions and intialize host accordingly */
 	rc = pcim_iomap_regions(pdev, 1 << VSC_MMIO_BAR, DRV_NAME);
 	if (rc == -EBUSY)
 		pcim_pin_device(pdev);
 	if (rc)
 		return rc;
+	host->iomap = pcim_iomap_table(pdev);
+
+	mmio_base = host->iomap[VSC_MMIO_BAR];
+
+	for (i = 0; i < host->n_ports; i++)
+		vsc_sata_setup_port(&host->ports[i]->ioaddr,
+				    mmio_base + (i + 1) * VSC_SATA_PORT_OFFSET);
 
 	/*
 	 * Use 32 bit DMA mask, because 64 bit address support is poor.
@@ -402,12 +421,6 @@ static int __devinit vsc_sata_init_one (struct pci_dev *pdev, const struct pci_d
 	if (rc)
 		return rc;
 
-	probe_ent = devm_kzalloc(&pdev->dev, sizeof(*probe_ent), GFP_KERNEL);
-	if (probe_ent == NULL)
-		return -ENOMEM;
-	probe_ent->dev = pci_dev_to_dev(pdev);
-	INIT_LIST_HEAD(&probe_ent->node);
-
 	/*
 	 * Due to a bug in the chip, the default cache line size can't be
 	 * used (unless the default is non-zero).
@@ -418,33 +431,6 @@ static int __devinit vsc_sata_init_one (struct pci_dev *pdev, const struct pci_d
 
 	if (pci_enable_msi(pdev) == 0)
 		pci_intx(pdev, 0);
-	else
-		probe_ent->irq_flags = IRQF_SHARED;
-
-	probe_ent->sht = &vsc_sata_sht;
-	probe_ent->port_flags = ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
-				ATA_FLAG_MMIO;
-	probe_ent->port_ops = &vsc_sata_ops;
-	probe_ent->n_ports = 4;
-	probe_ent->irq = pdev->irq;
-	probe_ent->iomap = pcim_iomap_table(pdev);
-
-	/* We don't care much about the PIO/UDMA masks, but the core won't like us
-	 * if we don't fill these
-	 */
-	probe_ent->pio_mask = 0x1f;
-	probe_ent->mwdma_mask = 0x07;
-	probe_ent->udma_mask = 0x7f;
-
-	mmio_base = probe_ent->iomap[VSC_MMIO_BAR];
-
-	/* We have 4 ports per PCI function */
-	vsc_sata_setup_port(&probe_ent->port[0], mmio_base + 1 * VSC_SATA_PORT_OFFSET);
-	vsc_sata_setup_port(&probe_ent->port[1], mmio_base + 2 * VSC_SATA_PORT_OFFSET);
-	vsc_sata_setup_port(&probe_ent->port[2], mmio_base + 3 * VSC_SATA_PORT_OFFSET);
-	vsc_sata_setup_port(&probe_ent->port[3], mmio_base + 4 * VSC_SATA_PORT_OFFSET);
-
-	pci_set_master(pdev);
 
 	/*
 	 * Config offset 0x98 is "Extended Control and Status Register 0"
@@ -454,11 +440,9 @@ static int __devinit vsc_sata_init_one (struct pci_dev *pdev, const struct pci_d
 	 */
 	pci_write_config_dword(pdev, 0x98, 0);
 
-	if (!ata_device_add(probe_ent))
-		return -ENODEV;
-
-	devm_kfree(&pdev->dev, probe_ent);
-	return 0;
+	pci_set_master(pdev);
+	return ata_host_activate(host, pdev->irq, vsc_sata_interrupt,
+				 IRQF_SHARED, &vsc_sata_sht);
 }
 
 static const struct pci_device_id vsc_sata_pci_tbl[] = {
-- 
1.5.0.3


