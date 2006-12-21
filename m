From: Manfred Gruber <manfred.gruber@contec.at>
Subject: ep93xx pata problem
Date: Thu, 21 Dec 2006 08:11:01 +0100
Message-ID: <200612210811.01289.manfred.gruber@contec.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from 85-126-107-146.static.sdsl-line.inode.at ([85.126.107.146]:3279
	"EHLO mail.contec.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422812AbWLUH1q (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 21 Dec 2006 02:27:46 -0500
Received: from comixs.contec-int.at (unknown [192.168.1.250])
	by mail.contec.at (Firewall Mailer Daemon) with ESMTP id 6CB0CC0873
	for <linux-ide@vger.kernel.org>; Thu, 21 Dec 2006 08:10:58 +0100 (CET)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hi !

I am new on the list. I try to get ep93xx pata driver from Alessandro Z=
ummo=20
running on 2.6.20-rc1. The driver supports for now no DMA but i think P=
IO or=20
MMIO, what is the difference? You see I am a newbe to ata ... sorry

The problem is that ata_interrupt comes always and the system hangs: =20

I have added some printks to ata_interrupt:

ep93xx_pata_probe: : ioremap to 0xc685a000=20
pata_ep93xx pata_ep93xx: version 0.1
ata_device_add: ENTER
ata_port_add: ENTER
ata_port_start: prd alloc, virt ffc97000, dma 5d9a000
ata1: PATA max PIO4 cmd 0xC685A002 ctl 0xC685A019 bmdma 0x0 irq 40
ata_device_add: probe begin
scsi0 : pata_ep93xx
ata_device_add: ata1: bus probe begin
ata_bus_reset: ENTER, host 1, port 0
ata_bus_softreset: ata1: bus reset via SRST
ata_dev_classify: found ATA device by sig
ata_bus_reset: EXIT
ata1: ata_dev_select: ENTER, ata1: device 0, wait 1
ata1: ata_dev_select: ENTER, ata1: device 0, wait 1
ep93xx_exec_command: ata1: cmd 0xEC
ATA INTERRUPT 1=20
ATA INTERRUPT 2=20
 ** ap->flags 18=20
ATA INTERRUPT 3=20
if (qc)
(qc->tf.flags & ATA_TFLAG_POLLING) qc->tf.flags 40=20
(qc->flags & ATA_QCFLAG_ACTIVE)

--> It looks like that the ATA_TFLAG_POLLING is alsways set. So Interru=
pt=20
alsways returns 0 because it is not handled.

--> Does someone have any information about that for me what i can do o=
r is=20
there a problem in the driver ?

Thanks a lot for help, happy x-mas, regards manfred

attached is the driver:

-- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6/drivers/ata/pata_ep93xx.c	2006-12-20 16:51:02.192065229 +=
0100
@@ -0,0 +1,378 @@
+/*
+ * EP93XX PATA controller driver.
+ * Copyright (c) 2006 Tower Technologies
+ * Author: Alessandro Zummo <a.zummo@towertech.it>
+ *
+ * An ATA driver to handle the embedded IDE controller
+ * of the Cirrus Logic EP93XX.
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/libata.h>
+#include <linux/irq.h>
+#include <scsi/scsi_host.h>
+#include <linux/platform_device.h>
+
+#define DRV_NAME	"pata_ep93xx"
+#define DRV_VERSION	"0.1"
+
+struct ep93xx_pata_data {
+	void __iomem *mem;
+	int irq;
+};
+
+struct ata_host *ep93xx_host;
+
+static inline void ep93xx_toggle_wr(register u32 ctrl)
+{
+	ctrl &=3D ~(EP93XX_IDE_CTRL_DIOWn);
+	__raw_writel(ctrl, EP93XX_IDE_CTRL);
+
+	ctrl |=3D EP93XX_IDE_CTRL_DIOWn;
+	__raw_writel(ctrl, EP93XX_IDE_CTRL);
+}
+
+static inline void ep93xx_toggle_rd(register u32 ctrl)
+{
+	ctrl &=3D ~(EP93XX_IDE_CTRL_DIORn);
+	__raw_writel(ctrl, EP93XX_IDE_CTRL);
+
+	ctrl |=3D EP93XX_IDE_CTRL_DIORn;
+	__raw_writel(ctrl, EP93XX_IDE_CTRL);
+}
+
+#define ep93xx_write_addr(ctrl,addr) { \
+	ctrl =3D (ctrl & ~(EP93XX_IDE_CTRL_DA_CS_MASK)) | EP93XX_IDE_CTRL_DA_=
CS(addr);=20
\
+	__raw_writel(ctrl, EP93XX_IDE_CTRL); }
+
+static inline void ep93xx_writew(register u16 value, volatile void __i=
omem=20
*p)
+{
+	register u32 ctrl =3D __raw_readl(EP93XX_IDE_CTRL);
+	ep93xx_write_addr(ctrl, (unsigned long) p);
+	__raw_writel(value, EP93XX_IDE_DATAOUT);
+	ep93xx_toggle_wr(ctrl);
+}
+
+#define ep93xx_writeb(value,addr) ep93xx_writew(value,addr)
+
+static inline unsigned short ep93xx_readw(volatile void __iomem *p)
+{
+	register u32 ctrl =3D __raw_readl(EP93XX_IDE_CTRL);
+
+	ep93xx_write_addr(ctrl, (unsigned long) p);
+	ep93xx_toggle_rd(ctrl);
+	return __raw_readl(EP93XX_IDE_DATAIN);
+}
+
+#define ep93xx_readb(addr) ep93xx_readw(addr)
+
+static unsigned long ep93xx_mode_filter(const struct ata_port *ap,
+				 struct ata_device *adev, unsigned long mask)
+{
+	return mask;
+}
+
+static void ep93xx_set_mode(struct ata_port *ap)
+{
+	int i;
+	for (i =3D 0; i < ATA_MAX_DEVICES; i++) {
+		struct ata_device *dev =3D &ap->device[i];
+		if (ata_dev_enabled(dev)) {
+			dev->pio_mode =3D XFER_PIO_0;
+			dev->xfer_mode =3D XFER_PIO_0;
+			dev->xfer_shift =3D ATA_SHIFT_PIO;
+			dev->flags |=3D ATA_DFLAG_PIO;
+		}
+	}
+}
+
+static void ep93xx_phy_reset(struct ata_port *ap)
+{
+	ap->cbl =3D ATA_CBL_PATA40;
+	ata_port_probe(ap);
+	ata_bus_reset(ap);
+}
+
+static void ep93xx_irq_clear(struct ata_port *ap)
+{
+}
+
+static void ep93xx_tf_load(struct ata_port *ap, const struct ata_taskf=
ile=20
*tf)
+{
+	struct ata_ioports *ioaddr =3D &ap->ioaddr;
+	unsigned int is_addr =3D tf->flags & ATA_TFLAG_ISADDR;
+
+	if (tf->ctl !=3D ap->last_ctl) {
+		ep93xx_writeb(tf->ctl, (void __iomem *) ap->ioaddr.ctl_addr);
+		ap->last_ctl =3D tf->ctl;
+		ata_wait_idle(ap);
+	}
+
+	if (is_addr && (tf->flags & ATA_TFLAG_LBA48)) {
+		ep93xx_writeb(tf->hob_feature, (void __iomem *) ioaddr->feature_addr=
);
+		ep93xx_writeb(tf->hob_nsect, (void __iomem *) ioaddr->nsect_addr);
+		ep93xx_writeb(tf->hob_lbal, (void __iomem *) ioaddr->lbal_addr);
+		ep93xx_writeb(tf->hob_lbam, (void __iomem *) ioaddr->lbam_addr);
+		ep93xx_writeb(tf->hob_lbah, (void __iomem *) ioaddr->lbah_addr);
+		VPRINTK("hob: feat 0x%X nsect 0x%X, lba 0x%X 0x%X 0x%X\n",
+			tf->hob_feature,
+			tf->hob_nsect,
+			tf->hob_lbal,
+			tf->hob_lbam,
+			tf->hob_lbah);
+	}
+
+	if (is_addr) {
+		ep93xx_writeb(tf->feature, (void __iomem *) ioaddr->feature_addr);
+		ep93xx_writeb(tf->nsect, (void __iomem *) ioaddr->nsect_addr);
+		ep93xx_writeb(tf->lbal, (void __iomem *) ioaddr->lbal_addr);
+		ep93xx_writeb(tf->lbam, (void __iomem *) ioaddr->lbam_addr);
+		ep93xx_writeb(tf->lbah, (void __iomem *) ioaddr->lbah_addr);
+		VPRINTK("feat 0x%X nsect 0x%X lba 0x%X 0x%X 0x%X\n",
+			tf->feature,
+			tf->nsect,
+			tf->lbal,
+			tf->lbam,
+			tf->lbah);
+	}
+
+	if (tf->flags & ATA_TFLAG_DEVICE) {
+		ep93xx_writeb(tf->device, (void __iomem *) ioaddr->device_addr);
+		VPRINTK("device 0x%X\n", tf->device);
+	}
+
+	ata_wait_idle(ap);
+}
+
+static void ep93xx_tf_read(struct ata_port *ap, struct ata_taskfile *t=
f)
+{
+	struct ata_ioports *ioaddr =3D &ap->ioaddr;
+
+	tf->command =3D ap->ops->check_status(ap);
+	tf->feature =3D ep93xx_readb((void __iomem *)ioaddr->error_addr);
+	tf->nsect =3D ep93xx_readb((void __iomem *)ioaddr->nsect_addr);
+	tf->lbal =3D ep93xx_readb((void __iomem *)ioaddr->lbal_addr);
+	tf->lbam =3D ep93xx_readb((void __iomem *)ioaddr->lbam_addr);
+	tf->lbah =3D ep93xx_readb((void __iomem *)ioaddr->lbah_addr);
+	tf->device =3D ep93xx_readb((void __iomem *)ioaddr->device_addr);
+
+	if (tf->flags & ATA_TFLAG_LBA48) {
+		ep93xx_writeb(tf->ctl | ATA_HOB, (void __iomem *) ap->ioaddr.ctl_add=
r);
+		tf->hob_feature =3D ep93xx_readb((void __iomem *)ioaddr->error_addr)=
;
+		tf->hob_nsect =3D ep93xx_readb((void __iomem *)ioaddr->nsect_addr);
+		tf->hob_lbal =3D ep93xx_readb((void __iomem *)ioaddr->lbal_addr);
+		tf->hob_lbam =3D ep93xx_readb((void __iomem *)ioaddr->lbam_addr);
+		tf->hob_lbah =3D ep93xx_readb((void __iomem *)ioaddr->lbah_addr);
+	}
+}
+
+static u8 ep93xx_check_status(struct ata_port *ap)
+{
+	return ep93xx_readb((void __iomem *) ap->ioaddr.status_addr);
+}
+
+static u8 ep93xx_check_altstatus(struct ata_port *ap)
+{
+	return ep93xx_readb((void __iomem *)ap->ioaddr.altstatus_addr);
+}
+
+static void ep93xx_exec_command(struct ata_port *ap, const struct=20
ata_taskfile *tf)
+{
+	DPRINTK("ata%u: cmd 0x%X\n", ap->id, tf->command);
+
+	ep93xx_writeb(tf->command, (void __iomem *) ap->ioaddr.command_addr);
+	ata_pause(ap);
+}
+
+static void ep93xx_data_xfer(struct ata_device *adev, unsigned char *b=
uf,
+			     unsigned int buflen, int write_data)
+{
+	unsigned int i;
+	unsigned int words =3D buflen >> 1;
+	u16 *buf16 =3D (u16 *) buf;
+	struct ata_port *ap =3D adev->ap;
+	void __iomem *mmio =3D (void __iomem *)ap->ioaddr.data_addr;
+
+	/* Transfer multiple of 2 bytes */
+	if (write_data) {
+		for (i =3D 0; i < words; i++)
+			ep93xx_writew(le16_to_cpu(buf16[i]), mmio);
+	} else {
+		for (i =3D 0; i < words; i++)
+			buf16[i] =3D cpu_to_le16(ep93xx_readw(mmio));
+	}
+
+	/* Transfer trailing 1 byte, if any. */
+	if (unlikely(buflen & 0x01)) {
+		u16 align_buf[1] =3D { 0 };
+		unsigned char *trailing_buf =3D buf + buflen - 1;
+
+		if (write_data) {
+			memcpy(align_buf, trailing_buf, 1);
+			ep93xx_writew(le16_to_cpu(align_buf[0]), mmio);
+		} else {
+			align_buf[0] =3D cpu_to_le16(ep93xx_readw(mmio));
+			memcpy(trailing_buf, align_buf, 1);
+		}
+	}
+}
+
+static struct scsi_host_template ep93xx_sht =3D {
+	.module			=3D THIS_MODULE,
+	.name			=3D DRV_NAME,
+	.ioctl			=3D ata_scsi_ioctl,
+	.queuecommand		=3D ata_scsi_queuecmd,
+	.can_queue		=3D ATA_DEF_QUEUE,
+	.this_id		=3D ATA_SHT_THIS_ID,
+	.sg_tablesize		=3D LIBATA_MAX_PRD,
+	.max_sectors		=3D ATA_MAX_SECTORS,
+	.cmd_per_lun		=3D ATA_SHT_CMD_PER_LUN,
+	.emulated		=3D ATA_SHT_EMULATED,
+	.use_clustering		=3D ATA_SHT_USE_CLUSTERING,
+	.proc_name		=3D DRV_NAME,
+	.dma_boundary		=3D ATA_DMA_BOUNDARY,
+	.slave_configure	=3D ata_scsi_slave_config,
+	.bios_param		=3D ata_std_bios_param,
+};
+
+static struct ata_port_operations ep93xx_port_ops =3D {
+	.set_mode		=3D ep93xx_set_mode,
+	.mode_filter		=3D ep93xx_mode_filter,
+
+	.port_disable		=3D ata_port_disable,
+	.tf_load		=3D ep93xx_tf_load,
+	.tf_read		=3D ep93xx_tf_read,
+	.check_status 		=3D ep93xx_check_status,
+	.check_altstatus	=3D ep93xx_check_altstatus,
+	.exec_command		=3D ep93xx_exec_command,
+	.data_xfer		=3D ep93xx_data_xfer,
+
+	.dev_select 		=3D ata_std_dev_select,
+
+	.qc_prep 		=3D ata_qc_prep,
+	.qc_issue		=3D ata_qc_issue_prot,
+	.eng_timeout		=3D ata_eng_timeout,
+
+	.irq_handler		=3D ata_interrupt,
+	.irq_clear		=3D ep93xx_irq_clear,
+
+	.port_start		=3D ata_port_start,
+	.port_stop		=3D ata_port_stop,
+	.host_stop		=3D ata_host_stop,
+
+	.phy_reset		=3D ep93xx_phy_reset,
+};
+
+/* Setup the addresses and encode CSx within them */
+static void ep93xx_ports(struct ata_ioports *ioaddr,struct ep93xx_pata=
_data=20
*data)
+{
+    ioaddr->cmd_addr        =3D data->mem + 2;
+    ioaddr->altstatus_addr  =3D data->mem + (0x06 << 2) + 1;
+    ioaddr->ctl_addr        =3D data->mem + (0x06 << 2) + 1;
+
+    ioaddr->data_addr       =3D data->mem + (ATA_REG_DATA << 2) + 2;
+    ioaddr->error_addr      =3D data->mem + (ATA_REG_ERR << 2) + 2;
+    ioaddr->feature_addr    =3D data->mem + (ATA_REG_FEATURE << 2) + 2=
;
+    ioaddr->nsect_addr      =3D data->mem + (ATA_REG_NSECT << 2) + 2;
+    ioaddr->lbal_addr       =3D data->mem + (ATA_REG_LBAL << 2) + 2;
+    ioaddr->lbam_addr       =3D data->mem + (ATA_REG_LBAM << 2) + 2;
+    ioaddr->lbah_addr       =3D data->mem + (ATA_REG_LBAH << 2) + 2;
+    ioaddr->device_addr     =3D data->mem + (ATA_REG_DEVICE << 2) + 2;
+    ioaddr->status_addr     =3D data->mem + (ATA_REG_STATUS << 2) + 2;
+    ioaddr->command_addr    =3D data->mem + (ATA_REG_CMD << 2) + 2;
+}
+
+static __devinit int ep93xx_pata_probe(struct platform_device *pdev)
+{
+	int ret;
+	struct ata_probe_ent ae;
+	struct resource *res;
+	struct ep93xx_pata_data *data;
+
+	memset(&ae, 0, sizeof(struct ata_probe_ent));
+	INIT_LIST_HEAD(&ae.node);
+
+	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res)
+		return -EINVAL;
+
+	data->mem =3D ioremap(res->start,0x1000);
+	if (data->mem =3D=3D NULL) {
+                dev_err(&pdev->dev, "Failed to ioremap pata registers\=
n");
+                return -EIO;
+        } else {
+	    DPRINTK(": ioremap to 0x%x \n",(unsigned int) data->mem);
+	}
+
+	data->irq =3D platform_get_irq(pdev, 0);
+	if (data->irq)
+		set_irq_type(data->irq, IRQT_HIGH);
+
+	ae.dev		=3D &pdev->dev;
+	ae.port_ops	=3D &ep93xx_port_ops;
+	ae.sht		=3D &ep93xx_sht;
+	ae.n_ports	=3D 1;
+	ae.pio_mask	=3D 0x1f; /* PIO4 */
+	ae.irq		=3D data->irq;
+	ae.irq_flags	=3D 0;
+	ae.port_flags	=3D ATA_FLAG_MMIO | ATA_FLAG_SRST;
+
+	ep93xx_ports(&ae.port[0], data);
+
+	/* enable ide and set pio mode 4 */
+	__raw_writel(EP93XX_IDE_CFG_IDEEN | EP93XX_IDE_CFG_PIO |
+			EP93XX_IDE_CFG_WST(0) | EP93XX_IDE_CFG_MODE(4),
+			EP93XX_IDE_CFG);
+
+	/* run in polling mode if no irq has been assigned */
+	if (!data->irq)
+		ae.port_flags |=3D ATA_FLAG_PIO_POLLING;
+
+	dev_printk(KERN_INFO, &pdev->dev, "version " DRV_VERSION "\n");
+
+	ret =3D ata_device_add(&ae);
+	if (ret =3D=3D 0)
+		return -ENODEV;
+
+	return 0;
+}
+
+static __devexit int ep93xx_pata_remove(struct platform_device *dev)
+{
+	struct ata_host *host =3D platform_get_drvdata(dev);
+
+	ata_host_remove(host);
+	platform_set_drvdata(dev, NULL);
+
+	return 0;
+}
+
+static struct platform_driver ep93xx_pata_platform_driver =3D {
+	.driver	 =3D {
+		.name   =3D DRV_NAME,
+		.owner  =3D THIS_MODULE,
+	},
+	.probe		=3D ep93xx_pata_probe,
+	.remove		=3D __devexit_p(ep93xx_pata_remove),
+};
+
+
+static int __init ep93xx_pata_init(void)
+{
+	return platform_driver_register(&ep93xx_pata_platform_driver);
+}
+
+static void __exit ep93xx_pata_exit(void)
+{
+	platform_driver_unregister(&ep93xx_pata_platform_driver);
+}
+
+MODULE_AUTHOR("Alessandro Zummo <a.zummo@towertech.it>");
+MODULE_DESCRIPTION("low-level driver for ep93xx ATA");
+MODULE_LICENSE("GPL");
+MODULE_VERSION(DRV_VERSION);
+
+module_init(ep93xx_pata_init);
+module_exit(ep93xx_pata_exit);
=20

--=20
mfg
Manfred Gruber
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Contec Steuerungstechnik & Automation GmbH
Manfred Gruber
Wildbichler Stra=C3=9Fe 2e
6341 Ebbs / Austria
AUSTRIA
------------------------------------------
http://www.contec.at/
manfred.gruber@contec.at

phone: 0043 / (0) 5373 / 43143 - 511
fax:   0043 / (0) 5373 / 43143 - 888
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
