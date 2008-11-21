From: David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH] ide: New libata driver for OCTEON SOC Compact Flash interface.
Date: Thu, 20 Nov 2008 18:24:37 -0800
Message-ID: <49261BE5.2010406@caviumnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail3.caviumnetworks.com ([12.108.191.235]:52553 "EHLO
	mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752046AbYKUCZr (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 20 Nov 2008 21:25:47 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org, linux-mips <linux-mips@linux-mips.org>

As part of our efforts to get the Cavium OCTEON processor support
merged (see: http://marc.info/?l=linux-mips&m=122704699515601), we
have this CF driver for your consideration.

Most OCTEON variants have *no* DMA or interrupt support on the CF
interface so for these, only PIO is supported.  Although if DMA is
available, we do take advantage of it.

The register definitions are part of the chip support patch set
mentioned above, and are not included here.

At this point I would like to get feedback on the patch and would
expect that it would merge via the linux-mips tree along with the rest
of the chip support.

Thanks,

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---
 drivers/ata/Kconfig          |    9 +
 drivers/ata/Makefile         |    1 +
 drivers/ata/pata_octeon_cf.c |  942 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 952 insertions(+), 0 deletions(-)

diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
index 78fbec8..b59904b 100644
--- a/drivers/ata/Kconfig
+++ b/drivers/ata/Kconfig
@@ -697,6 +697,15 @@ config PATA_IXP4XX_CF
 
 	  If unsure, say N.
 
+config PATA_OCTEON_CF
+	tristate "OCTEON Boot Bus Compact Flash support"
+	depends on CPU_CAVIUM_OCTEON
+	help
+	  This option enables a polled compact flash driver for use with
+	  compact flash cards attached to the OCTEON boot bus.
+
+	  If unsure, say N.
+
 config PATA_SCC
 	tristate "Toshiba's Cell Reference Set IDE support"
 	depends on PCI && PPC_CELLEB
diff --git a/drivers/ata/Makefile b/drivers/ata/Makefile
index 674965f..7f1ecf9 100644
--- a/drivers/ata/Makefile
+++ b/drivers/ata/Makefile
@@ -69,6 +69,7 @@ obj-$(CONFIG_PATA_IXP4XX_CF)	+= pata_ixp4xx_cf.o
 obj-$(CONFIG_PATA_SCC)		+= pata_scc.o
 obj-$(CONFIG_PATA_SCH)		+= pata_sch.o
 obj-$(CONFIG_PATA_BF54X)	+= pata_bf54x.o
+obj-$(CONFIG_PATA_OCTEON_CF)	+= pata_octeon_cf.o
 obj-$(CONFIG_PATA_PLATFORM)	+= pata_platform.o
 obj-$(CONFIG_PATA_OF_PLATFORM)	+= pata_of_platform.o
 obj-$(CONFIG_PATA_ICSIDE)	+= pata_icside.o
diff --git a/drivers/ata/pata_octeon_cf.c b/drivers/ata/pata_octeon_cf.c
new file mode 100644
index 0000000..e8712c0
--- /dev/null
+++ b/drivers/ata/pata_octeon_cf.c
@@ -0,0 +1,942 @@
+/*
+ * Driver for the Octeon bootbus compact flash.
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2005-2008 Cavium Networks
+ * Copyright (C) 2008 Wind River Systems
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/libata.h>
+#include <linux/irq.h>
+#include <linux/platform_device.h>
+#include <scsi/scsi_host.h>
+
+#include <asm/octeon/octeon.h>
+
+#define DRV_NAME	"pata_octeon_cf"
+#define DRV_VERSION	"2.1"
+
+
+struct octeon_cf_port {
+	struct tasklet_struct delayed_irq_tasklet;
+};
+
+/* Timing multiple used for configuring the boot bus DMA engine */
+#define CF_DMA_TIMING_MULT	4
+
+static struct scsi_host_template octeon_cf_sht = {
+	ATA_PIO_SHT(DRV_NAME),
+};
+
+static int use_cf_dma = 1;
+
+/**
+ * Called to enable the use of DMA based on kernel command line.
+ */
+void octeon_cf_enable_dma(void)
+{
+	use_cf_dma = 1;
+}
+
+static unsigned int div_roundup(unsigned int n, unsigned int d)
+{
+	return (n + d - 1) / d;
+}
+
+/**
+ * Convert nanosecond based time to setting used in the
+ * boot bus timing register, based on timing multiple
+ */
+static unsigned int ns_to_tim_reg(int tim_mult, uint32_t nsecs)
+{
+	unsigned int val;
+
+	/*
+	 * Compute # of eclock periods to get desired duration in
+	 * nanoseconds.
+	 */
+	val = div_roundup(nsecs * (octeon_get_clock_rate() / 1000000),
+			  1000);
+
+	/* Factor in timing multiple, if not 1 */
+	if (tim_mult != 1)
+		val = div_roundup(val, tim_mult);
+
+	return val;
+}
+
+/**
+ * Called after libata determines the needed PIO mode. This
+ * function programs the Octeon bootbus regions to support the
+ * timing requirements of the PIO mode.
+ *
+ * @ap:     ATA port information
+ * @dev:    ATA device
+ */
+static void octeon_cf_set_piomode(struct ata_port *ap, struct ata_device *dev)
+{
+	struct octeon_cf_data *ocd = ap->dev->platform_data;
+	cvmx_mio_boot_reg_timx_t mio_boot_reg_tim;
+	unsigned int cs = ocd->base_region;
+
+	int use_iordy;		/* Non zero to monitor the IORDY signal */
+	int clocks_us;		/* Number of clock cycles per microsec */
+	/* These names are timing parameters from the ATA spec */
+	int t1;
+	int t2;
+	int t2i;
+	int t4;
+	int t6;
+	int t6z;
+	/*
+	 * PIO modes 0-4 all allow the device to deassert IORDY to slow down
+	 * the host.
+	 */
+	use_iordy = 1;
+	/* Use the PIO mode to determine out timing parameters */
+	switch (dev->pio_mode) {
+	case XFER_PIO_0:
+		t1 = 70;
+		t2 = 165;
+		t2i = 0;
+		t4 = 30;
+		t6 = 5;
+		t6z = 30;
+		break;
+	case XFER_PIO_1:
+		t1 = 50;
+		t2 = 125;
+		t2i = 0;
+		t4 = 20;
+		t6 = 5;
+		t6z = 30;
+		break;
+	case XFER_PIO_2:
+		t1 = 30;
+		t2 = 100;
+		t2i = 0;
+		t4 = 15;
+		t6 = 5;
+		t6z = 30;
+		break;
+	case XFER_PIO_3:
+		t1 = 30;
+		t2 = 80;
+		t2i = 70;
+		t4 = 10;
+		t6 = 5;
+		t6z = 30;
+		break;
+	case XFER_PIO_4:
+		t1 = 25;
+		t2 = 70;
+		t2i = 25;
+		t4 = 10;
+		t6 = 5;
+		t6z = 30;
+		break;
+	case XFER_PIO_5:
+		/* CF spec say IORDY should be ignored in PIO 5 and 6 */
+		use_iordy = 0;
+		t1 = 15;
+		t2 = 65;
+		t2i = 25;
+		t4 = 5;
+		t6 = 5;
+		t6z = 20;
+		break;
+	case XFER_PIO_6:
+		/* CF spec say IORDY should be ignored in PIO 5 and 6 */
+		use_iordy = 0;
+		t1 = 10;
+		t2 = 55;
+		t2i = 20;
+		t4 = 5;
+		t6 = 5;
+		t6z = 20;
+		break;
+	default:
+		BUG();
+	}
+	clocks_us = (octeon_get_clock_rate() + (1000000 - 1)) / (1000000);
+
+	t1 = (t1 * clocks_us) / 1000 / 2;
+	if (t1)
+		t1--;
+	t2 = (t2 * clocks_us) / 1000 / 2;
+	if (t2)
+		t2--;
+	t2i = (t2i * clocks_us) / 1000 / 2;
+	if (t2i)
+		t2i--;
+	t4 = (t4 * clocks_us) / 1000 / 2;
+	if (t4)
+		t4--;
+	t6 = (t6 * clocks_us) / 1000 / 2;
+	if (t6)
+		t6--;
+	t6z = (t6z * clocks_us) / 1000 / 2;
+	if (t6z)
+		t6z--;
+
+	mio_boot_reg_tim.u64 = cvmx_read_csr(CVMX_MIO_BOOT_REG_TIMX(cs));
+	/* Disable page mode */
+	mio_boot_reg_tim.s.pagem = 0;
+	/* Enable dynamic timing */
+	mio_boot_reg_tim.s.waitm = use_iordy;
+	/* Pages are disabled */
+	mio_boot_reg_tim.s.pages = 0;
+	/* We don't use multiplexed address mode */
+	mio_boot_reg_tim.s.ale = 0;
+	/* Not used */
+	mio_boot_reg_tim.s.page = 0;
+	/* Time after IORDY to coninue to assert the data */
+	mio_boot_reg_tim.s.wait = 0;
+	/* Time after CE that signals stay valid */
+	mio_boot_reg_tim.s.pause = t6z - t6;
+	/* How long to hold after a write */
+	mio_boot_reg_tim.s.wr_hld = t4;
+	/* How long to wait after a read for device to tristate */
+	mio_boot_reg_tim.s.rd_hld = t6;
+	/* How long write enable is asserted */
+	mio_boot_reg_tim.s.we = t2;
+	/* How long read enable is asserted */
+	mio_boot_reg_tim.s.oe = t2;
+	/* Time after CE that read/write starts */
+	mio_boot_reg_tim.s.ce = 0;
+	/* Time before CE that address is valid */
+	mio_boot_reg_tim.s.adr = 0;
+
+	/* Program the bootbus region timing for the data port chip select. */
+	cvmx_write_csr(CVMX_MIO_BOOT_REG_TIMX(cs), mio_boot_reg_tim.u64);
+}
+
+static void octeon_cf_set_dmamode(struct ata_port *ap, struct ata_device *dev)
+{
+	struct octeon_cf_data *ocd = dev->link->ap->dev->platform_data;
+	cvmx_mio_boot_dma_timx_t dma_tim;
+	int oe_a;
+	int oe_n;
+	int dma_acks;
+	int dma_ackh;
+	int dma_arq;
+	int pause;
+	int To, Tkr, Td;
+	int tim_mult = 4;
+
+	dma_tim.u64 = 0;
+
+	dma_acks = 0;	/*Ti */
+
+	/* not spec'ed, value in eclocks, not affected by tim_mult */
+	dma_arq = 8;
+	pause = 25 - dma_arq * 1000 /
+		(octeon_get_clock_rate() / 1000000); /* Tz */
+
+	switch (dev->dma_mode) {
+	case XFER_MW_DMA_0:
+		dma_ackh = 20;	/* Tj */
+		To = 480;
+		Td = 215;
+		Tkr = 50;
+		break;
+	case XFER_MW_DMA_1:
+		dma_ackh = 5;	/* Tj */
+		To = 150;
+		Td = 80;
+		Tkr = 50;
+		break;
+	case XFER_MW_DMA_2:
+		dma_ackh = 5;	/* Tj */
+		To = 120;
+		Td = 70;
+		Tkr = 25;
+		break;
+	case XFER_MW_DMA_3:
+		dma_ackh = 5;	/* Tj */
+		To = 100;
+		Td = 65;
+		Tkr = 25;
+		break;
+	case XFER_MW_DMA_4:
+		dma_ackh = 5;	/* Tj */
+		To = 80;
+		Td = 55;
+		Tkr = 20;
+		break;
+	default:
+		BUG();
+	}
+	/* Td (Seem to need more margin here.... */
+	oe_a = Td + 20;
+	/* Tkr from cf spec, lengthened to meet To */
+	oe_n = max(To - oe_a, Tkr);
+
+	dma_tim.s.dmack_pi = 1;
+
+	dma_tim.s.oe_n = ns_to_tim_reg(tim_mult, oe_n);
+	dma_tim.s.oe_a = ns_to_tim_reg(tim_mult, oe_a);
+
+	dma_tim.s.dmack_s = ns_to_tim_reg(tim_mult, dma_acks);
+	dma_tim.s.dmack_h = ns_to_tim_reg(tim_mult, dma_ackh);
+
+	dma_tim.s.dmarq = dma_arq;
+	dma_tim.s.pause = ns_to_tim_reg(tim_mult, pause);
+
+	dma_tim.s.rd_dly = 0;	/* Sample right on edge */
+
+	/*  writes only */
+	dma_tim.s.we_n = ns_to_tim_reg(tim_mult, oe_n);
+	dma_tim.s.we_a = ns_to_tim_reg(tim_mult, oe_a);
+
+#if 0
+	pr_info("ns to ticks (mult %d) of %d is: %d\n", TIM_MULT, 60,
+		     ns_to_tim_reg(60));
+	pr_info("oe_n: %d, oe_a: %d, dmack_s: %d, dmack_h: "
+		"%d, dmarq: %d, pause: %d\n",
+		dma_tim.s.oe_n, dma_tim.s.oe_a, dma_tim.s.dmack_s,
+		dma_tim.s.dmack_h, dma_tim.s.dmarq, dma_tim.s.pause);
+#endif
+	cvmx_write_csr(CVMX_MIO_BOOT_DMA_TIMX(ocd->dma_engine),
+		       dma_tim.u64);
+
+}
+
+/**
+ * Handle an I/O request.
+ *
+ * @cf:         Device to access
+ * @lba_sector: Starting sector
+ * @num_sectors:
+ *                   Number of sectors to transfer
+ * @buffer:     Data buffer
+ * @write:      Is the a write. Default to a read
+ */
+static unsigned int octeon_cf_data_xfer(struct ata_device *dev,
+					unsigned char *buffer,
+					unsigned int buflen,
+					int rw)
+{
+	struct ata_port *ap		= dev->link->ap;
+	struct octeon_cf_data *ocd	= ap->dev->platform_data;
+	void __iomem *data_addr		= ap->ioaddr.data_addr;
+	unsigned int words;
+	unsigned int count;
+
+	/*
+	 * Odd lengths are not supported. We should always be a
+	 * multiple of 512.
+	 */
+	BUG_ON(buflen & 1);
+	if (ocd->is16bit) {
+		words = buflen / 2;
+		if (rw) {
+			count = 16;
+			while (words--) {
+				iowrite16(*(uint16_t *)buffer, data_addr);
+				buffer += sizeof(uint16_t);
+				/*
+				 * Every 16 writes do a read so the
+				 * bootbus FIFO doesn't fill up.
+				 */
+				if (--count == 0) {
+					ioread8(ap->ioaddr.altstatus_addr);
+					count = 16;
+				}
+			}
+		} else {
+			while (words--) {
+				*(uint16_t *)buffer = ioread16(data_addr);
+				buffer += sizeof(uint16_t);
+			}
+		}
+	} else {
+		/* 8-bit */
+		words = buflen;
+		if (rw) {
+			count = 16;
+			while (words--) {
+				iowrite8(*buffer, data_addr);
+				buffer++;
+				/*
+				 * Every 16 writes do a read so the
+				 * bootbus FIFO doesn't fill up.
+				 */
+				if (--count == 0) {
+					ioread8(ap->ioaddr.altstatus_addr);
+					count = 16;
+				}
+			}
+		} else
+			ioread8_rep(data_addr, buffer, words);
+	}
+	return buflen;
+}
+
+
+/**
+ * Read the taskfile for 16bit non-true_ide only.
+ */
+static void octeon_cf_tf_read16(struct ata_port *ap, struct ata_taskfile *tf)
+{
+	u16 blob;
+	/* The base of the registers is at ioaddr.data_addr. */
+	void __iomem *base = ap->ioaddr.data_addr;
+
+	blob = __raw_readw(base + 0xc);
+	tf->feature = blob >> 8;
+
+	blob = __raw_readw(base + 2);
+	tf->nsect = blob & 0xff;
+	tf->lbal = blob >> 8;
+
+	blob = __raw_readw(base + 4);
+	tf->lbam = blob & 0xff;
+	tf->lbah = blob >> 8;
+
+	blob = __raw_readw(base + 6);
+	tf->device = blob && 8;
+	tf->command = blob >> 8;
+
+	if (tf->flags & ATA_TFLAG_LBA48) {
+		if (likely(ap->ioaddr.ctl_addr)) {
+			iowrite8(tf->ctl | ATA_HOB, ap->ioaddr.ctl_addr);
+
+			blob = __raw_readw(base + 0xc);
+			tf->hob_feature = blob >> 8;
+
+			blob = __raw_readw(base + 2);
+			tf->hob_nsect = blob & 0xff;
+			tf->hob_lbal = blob >> 8;
+
+			blob = __raw_readw(base + 4);
+			tf->hob_lbam = blob & 0xff;
+			tf->hob_lbah = blob >> 8;
+
+			iowrite8(tf->ctl, ap->ioaddr.ctl_addr);
+			ap->last_ctl = tf->ctl;
+		} else
+			WARN_ON(1);
+	}
+}
+
+static u8 octeon_cf_check_status16(struct ata_port *ap)
+{
+	u16 blob;
+	void __iomem *base = ap->ioaddr.data_addr;
+
+	blob = __raw_readw(base + 6);
+	return blob >> 8;
+}
+
+static int octeon_cf_softreset16(struct ata_link *link, unsigned int *classes,
+				 unsigned long deadline)
+{
+	struct ata_port *ap = link->ap;
+	void __iomem *base = ap->ioaddr.data_addr;
+	int rc;
+	u8 err;
+
+	DPRINTK("about to softreset\n");
+	__raw_writew(ap->ctl, base + 0xe);
+	udelay(20);
+	__raw_writew(ap->ctl | ATA_SRST, base + 0xe);
+	udelay(20);
+	__raw_writew(ap->ctl, base + 0xe);
+
+	rc = ata_sff_wait_after_reset(link, 1, deadline);
+	if (rc) {
+		ata_link_printk(link, KERN_ERR, "SRST failed (errno=%d)\n", rc);
+		return rc;
+	}
+
+	/* determine by signature whether we have ATA or ATAPI devices */
+	classes[0] = ata_sff_dev_classify(&link->device[0], 1, &err);
+	DPRINTK("EXIT, classes[0]=%u [1]=%u\n", classes[0], classes[1]);
+	return 0;
+}
+
+/**
+ * Load the taskfile for 16bit non-true_ide only.  The device_addr is
+ * not loaded, we do this as part of octeon_cf_exec_command16.
+ */
+static void octeon_cf_tf_load16(struct ata_port *ap,
+				const struct ata_taskfile *tf)
+{
+	unsigned int is_addr = tf->flags & ATA_TFLAG_ISADDR;
+	/* The base of the registers is at ioaddr.data_addr. */
+	void __iomem *base = ap->ioaddr.data_addr;
+
+	if (tf->ctl != ap->last_ctl) {
+		iowrite8(tf->ctl, ap->ioaddr.ctl_addr);
+		ap->last_ctl = tf->ctl;
+		ata_wait_idle(ap);
+	}
+	if (is_addr && (tf->flags & ATA_TFLAG_LBA48)) {
+		__raw_writew(tf->hob_feature << 8, base + 0xc);
+		__raw_writew(tf->hob_nsect | tf->hob_lbal << 8, base + 2);
+		__raw_writew(tf->hob_lbam | tf->hob_lbah << 8, base + 4);
+		VPRINTK("hob: feat 0x%X nsect 0x%X, lba 0x%X 0x%X 0x%X\n",
+			tf->hob_feature,
+			tf->hob_nsect,
+			tf->hob_lbal,
+			tf->hob_lbam,
+			tf->hob_lbah);
+	}
+	if (is_addr) {
+		__raw_writew(tf->feature << 8, base + 0xc);
+		__raw_writew(tf->nsect | tf->lbal << 8, base + 2);
+		__raw_writew(tf->lbam | tf->lbah << 8, base + 4);
+		VPRINTK("feat 0x%X nsect 0x%X, lba 0x%X 0x%X 0x%X\n",
+			tf->feature,
+			tf->nsect,
+			tf->lbal,
+			tf->lbam,
+			tf->lbah);
+	}
+	ata_wait_idle(ap);
+}
+
+
+static void octeon_cf_dev_select(struct ata_port *ap, unsigned int device)
+{
+/*  There is only one device, do nothing. */
+	return;
+}
+
+/**
+ * Issue ATA command to host controller.  The device_addr is also sent
+ * as it must be written in a combined write with the command.
+ */
+static void octeon_cf_exec_command16(struct ata_port *ap,
+				const struct ata_taskfile *tf)
+{
+	/* The base of the registers is at ioaddr.data_addr. */
+	void __iomem *base = ap->ioaddr.data_addr;
+	u16 blob;
+
+	if (tf->flags & ATA_TFLAG_DEVICE) {
+		VPRINTK("device 0x%X\n", tf->device);
+		blob = tf->device;
+	} else
+		blob = 0;
+
+	DPRINTK("ata%u: cmd 0x%X\n", ap->print_id, tf->command);
+	blob |= (tf->command << 8);
+	__raw_writew(blob, base + 6);
+
+
+	ata_wait_idle(ap);
+}
+
+static u8 octeon_cf_irq_on(struct ata_port *ap)
+{
+	return 0;
+}
+static void octeon_cf_irq_clear(struct ata_port *ap)
+{
+	struct octeon_cf_data *ocd = ap->dev->platform_data;
+	cvmx_mio_boot_dma_intx_t mio_boot_dma_int;
+	DPRINTK("ENTER\n");
+
+	mio_boot_dma_int.u64 = 0;
+
+	/* Disable the interrupt.  */
+	cvmx_write_csr(CVMX_MIO_BOOT_DMA_INT_ENX(ocd->dma_engine),
+		       mio_boot_dma_int.u64);
+
+	/* Clear the DMA complete status. */
+	mio_boot_dma_int.s.done = 1;
+	cvmx_write_csr(CVMX_MIO_BOOT_DMA_INTX(ocd->dma_engine),
+		       mio_boot_dma_int.u64);
+
+}
+
+/**
+ * Get ready for a dma operation.  We do nothing, as all DMA
+ * operations are taken care of in octeon_cf_bmdma_start.
+ */
+void octeon_cf_qc_prep(struct ata_queued_cmd *qc)
+{
+}
+
+void octeon_cf_bmdma_setup(struct ata_queued_cmd *qc)
+{
+	struct ata_port *ap = qc->ap;
+	DPRINTK("ENTER\n");
+	/* issue r/w command */
+	qc->cursg = qc->sg;
+	ap->ops->sff_exec_command(ap, &qc->tf);
+}
+/**
+ * Start a DMA transfer that was already setup
+ *
+ * @qc:     Information about the DMA
+ */
+static void octeon_cf_bmdma_start(struct ata_queued_cmd *qc)
+{
+	struct octeon_cf_data *ocd = qc->ap->dev->platform_data;
+	cvmx_mio_boot_dma_cfgx_t mio_boot_dma_cfg;
+	cvmx_mio_boot_dma_intx_t mio_boot_dma_int;
+	struct scatterlist *sg;
+
+	VPRINTK("%d scatterlists\n", qc->n_elem);
+
+	/* Get the scatter list entry we need to DMA into */
+	sg = qc->cursg;
+	BUG_ON(!sg);
+
+	/*
+	 * Clear the DMA complete status.
+	 */
+	mio_boot_dma_int.u64 = 0;
+	mio_boot_dma_int.s.done = 1;
+	cvmx_write_csr(CVMX_MIO_BOOT_DMA_INTX(ocd->dma_engine),
+		       mio_boot_dma_int.u64);
+
+	/* Enable the interrupt.  */
+	cvmx_write_csr(CVMX_MIO_BOOT_DMA_INT_ENX(ocd->dma_engine),
+		       mio_boot_dma_int.u64);
+
+
+	/* Set the direction of the DMA */
+	mio_boot_dma_cfg.u64 = 0;
+	mio_boot_dma_cfg.s.en = 1;
+	mio_boot_dma_cfg.s.rw = ((qc->tf.flags & ATA_TFLAG_WRITE) != 0);
+
+	/*
+	 * Don't stop the DMA if the device deasserts DMARQ. Many compact
+	 * flashes deassert DMARQ for a short time between sectors. Instead of
+	 * stoppng and restarting the DMA, we'll let the hardware do it. If the
+	 * DMA is really stopped early due to an error condition, a later
+	 * timeout will force us to stop.
+	 */
+	mio_boot_dma_cfg.s.clr = 0;
+
+	/* Size is specified in 16bit words and minus one notation */
+	mio_boot_dma_cfg.s.size = sg_dma_len(sg) / 2 - 1;
+
+	/* We need to swap the high and low bytes of every 16 bits */
+	mio_boot_dma_cfg.s.swap8 = 1;
+
+	mio_boot_dma_cfg.s.adr = sg_dma_address(sg);
+
+	VPRINTK("%s %d bytes address=%p\n",
+		(mio_boot_dma_cfg.s.rw) ? "write" : "read", sg->length,
+		(void *)(unsigned long)mio_boot_dma_cfg.s.adr);
+
+	cvmx_write_csr(CVMX_MIO_BOOT_DMA_CFGX(ocd->dma_engine),
+		       mio_boot_dma_cfg.u64);
+}
+
+/**
+ * Get the status of the DMA engine. The results of this function
+ * must emulate the BMDMA engine expected by libata.
+ *
+ * @ap:     ATA port to check status on
+ *
+ * Returns BMDMA status bits
+ */
+static uint8_t octeon_cf_bmdma_status(struct ata_port *ap)
+{
+	struct octeon_cf_data *ocd = ap->dev->platform_data;
+	cvmx_mio_boot_dma_intx_t mio_boot_dma_int;
+	cvmx_mio_boot_dma_cfgx_t mio_boot_dma_cfg;
+	uint8_t result = 0;
+
+	mio_boot_dma_int.u64 =
+		cvmx_read_csr(CVMX_MIO_BOOT_DMA_INTX(ocd->dma_engine));
+	if (mio_boot_dma_int.s.done)
+		result |= ATA_DMA_INTR;
+
+	mio_boot_dma_cfg.u64 =
+		cvmx_read_csr(CVMX_MIO_BOOT_DMA_CFGX(ocd->dma_engine));
+	if (mio_boot_dma_cfg.s.en)
+		result |= ATA_DMA_ACTIVE;
+	else if (mio_boot_dma_cfg.s.size != 0xfffff)
+		result |= ATA_DMA_ERR;
+
+	VPRINTK("%s %s %s\n",
+		(result & ATA_DMA_INTR) ? "INTRQ" : "",
+		(result & ATA_DMA_ACTIVE) ? "Active" : "",
+		(result & ATA_DMA_ERR) ? "ERR" : "");
+
+	return result;
+}
+
+/**
+ * Stop a DMA that is in progress
+ *
+ * @qc:     Information about the DMA
+ */
+static void octeon_cf_bmdma_stop(struct ata_queued_cmd *qc)
+{
+	struct octeon_cf_data *ocd = qc->ap->dev->platform_data;
+	cvmx_mio_boot_dma_cfgx_t mio_boot_dma_cfg;
+	cvmx_mio_boot_dma_intx_t mio_boot_dma_int;
+
+	DPRINTK("ENTER\n");
+
+	/* Clear out the DMA config */
+	mio_boot_dma_cfg.u64 = 0;
+	mio_boot_dma_cfg.s.size = -1;
+	cvmx_write_csr(CVMX_MIO_BOOT_DMA_CFGX(ocd->dma_engine),
+		       mio_boot_dma_cfg.u64);
+
+	mio_boot_dma_int.u64 = 0;
+	/* Disable the interrupt.  */
+	cvmx_write_csr(CVMX_MIO_BOOT_DMA_INT_ENX(ocd->dma_engine),
+		       mio_boot_dma_int.u64);
+
+	/* Clear the DMA complete status */
+	mio_boot_dma_int.s.done = 1;
+	cvmx_write_csr(CVMX_MIO_BOOT_DMA_INTX(ocd->dma_engine),
+		       mio_boot_dma_int.u64);
+
+}
+
+/**
+ * Check if any queued commands have more DMAs, if so start the next
+ * transfer, else do standard handling.
+ */
+irqreturn_t octeon_cf_interrupt(int irq, void *dev_instance)
+{
+	struct ata_host *host = dev_instance;
+	struct octeon_cf_port *cf_port;
+	int i;
+	unsigned int handled = 0;
+	unsigned long flags;
+
+	spin_lock_irqsave(&host->lock, flags);
+
+	DPRINTK("ENTER\n");
+	for (i = 0; i < host->n_ports; i++) {
+		struct ata_port *ap;
+		struct ata_queued_cmd *qc;
+
+		ap = host->ports[i];
+		if (!ap || (ap->flags & ATA_FLAG_DISABLED))
+			continue;
+
+		qc = ata_qc_from_tag(ap, ap->link.active_tag);
+		if (qc && (!(qc->tf.flags & ATA_TFLAG_POLLING)) &&
+			(qc->flags & ATA_QCFLAG_ACTIVE)) {
+			u8 status = octeon_cf_bmdma_status(ap);
+			if ((status & ATA_DMA_INTR)
+			    && !(status & ATA_DMA_ACTIVE)
+			    && !sg_is_last(qc->cursg)) {
+				qc->cursg = sg_next(qc->cursg);
+				handled = 1;
+				octeon_cf_bmdma_start(qc);
+			} else {
+				status = ioread8(ap->ioaddr.altstatus_addr);
+				if (status & ATA_BUSY) {
+					/*
+					 * We are busy, try to handle
+					 * it later.  This is the DMA
+					 * finished interrupt, and it
+					 * could take a little while
+					 * for the card to be ready
+					 * for more commands.
+					 */
+					cf_port = (struct octeon_cf_port *)ap->private_data;
+					tasklet_schedule(&cf_port->delayed_irq_tasklet);
+					handled = 1;
+				} else
+					handled |= ata_sff_host_intr(ap, qc);
+			}
+		}
+	}
+	spin_unlock_irqrestore(&host->lock, flags);
+	DPRINTK("EXIT\n");
+	return IRQ_RETVAL(handled);
+}
+
+static void octeon_cf_delayed_irq(unsigned long data)
+{
+	struct ata_port *ap = (struct ata_port *)data;
+	struct octeon_cf_port *cf_port;
+	struct ata_host *host = ap->host;
+	struct ata_queued_cmd *qc;
+	unsigned long flags;
+	u8 status;
+
+	cf_port = (struct octeon_cf_port *)ap->private_data;
+
+	spin_lock_irqsave(&host->lock, flags);
+
+	status = ioread8(ap->ioaddr.altstatus_addr);
+	if (status & ATA_BUSY) {
+		/* Still busy, try again. */
+		cf_port = (struct octeon_cf_port *)ap->private_data;
+		tasklet_schedule(&cf_port->delayed_irq_tasklet);
+		goto out;
+	}
+
+	qc = ata_qc_from_tag(ap, ap->link.active_tag);
+	if (qc && (!(qc->tf.flags & ATA_TFLAG_POLLING)) &&
+	    (qc->flags & ATA_QCFLAG_ACTIVE))
+		ata_sff_host_intr(ap, qc);
+out:
+	spin_unlock_irqrestore(&host->lock, flags);
+}
+
+static struct ata_port_operations octeon_cf_ops = {
+	.inherits	= &ata_sff_port_ops,
+	.qc_prep	= octeon_cf_qc_prep,
+	.sff_dev_select	= octeon_cf_dev_select,
+	.sff_data_xfer	= octeon_cf_data_xfer,
+	.sff_irq_on	= octeon_cf_irq_on,
+	.sff_irq_clear	= octeon_cf_irq_clear,
+	.bmdma_setup	= octeon_cf_bmdma_setup,
+	.bmdma_start	= octeon_cf_bmdma_start,
+	.bmdma_stop	= octeon_cf_bmdma_stop,
+	.bmdma_status	= octeon_cf_bmdma_status,
+	.cable_detect	= ata_cable_40wire,
+	.set_piomode	= octeon_cf_set_piomode,
+	.set_dmamode	= octeon_cf_set_dmamode,
+};
+
+static int __devinit octeon_cf_probe(struct platform_device *pdev)
+{
+	struct resource *res_cs0, *res_cs1;
+
+	void __iomem *cs0;
+	void __iomem *cs1;
+	struct ata_host *host;
+	struct ata_port *ap;
+	struct octeon_cf_data *ocd;
+	int irq = 0;
+	irq_handler_t irq_handler = NULL;
+	void __iomem *base;
+	int is_true_ide = 0;
+	struct octeon_cf_port *cf_port;
+
+	res_cs0 = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	res_cs1 = platform_get_resource(pdev, IORESOURCE_MEM, 1);
+
+	if (!res_cs0 || !res_cs1)
+		return -EINVAL;
+
+	ocd = pdev->dev.platform_data;
+
+	cs0 = devm_ioremap_nocache(&pdev->dev, res_cs0->start,
+				   res_cs0->end - res_cs0->start + 1);
+	cs1 = devm_ioremap_nocache(&pdev->dev, res_cs1->start,
+				   res_cs0->end - res_cs1->start + 1);
+
+	if (!cs0 || !cs1)
+		return -ENOMEM;
+
+	cf_port = kzalloc(sizeof(*cf_port), GFP_KERNEL);
+	if (!cf_port)
+		return -ENOMEM;
+
+	/* Determine from availability of DMA if IDE mode or not */
+	if (ocd->dma_engine >= 0)
+		is_true_ide = 1;
+
+	/* allocate host */
+	host = ata_host_alloc(&pdev->dev, 1);
+	if (!host)
+		return -ENOMEM;
+
+	ap = host->ports[0];
+	ap->private_data = cf_port;
+	ap->ops = &octeon_cf_ops;
+	ap->pio_mask = 0x7f; /* Support PIO 0-6 */
+	ap->flags |= ATA_FLAG_MMIO | ATA_FLAG_NO_LEGACY
+		  | ATA_FLAG_NO_ATAPI | ATA_FLAG_PIO_POLLING;
+
+	tasklet_init(&cf_port->delayed_irq_tasklet, octeon_cf_delayed_irq,
+		     (unsigned long)ap);
+
+	base = cs0 + ocd->base_region_bias;
+	if (!ocd->is16bit) {
+		ap->ioaddr.cmd_addr	= base + ATA_REG_CMD;
+		ap->ioaddr.data_addr	= base + ATA_REG_DATA;
+		ap->ioaddr.error_addr	= base + ATA_REG_ERR;
+		ap->ioaddr.feature_addr	= base + ATA_REG_FEATURE;
+		ap->ioaddr.nsect_addr	= base + ATA_REG_NSECT;
+		ap->ioaddr.lbal_addr	= base + ATA_REG_LBAL;
+		ap->ioaddr.lbam_addr	= base + ATA_REG_LBAM;
+		ap->ioaddr.lbah_addr	= base + ATA_REG_LBAH;
+		ap->ioaddr.device_addr	= base + ATA_REG_DEVICE;
+		ap->ioaddr.status_addr	= base + ATA_REG_STATUS;
+		ap->ioaddr.command_addr	= base + ATA_REG_CMD;
+		ap->ioaddr.altstatus_addr = base + 0xe;
+		ap->ioaddr.ctl_addr	= base + 0xe;
+	} else if (is_true_ide) {
+		ap->ioaddr.cmd_addr	= base + (ATA_REG_CMD << 1) + 1;
+		ap->ioaddr.data_addr	= base + (ATA_REG_DATA << 1);
+		ap->ioaddr.error_addr	= base + (ATA_REG_ERR << 1) + 1;
+		ap->ioaddr.feature_addr	= base + (ATA_REG_FEATURE << 1) + 1;
+		ap->ioaddr.nsect_addr	= base + (ATA_REG_NSECT << 1) + 1;
+		ap->ioaddr.lbal_addr	= base + (ATA_REG_LBAL << 1) + 1;
+		ap->ioaddr.lbam_addr	= base + (ATA_REG_LBAM << 1) + 1;
+		ap->ioaddr.lbah_addr	= base + (ATA_REG_LBAH << 1) + 1;
+		ap->ioaddr.device_addr	= base + (ATA_REG_DEVICE << 1) + 1;
+		ap->ioaddr.status_addr	= base + (ATA_REG_STATUS << 1) + 1;
+		ap->ioaddr.command_addr	= base + (ATA_REG_CMD << 1) + 1;
+		ap->ioaddr.altstatus_addr = cs1 + (6 << 1) + 1;
+		ap->ioaddr.ctl_addr	= cs1 + (6 << 1) + 1;
+		if (use_cf_dma) {
+			ap->mwdma_mask	= 0x1f;	/* Support Multiword DMA 0-4 */
+			irq = platform_get_irq(pdev, 0);
+			irq_handler = octeon_cf_interrupt;
+		}
+	} else {
+		/* 16 bit but not true_ide */
+		octeon_cf_ops.softreset		= octeon_cf_softreset16;
+		octeon_cf_ops.sff_check_status	= octeon_cf_check_status16;
+		octeon_cf_ops.sff_tf_read	= octeon_cf_tf_read16;
+		octeon_cf_ops.sff_tf_load	= octeon_cf_tf_load16;
+		octeon_cf_ops.sff_exec_command	= octeon_cf_exec_command16;
+
+		ap->ioaddr.data_addr	= base + ATA_REG_DATA;
+		ap->ioaddr.nsect_addr	= base + ATA_REG_NSECT;
+		ap->ioaddr.lbal_addr	= base + ATA_REG_LBAL;
+		ap->ioaddr.ctl_addr	= base + 0xe;
+		ap->ioaddr.altstatus_addr = base + 0xe;
+	}
+
+	ata_port_desc(ap, "cmd %p ctl %p", base, ap->ioaddr.ctl_addr);
+
+
+	dev_printk(KERN_INFO, &pdev->dev,
+		   DRV_NAME " version " DRV_VERSION" %d bit%s.\n",
+		   (ocd->is16bit) ? 16 : 8,
+		   (is_true_ide) ? ", ide" : "");
+
+
+	return ata_host_activate(host, irq, irq_handler, 0, &octeon_cf_sht);
+}
+
+static struct platform_driver octeon_cf_driver = {
+	.probe		= octeon_cf_probe,
+	.driver		= {
+		.name	= "octeon-cf",
+		.owner	= THIS_MODULE,
+	},
+};
+
+static int __init octeon_cf_init(void)
+{
+	pr_info(DRV_NAME ": OCTEON bootbus compact flash driver\n");
+
+	return platform_driver_register(&octeon_cf_driver);
+}
+
+
+MODULE_AUTHOR("David Daney <ddaney@caviumnetworks.com>");
+MODULE_DESCRIPTION("low-level driver for Cavium OCTEON Compact Flash PATA");
+MODULE_LICENSE("GPL");
+MODULE_VERSION(DRV_VERSION);
+MODULE_ALIAS("platform:" DRV_NAME);
+
+module_init(octeon_cf_init);
