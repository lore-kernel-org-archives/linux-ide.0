From: Mikael Pettersson <mikpe@it.uu.se>
Subject: [PATCH 2.6.26-rc2 2/3] sata_promise: mmio access cleanups
Date: Sat, 17 May 2008 18:48:15 +0200 (MEST)
Message-ID: <200805171648.m4HGmFlu015970@harpo.it.uu.se>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from aun.it.uu.se ([130.238.12.36]:48806 "EHLO aun.it.uu.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752067AbYEQQsZ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 17 May 2008 12:48:25 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org
Cc: linux-ide@vger.kernel.org

This patch cleans up sata_promise's mmio accesses.

In sata_promise there are three distinct mmio address spaces:
1. global registers, offsets from host->iomap[PDC_MMIO_BAR]
2. per-port ATA registers, offsets from ap->ioaddr.cmd_addr
3. per-port SATA registers, offsets from ap->ioaddr.scr_addr

The driver currently often fails to indicate which address space
a given mmio base pointer refers to, which is a source of bugs
and confusion (see recent pdc_thaw() irq clearing bug; it's also
been an obstacle for the pending NCQ extensions).

To reduce these problems, adopt a coding style where the name of
a base pointer always indicates which address space it refers to:
1. global registers: host_mmio
2. per-port ATA registers: ata_mmio
3. per-port SATA registers: sata_mmio

Also rearrange register offset definitions to clearly indicate
which address space they belong to, and add a symbolic definition
for the previously hard-coded PHYMODE4 register.

Signed-off-by: Mikael Pettersson <mikpe@it.uu.se>
---
 drivers/ata/sata_promise.c |  124 +++++++++++++++++++++++----------------------
 1 file changed, 65 insertions(+), 59 deletions(-)

diff -rupN linux-2.6.26-rc2.sata_promise-irqclear/drivers/ata/sata_promise.c linux-2.6.26-rc2.sata_promise-mmio-cleanups/drivers/ata/sata_promise.c
--- linux-2.6.26-rc2.sata_promise-irqclear/drivers/ata/sata_promise.c	2008-05-17 15:02:01.000000000 +0200
+++ linux-2.6.26-rc2.sata_promise-mmio-cleanups/drivers/ata/sata_promise.c	2008-05-17 15:36:10.000000000 +0200
@@ -53,7 +53,15 @@ enum {
 	PDC_MMIO_BAR		= 3,
 	PDC_MAX_PRD		= LIBATA_MAX_PRD - 1, /* -1 for ASIC PRD bug workaround */
 
-	/* register offsets */
+	/* host register offsets (from host->iomap[PDC_MMIO_BAR]) */
+	PDC_INT_SEQMASK		= 0x40,	/* Mask of asserted SEQ INTs */
+	PDC_FLASH_CTL		= 0x44, /* Flash control register */
+	PDC_SATA_PLUG_CSR	= 0x6C, /* SATA Plug control/status reg */
+	PDC2_SATA_PLUG_CSR	= 0x60, /* SATAII Plug control/status reg */
+	PDC_TBG_MODE		= 0x41C, /* TBG mode (not SATAII) */
+	PDC_SLEW_CTL		= 0x470, /* slew rate control reg (not SATAII) */
+
+	/* per-port ATA register offsets (from ap->ioaddr.cmd_addr) */
 	PDC_FEATURE		= 0x04, /* Feature/Error reg (per port) */
 	PDC_SECTOR_COUNT	= 0x08, /* Sector count reg (per port) */
 	PDC_SECTOR_NUMBER	= 0x0C, /* Sector number reg (per port) */
@@ -63,14 +71,11 @@ enum {
 	PDC_COMMAND		= 0x1C, /* Command/status reg (per port) */
 	PDC_ALTSTATUS		= 0x38, /* Alternate-status/device-control reg (per port) */
 	PDC_PKT_SUBMIT		= 0x40, /* Command packet pointer addr */
-	PDC_INT_SEQMASK		= 0x40,	/* Mask of asserted SEQ INTs */
-	PDC_FLASH_CTL		= 0x44, /* Flash control register */
 	PDC_GLOBAL_CTL		= 0x48, /* Global control/status (per port) */
 	PDC_CTLSTAT		= 0x60,	/* IDE control and status (per port) */
-	PDC_SATA_PLUG_CSR	= 0x6C, /* SATA Plug control/status reg */
-	PDC2_SATA_PLUG_CSR	= 0x60, /* SATAII Plug control/status reg */
-	PDC_TBG_MODE		= 0x41C, /* TBG mode (not SATAII) */
-	PDC_SLEW_CTL		= 0x470, /* slew rate control reg (not SATAII) */
+
+	/* per-port SATA register offsets (from ap->ioaddr.scr_addr) */
+	PDC_PHYMODE4		= 0x14,
 
 	/* PDC_GLOBAL_CTL bit definitions */
 	PDC_PH_ERR		= (1 <<  8), /* PCI error while loading packet */
@@ -332,12 +337,12 @@ static int pdc_sata_port_start(struct at
 
 	/* fix up PHYMODE4 align timing */
 	if (ap->flags & PDC_FLAG_GEN_II) {
-		void __iomem *mmio = ap->ioaddr.scr_addr;
+		void __iomem *sata_mmio = ap->ioaddr.scr_addr;
 		unsigned int tmp;
 
-		tmp = readl(mmio + 0x014);
+		tmp = readl(sata_mmio + PDC_PHYMODE4);
 		tmp = (tmp & ~3) | 1;	/* set bits 1:0 = 0:1 */
-		writel(tmp, mmio + 0x014);
+		writel(tmp, sata_mmio + PDC_PHYMODE4);
 	}
 
 	return 0;
@@ -345,32 +350,32 @@ static int pdc_sata_port_start(struct at
 
 static void pdc_reset_port(struct ata_port *ap)
 {
-	void __iomem *mmio = ap->ioaddr.cmd_addr + PDC_CTLSTAT;
+	void __iomem *ata_ctlstat_mmio = ap->ioaddr.cmd_addr + PDC_CTLSTAT;
 	unsigned int i;
 	u32 tmp;
 
 	for (i = 11; i > 0; i--) {
-		tmp = readl(mmio);
+		tmp = readl(ata_ctlstat_mmio);
 		if (tmp & PDC_RESET)
 			break;
 
 		udelay(100);
 
 		tmp |= PDC_RESET;
-		writel(tmp, mmio);
+		writel(tmp, ata_ctlstat_mmio);
 	}
 
 	tmp &= ~PDC_RESET;
-	writel(tmp, mmio);
-	readl(mmio);	/* flush */
+	writel(tmp, ata_ctlstat_mmio);
+	readl(ata_ctlstat_mmio);	/* flush */
 }
 
 static int pdc_pata_cable_detect(struct ata_port *ap)
 {
 	u8 tmp;
-	void __iomem *mmio = ap->ioaddr.cmd_addr + PDC_CTLSTAT + 0x03;
+	void __iomem *ata_mmio = ap->ioaddr.cmd_addr;
 
-	tmp = readb(mmio);
+	tmp = readb(ata_mmio + PDC_CTLSTAT + 3);
 	if (tmp & 0x01)
 		return ATA_CBL_PATA40;
 	return ATA_CBL_PATA80;
@@ -624,14 +629,14 @@ static unsigned int pdc_sata_hotplug_off
 
 static void pdc_freeze(struct ata_port *ap)
 {
-	void __iomem *mmio = ap->ioaddr.cmd_addr;
+	void __iomem *ata_mmio = ap->ioaddr.cmd_addr;
 	u32 tmp;
 
-	tmp = readl(mmio + PDC_CTLSTAT);
+	tmp = readl(ata_mmio + PDC_CTLSTAT);
 	tmp |= PDC_IRQ_DISABLE;
 	tmp &= ~PDC_DMA_ENABLE;
-	writel(tmp, mmio + PDC_CTLSTAT);
-	readl(mmio + PDC_CTLSTAT); /* flush */
+	writel(tmp, ata_mmio + PDC_CTLSTAT);
+	readl(ata_mmio + PDC_CTLSTAT); /* flush */
 }
 
 static void pdc_sata_freeze(struct ata_port *ap)
@@ -659,17 +664,17 @@ static void pdc_sata_freeze(struct ata_p
 
 static void pdc_thaw(struct ata_port *ap)
 {
-	void __iomem *mmio = ap->ioaddr.cmd_addr;
+	void __iomem *ata_mmio = ap->ioaddr.cmd_addr;
 	u32 tmp;
 
 	/* clear IRQ */
-	readl(mmio + PDC_COMMAND);
+	readl(ata_mmio + PDC_COMMAND);
 
 	/* turn IRQ back on */
-	tmp = readl(mmio + PDC_CTLSTAT);
+	tmp = readl(ata_mmio + PDC_CTLSTAT);
 	tmp &= ~PDC_IRQ_DISABLE;
-	writel(tmp, mmio + PDC_CTLSTAT);
-	readl(mmio + PDC_CTLSTAT); /* flush */
+	writel(tmp, ata_mmio + PDC_CTLSTAT);
+	readl(ata_mmio + PDC_CTLSTAT); /* flush */
 }
 
 static void pdc_sata_thaw(struct ata_port *ap)
@@ -747,7 +752,7 @@ static inline unsigned int pdc_host_intr
 					 struct ata_queued_cmd *qc)
 {
 	unsigned int handled = 0;
-	void __iomem *port_mmio = ap->ioaddr.cmd_addr;
+	void __iomem *ata_mmio = ap->ioaddr.cmd_addr;
 	u32 port_status, err_mask;
 
 	err_mask = PDC_ERR_MASK;
@@ -755,7 +760,7 @@ static inline unsigned int pdc_host_intr
 		err_mask &= ~PDC1_ERR_MASK;
 	else
 		err_mask &= ~PDC2_ERR_MASK;
-	port_status = readl(port_mmio + PDC_GLOBAL_CTL);
+	port_status = readl(ata_mmio + PDC_GLOBAL_CTL);
 	if (unlikely(port_status & err_mask)) {
 		pdc_error_intr(ap, qc, port_status, err_mask);
 		return 1;
@@ -781,9 +786,9 @@ static inline unsigned int pdc_host_intr
 
 static void pdc_irq_clear(struct ata_port *ap)
 {
-	void __iomem *mmio = ap->ioaddr.cmd_addr;
+	void __iomem *ata_mmio = ap->ioaddr.cmd_addr;
 
-	readl(mmio + PDC_COMMAND);
+	readl(ata_mmio + PDC_COMMAND);
 }
 
 static irqreturn_t pdc_interrupt(int irq, void *dev_instance)
@@ -793,7 +798,7 @@ static irqreturn_t pdc_interrupt(int irq
 	u32 mask = 0;
 	unsigned int i, tmp;
 	unsigned int handled = 0;
-	void __iomem *mmio_base;
+	void __iomem *host_mmio;
 	unsigned int hotplug_offset, ata_no;
 	u32 hotplug_status;
 	int is_sataii_tx4;
@@ -805,7 +810,7 @@ static irqreturn_t pdc_interrupt(int irq
 		return IRQ_NONE;
 	}
 
-	mmio_base = host->iomap[PDC_MMIO_BAR];
+	host_mmio = host->iomap[PDC_MMIO_BAR];
 
 	spin_lock(&host->lock);
 
@@ -814,13 +819,13 @@ static irqreturn_t pdc_interrupt(int irq
 		hotplug_offset = PDC2_SATA_PLUG_CSR;
 	else
 		hotplug_offset = PDC_SATA_PLUG_CSR;
-	hotplug_status = readl(mmio_base + hotplug_offset);
+	hotplug_status = readl(host_mmio + hotplug_offset);
 	if (hotplug_status & 0xff)
-		writel(hotplug_status | 0xff, mmio_base + hotplug_offset);
+		writel(hotplug_status | 0xff, host_mmio + hotplug_offset);
 	hotplug_status &= 0xff;	/* clear uninteresting bits */
 
 	/* reading should also clear interrupts */
-	mask = readl(mmio_base + PDC_INT_SEQMASK);
+	mask = readl(host_mmio + PDC_INT_SEQMASK);
 
 	if (mask == 0xffffffff && hotplug_status == 0) {
 		VPRINTK("QUICK EXIT 2\n");
@@ -833,7 +838,7 @@ static irqreturn_t pdc_interrupt(int irq
 		goto done_irq;
 	}
 
-	writel(mask, mmio_base + PDC_INT_SEQMASK);
+	writel(mask, host_mmio + PDC_INT_SEQMASK);
 
 	is_sataii_tx4 = pdc_is_sataii_tx4(host->ports[0]->flags);
 
@@ -878,19 +883,20 @@ static inline void pdc_packet_start(stru
 {
 	struct ata_port *ap = qc->ap;
 	struct pdc_port_priv *pp = ap->private_data;
-	void __iomem *mmio = ap->host->iomap[PDC_MMIO_BAR];
+	void __iomem *host_mmio = ap->host->iomap[PDC_MMIO_BAR];
+	void __iomem *ata_mmio = ap->ioaddr.cmd_addr;
 	unsigned int port_no = ap->port_no;
 	u8 seq = (u8) (port_no + 1);
 
 	VPRINTK("ENTER, ap %p\n", ap);
 
-	writel(0x00000001, mmio + (seq * 4));
-	readl(mmio + (seq * 4));	/* flush */
+	writel(0x00000001, host_mmio + (seq * 4));
+	readl(host_mmio + (seq * 4));	/* flush */
 
 	pp->pkt[2] = seq;
 	wmb();			/* flush PRD, pkt writes */
-	writel(pp->pkt_dma, ap->ioaddr.cmd_addr + PDC_PKT_SUBMIT);
-	readl(ap->ioaddr.cmd_addr + PDC_PKT_SUBMIT); /* flush */
+	writel(pp->pkt_dma, ata_mmio + PDC_PKT_SUBMIT);
+	readl(ata_mmio + PDC_PKT_SUBMIT); /* flush */
 }
 
 static unsigned int pdc_qc_issue(struct ata_queued_cmd *qc)
@@ -986,7 +992,7 @@ static void pdc_ata_setup_port(struct at
 
 static void pdc_host_init(struct ata_host *host)
 {
-	void __iomem *mmio = host->iomap[PDC_MMIO_BAR];
+	void __iomem *host_mmio = host->iomap[PDC_MMIO_BAR];
 	int is_gen2 = host->ports[0]->flags & PDC_FLAG_GEN_II;
 	int hotplug_offset;
 	u32 tmp;
@@ -1003,38 +1009,38 @@ static void pdc_host_init(struct ata_hos
 	 */
 
 	/* enable BMR_BURST, maybe change FIFO_SHD to 8 dwords */
-	tmp = readl(mmio + PDC_FLASH_CTL);
+	tmp = readl(host_mmio + PDC_FLASH_CTL);
 	tmp |= 0x02000;	/* bit 13 (enable bmr burst) */
 	if (!is_gen2)
 		tmp |= 0x10000;	/* bit 16 (fifo threshold at 8 dw) */
-	writel(tmp, mmio + PDC_FLASH_CTL);
+	writel(tmp, host_mmio + PDC_FLASH_CTL);
 
 	/* clear plug/unplug flags for all ports */
-	tmp = readl(mmio + hotplug_offset);
-	writel(tmp | 0xff, mmio + hotplug_offset);
+	tmp = readl(host_mmio + hotplug_offset);
+	writel(tmp | 0xff, host_mmio + hotplug_offset);
 
 	/* unmask plug/unplug ints */
-	tmp = readl(mmio + hotplug_offset);
-	writel(tmp & ~0xff0000, mmio + hotplug_offset);
+	tmp = readl(host_mmio + hotplug_offset);
+	writel(tmp & ~0xff0000, host_mmio + hotplug_offset);
 
 	/* don't initialise TBG or SLEW on 2nd generation chips */
 	if (is_gen2)
 		return;
 
 	/* reduce TBG clock to 133 Mhz. */
-	tmp = readl(mmio + PDC_TBG_MODE);
+	tmp = readl(host_mmio + PDC_TBG_MODE);
 	tmp &= ~0x30000; /* clear bit 17, 16*/
 	tmp |= 0x10000;  /* set bit 17:16 = 0:1 */
-	writel(tmp, mmio + PDC_TBG_MODE);
+	writel(tmp, host_mmio + PDC_TBG_MODE);
 
-	readl(mmio + PDC_TBG_MODE);	/* flush */
+	readl(host_mmio + PDC_TBG_MODE);	/* flush */
 	msleep(10);
 
 	/* adjust slew rate control register. */
-	tmp = readl(mmio + PDC_SLEW_CTL);
+	tmp = readl(host_mmio + PDC_SLEW_CTL);
 	tmp &= 0xFFFFF03F; /* clear bit 11 ~ 6 */
 	tmp  |= 0x00000900; /* set bit 11-9 = 100b , bit 8-6 = 100 */
-	writel(tmp, mmio + PDC_SLEW_CTL);
+	writel(tmp, host_mmio + PDC_SLEW_CTL);
 }
 
 static int pdc_ata_init_one(struct pci_dev *pdev,
@@ -1044,7 +1050,7 @@ static int pdc_ata_init_one(struct pci_d
 	const struct ata_port_info *pi = &pdc_port_info[ent->driver_data];
 	const struct ata_port_info *ppi[PDC_MAX_PORTS];
 	struct ata_host *host;
-	void __iomem *base;
+	void __iomem *host_mmio;
 	int n_ports, i, rc;
 	int is_sataii_tx4;
 
@@ -1061,7 +1067,7 @@ static int pdc_ata_init_one(struct pci_d
 		pcim_pin_device(pdev);
 	if (rc)
 		return rc;
-	base = pcim_iomap_table(pdev)[PDC_MMIO_BAR];
+	host_mmio = pcim_iomap_table(pdev)[PDC_MMIO_BAR];
 
 	/* determine port configuration and setup host */
 	n_ports = 2;
@@ -1071,7 +1077,7 @@ static int pdc_ata_init_one(struct pci_d
 		ppi[i] = pi;
 
 	if (pi->flags & PDC_FLAG_SATA_PATA) {
-		u8 tmp = readb(base + PDC_FLASH_CTL+1);
+		u8 tmp = readb(host_mmio + PDC_FLASH_CTL + 1);
 		if (!(tmp & 0x80))
 			ppi[n_ports++] = pi + 1;
 	}
@@ -1087,13 +1093,13 @@ static int pdc_ata_init_one(struct pci_d
 	for (i = 0; i < host->n_ports; i++) {
 		struct ata_port *ap = host->ports[i];
 		unsigned int ata_no = pdc_port_no_to_ata_no(i, is_sataii_tx4);
-		unsigned int port_offset = 0x200 + ata_no * 0x80;
+		unsigned int ata_offset = 0x200 + ata_no * 0x80;
 		unsigned int scr_offset = 0x400 + ata_no * 0x100;
 
-		pdc_ata_setup_port(ap, base + port_offset, base + scr_offset);
+		pdc_ata_setup_port(ap, host_mmio + ata_offset, host_mmio + scr_offset);
 
 		ata_port_pbar_desc(ap, PDC_MMIO_BAR, -1, "mmio");
-		ata_port_pbar_desc(ap, PDC_MMIO_BAR, port_offset, "port");
+		ata_port_pbar_desc(ap, PDC_MMIO_BAR, ata_offset, "ata");
 	}
 
 	/* initialize adapter */
