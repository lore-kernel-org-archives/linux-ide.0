Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82F25529412;
	Tue, 13 Oct 2026 13:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791897604; cv=none; b=mOCb87qlICZWgAzHk22XCd+rU1WfiH2GhWh2txxPJMCbWjhMAMsgZENVaRIokkrdKwf20t/YmAPX8eXANfYHJd1fpLLHzQc5/NrTZ9eeRKWFBr3MXm11vJYQd6WH5wjfeSokbS7uYj7WRw3HWUd3bce/Ft/zFidW4GMtQtwZoyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791897604; c=relaxed/simple;
	bh=FNAMlW7mHSBjuzcz21LfhYIUlF6/j8DiYzXMYKl1yzQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DrydmtLPSUmtH3C6TVw0bXaAPHeclQIRE4QgQY8aKywIT4VCORvtHFwCZ7LpAZVjp/3o3KBl/tfuP7rjE9F+J1jfc/kb75abXHBONkFJUkHtQRvhaWy1TOw0KiapxAIGO/ftCTQOsuEXHmiKi+oNGq1YM4f0/9a27S8KlYqK9SE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Btx6nnQH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Btx6nnQH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C8601F00893;
	Tue, 13 Oct 2026 13:20:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791897603;
	bh=BCIBWb+polg6WeNaIs2yprnl0tPq6PaHmhBp5ax/z9E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Btx6nnQHnf5hX1NOjBBVS9CBm6rfePMKM9apSbxA3ZWtHVAzniblewSjJ7kYgLSVA
	 TLlNKGNlG9qV2VL/exnbHJXrZ3/cyFdl9N9EKlTMBVmglclz2d9CWuep47JAdV0y3V
	 BYI9UIvUs9ZYa5kuhYKLJV6U+mJZSANWCHyVCG+M2hQv+liBLJyrKRFw5jh7LVMPzk
	 882D1/R47hAV3KQ2Mva7r5hL+Ymm4hCIsaoXqoSXlX9bEpMr6F57P35taC4th4o4ND
	 0FITdpcP/d1QIEmp4gCC0LyjnPWnZ6VW8bFbEO1qQaOwp92YR/XeaG49PRBsHI214E
	 T5OXcR7trliwA==
From: Imre Kaloz <kaloz@kernel.org>
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: linux-mips@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lee Jones <lee@kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	linux-ide@vger.kernel.org
Subject: [PATCH v2 45/53] ata: add pata_sgiioc4 driver for the SGI IOC4 ATA/ATAPI controller
Date: Tue, 13 Oct 2026 15:17:05 +0200
Message-ID: <113e6db8a3092fa79189e63e00fac5fdf669faee.1791890466.git.kaloz@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1791890466.git.kaloz@kernel.org>
References: <cover.1791890466.git.kaloz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The IOC4 on Origin 350-class I-brick boards drives the DVD-ROM from an
ATA/ATAPI controller at BAR0+0x100. drivers/ide/sgiioc4.c went away in
v5.4.

Add a libata driver bound to an IOC4 MFD cell, with PIO4 and multiword
DMA mode 2. Each taskfile register sits at the lowest address of its
own 32-bit slot; the IDE driver's "+3" byte-lane correction reads
zeros there.

Signed-off-by: Imre Kaloz <kaloz@kernel.org>
---
 drivers/ata/Kconfig        |  10 ++
 drivers/ata/Makefile       |   1 +
 drivers/ata/pata_sgiioc4.c | 311 +++++++++++++++++++++++++++++++++++++
 3 files changed, 322 insertions(+)
 create mode 100644 drivers/ata/pata_sgiioc4.c

diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
index 28ca856ecc75..704414501f35 100644
--- a/drivers/ata/Kconfig
+++ b/drivers/ata/Kconfig
@@ -940,6 +940,16 @@ config PATA_SERVERWORKS
 
 	  If unsure, say N.
 
+config PATA_SGIIOC4
+	tristate "SGI IOC4 ATA/ATAPI support"
+	depends on SGI_MFD_IOC3
+	help
+	  This option enables support for the ATA/ATAPI controller
+	  integrated into SGI's IOC4 I/O ASIC, found on Tezro/Origin
+	  350-class I-brick system boards.
+
+	  If unsure, say N.
+
 config PATA_SIL680
 	tristate "CMD / Silicon Image 680 PATA support"
 	depends on PCI
diff --git a/drivers/ata/Makefile b/drivers/ata/Makefile
index b96025abd45e..f2947a2b86be 100644
--- a/drivers/ata/Makefile
+++ b/drivers/ata/Makefile
@@ -89,6 +89,7 @@ obj-$(CONFIG_PATA_RDC)		+= pata_rdc.o
 obj-$(CONFIG_PATA_SC1200)	+= pata_sc1200.o
 obj-$(CONFIG_PATA_SCH)		+= pata_sch.o
 obj-$(CONFIG_PATA_SERVERWORKS)	+= pata_serverworks.o
+obj-$(CONFIG_PATA_SGIIOC4)	+= pata_sgiioc4.o
 obj-$(CONFIG_PATA_SIL680)	+= pata_sil680.o
 obj-$(CONFIG_PATA_SIS)		+= pata_sis.o
 obj-$(CONFIG_PATA_TOSHIBA)	+= pata_piccolo.o
diff --git a/drivers/ata/pata_sgiioc4.c b/drivers/ata/pata_sgiioc4.c
new file mode 100644
index 000000000000..454c43c6b6c7
--- /dev/null
+++ b/drivers/ata/pata_sgiioc4.c
@@ -0,0 +1,311 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * libata driver for the ATA/ATAPI controller in SGI's IOC4 I/O ASIC.
+ *
+ * Copyright (C) 1999-2004 Silicon Graphics, Inc.
+ * Copyright (C) 2026 Imre Kaloz <kaloz@kernel.org>
+ */
+#include <linux/ata.h>
+#include <linux/dma-mapping.h>
+#include <linux/iopoll.h>
+#include <linux/libata.h>
+#include <linux/module.h>
+#include <linux/pci.h>
+#include <linux/platform_device.h>
+#include <linux/sizes.h>
+#include <linux/string.h>
+
+#include <asm/sn/ioc4.h>
+
+#define DRV_NAME	"pata_sgiioc4"
+
+#define IOC4_ATA_CTRL_OFFSET	offsetof(struct ioc4_ata_regs, ctrl)
+
+/* The ATA controller needs IOC4 firmware revision 46 or later. */
+#define IOC4_ATA_MIN_REV	46
+
+/* DMA engine registers, as offsets into the ATA block */
+#define IOC4_DMA_REG(n)		offsetof(struct ioc4_ata_regs, dma[n])
+#define IOC4_DMA_PTR_L		IOC4_DMA_REG(1)	/* descriptor list */
+#define IOC4_DMA_PTR_H		IOC4_DMA_REG(2)
+#define IOC4_DMA_ADDR_L		IOC4_DMA_REG(3)	/* current memory address */
+#define IOC4_DMA_ADDR_H		IOC4_DMA_REG(4)
+#define IOC4_DMA_BC_DEV		IOC4_DMA_REG(5)
+#define IOC4_DMA_BC_MEM		IOC4_DMA_REG(6)
+#define IOC4_DMA_CTRL		IOC4_DMA_REG(7)
+#define IOC4_DMA_END		IOC4_DMA_REG(8)	/* completion area */
+
+#define IOC4_DMA_START		BIT(0)
+#define IOC4_DMA_STOP		BIT(1)	/* reads 1 until the engine stops */
+#define IOC4_DMA_TO_MEM		BIT(2)
+#define IOC4_DMA_ACTIVE		BIT(3)
+#define IOC4_DMA_MEMERR		BIT(4)
+
+#define IOC4_DMA_STOP_TIMEOUT_US	200
+
+/* Descriptors are big-endian; the last one has bit 31 set in its count. */
+struct ioc4_ata_prd {
+	__be64	addr;
+	__be64	count;
+};
+
+#define IOC4_PRD_EOL		0x80000000
+#define IOC4_PRD_ENTRIES	ATA_MAX_PRD
+#define IOC4_PRD_SIZE		(IOC4_PRD_ENTRIES * sizeof(struct ioc4_ata_prd))
+
+/*
+ * The count field holds at most 0xfffe bytes, so a whole 64 KiB segment
+ * does not fit one descriptor. Splitting at 32 KiB boundaries keeps
+ * libata's segments within two descriptors each.
+ */
+#define IOC4_PRD_CHUNK		SZ_32K
+
+/*
+ * After the last data of a transfer the engine writes nonzero bytes into
+ * a 128-byte, 128-byte aligned area. Register reads are not ordered
+ * against its data writes, so the data is valid only once this area
+ * changes.
+ */
+#define IOC4_DMAEND_SIZE	128
+#define IOC4_DMAEND_TIMEOUT_US	1000
+
+struct ioc4_ata_port {
+	struct ioc4_ata_prd	*prd;
+	void			*dmaend;
+	dma_addr_t		prd_dma;
+	dma_addr_t		dmaend_dma;
+	u32			dir;
+};
+
+static void ioc4_ata_dma_halt(struct ata_port *ap)
+{
+	void __iomem *base = ap->ioaddr.cmd_addr;
+	u32 val;
+
+	writel(IOC4_DMA_STOP, base + IOC4_DMA_CTRL);
+	if (readl_poll_timeout_atomic(base + IOC4_DMA_CTRL, val,
+				      !(val & IOC4_DMA_STOP), 1,
+				      IOC4_DMA_STOP_TIMEOUT_US))
+		ata_port_warn(ap, "DMA engine did not stop\n");
+}
+
+static enum ata_completion_errors ioc4_ata_qc_prep(struct ata_queued_cmd *qc)
+{
+	struct ioc4_ata_port *pp = qc->ap->private_data;
+	struct scatterlist *sg;
+	unsigned int si, pi = 0;
+
+	if (!(qc->flags & ATA_QCFLAG_DMAMAP))
+		return AC_ERR_OK;
+
+	for_each_sg(qc->sg, sg, qc->n_elem, si) {
+		dma_addr_t addr = sg_dma_address(sg);
+		u32 sg_len = sg_dma_len(sg);
+
+		while (sg_len) {
+			u32 len = min_t(u32, sg_len, IOC4_PRD_CHUNK -
+					(addr & (IOC4_PRD_CHUNK - 1)));
+
+			pp->prd[pi].addr = cpu_to_be64(addr);
+			pp->prd[pi].count = cpu_to_be64(len);
+			pi++;
+			addr += len;
+			sg_len -= len;
+		}
+	}
+	pp->prd[pi - 1].count |= cpu_to_be64(IOC4_PRD_EOL);
+
+	return AC_ERR_OK;
+}
+
+static void ioc4_ata_bmdma_setup(struct ata_queued_cmd *qc)
+{
+	struct ata_port *ap = qc->ap;
+	struct ioc4_ata_port *pp = ap->private_data;
+	void __iomem *base = ap->ioaddr.cmd_addr;
+
+	/* A failed transfer can leave the engine running or an error latched. */
+	if (readl(base + IOC4_DMA_CTRL) & (IOC4_DMA_ACTIVE | IOC4_DMA_MEMERR))
+		ioc4_ata_dma_halt(ap);
+
+	writel(lower_32_bits(pp->prd_dma), base + IOC4_DMA_PTR_L);
+	writel(upper_32_bits(pp->prd_dma), base + IOC4_DMA_PTR_H);
+
+	memset(pp->dmaend, 0, IOC4_DMAEND_SIZE);
+	writel(lower_32_bits(pp->dmaend_dma), base + IOC4_DMA_END);
+
+	pp->dir = qc->tf.flags & ATA_TFLAG_WRITE ? 0 : IOC4_DMA_TO_MEM;
+
+	ap->ops->sff_exec_command(ap, &qc->tf);
+}
+
+static void ioc4_ata_bmdma_start(struct ata_queued_cmd *qc)
+{
+	struct ata_port *ap = qc->ap;
+	struct ioc4_ata_port *pp = ap->private_data;
+
+	writel(pp->dir | IOC4_DMA_START, ap->ioaddr.cmd_addr + IOC4_DMA_CTRL);
+}
+
+static void ioc4_ata_bmdma_stop(struct ata_queued_cmd *qc)
+{
+	ioc4_ata_dma_halt(qc->ap);
+}
+
+/*
+ * The engine raises no completion interrupt; the port interrupt is
+ * the drive's. Once the drive has finished without error, wait for the
+ * completion area before the data is handed back.
+ */
+static u8 ioc4_ata_bmdma_status(struct ata_port *ap)
+{
+	struct ioc4_ata_port *pp = ap->private_data;
+	u32 ctrl = readl(ap->ioaddr.cmd_addr + IOC4_DMA_CTRL);
+	u8 status = ATA_DMA_INTR;
+	void *seen;
+
+	if (ctrl & IOC4_DMA_ACTIVE)
+		status |= ATA_DMA_ACTIVE;
+
+	if (ctrl & IOC4_DMA_MEMERR)
+		return status | ATA_DMA_ERR;
+
+	if (ioread8(ap->ioaddr.altstatus_addr) & (ATA_BUSY | ATA_DRQ | ATA_ERR))
+		return status;
+
+	if (read_poll_timeout_atomic(memchr_inv, seen, seen, 1,
+				     IOC4_DMAEND_TIMEOUT_US, false,
+				     pp->dmaend, 0, IOC4_DMAEND_SIZE))
+		return status | ATA_DMA_ERR;
+	dma_rmb();
+
+	return status;
+}
+
+static int ioc4_ata_port_start(struct ata_port *ap)
+{
+	struct device *dev = ap->host->dev;
+	struct ioc4_ata_port *pp;
+
+	pp = devm_kzalloc(dev, sizeof(*pp), GFP_KERNEL);
+	if (!pp)
+		return -ENOMEM;
+
+	/* The page-aligned list leaves the completion area 128-byte aligned. */
+	pp->prd = dmam_alloc_coherent(dev, IOC4_PRD_SIZE + IOC4_DMAEND_SIZE,
+				      &pp->prd_dma, GFP_KERNEL);
+	if (!pp->prd)
+		return -ENOMEM;
+
+	pp->dmaend = (void *)pp->prd + IOC4_PRD_SIZE;
+	pp->dmaend_dma = pp->prd_dma + IOC4_PRD_SIZE;
+	ap->private_data = pp;
+
+	return 0;
+}
+
+static struct ata_port_operations ioc4_ata_port_ops = {
+	.inherits		= &ata_bmdma_port_ops,
+
+	.cable_detect		= ata_cable_40wire,
+
+	/* No .set_piomode: what the ATA timing register does is unknown. */
+
+	.qc_prep		= ioc4_ata_qc_prep,
+	.bmdma_setup		= ioc4_ata_bmdma_setup,
+	.bmdma_start		= ioc4_ata_bmdma_start,
+	.bmdma_stop		= ioc4_ata_bmdma_stop,
+	.bmdma_status		= ioc4_ata_bmdma_status,
+	.port_start		= ioc4_ata_port_start,
+};
+
+static const struct scsi_host_template ioc4_ata_sht = {
+	ATA_BMDMA_SHT(DRV_NAME),
+};
+
+static int ioc4_ata_probe(struct platform_device *pdev)
+{
+	struct ata_port_info pinfo = {
+		.flags		= ATA_FLAG_SLAVE_POSS,
+		.pio_mask	= ATA_PIO4,
+		.mwdma_mask	= ATA_MWDMA2_ONLY,
+		.port_ops	= &ioc4_ata_port_ops,
+	};
+	const struct ata_port_info *ppi[] = { &pinfo, NULL };
+	struct pci_dev *pci_parent;
+	struct ata_host *host;
+	struct ata_port *ap;
+	struct resource *res;
+	void __iomem *base;
+	int irq, ret;
+
+	if (!dev_is_pci(pdev->dev.parent))
+		return -EINVAL;
+	pci_parent = to_pci_dev(pdev->dev.parent);
+
+	if (pci_parent->revision < IOC4_ATA_MIN_REV) {
+		dev_err(&pdev->dev,
+			"IOC4 firmware revision %u is not supported, %u or later is required\n",
+			pci_parent->revision, IOC4_ATA_MIN_REV);
+		return -ENODEV;
+	}
+
+	base = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
+	if (IS_ERR(base))
+		return PTR_ERR(base);
+
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0)
+		return irq;
+
+	/*
+	 * The cell inherits its parent's 64-bit DMA mask, but the engine
+	 * takes 32-bit bus addresses only.
+	 */
+	ret = dma_coerce_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32));
+	if (ret)
+		return ret;
+
+	host = ata_host_alloc_pinfo(&pdev->dev, ppi, 1);
+	if (!host)
+		return -ENOMEM;
+
+	ap = host->ports[0];
+
+	/*
+	 * Each taskfile register has a 32-bit slot of its own and sits at the
+	 * slot's lowest address, with no byte-lane correction.
+	 */
+	ap->ioaddr.cmd_addr	 = base;
+	ap->ioaddr.data_addr	 = base + (ATA_REG_DATA << 2);
+	ap->ioaddr.error_addr	 = base + (ATA_REG_ERR << 2);
+	ap->ioaddr.feature_addr	 = ap->ioaddr.error_addr;
+	ap->ioaddr.nsect_addr	 = base + (ATA_REG_NSECT << 2);
+	ap->ioaddr.lbal_addr	 = base + (ATA_REG_LBAL << 2);
+	ap->ioaddr.lbam_addr	 = base + (ATA_REG_LBAM << 2);
+	ap->ioaddr.lbah_addr	 = base + (ATA_REG_LBAH << 2);
+	ap->ioaddr.device_addr	 = base + (ATA_REG_DEVICE << 2);
+	ap->ioaddr.status_addr	 = base + (ATA_REG_STATUS << 2);
+	ap->ioaddr.command_addr	 = ap->ioaddr.status_addr;
+	ap->ioaddr.altstatus_addr = base + IOC4_ATA_CTRL_OFFSET;
+	ap->ioaddr.ctl_addr	 = ap->ioaddr.altstatus_addr;
+
+	ata_port_desc(ap, "cmd 0x%llx", (unsigned long long)res->start);
+
+	return ata_host_activate(host, irq, ata_bmdma_interrupt, IRQF_SHARED,
+				  &ioc4_ata_sht);
+}
+
+static struct platform_driver ioc4_ata_driver = {
+	.probe	= ioc4_ata_probe,
+	.remove	= ata_platform_remove_one,
+	.driver	= {
+		.name	= DRV_NAME,
+	},
+};
+module_platform_driver(ioc4_ata_driver);
+
+MODULE_AUTHOR("Imre Kaloz <kaloz@kernel.org>");
+MODULE_DESCRIPTION("SGI IOC4 ATA/ATAPI libata driver");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:" DRV_NAME);
-- 
2.47.3

