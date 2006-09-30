From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 2/2] [PATCH] ahci: honor PORTS_IMPL on ICH8s
Date: Sat, 30 Sep 2006 21:22:59 +0900
Message-ID: <20060930122259.GS25800@htj.dyndns.org>
References: <20060930122121.GR25800@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.177]:52158 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1750947AbWI3MXG (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 30 Sep 2006 08:23:06 -0400
Received: by py-out-1112.google.com with SMTP id n25so1671921pyg
        for <linux-ide@vger.kernel.org>; Sat, 30 Sep 2006 05:23:05 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20060930122121.GR25800@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org, robbat2@gentoo.org

Some ICH8s use non-linear port mapping.  ahci driver didn't use to
honor PORTS_IMPL and this made ports after hole nonfunctional.  This
patch implements port mapping table and use it to handle non-linear
port mapping.

As it's unknown whether other AHCIs implement PORTS_IMPL register
properly, new board id board_ahci_pi is added and selectively applied
to ICH8s.  All other AHCIs continue to use linear mapping regardless
of PORTS_IMPL value.

Signed-off-by: Tejun Heo <htejun@gmail.com>
Cc: Robin H. Johnson <robbat2@gentoo.org>
---

Jeff, this version adds pp->hw_idx to access port index and honors
PORTS_IMPL only on ICH8s.  Tested on ICH7 and ICH8.

Thanks.

 drivers/ata/ahci.c |  142 ++++++++++++++++++++++++++++++++++------------------
 1 files changed, 93 insertions(+), 49 deletions(-)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index d268ced..38499ee 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -53,6 +53,7 @@ #define DRV_VERSION	"2.0"
 
 enum {
 	AHCI_PCI_BAR		= 5,
+	AHCI_MAX_PORTS		= 32,
 	AHCI_MAX_SG		= 168, /* hardware max is 64K */
 	AHCI_DMA_BOUNDARY	= 0xffffffff,
 	AHCI_USE_CLUSTERING	= 0,
@@ -77,7 +78,8 @@ enum {
 	RX_FIS_UNK		= 0x60, /* offset of Unknown FIS data */
 
 	board_ahci		= 0,
-	board_ahci_vt8251	= 1,
+	board_ahci_pi		= 1,
+	board_ahci_vt8251	= 2,
 
 	/* global controller registers */
 	HOST_CAP		= 0x00, /* host capabilities */
@@ -166,6 +168,7 @@ enum {
 	AHCI_FLAG_MSI		= (1 << 0),
 
 	/* ap->flags bits */
+	AHCI_FLAG_HONOR_PI		= (1 << 23), /* honor PORTS_IMPL */
 	AHCI_FLAG_RESET_NEEDS_CLO	= (1 << 24),
 	AHCI_FLAG_NO_NCQ		= (1 << 25),
 };
@@ -189,9 +192,12 @@ struct ahci_host_priv {
 	unsigned long		flags;
 	u32			cap;	/* cache of HOST_CAP register */
 	u32			port_map; /* cache of HOST_PORTS_IMPL reg */
+	u8			port_tbl[AHCI_MAX_PORTS];
 };
 
 struct ahci_port_priv {
+	int			hw_idx;
+	void __iomem		*mmio;
 	struct ahci_cmd_hdr	*cmd_slot;
 	dma_addr_t		cmd_slot_dma;
 	void			*cmd_tbl;
@@ -284,6 +290,16 @@ static const struct ata_port_info ahci_p
 		.udma_mask	= 0x7f, /* udma0-6 ; FIXME */
 		.port_ops	= &ahci_ops,
 	},
+	/* board_ahci_pi */
+	{
+		.sht		= &ahci_sht,
+		.flags		= ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
+				  ATA_FLAG_MMIO | ATA_FLAG_PIO_DMA |
+				  ATA_FLAG_SKIP_D2H_BSY | AHCI_FLAG_HONOR_PI,
+		.pio_mask	= 0x1f, /* pio0-4 */
+		.udma_mask	= 0x7f, /* udma0-6 ; FIXME */
+		.port_ops	= &ahci_ops,
+	},
 	/* board_ahci_vt8251 */
 	{
 		.sht		= &ahci_sht,
@@ -309,11 +325,11 @@ static const struct pci_device_id ahci_p
 	{ PCI_VDEVICE(INTEL, 0x2682), board_ahci }, /* ESB2 */
 	{ PCI_VDEVICE(INTEL, 0x2683), board_ahci }, /* ESB2 */
 	{ PCI_VDEVICE(INTEL, 0x27c6), board_ahci }, /* ICH7-M DH */
-	{ PCI_VDEVICE(INTEL, 0x2821), board_ahci }, /* ICH8 */
-	{ PCI_VDEVICE(INTEL, 0x2822), board_ahci }, /* ICH8 */
-	{ PCI_VDEVICE(INTEL, 0x2824), board_ahci }, /* ICH8 */
-	{ PCI_VDEVICE(INTEL, 0x2829), board_ahci }, /* ICH8M */
-	{ PCI_VDEVICE(INTEL, 0x282a), board_ahci }, /* ICH8M */
+	{ PCI_VDEVICE(INTEL, 0x2821), board_ahci_pi }, /* ICH8 */
+	{ PCI_VDEVICE(INTEL, 0x2822), board_ahci_pi }, /* ICH8 */
+	{ PCI_VDEVICE(INTEL, 0x2824), board_ahci_pi }, /* ICH8 */
+	{ PCI_VDEVICE(INTEL, 0x2829), board_ahci_pi }, /* ICH8M */
+	{ PCI_VDEVICE(INTEL, 0x282a), board_ahci_pi }, /* ICH8M */
 
 	/* JMicron */
 	{ PCI_VDEVICE(JMICRON, 0x2360), board_ahci }, /* JMicron JMB360 */
@@ -614,22 +630,18 @@ static int ahci_reset_controller(void __
 }
 
 static void ahci_init_controller(void __iomem *mmio, struct pci_dev *pdev,
-				 int n_ports, u32 cap)
+				 int n_ports, struct ahci_host_priv *hpriv)
 {
 	int i, rc;
 	u32 tmp;
 
 	for (i = 0; i < n_ports; i++) {
-		void __iomem *port_mmio = ahci_port_base(mmio, i);
+		int hw_idx = hpriv->port_tbl[i];
+		void __iomem *port_mmio = ahci_port_base(mmio, hw_idx);
 		const char *emsg = NULL;
 
-#if 0 /* BIOSen initialize this incorrectly */
-		if (!(hpriv->port_map & (1 << i)))
-			continue;
-#endif
-
 		/* make sure port is not active */
-		rc = ahci_deinit_port(port_mmio, cap, &emsg);
+		rc = ahci_deinit_port(port_mmio, hpriv->cap, &emsg);
 		if (rc)
 			dev_printk(KERN_WARNING, &pdev->dev,
 				   "%s (%d)\n", emsg, rc);
@@ -657,7 +669,8 @@ #endif
 
 static unsigned int ahci_dev_classify(struct ata_port *ap)
 {
-	void __iomem *port_mmio = (void __iomem *) ap->ioaddr.cmd_addr;
+	struct ahci_port_priv *pp = ap->private_data;
+	void __iomem *port_mmio = pp->mmio;
 	struct ata_taskfile tf;
 	u32 tmp;
 
@@ -685,8 +698,9 @@ static void ahci_fill_cmd_slot(struct ah
 
 static int ahci_clo(struct ata_port *ap)
 {
-	void __iomem *port_mmio = (void __iomem *) ap->ioaddr.cmd_addr;
 	struct ahci_host_priv *hpriv = ap->host->private_data;
+	struct ahci_port_priv *pp = ap->private_data;
+	void __iomem *port_mmio = pp->mmio;
 	u32 tmp;
 
 	if (!(hpriv->cap & HOST_CAP_CLO))
@@ -718,8 +732,7 @@ static int ahci_prereset(struct ata_port
 static int ahci_softreset(struct ata_port *ap, unsigned int *class)
 {
 	struct ahci_port_priv *pp = ap->private_data;
-	void __iomem *mmio = ap->host->mmio_base;
-	void __iomem *port_mmio = ahci_port_base(mmio, ap->port_no);
+	void __iomem *port_mmio = pp->mmio;
 	const u32 cmd_fis_len = 5; /* five dwords */
 	const char *reason = NULL;
 	struct ata_taskfile tf;
@@ -826,9 +839,8 @@ static int ahci_hardreset(struct ata_por
 {
 	struct ahci_port_priv *pp = ap->private_data;
 	u8 *d2h_fis = pp->rx_fis + RX_FIS_D2H_REG;
+	void __iomem *port_mmio = pp->mmio;
 	struct ata_taskfile tf;
-	void __iomem *mmio = ap->host->mmio_base;
-	void __iomem *port_mmio = ahci_port_base(mmio, ap->port_no);
 	int rc;
 
 	DPRINTK("ENTER\n");
@@ -855,7 +867,8 @@ static int ahci_hardreset(struct ata_por
 
 static void ahci_postreset(struct ata_port *ap, unsigned int *class)
 {
-	void __iomem *port_mmio = (void __iomem *) ap->ioaddr.cmd_addr;
+	struct ahci_port_priv *pp = ap->private_data;
+	void __iomem *port_mmio = pp->mmio;
 	u32 new_tmp, tmp;
 
 	ata_std_postreset(ap, class);
@@ -1016,9 +1029,9 @@ static void ahci_error_intr(struct ata_p
 
 static void ahci_host_intr(struct ata_port *ap)
 {
-	void __iomem *mmio = ap->host->mmio_base;
-	void __iomem *port_mmio = ahci_port_base(mmio, ap->port_no);
+	struct ahci_port_priv *pp = ap->private_data;
 	struct ata_eh_info *ehi = &ap->eh_info;
+	void __iomem *port_mmio = pp->mmio;
 	u32 status, qc_active;
 	int rc;
 
@@ -1088,12 +1101,12 @@ static irqreturn_t ahci_interrupt(int ir
         spin_lock(&host->lock);
 
         for (i = 0; i < host->n_ports; i++) {
-		struct ata_port *ap;
+		struct ata_port *ap = host->ports[i];
+		struct ahci_port_priv *pp = ap->private_data;
 
-		if (!(irq_stat & (1 << i)))
+		if (!(irq_stat & (1 << pp->hw_idx)))
 			continue;
 
-		ap = host->ports[i];
 		if (ap) {
 			ahci_host_intr(ap);
 			VPRINTK("port %u\n", i);
@@ -1104,7 +1117,7 @@ static irqreturn_t ahci_interrupt(int ir
 					"interrupt on disabled port %u\n", i);
 		}
 
-		irq_ack |= (1 << i);
+		irq_ack |= (1 << pp->hw_idx);
 	}
 
 	if (irq_ack) {
@@ -1122,7 +1135,8 @@ static irqreturn_t ahci_interrupt(int ir
 static unsigned int ahci_qc_issue(struct ata_queued_cmd *qc)
 {
 	struct ata_port *ap = qc->ap;
-	void __iomem *port_mmio = (void __iomem *) ap->ioaddr.cmd_addr;
+	struct ahci_port_priv *pp = ap->private_data;
+	void __iomem *port_mmio = pp->mmio;
 
 	if (qc->tf.protocol == ATA_PROT_NCQ)
 		writel(1 << qc->tag, port_mmio + PORT_SCR_ACT);
@@ -1134,8 +1148,8 @@ static unsigned int ahci_qc_issue(struct
 
 static void ahci_freeze(struct ata_port *ap)
 {
-	void __iomem *mmio = ap->host->mmio_base;
-	void __iomem *port_mmio = ahci_port_base(mmio, ap->port_no);
+	struct ahci_port_priv *pp = ap->private_data;
+	void __iomem *port_mmio = pp->mmio;
 
 	/* turn IRQ off */
 	writel(0, port_mmio + PORT_IRQ_MASK);
@@ -1143,14 +1157,15 @@ static void ahci_freeze(struct ata_port 
 
 static void ahci_thaw(struct ata_port *ap)
 {
+	struct ahci_port_priv *pp = ap->private_data;
 	void __iomem *mmio = ap->host->mmio_base;
-	void __iomem *port_mmio = ahci_port_base(mmio, ap->port_no);
+	void __iomem *port_mmio = pp->mmio;
 	u32 tmp;
 
 	/* clear IRQ */
 	tmp = readl(port_mmio + PORT_IRQ_STAT);
 	writel(tmp, port_mmio + PORT_IRQ_STAT);
-	writel(1 << ap->id, mmio + HOST_IRQ_STAT);
+	writel(1 << pp->hw_idx, mmio + HOST_IRQ_STAT);
 
 	/* turn IRQ back on */
 	writel(DEF_PORT_IRQ, port_mmio + PORT_IRQ_MASK);
@@ -1158,8 +1173,8 @@ static void ahci_thaw(struct ata_port *a
 
 static void ahci_error_handler(struct ata_port *ap)
 {
-	void __iomem *mmio = ap->host->mmio_base;
-	void __iomem *port_mmio = ahci_port_base(mmio, ap->port_no);
+	struct ahci_port_priv *pp = ap->private_data;
+	void __iomem *port_mmio = pp->mmio;
 
 	if (!(ap->pflags & ATA_PFLAG_FROZEN)) {
 		/* restart engine */
@@ -1175,8 +1190,8 @@ static void ahci_error_handler(struct at
 static void ahci_post_internal_cmd(struct ata_queued_cmd *qc)
 {
 	struct ata_port *ap = qc->ap;
-	void __iomem *mmio = ap->host->mmio_base;
-	void __iomem *port_mmio = ahci_port_base(mmio, ap->port_no);
+	struct ahci_port_priv *pp = ap->private_data;
+	void __iomem *port_mmio = pp->mmio;
 
 	if (qc->flags & ATA_QCFLAG_FAILED)
 		qc->err_mask |= AC_ERR_OTHER;
@@ -1192,8 +1207,7 @@ static int ahci_port_suspend(struct ata_
 {
 	struct ahci_host_priv *hpriv = ap->host->private_data;
 	struct ahci_port_priv *pp = ap->private_data;
-	void __iomem *mmio = ap->host->mmio_base;
-	void __iomem *port_mmio = ahci_port_base(mmio, ap->port_no);
+	void __iomem *port_mmio = pp->mmio;
 	const char *emsg = NULL;
 	int rc;
 
@@ -1209,10 +1223,9 @@ static int ahci_port_suspend(struct ata_
 
 static int ahci_port_resume(struct ata_port *ap)
 {
-	struct ahci_port_priv *pp = ap->private_data;
 	struct ahci_host_priv *hpriv = ap->host->private_data;
-	void __iomem *mmio = ap->host->mmio_base;
-	void __iomem *port_mmio = ahci_port_base(mmio, ap->port_no);
+	struct ahci_port_priv *pp = ap->private_data;
+	void __iomem *port_mmio = pp->mmio;
 
 	ahci_init_port(port_mmio, hpriv->cap, pp->cmd_slot_dma, pp->rx_fis_dma);
 
@@ -1253,7 +1266,7 @@ static int ahci_pci_device_resume(struct
 		if (rc)
 			return rc;
 
-		ahci_init_controller(mmio, pdev, host->n_ports, hpriv->cap);
+		ahci_init_controller(mmio, pdev, host->n_ports, hpriv);
 	}
 
 	ata_host_resume(host);
@@ -1266,8 +1279,9 @@ static int ahci_port_start(struct ata_po
 	struct device *dev = ap->host->dev;
 	struct ahci_host_priv *hpriv = ap->host->private_data;
 	struct ahci_port_priv *pp;
+	int port_hw_idx = hpriv->port_tbl[ap->port_no];
 	void __iomem *mmio = ap->host->mmio_base;
-	void __iomem *port_mmio = ahci_port_base(mmio, ap->port_no);
+	void __iomem *port_mmio = ahci_port_base(mmio, port_hw_idx);
 	void *mem;
 	dma_addr_t mem_dma;
 	int rc;
@@ -1283,6 +1297,9 @@ static int ahci_port_start(struct ata_po
 		return rc;
 	}
 
+	pp->hw_idx = port_hw_idx;
+	pp->mmio = port_mmio;
+
 	mem = dma_alloc_coherent(dev, AHCI_PORT_PRIV_DMA_SZ, &mem_dma, GFP_KERNEL);
 	if (!mem) {
 		ata_pad_free(ap, dev);
@@ -1330,8 +1347,7 @@ static void ahci_port_stop(struct ata_po
 	struct device *dev = ap->host->dev;
 	struct ahci_host_priv *hpriv = ap->host->private_data;
 	struct ahci_port_priv *pp = ap->private_data;
-	void __iomem *mmio = ap->host->mmio_base;
-	void __iomem *port_mmio = ahci_port_base(mmio, ap->port_no);
+	void __iomem *port_mmio = pp->mmio;
 	const char *emsg = NULL;
 	int rc;
 
@@ -1365,7 +1381,7 @@ static int ahci_host_init(struct ata_pro
 	struct ahci_host_priv *hpriv = probe_ent->private_data;
 	struct pci_dev *pdev = to_pci_dev(probe_ent->dev);
 	void __iomem *mmio = probe_ent->mmio_base;
-	unsigned int i, using_dac;
+	unsigned int i, n_ports, using_dac;
 	int rc;
 
 	rc = ahci_reset_controller(mmio, pdev);
@@ -1374,7 +1390,34 @@ static int ahci_host_init(struct ata_pro
 
 	hpriv->cap = readl(mmio + HOST_CAP);
 	hpriv->port_map = readl(mmio + HOST_PORTS_IMPL);
-	probe_ent->n_ports = (hpriv->cap & 0x1f) + 1;
+
+	/* determine number of ports and port table */
+	n_ports = 0;
+
+	if (probe_ent->port_flags & AHCI_FLAG_HONOR_PI) {
+		for (i = 0; i < AHCI_MAX_PORTS; i++)
+			if (hpriv->port_map & (1 << i))
+				hpriv->port_tbl[n_ports++] = i;
+
+		i = (hpriv->cap & 0x1f) + 1;
+		if (n_ports > i) {
+			dev_printk(KERN_WARNING, &pdev->dev,
+				   "n_ports in PI (%d) > CAP.NP (%d), "
+				   "using %d\n", n_ports, i, i);
+			n_ports = i;
+		}
+	} else {
+		n_ports = (hpriv->cap & 0x1f) + 1;
+		for (i = 0; i < n_ports; i++)
+			hpriv->port_tbl[i] = i;
+	}
+
+	if (n_ports == 0) {
+		dev_printk(KERN_ERR, &pdev->dev, "0 port implemented\n");
+		return -EINVAL;
+	}
+
+	probe_ent->n_ports = n_ports;
 
 	VPRINTK("cap 0x%x  port_map 0x%x  n_ports %d\n",
 		hpriv->cap, hpriv->port_map, probe_ent->n_ports);
@@ -1407,9 +1450,10 @@ static int ahci_host_init(struct ata_pro
 	}
 
 	for (i = 0; i < probe_ent->n_ports; i++)
-		ahci_setup_port(&probe_ent->port[i], (unsigned long) mmio, i);
+		ahci_setup_port(&probe_ent->port[i], (unsigned long) mmio,
+				hpriv->port_tbl[i]);
 
-	ahci_init_controller(mmio, pdev, probe_ent->n_ports, hpriv->cap);
+	ahci_init_controller(mmio, pdev, probe_ent->n_ports, hpriv);
 
 	pci_set_master(pdev);
 
-- 
1.4.2.1

