From: Tejun Heo <htejun@gmail.com>
Subject: Not-yet-working inic162x driver
Date: Tue, 7 Feb 2006 14:28:48 +0900
Message-ID: <20060207052848.GA6178@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from xproxy.gmail.com ([66.249.82.202]:60004 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750763AbWBGF2x (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 7 Feb 2006 00:28:53 -0500
Received: by xproxy.gmail.com with SMTP id s14so899336wxc
        for <linux-ide@vger.kernel.org>; Mon, 06 Feb 2006 21:28:53 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hello, guys.

This is not-yet-working inic162x driver.

* The document on the website[1] contains register descriptions but
  no programming model information or usage cases.

* In non-queued mode, the device acts pretty much like a traditional
  TF/BMDMA controller except that the controller doesn't follow BMDMA
  register/programming model.  By writing BMDMA callbacks and
  emulating BMDMA status register, standard libata routines can be
  used.

* I couldn't get TF to work properly.  It seems like it's doing
  something but not quite enough.  I suspect the reason is because the
  controller is not in legacy mode.  There's a legacy mode bit in
  port status register and I couldn't get that bit turned on.

I've already sent an email to Initio support for more information, but
if you know better contact channel, please let me know.

Debug codes/comments are marked with XXX's.  If you have the hardware
and some spare time, play with this thing.  :-)

diff --git a/drivers/scsi/Kconfig b/drivers/scsi/Kconfig
index 3c606cf..a989951 100644
--- a/drivers/scsi/Kconfig
+++ b/drivers/scsi/Kconfig
@@ -487,6 +487,15 @@ config SCSI_SATA_SVW
 
 	  If unsure, say N.
 
+config SCSI_SATA_INIC162X
+	tristate "Initio INIC162x SATA support (EXPERIMENTAL)"
+	depends on SCSI_SATA && PCI && EXPERIMENTAL
+	help
+	  This option enables support for the Initio INIC162x SATA
+	  controllers.
+
+	  If unsure, say N.
+
 config SCSI_ATA_PIIX
 	tristate "Intel PIIX/ICH SATA support"
 	depends on SCSI_SATA && PCI
diff --git a/drivers/scsi/Makefile b/drivers/scsi/Makefile
index 320e765..3cdf53e 100644
--- a/drivers/scsi/Makefile
+++ b/drivers/scsi/Makefile
@@ -125,6 +125,7 @@ obj-$(CONFIG_SCSI_IPR)		+= ipr.o
 obj-$(CONFIG_SCSI_IBMVSCSI)	+= ibmvscsi/
 obj-$(CONFIG_SCSI_SATA_AHCI)	+= libata.o ahci.o
 obj-$(CONFIG_SCSI_SATA_SVW)	+= libata.o sata_svw.o
+obj-$(CONFIG_SCSI_SATA_INIC162X) += libata.o sata_inic162x.o
 obj-$(CONFIG_SCSI_ATA_PIIX)	+= libata.o ata_piix.o
 obj-$(CONFIG_SCSI_SATA_PROMISE)	+= libata.o sata_promise.o
 obj-$(CONFIG_SCSI_SATA_QSTOR)	+= libata.o sata_qstor.o
diff --git a/drivers/scsi/sata_inic162x.c b/drivers/scsi/sata_inic162x.c
new file mode 100644
index 0000000..c869003
--- /dev/null
+++ b/drivers/scsi/sata_inic162x.c
@@ -0,0 +1,750 @@
+/*
+ *  sata_inic162x - Initio INIC-162x SATA
+ *
+ *  Maintained by:  Tejun Heo <htejun@gmail.com>
+ * 		    Please ALWAYS copy linux-ide@vger.kernel.org
+ * 		    on emails.
+ *
+ *  Copyright 2006  Tejun Heo
+ *
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2, or (at your option)
+ *  any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; see the file COPYING.  If not, write to
+ *  the Free Software Foundation, 675 Mass Ave, Cambridge, MA 02139, USA.
+ *
+ */
+
+/*
+ * XXX THIS DRIVER DOESN'T WORK YET.  PLEASE SEARCH FOR XXX.
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/pci.h>
+#include <linux/init.h>
+#include <linux/blkdev.h>
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <scsi/scsi_host.h>
+#include <linux/libata.h>
+#include <asm/io.h>
+
+#define DRV_NAME	"sata_inic162x"
+#define DRV_VERSION	"0.01"
+
+enum {
+	HOST_CTRL		= 0x7c,
+	HOST_STAT		= 0x7e,
+	HOST_IRQ_STAT		= 0xbc,
+	HOST_IRQ_MASK		= 0xbe,
+
+	PORT0_BASE		= 0x00,
+	PORT1_BASE		= 0x40,
+
+	/* Registers for ATA TF operation */
+	PORT_TF			= 0x00,
+	PORT_ALT_STAT		= 0x08,
+	PORT_IRQ_STAT		= 0x09,
+	PORT_IRQ_MASK		= 0x0a,
+	PORT_PRD_CTRL		= 0x0b,
+	PORT_PRD_ADDR		= 0x0c,
+	PORT_PRD_XFERLEN	= 0x10,
+
+	/* Registers for IDMA operation (for NCQ) */
+	PORT_IDMA_CTRL		= 0x14,
+	PORT_IDMA_STAT		= 0x16,
+	PORT_CPB_TBL		= 0x18,
+	PORT_POST_FIFO		= 0x1c,
+	PORT_POST_CNT		= 0x1d,
+	PORT_REPLY_FIFO		= 0x1e,
+	PORT_REPLY_CNT		= 0x1f,
+
+	PORT_SCR_BASE		= 0x20,
+	PORT_PM_SELECT		= 0x38,	/* upper 4bits */
+
+	/* HOST_CTRL bits */
+	HCTRL_MIREN		= (1 << 2),  /* mirroring enable */
+	HCTRL_GINTDIS		= (1 << 8),  /* global interrupt disable */
+	HCTRL_PWRDWN		= (1 << 12), /* PHY power off */
+	HCTRL_SOFTRST		= (1 << 13), /* Global reset (no phy reset) */
+	HCTRL_RPGSEL		= (1 << 15), /* Register page select */
+
+	/* HOST_IRQ_(STAT|MASK) bits */
+	HIRQ_PORT0		= (1 << 0),
+	HIRQ_PORT1		= (1 << 1),
+	HIRQ_SOFT		= (1 << 14),
+	HIRQ_GLOBAL		= (1 << 15), /* STAT only */
+
+	/* PORT_IRQ_(STAT|MASK) bits */
+	PIRQ_OFFLINE		= (1 << 0),  /* device unplugged */
+	PIRQ_ONLINE		= (1 << 1),  /* device plugged */
+	PIRQ_COMPLETE		= (1 << 2),  /* completion interrupt */
+	PIRQ_FATAL		= (1 << 3),  /* fatal error */
+	PIRQ_ATA		= (1 << 4),  /* ATA interrupt */
+	PIRQ_REPLY		= (1 << 5),  /* reply FIFO not empty */
+	PIRQ_PENDING		= (1 << 7),  /* port IRQ pending (STAT only) */
+
+	PIRQ_MASK		= PIRQ_OFFLINE | PIRQ_ONLINE | PIRQ_REPLY,
+
+	/* PORT_PRD_CTRL bits */
+	PRD_CTRL_START		= (1 << 0),
+	PRD_CTRL_WR		= (1 << 3),
+	PRD_CTRL_DMAEN		= (1 << 7),  /* DMA enable */
+
+	PRD_RSVD		= 0x76,
+
+	/* PORT_IDMA_CTRL bits */
+	IDMA_CTRL_UNFREEZE	= (1 << 1),  /* resume ADMA */
+	IDMA_CTRL_RST_ATA	= (1 << 2),  /* hardreset ATA bus */
+	IDMA_CTRL_ABORT		= (1 << 4),  /* abort all commands */
+	IDMA_CTRL_RST_IDMA	= (1 << 5),  /* reset IDMA machinary */
+	IDMA_CTRL_PAUSE		= (1 << 6),  /* pause IDMA */
+	IDMA_CTRL_GO		= (1 << 7),  /* gogogo */
+	IDMA_CTRL_ATA_IRQ_DIS	= (1 << 8),  /* ATA IRQ disable */
+	IDMA_CTRL_HWFRZEN	= (1 << 9),  /* enable HW freeze after error */
+
+	IDMA_CTRL_RSVD		= 0x6c00,    /* RSVD and MSLVSEL[01:00] */
+
+	/* misc */
+	INIC_NPORTS		= 2,
+};
+
+struct inic_cmd_block {
+	/* struct inic_cpb cpb; */	/* not yet */
+	struct ata_prd prd[LIBATA_MAX_PRD];
+};
+
+struct inic_port_priv {
+	struct inic_cmd_block *cmd_block;
+	dma_addr_t cmd_block_dma;
+	u8 dfl_prdctl, cached_prdctl;
+	u8 bmdma_status;
+};
+
+#define CB_PRD_OFFSET	offsetof(struct inic_cmd_block, prd)
+#define AP_MMIO(ap)	((void __iomem *)(ap)->ioaddr.cmd_addr - PORT_TF)
+
+static u32 inic_scr_read(struct ata_port *ap, unsigned sc_reg);
+static void inic_scr_write(struct ata_port *ap, unsigned sc_ret, u32 val);
+static void inic_bmdma_setup(struct ata_queued_cmd *qc);
+static void inic_bmdma_start(struct ata_queued_cmd *qc);
+static void inic_bmdma_stop(struct ata_queued_cmd *qc);
+static u8 inic_bmdma_status(struct ata_port *ap);
+static void inic_irq_clear(struct ata_port *ap);
+static irqreturn_t inic_interrupt(int irq, void *dev_instance, struct pt_regs *regs);
+static int inic_port_start(struct ata_port *ap);
+static void inic_port_stop(struct ata_port *ap);
+static int inic_init_one(struct pci_dev *pdev, const struct pci_device_id *ent);
+
+static const struct pci_device_id inic_pci_tbl[] = {
+	{ 0x1101, 0x1622, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
+	{ } /* terminate list */
+};
+
+static struct pci_driver inic_pci_driver = {
+	.name			= DRV_NAME,
+	.id_table		= inic_pci_tbl,
+	.probe			= inic_init_one,
+	.remove			= ata_pci_remove_one,
+};
+
+static struct scsi_host_template inic_sht = {
+	.module			= THIS_MODULE,
+	.name			= DRV_NAME,
+	.ioctl			= ata_scsi_ioctl,
+	.queuecommand		= ata_scsi_queuecmd,
+	.eh_strategy_handler	= ata_scsi_error,
+	.can_queue		= ATA_DEF_QUEUE,
+	.this_id		= ATA_SHT_THIS_ID,
+	.sg_tablesize		= LIBATA_MAX_PRD,
+	.max_sectors		= ATA_MAX_SECTORS,
+	.cmd_per_lun		= ATA_SHT_CMD_PER_LUN,
+	.emulated		= ATA_SHT_EMULATED,
+	.use_clustering		= ATA_SHT_USE_CLUSTERING,
+	.proc_name		= DRV_NAME,
+	.dma_boundary		= ATA_DMA_BOUNDARY,
+	.slave_configure	= ata_scsi_slave_config,
+	.bios_param		= ata_std_bios_param,
+};
+
+static const struct ata_port_operations inic_ops = {
+	.port_disable		= ata_port_disable,
+
+	.tf_load		= ata_tf_load,
+	.tf_read		= ata_tf_read,
+	.check_status		= ata_check_status,
+	.exec_command		= ata_exec_command,
+	.dev_select		= ata_std_dev_select,
+
+	.phy_reset		= sata_phy_reset,
+
+	.bmdma_setup            = inic_bmdma_setup,
+	.bmdma_start            = inic_bmdma_start,
+	.bmdma_stop		= inic_bmdma_stop,
+	.bmdma_status		= inic_bmdma_status,
+
+	.qc_prep		= ata_qc_prep,
+	.qc_issue		= ata_qc_issue_prot,
+
+	.eng_timeout		= ata_eng_timeout,
+
+	.irq_handler		= inic_interrupt,
+	.irq_clear		= inic_irq_clear,
+
+	.scr_read		= inic_scr_read,
+	.scr_write		= inic_scr_write,
+
+	.port_start		= inic_port_start,
+	.port_stop		= inic_port_stop,
+	.host_stop		= ata_host_stop,
+};
+
+static struct ata_port_info inic_port_info = {
+	.sht			= &inic_sht,
+	/* XXX - for the time being, SATA_RESET fails faster... */
+	.host_flags		= ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
+				  ATA_FLAG_MMIO | ATA_FLAG_SATA_RESET,
+	.pio_mask		= 0x1f,
+	.mwdma_mask		= 0x07,
+	.udma_mask		= 0x7f,
+	.port_ops		= &inic_ops,
+};
+
+static u32 inic_scr_read(struct ata_port *ap, unsigned sc_reg)
+{
+	void __iomem *scr_addr = (void __iomem *)ap->ioaddr.scr_addr;
+
+	if (sc_reg <= SCR_ACTIVE)
+		return readl(scr_addr + sc_reg * 4);
+	return -1U;
+}
+
+static void inic_scr_write(struct ata_port *ap, unsigned sc_reg, u32 val)
+{
+	void __iomem *scr_addr = (void __iomem *)ap->ioaddr.scr_addr;
+
+	if (sc_reg <= SCR_ACTIVE)
+		writel(val, scr_addr + sc_reg * 4);
+}
+
+static void inic_bmdma_setup(struct ata_queued_cmd *qc)
+{
+	struct ata_port *ap = qc->ap;
+	struct inic_port_priv *pp = ap->private_data;
+	void __iomem *base = AP_MMIO(ap);
+	int rw = qc->tf.flags & ATA_TFLAG_WRITE;
+	u32 len;
+
+	/* make sure device sees PRD table writes */
+	wmb();
+
+	/* load transfer length - is this necessary? */
+	if (is_atapi_taskfile(&qc->tf))
+		len = qc->nsect << 9;
+	else
+		len = qc->nbytes;
+	writel(len, base + PORT_PRD_XFERLEN);
+
+	/* specify data direction, make sure start bit is clear */
+	pp->cached_prdctl = pp->dfl_prdctl | PRD_CTRL_DMAEN;
+	if (!rw)
+		pp->cached_prdctl |= PRD_CTRL_WR;
+	writeb(pp->cached_prdctl, base + PORT_PRD_CTRL);
+
+	/* issue r/w command */
+	ap->ops->exec_command(ap, &qc->tf);
+}
+
+static void inic_bmdma_start(struct ata_queued_cmd *qc)
+{
+	struct ata_port *ap = qc->ap;
+	struct inic_port_priv *pp = ap->private_data;
+	void __iomem *base = AP_MMIO(ap);
+
+	/* start host DMA transaction */
+	pp->cached_prdctl |= PRD_CTRL_START;
+	writeb(pp->cached_prdctl, base + PORT_PRD_CTRL);
+
+	/* fake BMDMA status */
+	pp->bmdma_status |= ATA_DMA_ACTIVE;
+}
+
+static void inic_bmdma_stop(struct ata_queued_cmd *qc)
+{
+	struct ata_port *ap = qc->ap;
+	struct inic_port_priv *pp = ap->private_data;
+	void __iomem *base = AP_MMIO(ap);
+
+	/* clear START and DMAEN */
+	writeb(pp->dfl_prdctl, base + PORT_PRD_CTRL);
+
+	/* clear BMDMA status */
+	pp->bmdma_status &= ~(ATA_DMA_ACTIVE | ATA_DMA_ERR | ATA_DMA_INTR);
+}
+
+static u8 inic_bmdma_status(struct ata_port *ap)
+{
+	struct inic_port_priv *pp = ap->private_data;
+
+	return pp->bmdma_status;
+}
+
+static void inic_irq_clear(struct ata_port *ap)
+{
+	struct inic_port_priv *pp = ap->private_data;
+	void __iomem *base = AP_MMIO(ap);
+
+	/* How do I clear hardware IRQ?  Is reading port IRQ stat enough? */
+
+	/* XXX - not enough, it seems we need to read STATUS to clear
+	 * ATA interrupt, SError to clear ONLINE/OFFLINE interrupt,
+	 * etc... */
+	readb(base + PORT_IRQ_STAT);
+
+	pp->bmdma_status &= ~ATA_DMA_INTR;
+}
+
+/* XXX - interrupt handling path is not tested yet.  Don't expect it to work */
+static void inic_host_intr(struct ata_port *ap)
+{
+	struct inic_port_priv *pp = ap->private_data;
+	void __iomem *base = AP_MMIO(ap);
+	struct ata_queued_cmd *qc = ata_qc_from_tag(ap, ap->active_tag);
+	u8 irq_stat;
+
+	irq_stat = readb(base + PORT_IRQ_STAT);
+	printk("ata%u: irq_stat=0x%x\n", ap->id, irq_stat);
+	if (!(irq_stat & PIRQ_FATAL))
+		pp->bmdma_status &= ~ATA_DMA_ACTIVE;
+	else
+		pp->bmdma_status |= ATA_DMA_ERR;
+
+	pp->bmdma_status |= ATA_DMA_INTR;
+
+	if (qc)
+		ata_host_intr(ap, qc);
+}
+
+static irqreturn_t inic_interrupt(int irq, void *dev_instance, struct pt_regs *regs)
+{
+	struct ata_host_set *host_set = dev_instance;
+	void __iomem *regs_base = host_set->mmio_base;
+	u16 host_irq_stat;
+	int i, handled = 0;;
+
+	host_irq_stat = readw(regs_base + HOST_IRQ_STAT);
+
+	if (unlikely(!(host_irq_stat & HIRQ_GLOBAL)))
+		goto out;
+
+	spin_lock(&host_set->lock);
+
+	for (i = 0; i < INIC_NPORTS; i++) {
+		if (host_irq_stat & (1 << i)) {
+			struct ata_port *ap = host_set->ports[i];
+			if (ap && !(ap->flags & ATA_FLAG_PORT_DISABLED)) {
+				inic_host_intr(ap);
+				handled++;
+			} else {
+				u8 irq_stat;
+				/* XXX - Clear only ATA interrupt for
+				 * the time being. */
+				irq_stat = readb(AP_MMIO(ap) + PORT_IRQ_STAT);
+				readb(AP_MMIO(ap) + PORT_TF + ATA_REG_STATUS);
+				dev_printk(KERN_ERR, host_set->dev,
+					   "interrupt from disabled port %d (0x%x)\n", i, irq_stat);
+			}
+		}
+	}
+
+	spin_unlock(&host_set->lock);
+
+ out:
+	return IRQ_RETVAL(handled);
+}
+
+/* XXX */
+static void dump_port(struct ata_port *ap)
+{
+	void __iomem *regs_base = ap->host_set->mmio_base;
+	void __iomem *base = AP_MMIO(ap);
+	u16 ga, gb, a, b, gi;
+	u8 f0, f1, pi;
+	void *cpb;
+
+	ga = readw(regs_base + HOST_CTRL);
+	gb = readw(regs_base + HOST_STAT);
+	gi = readw(regs_base + HOST_IRQ_STAT);
+	a = readw(base + PORT_IDMA_CTRL);
+	b = readw(base + PORT_IDMA_STAT);
+	cpb = (void *)readl(base + PORT_CPB_TBL);
+	f0 = readb(base + PORT_POST_CNT);
+	f1 = readb(base + PORT_REPLY_CNT);
+	pi = readb(base + PORT_IRQ_STAT);
+
+	printk("XXX ata%u: gctrl=0x%x gstat=0x%x pctrl=0x%x pstat=0x%x cpb=%p %d:%d\n",
+	       ap->id, ga, gb, a, b, cpb, f0, f1);
+	printk("XXX ata%u: girq=0x%x pirq=0x%x\n", ap->id, gi, pi);
+}
+
+static void dump_tf(struct ata_port *ap)
+{
+	struct ata_taskfile tf;
+	memset(&tf, 0, sizeof(tf));
+	ap->ops->tf_read(ap, &tf);
+	printk("XXX %02x:%02x:%02x:%02x:%02x %02x:%02x:%02x:%02x:%02x %02x %02x\n",
+	       tf.feature, tf.nsect, tf.lbal, tf.lbam, tf.lbah,
+	       tf.hob_feature, tf.hob_nsect, tf.hob_lbal, tf.hob_lbam,
+	       tf.hob_lbah, tf.device, tf.command);
+}
+/* XXX */
+
+static int inic_port_start(struct ata_port *ap)
+{
+	struct device *dev = ap->host_set->dev;
+	void __iomem *regs_base = ap->host_set->mmio_base;
+	void __iomem *base = AP_MMIO(ap);
+	struct inic_port_priv *pp = NULL;
+	struct inic_cmd_block *cb = NULL;
+	dma_addr_t cb_dma;
+	int rc;
+	u32 tmp;
+
+	/* Alloc resources */
+	rc = -ENOMEM;
+	pp = kzalloc(sizeof(*pp), GFP_KERNEL);
+	if (!pp)
+		goto err_out;
+
+	cb = dma_alloc_coherent(dev, sizeof(*cb), &cb_dma, GFP_KERNEL);
+	if (!cb)
+		goto err_out;
+	memset(cb, 0, sizeof(*cb));
+
+	rc = ata_pad_alloc(ap, dev);
+	if (rc)
+		goto err_out;
+
+	/* XXX */
+	printk("XXX POST GLOBAL RESET\n");
+	dump_tf(ap);
+	dump_port(ap);
+	/* XXX */
+
+	/* Stop BMDMA and reset IDMA */
+	tmp = readb(base + PORT_PRD_CTRL);
+	tmp &= PRD_RSVD;
+	writeb(tmp, base + PORT_PRD_CTRL);
+
+	tmp = readw(base + PORT_IDMA_CTRL);
+	tmp &= IDMA_CTRL_RSVD;
+	writew(tmp | IDMA_CTRL_RST_IDMA, base + PORT_IDMA_CTRL);
+	readw(base + PORT_IDMA_CTRL);	/* flush */
+	msleep(1);			/* spec says 1us, well... */
+	writew(tmp, base + PORT_IDMA_CTRL);
+
+	/* Setup PRD address */
+	writel(cb_dma + CB_PRD_OFFSET, base + PORT_PRD_ADDR);
+
+	/* Setup IRQ mask and enable IRQ for this port */
+	writeb(PIRQ_MASK, base + PORT_IRQ_MASK);
+
+	tmp = readw(regs_base + HOST_IRQ_MASK);
+	if (ap->port_no == 0)
+		tmp &= ~HIRQ_PORT0;
+	else
+		tmp &= ~HIRQ_PORT1;
+	writew(tmp, regs_base + HOST_IRQ_MASK);
+
+	/* Initialize data structures */
+	pp->bmdma_status = 0x20; /* Drive 0 DMA capable */
+	pp->cmd_block = cb;
+	pp->cmd_block_dma = cb_dma;
+	pp->dfl_prdctl = readb(base + PORT_PRD_CTRL);
+	ap->private_data = pp;
+
+	ap->prd = cb->prd;
+	ap->prd_dma = cb_dma + CB_PRD_OFFSET;
+
+	/* XXX */
+	printk("XXX HERE0\n");
+	writeb(0xde, base + PORT_TF + ATA_REG_NSECT);
+	writeb(0xad, base + PORT_TF + ATA_REG_LBAL);
+	writeb(0xbe, base + PORT_TF + ATA_REG_LBAM);
+	writeb(0xef, base + PORT_TF + ATA_REG_LBAH);
+	writeb(0x69, base + PORT_TF + ATA_REG_FEATURE);
+	dump_tf(ap);
+	dump_port(ap);
+
+	/*
+	 * XXX - this is where I got stuck.  I couldn't get ATA TF
+	 * mode working.
+	 *
+	 * STANDBYNOW1 actually gets issued and the drive spins down.
+	 * BUT no interrupt is generated.
+	 *
+	 * SRST seems to do something but drive never gets out of BUSY
+	 * status.
+	 *
+	 * SATA RESET also seems to do something but TF registers are
+	 * not changed after it.  (TF regs doesn't change at all, to
+	 * verify, load TF regs with arbitrary values.
+	 *
+	 * PORT RESET seems to perform reset and it loads part of
+	 * signature into TF regs.  But error register is 0xff after
+	 * PORT RESET.
+	 *
+	 * PORT_IDMA_STAT's legacy mode bit is off all the time.  I
+	 * think this is why TF regs are not behaving as expected.  If
+	 * you find out how to turn on legacy mode, please let me
+	 * know.
+	 *
+	 * Contrary to the document, host reset does seem to reset the
+	 * PHYs and loads part of classification signature into TF
+	 * registers (again, error register is off).
+	 *
+	 * Lying about error register make libata continue to issue
+	 * IDENTIFY but it times out.
+	 */
+
+/*	printk("issuing STANDBYNOW1\n");
+	writeb(ATA_CMD_STANDBYNOW1, base + PORT_TF + ATA_REG_CMD);
+	printk("sleeping 3secss\n");
+	msleep(3000);*/
+/*	printk("SRST...\n");
+	writeb(ap->ctl | ATA_SRST, base + PORT_ALT_STAT);
+	msleep(100);
+	writeb(ap->ctl, base + PORT_ALT_STAT);
+	msleep(3000);*/
+/*	printk("SATA RESET\n");
+	scr_write_flush(ap, SCR_CONTROL, 0x301);
+	msleep(1);
+	scr_write_flush(ap, SCR_CONTROL, 0x300);
+	msleep(3000);*/
+	printk("PORT RESET\n");
+	writew(tmp | IDMA_CTRL_RST_ATA, base + PORT_IDMA_CTRL);
+	msleep(100);
+	writew(tmp, base + PORT_IDMA_CTRL);
+	msleep(3000);
+
+	dump_tf(ap);
+	dump_port(ap);
+	/* XXX */
+
+	return 0;
+
+ err_out:
+	if (cb)
+		dma_free_coherent(dev, sizeof(*cb), cb, cb_dma);
+	if (pp)
+		kfree(pp);
+	return rc;
+}
+
+static void inic_port_stop(struct ata_port *ap)
+{
+	struct device *dev = ap->host_set->dev;
+	void __iomem *regs_base = ap->host_set->mmio_base;
+	struct inic_port_priv *pp = ap->private_data;
+	u32 tmp;
+
+	/* disable IRQ for this port */
+	tmp = readw(regs_base + HOST_IRQ_MASK);
+	if (ap->port_no == 0)
+		tmp |= HIRQ_PORT0;
+	else
+		tmp |= HIRQ_PORT1;
+	writew(tmp, regs_base + HOST_IRQ_MASK);
+
+	/* free resources */
+	ata_pad_free(ap, dev);
+	dma_free_coherent(dev, sizeof(*pp->cmd_block),
+			  pp->cmd_block, pp->cmd_block_dma);
+	kfree(pp);
+}
+
+static int inic_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
+{
+	static int printed_version = 0;
+	int mmio_idx, i, rc;
+	struct ata_probe_ent *probe_ent = NULL;
+	void __iomem *regs_base = NULL;
+	struct ata_port_info *pinfo;
+	struct ata_ioports *port;
+	u16 ctrl;
+	u32 tmp;
+
+	if (!printed_version++)
+		dev_printk(KERN_DEBUG, &pdev->dev, "version " DRV_VERSION "\n");
+
+	rc = pci_enable_device(pdev);
+	if (rc)
+		return rc;
+
+	rc = pci_request_regions(pdev, DRV_NAME);
+	if (rc)
+		goto out_disable;
+
+	/*
+	 * If the controller is configured for Cardbus mode, BAR[0-1]
+	 * map to BAR[4-5] of normal PCI mode and the rest are
+	 * reserved.
+	 */
+	mmio_idx = 5;
+	if (pci_resource_flags(pdev, 1) & IORESOURCE_MEM)
+		mmio_idx = 1;
+
+	if (!(pci_resource_flags(pdev, mmio_idx) & IORESOURCE_MEM)) {
+		dev_printk(KERN_ERR, &pdev->dev,
+			   "invalid mmio area, flags %lx size %lu\n",
+			   pci_resource_flags(pdev, mmio_idx),
+			   pci_resource_len(pdev, mmio_idx));
+		rc = -EINVAL;
+		goto out_free;
+	}
+
+	rc = -ENOMEM;
+	/* ioremap mmio registers */
+	regs_base = ioremap(pci_resource_start(pdev, mmio_idx),
+			    pci_resource_len(pdev, mmio_idx));
+	if (!regs_base)
+		goto out_free;
+
+	/* allocate & init probe_ent */
+	probe_ent = kzalloc(sizeof(*probe_ent), GFP_KERNEL);
+	if (!probe_ent)
+		goto out_free;
+
+	probe_ent->dev = &pdev->dev;
+	INIT_LIST_HEAD(&probe_ent->node);
+
+	pinfo = &inic_port_info;
+	port = probe_ent->port;
+
+	probe_ent->sht		= pinfo->sht;
+	probe_ent->host_flags	= pinfo->host_flags;
+	probe_ent->pio_mask	= pinfo->pio_mask;
+	probe_ent->udma_mask	= pinfo->udma_mask;
+	probe_ent->port_ops	= pinfo->port_ops;
+	probe_ent->n_ports	= INIC_NPORTS;
+
+	probe_ent->irq = pdev->irq;
+	probe_ent->irq_flags = SA_SHIRQ;
+	probe_ent->mmio_base = regs_base;
+
+	for (i = 0; i < INIC_NPORTS; i++) {
+		unsigned long base = (unsigned long)regs_base;
+
+		if (i == 0)
+			base += PORT0_BASE;
+		else
+			base += PORT1_BASE;
+		
+		port[i].cmd_addr = base + PORT_TF;
+		ata_std_ports(&port[i]);
+		port[i].altstatus_addr = base + PORT_ALT_STAT;
+		port[i].ctl_addr = base + PORT_ALT_STAT;
+		port[i].scr_addr = base + PORT_SCR_BASE;
+	}
+
+	/* Set dma_mask.  This devices doesn't support 64bit addressing. */
+	rc = pci_set_dma_mask(pdev, DMA_32BIT_MASK);
+	if (rc) {
+		dev_printk(KERN_ERR, &pdev->dev,
+			   "32-bit DMA enable failed\n");
+		goto out_free;
+	}
+
+	rc = pci_set_consistent_dma_mask(pdev, DMA_32BIT_MASK);
+	if (rc) {
+		dev_printk(KERN_ERR, &pdev->dev,
+			   "32-bit consistent DMA enable failed\n");
+		goto out_free;
+	}
+
+	/*
+	 * Configure the controller
+	 */
+
+	/* Set sensible HOST_CTRL and turn global IRQ off */
+	ctrl = readw(regs_base + HOST_CTRL);
+	ctrl &= ~(HCTRL_MIREN | HCTRL_PWRDWN | HCTRL_RPGSEL);
+	ctrl |= HCTRL_GINTDIS;
+	writew(ctrl, regs_base + HOST_CTRL);
+
+	/* Mask irqs */
+	tmp = readw(regs_base + HOST_IRQ_MASK);
+	tmp |= HIRQ_PORT0 | HIRQ_PORT1 | HIRQ_SOFT;
+	writew(tmp, regs_base + HOST_IRQ_MASK);
+
+	/* Soft reset the controller */
+	ctrl |= HCTRL_SOFTRST;
+	writew(ctrl, regs_base + HOST_CTRL);
+
+	/*
+	 * Spec says reset duration is 3 PCI clocks, be generous and
+	 * give it 10ms.
+	 */
+	for (i = 0; i < 10; i++) {
+		msleep(1);
+		ctrl = readw(regs_base + HOST_CTRL);
+		if (!(ctrl & HCTRL_SOFTRST))
+			break;
+	}
+
+	if (ctrl & HCTRL_SOFTRST) {
+		dev_printk(KERN_ERR, &pdev->dev,
+			   "failed to reset the controller\n");
+		rc = -EIO;
+		goto out_free;
+	}
+
+	/* Turn on global IRQ */
+	ctrl &= ~HCTRL_GINTDIS;
+	writew(ctrl, regs_base + HOST_CTRL);
+
+	pci_set_master(pdev);
+
+	/* FIXME: check ata_device_add return value */
+	ata_device_add(probe_ent);
+
+	kfree(probe_ent);
+	return 0;
+
+ out_free:
+	if (regs_base)
+		iounmap(regs_base);
+	kfree(probe_ent);
+	pci_release_regions(pdev);
+ out_disable:
+	pci_disable_device(pdev);
+	return rc;
+}
+
+static int __init inic_init(void)
+{
+	return pci_module_init(&inic_pci_driver);
+}
+
+static void __exit inic_exit(void)
+{
+	pci_unregister_driver(&inic_pci_driver);
+}
+
+MODULE_AUTHOR("Tejun Heo");
+MODULE_DESCRIPTION("Initio INIC-162X SATA low-level driver");
+MODULE_LICENSE("GPL");
+MODULE_DEVICE_TABLE(pci, inic_pci_tbl);
+
+module_init(inic_init);
+module_exit(inic_exit);
