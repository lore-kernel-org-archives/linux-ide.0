From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 1/6] ahci: relocate several internal functions
Date: Wed, 26 Jul 2006 15:59:25 +0900
Message-ID: <1153897165945-git-send-email-htejun@gmail.com>
References: <11538971651205-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.179]:46947 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1030444AbWGZG7c (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 26 Jul 2006 02:59:32 -0400
Received: by py-out-1112.google.com with SMTP id t32so3362778pyc
        for <linux-ide@vger.kernel.org>; Tue, 25 Jul 2006 23:59:31 -0700 (PDT)
In-Reply-To: <11538971651205-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>, Zhao@htj.dyndns.org, Forrest <forrest.zhao@intel.com>

* move ahci_port_start/stop() below EH functions.  This makes ahci
  more consistent with other drivers and makes prototypes for
  ahci_start/stop_engine() unnecessary.

* swap positions between ahci_start_engine() and ahci_stop_engine()
  for readability.

Signed-off-by: Tejun Heo <htejun@gmail.com>
Signed-off-by: Zhao, Forrest <forrest.zhao@intel.com>

---

 drivers/scsi/ahci.c |  255 +++++++++++++++++++++++++--------------------------
 1 files changed, 126 insertions(+), 129 deletions(-)

0353fed85301f2f2af7fdce02f6b9c1f55160462
diff --git a/drivers/scsi/ahci.c b/drivers/scsi/ahci.c
index f1516ca..92e2b95 100644
--- a/drivers/scsi/ahci.c
+++ b/drivers/scsi/ahci.c
@@ -205,8 +205,6 @@ static irqreturn_t ahci_interrupt (int i
 static void ahci_irq_clear(struct ata_port *ap);
 static int ahci_port_start(struct ata_port *ap);
 static void ahci_port_stop(struct ata_port *ap);
-static int ahci_start_engine(void __iomem *port_mmio);
-static int ahci_stop_engine(void __iomem *port_mmio);
 static void ahci_tf_read(struct ata_port *ap, struct ata_taskfile *tf);
 static void ahci_qc_prep(struct ata_queued_cmd *qc);
 static u8 ahci_check_status(struct ata_port *ap);
@@ -374,108 +372,6 @@ static inline void __iomem *ahci_port_ba
 	return (void __iomem *) ahci_port_base_ul((unsigned long)base, port);
 }
 
-static int ahci_port_start(struct ata_port *ap)
-{
-	struct device *dev = ap->host_set->dev;
-	struct ahci_host_priv *hpriv = ap->host_set->private_data;
-	struct ahci_port_priv *pp;
-	void __iomem *mmio = ap->host_set->mmio_base;
-	void __iomem *port_mmio = ahci_port_base(mmio, ap->port_no);
-	void *mem;
-	dma_addr_t mem_dma;
-	int rc;
-
-	pp = kmalloc(sizeof(*pp), GFP_KERNEL);
-	if (!pp)
-		return -ENOMEM;
-	memset(pp, 0, sizeof(*pp));
-
-	rc = ata_pad_alloc(ap, dev);
-	if (rc) {
-		kfree(pp);
-		return rc;
-	}
-
-	mem = dma_alloc_coherent(dev, AHCI_PORT_PRIV_DMA_SZ, &mem_dma, GFP_KERNEL);
-	if (!mem) {
-		ata_pad_free(ap, dev);
-		kfree(pp);
-		return -ENOMEM;
-	}
-	memset(mem, 0, AHCI_PORT_PRIV_DMA_SZ);
-
-	/*
-	 * First item in chunk of DMA memory: 32-slot command table,
-	 * 32 bytes each in size
-	 */
-	pp->cmd_slot = mem;
-	pp->cmd_slot_dma = mem_dma;
-
-	mem += AHCI_CMD_SLOT_SZ;
-	mem_dma += AHCI_CMD_SLOT_SZ;
-
-	/*
-	 * Second item: Received-FIS area
-	 */
-	pp->rx_fis = mem;
-	pp->rx_fis_dma = mem_dma;
-
-	mem += AHCI_RX_FIS_SZ;
-	mem_dma += AHCI_RX_FIS_SZ;
-
-	/*
-	 * Third item: data area for storing a single command
-	 * and its scatter-gather table
-	 */
-	pp->cmd_tbl = mem;
-	pp->cmd_tbl_dma = mem_dma;
-
-	ap->private_data = pp;
-
-	if (hpriv->cap & HOST_CAP_64)
-		writel((pp->cmd_slot_dma >> 16) >> 16, port_mmio + PORT_LST_ADDR_HI);
-	writel(pp->cmd_slot_dma & 0xffffffff, port_mmio + PORT_LST_ADDR);
-	readl(port_mmio + PORT_LST_ADDR); /* flush */
-
-	if (hpriv->cap & HOST_CAP_64)
-		writel((pp->rx_fis_dma >> 16) >> 16, port_mmio + PORT_FIS_ADDR_HI);
-	writel(pp->rx_fis_dma & 0xffffffff, port_mmio + PORT_FIS_ADDR);
-	readl(port_mmio + PORT_FIS_ADDR); /* flush */
-
-	writel(PORT_CMD_ICC_ACTIVE | PORT_CMD_FIS_RX |
-	       PORT_CMD_POWER_ON | PORT_CMD_SPIN_UP |
-	       PORT_CMD_START, port_mmio + PORT_CMD);
-	readl(port_mmio + PORT_CMD); /* flush */
-
-	return 0;
-}
-
-
-static void ahci_port_stop(struct ata_port *ap)
-{
-	struct device *dev = ap->host_set->dev;
-	struct ahci_port_priv *pp = ap->private_data;
-	void __iomem *mmio = ap->host_set->mmio_base;
-	void __iomem *port_mmio = ahci_port_base(mmio, ap->port_no);
-	u32 tmp;
-
-	tmp = readl(port_mmio + PORT_CMD);
-	tmp &= ~(PORT_CMD_START | PORT_CMD_FIS_RX);
-	writel(tmp, port_mmio + PORT_CMD);
-	readl(port_mmio + PORT_CMD); /* flush */
-
-	/* spec says 500 msecs for each PORT_CMD_{START,FIS_RX} bit, so
-	 * this is slightly incorrect.
-	 */
-	msleep(500);
-
-	ap->private_data = NULL;
-	dma_free_coherent(dev, AHCI_PORT_PRIV_DMA_SZ,
-			  pp->cmd_slot, pp->cmd_slot_dma);
-	ata_pad_free(ap, dev);
-	kfree(pp);
-}
-
 static u32 ahci_scr_read (struct ata_port *ap, unsigned int sc_reg_in)
 {
 	unsigned int sc_reg;
@@ -510,31 +406,6 @@ static void ahci_scr_write (struct ata_p
 	writel(val, (void __iomem *) ap->ioaddr.scr_addr + (sc_reg * 4));
 }
 
-static int ahci_stop_engine(void __iomem *port_mmio)
-{
-	u32 tmp;
-
-	tmp = readl(port_mmio + PORT_CMD);
-
-	/* Check if the HBA is idle */
-	if ((tmp & (PORT_CMD_START | PORT_CMD_LIST_ON)) == 0)
-		return 0;
-
-	/* Setting HBA to idle */
-	tmp &= ~PORT_CMD_START;
-	writel(tmp, port_mmio + PORT_CMD);
-
-	/* wait for engine to stop. This could be
-	 * as long as 500 msec
-	 */
-	tmp = ata_wait_register(port_mmio + PORT_CMD,
-			        PORT_CMD_LIST_ON, PORT_CMD_LIST_ON, 1, 500);
-	if(tmp & PORT_CMD_LIST_ON)
-		return -EIO;
-
-	return 0;
-}
-
 static int ahci_start_engine(void __iomem *port_mmio)
 {
 	u32 tmp;
@@ -570,6 +441,31 @@ static int ahci_start_engine(void __iome
 	return 0;
 }
 
+static int ahci_stop_engine(void __iomem *port_mmio)
+{
+	u32 tmp;
+
+	tmp = readl(port_mmio + PORT_CMD);
+
+	/* Check if the HBA is idle */
+	if ((tmp & (PORT_CMD_START | PORT_CMD_LIST_ON)) == 0)
+		return 0;
+
+	/* Setting HBA to idle */
+	tmp &= ~PORT_CMD_START;
+	writel(tmp, port_mmio + PORT_CMD);
+
+	/* wait for engine to stop. This could be
+	 * as long as 500 msec
+	 */
+	tmp = ata_wait_register(port_mmio + PORT_CMD,
+			        PORT_CMD_LIST_ON, PORT_CMD_LIST_ON, 1, 500);
+	if(tmp & PORT_CMD_LIST_ON)
+		return -EIO;
+
+	return 0;
+}
+
 static unsigned int ahci_dev_classify(struct ata_port *ap)
 {
 	void __iomem *port_mmio = (void __iomem *) ap->ioaddr.cmd_addr;
@@ -1109,6 +1005,107 @@ static void ahci_post_internal_cmd(struc
 	}
 }
 
+static int ahci_port_start(struct ata_port *ap)
+{
+	struct device *dev = ap->host_set->dev;
+	struct ahci_host_priv *hpriv = ap->host_set->private_data;
+	struct ahci_port_priv *pp;
+	void __iomem *mmio = ap->host_set->mmio_base;
+	void __iomem *port_mmio = ahci_port_base(mmio, ap->port_no);
+	void *mem;
+	dma_addr_t mem_dma;
+	int rc;
+
+	pp = kmalloc(sizeof(*pp), GFP_KERNEL);
+	if (!pp)
+		return -ENOMEM;
+	memset(pp, 0, sizeof(*pp));
+
+	rc = ata_pad_alloc(ap, dev);
+	if (rc) {
+		kfree(pp);
+		return rc;
+	}
+
+	mem = dma_alloc_coherent(dev, AHCI_PORT_PRIV_DMA_SZ, &mem_dma, GFP_KERNEL);
+	if (!mem) {
+		ata_pad_free(ap, dev);
+		kfree(pp);
+		return -ENOMEM;
+	}
+	memset(mem, 0, AHCI_PORT_PRIV_DMA_SZ);
+
+	/*
+	 * First item in chunk of DMA memory: 32-slot command table,
+	 * 32 bytes each in size
+	 */
+	pp->cmd_slot = mem;
+	pp->cmd_slot_dma = mem_dma;
+
+	mem += AHCI_CMD_SLOT_SZ;
+	mem_dma += AHCI_CMD_SLOT_SZ;
+
+	/*
+	 * Second item: Received-FIS area
+	 */
+	pp->rx_fis = mem;
+	pp->rx_fis_dma = mem_dma;
+
+	mem += AHCI_RX_FIS_SZ;
+	mem_dma += AHCI_RX_FIS_SZ;
+
+	/*
+	 * Third item: data area for storing a single command
+	 * and its scatter-gather table
+	 */
+	pp->cmd_tbl = mem;
+	pp->cmd_tbl_dma = mem_dma;
+
+	ap->private_data = pp;
+
+	if (hpriv->cap & HOST_CAP_64)
+		writel((pp->cmd_slot_dma >> 16) >> 16, port_mmio + PORT_LST_ADDR_HI);
+	writel(pp->cmd_slot_dma & 0xffffffff, port_mmio + PORT_LST_ADDR);
+	readl(port_mmio + PORT_LST_ADDR); /* flush */
+
+	if (hpriv->cap & HOST_CAP_64)
+		writel((pp->rx_fis_dma >> 16) >> 16, port_mmio + PORT_FIS_ADDR_HI);
+	writel(pp->rx_fis_dma & 0xffffffff, port_mmio + PORT_FIS_ADDR);
+	readl(port_mmio + PORT_FIS_ADDR); /* flush */
+
+	writel(PORT_CMD_ICC_ACTIVE | PORT_CMD_FIS_RX |
+	       PORT_CMD_POWER_ON | PORT_CMD_SPIN_UP |
+	       PORT_CMD_START, port_mmio + PORT_CMD);
+	readl(port_mmio + PORT_CMD); /* flush */
+
+	return 0;
+}
+
+static void ahci_port_stop(struct ata_port *ap)
+{
+	struct device *dev = ap->host_set->dev;
+	struct ahci_port_priv *pp = ap->private_data;
+	void __iomem *mmio = ap->host_set->mmio_base;
+	void __iomem *port_mmio = ahci_port_base(mmio, ap->port_no);
+	u32 tmp;
+
+	tmp = readl(port_mmio + PORT_CMD);
+	tmp &= ~(PORT_CMD_START | PORT_CMD_FIS_RX);
+	writel(tmp, port_mmio + PORT_CMD);
+	readl(port_mmio + PORT_CMD); /* flush */
+
+	/* spec says 500 msecs for each PORT_CMD_{START,FIS_RX} bit, so
+	 * this is slightly incorrect.
+	 */
+	msleep(500);
+
+	ap->private_data = NULL;
+	dma_free_coherent(dev, AHCI_PORT_PRIV_DMA_SZ,
+			  pp->cmd_slot, pp->cmd_slot_dma);
+	ata_pad_free(ap, dev);
+	kfree(pp);
+}
+
 static void ahci_setup_port(struct ata_ioports *port, unsigned long base,
 			    unsigned int port_idx)
 {
-- 
1.3.2


