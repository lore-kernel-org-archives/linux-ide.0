From: "Albert Lee" <albertcc@tw.ibm.com>
Subject: Re: PDC20269: Limit on number of controllers?
Date: Tue, 22 Feb 2005 15:28:16 +0800
Message-ID: <001e01c518b0$14d21470$6401a8c0@tw.ibm.com>
References: <66F9227F7417874C8DB3CEB057727417044F96@MILEX0.Miltope.local>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_001B_01C518F3.214F93B0"
Received: from bluehawaii.tikira.net ([61.62.22.51]:39923 "EHLO
	bluehawaii.tikira.net") by vger.kernel.org with ESMTP
	id S262238AbVBVH2s (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 22 Feb 2005 02:28:48 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Winstel, Drew" <DWinstel@Miltope.com>
Cc: IDE Linux <linux-ide@vger.kernel.org>

This is a multi-part message in MIME format.

------=_NextPart_000_001B_01C518F3.214F93B0
Content-Type: text/plain;
	charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit





> Is there a limit on the number of Promise Ultra133TX2 (PDC20269
>  chip) PATA interface cards that can be present on a system?  
> 
> Judging from my efforts to get a test PC running with the
> configuration below, it would appear that there is a maximum 
> of two cards that can be installed.  After much trial and error, 
> I have determined that the errors listed below occur only on 
> UDMA(100) drives that are connected to ide6 and later (that 
> is, the 3rd card).  Master/slave jumper settings have no 
> visible effect.
> 
> I tried using three Highpoint Rocket 133 cards to see if they 
> performed any better, and they were not vulnerable to the DMA 
> limitation, but I must have gotten a bad card or two since they 
> left the drives in an unstable condition (/var/log/messages 
> grew to 343M!).  
> 
> Steps to reproduce:
> 1) Set up a system with at least 3 Promise Ultra133TX2 cards in 
> addition to having on-board primary and secondary IDE enabled.
> 2) Populate the primary master of the third controller with a 
> drive supporting UDMA 5 or better.  It appears to have no 
> bearing whether or not the first two controllers are populated 
> or not.  
> 3) Check dmesg for errors akin to the ones below.
> 
> This dmesg output is from 2.6.7, but the problem also exists 
> in 2.6.11-rc4.  
> 
> Oh, and before anyone asks me why in the world I would have a 
> need for a system capable of addressing 16 drives attached to 
> one PC, the machine's entire purpose is stressing the IDE drives 
> to the limit before they are declared safe for production use.  
> Ordinarily, I would say this isn't much of a problem, but during 
> one of the stress runs, these problems force the drives to drop 
> to PIO mode, thereby killing any resemblance of speed.  
> 
> Thanks for any help!
> 
> Drew Winstel
> 

Hi, 

  Maybe the PLL on the 3rd pdc20269 adapter not initialized by the firmware.

Could you help to test it with the attached libata pdc2027x driver patch with kernel 2.6.10 or above?

When configuring the kernel, please select "N" for pdc202xx_new driver and
select "Y" for the attached pata_pdc2027x driver instead. Thanks.


Albert
------=_NextPart_000_001B_01C518F3.214F93B0
Content-Type: application/octet-stream;
	name="pdc20269_debug.diff"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="pdc20269_debug.diff"

diff -Nru linux-2.6.10/drivers/scsi/Kconfig =
linux-2.6.10-mod/drivers/scsi/Kconfig=0A=
--- linux-2.6.10/drivers/scsi/Kconfig	2004-12-25 05:35:28.000000000 +0800=0A=
+++ linux-2.6.10-mod/drivers/scsi/Kconfig	2005-02-22 15:11:57.000000000 =
+0800=0A=
@@ -441,6 +441,14 @@=0A=
 =0A=
 	  If unsure, say N.=0A=
 =0A=
+config SCSI_PATA_PDC2027X=0A=
+	tristate "Promise PATA 2027x support"=0A=
+	depends on SCSI_SATA && PCI=0A=
+	help=0A=
+	  This option enables support for Promise PATA pdc20268 to pdc20277 =
host adapters.=0A=
+=0A=
+	  If unsure, say N.=0A=
+=0A=
 config SCSI_SATA_PROMISE=0A=
 	tristate "Promise SATA TX2/TX4 support"=0A=
 	depends on SCSI_SATA && PCI=0A=
diff -Nru linux-2.6.10/drivers/scsi/Makefile =
linux-2.6.10-mod/drivers/scsi/Makefile=0A=
--- linux-2.6.10/drivers/scsi/Makefile	2004-12-25 05:35:24.000000000 =
+0800=0A=
+++ linux-2.6.10-mod/drivers/scsi/Makefile	2005-02-22 15:12:18.000000000 =
+0800=0A=
@@ -124,6 +124,7 @@=0A=
 obj-$(CONFIG_SCSI_SATA_AHCI)	+=3D libata.o ahci.o=0A=
 obj-$(CONFIG_SCSI_SATA_SVW)	+=3D libata.o sata_svw.o=0A=
 obj-$(CONFIG_SCSI_ATA_PIIX)	+=3D libata.o ata_piix.o=0A=
+obj-$(CONFIG_SCSI_PATA_PDC2027X)+=3D libata.o pata_pdc2027x.o=0A=
 obj-$(CONFIG_SCSI_SATA_PROMISE)	+=3D libata.o sata_promise.o=0A=
 obj-$(CONFIG_SCSI_SATA_SIL)	+=3D libata.o sata_sil.o=0A=
 obj-$(CONFIG_SCSI_SATA_VIA)	+=3D libata.o sata_via.o=0A=
diff -Nru linux-2.6.10/drivers/scsi/pata_pdc2027x.c =
linux-2.6.10-mod/drivers/scsi/pata_pdc2027x.c=0A=
--- linux-2.6.10/drivers/scsi/pata_pdc2027x.c	1970-01-01 =
08:00:00.000000000 +0800=0A=
+++ linux-2.6.10-mod/drivers/scsi/pata_pdc2027x.c	2005-02-22 =
15:13:00.000000000 +0800=0A=
@@ -0,0 +1,767 @@=0A=
+/*=0A=
+ *  Promise PATA TX2/TX4/TX2000/133 IDE driver for pdc20268 to pdc20277.=0A=
+ *=0A=
+ *  This program is free software; you can redistribute it and/or=0A=
+ *  modify it under the terms of the GNU General Public License=0A=
+ *  as published by the Free Software Foundation; either version=0A=
+ *  2 of the License, or (at your option) any later version.=0A=
+ *=0A=
+ *  Ported to libata by:=0A=
+ *  Albert Lee <albertcc@tw.ibm.com> IBM Corporation =0A=
+ *=0A=
+ *  Copyright (C) 1998-2002		Andre Hedrick <andre@linux-ide.org>=0A=
+ *  Portions Copyright (C) 1999 Promise Technology, Inc.=0A=
+ *=0A=
+ *  Author: Frank Tiernan (frankt@promise.com)=0A=
+ *  Released under terms of General Public License=0A=
+ * =0A=
+ * =0A=
+ */=0A=
+#include <linux/kernel.h>=0A=
+#include <linux/module.h>=0A=
+#include <linux/pci.h>=0A=
+#include <linux/init.h>=0A=
+#include <linux/blkdev.h>=0A=
+#include <linux/delay.h>=0A=
+#include "scsi.h"=0A=
+#include <scsi/scsi_host.h>=0A=
+#include <linux/libata.h>=0A=
+#include <asm/io.h>=0A=
+=0A=
+#define DRV_NAME	"pata_pdc2027x"=0A=
+#define DRV_VERSION	"0.56"=0A=
+#define PDC_DEBUG=0A=
+=0A=
+#ifdef PDC_DEBUG=0A=
+#define PDPRINTK(fmt, args...) printk(KERN_DEBUG "%s: " fmt, =
__FUNCTION__, ## args)=0A=
+#else=0A=
+#define PDPRINTK(fmt, args...)=0A=
+#endif=0A=
+=0A=
+enum {=0A=
+	PDC_UDMA_100        =3D 0,=0A=
+	PDC_UDMA_133        =3D 1,=0A=
+	=0A=
+	PDC_100_MHZ         =3D 100000000,=0A=
+	PDC_133_MHZ         =3D 133333333,=0A=
+};=0A=
+=0A=
+static int pdc2027x_init_one(struct pci_dev *pdev, const struct =
pci_device_id *ent);=0A=
+static void pdc2027x_remove_one(struct pci_dev *pdev);=0A=
+static void pdc2027x_phy_reset(struct ata_port *ap);=0A=
+static void pdc2027x_set_piomode(struct ata_port *ap, struct ata_device =
*adev);=0A=
+static void pdc2027x_set_dmamode(struct ata_port *ap, struct ata_device =
*adev);=0A=
+static void pdc2027x_post_set_mode(struct ata_port *ap);=0A=
+static int pdc2027x_check_atapi_dma(struct ata_queued_cmd *qc);=0A=
+=0A=
+/* =0A=
+ * ATA Timing Tables based on 133MHz controller clock.=0A=
+ * These tables are only used when the controller is in 133MHz clock.=0A=
+ * If the controller is in 100MHz clock, the ASIC hardware will =0A=
+ * set the timing registers automatically when "set feature" command =0A=
+ * is issued to the device. However, if the controller clock is 133MHz, =0A=
+ * the following tables must be used.=0A=
+ */=0A=
+static struct pdc2027x_pio_timing {=0A=
+	u8 value0, value1, value2;=0A=
+} pdc2027x_pio_timing_tbl [] =3D {=0A=
+	{ 0xfb, 0x2b, 0xac }, /* PIO mode 0 */=0A=
+	{ 0x46, 0x29, 0xa4 }, /* PIO mode 1 */=0A=
+	{ 0x23, 0x26, 0x64 }, /* PIO mode 2 */=0A=
+	{ 0x27, 0x0d, 0x35 }, /* PIO mode 3, IORDY on, Prefetch off */=0A=
+	{ 0x23, 0x09, 0x25 }, /* PIO mode 4, IORDY on, Prefetch off */=0A=
+};=0A=
+=0A=
+static struct pdc2027x_mdma_timing {=0A=
+	u8 value0, value1;=0A=
+} pdc2027x_mdma_timing_tbl [] =3D {=0A=
+	{ 0xdf, 0x5f }, /* MDMA mode 0 */=0A=
+	{ 0x6b, 0x27 }, /* MDMA mode 1 */=0A=
+	{ 0x69, 0x25 }, /* MDMA mode 2 */=0A=
+};=0A=
+=0A=
+static struct pdc2027x_udma_timing {=0A=
+	u8 value0, value1, value2;=0A=
+} pdc2027x_udma_timing_tbl [] =3D {=0A=
+	{ 0x4a, 0x0f, 0xd5 }, /* UDMA mode 0 */=0A=
+	{ 0x3a, 0x0a, 0xd0 }, /* UDMA mode 1 */=0A=
+	{ 0x2a, 0x07, 0xcd }, /* UDMA mode 2 */=0A=
+	{ 0x1a, 0x05, 0xcd }, /* UDMA mode 3 */=0A=
+	{ 0x1a, 0x03, 0xcd }, /* UDMA mode 4 */=0A=
+	{ 0x1a, 0x02, 0xcb }, /* UDMA mode 5 */=0A=
+	{ 0x1a, 0x01, 0xcb }, /* UDMA mode 6 */=0A=
+};=0A=
+=0A=
+static struct pci_device_id pdc2027x_pci_tbl[] =3D {=0A=
+#ifdef ATA_ENABLE_PATA=0A=
+	{ PCI_VENDOR_ID_PROMISE, PCI_DEVICE_ID_PROMISE_20268, PCI_ANY_ID, =
PCI_ANY_ID, 0, 0, PDC_UDMA_100 },=0A=
+	{ PCI_VENDOR_ID_PROMISE, PCI_DEVICE_ID_PROMISE_20269, PCI_ANY_ID, =
PCI_ANY_ID, 0, 0, PDC_UDMA_133 },=0A=
+	{ PCI_VENDOR_ID_PROMISE, PCI_DEVICE_ID_PROMISE_20270, PCI_ANY_ID, =
PCI_ANY_ID, 0, 0, PDC_UDMA_100 },=0A=
+	{ PCI_VENDOR_ID_PROMISE, PCI_DEVICE_ID_PROMISE_20271, PCI_ANY_ID, =
PCI_ANY_ID, 0, 0, PDC_UDMA_133 },=0A=
+	{ PCI_VENDOR_ID_PROMISE, PCI_DEVICE_ID_PROMISE_20275, PCI_ANY_ID, =
PCI_ANY_ID, 0, 0, PDC_UDMA_133 },=0A=
+	{ PCI_VENDOR_ID_PROMISE, PCI_DEVICE_ID_PROMISE_20276, PCI_ANY_ID, =
PCI_ANY_ID, 0, 0, PDC_UDMA_133 },=0A=
+	{ PCI_VENDOR_ID_PROMISE, PCI_DEVICE_ID_PROMISE_20277, PCI_ANY_ID, =
PCI_ANY_ID, 0, 0, PDC_UDMA_133 },=0A=
+#endif=0A=
+	{ }	/* terminate list */=0A=
+};=0A=
+=0A=
+static struct pci_driver pdc2027x_pci_driver =3D {=0A=
+	.name			=3D DRV_NAME,=0A=
+	.id_table		=3D pdc2027x_pci_tbl,=0A=
+	.probe			=3D pdc2027x_init_one,=0A=
+	.remove			=3D __devexit_p(pdc2027x_remove_one),=0A=
+};=0A=
+=0A=
+static Scsi_Host_Template pdc2027x_sht =3D {=0A=
+	.module			=3D THIS_MODULE,=0A=
+	.name			=3D DRV_NAME,=0A=
+	.queuecommand		=3D ata_scsi_queuecmd,=0A=
+	.eh_strategy_handler	=3D ata_scsi_error,=0A=
+	.can_queue		=3D ATA_DEF_QUEUE,=0A=
+	.this_id		=3D ATA_SHT_THIS_ID,=0A=
+	.sg_tablesize		=3D LIBATA_MAX_PRD,=0A=
+	.max_sectors		=3D ATA_MAX_SECTORS,=0A=
+	.cmd_per_lun		=3D ATA_SHT_CMD_PER_LUN,=0A=
+	.emulated		=3D ATA_SHT_EMULATED,=0A=
+	.use_clustering		=3D ATA_SHT_USE_CLUSTERING,=0A=
+	.proc_name		=3D DRV_NAME,=0A=
+	.dma_boundary		=3D ATA_DMA_BOUNDARY,=0A=
+	.slave_configure	=3D ata_scsi_slave_config,=0A=
+	.bios_param		=3D ata_std_bios_param,=0A=
+};=0A=
+=0A=
+static struct ata_port_operations pdc2027x_pata100_ops =3D {=0A=
+	.port_disable		=3D ata_port_disable,=0A=
+=0A=
+	.tf_load		=3D ata_tf_load,=0A=
+	.tf_read		=3D ata_tf_read,=0A=
+	.check_status		=3D ata_check_status,=0A=
+	.exec_command		=3D ata_exec_command,=0A=
+	.dev_select		=3D ata_std_dev_select,=0A=
+=0A=
+	.phy_reset		=3D pdc2027x_phy_reset,   =0A=
+=0A=
+	.check_atapi_dma	=3D pdc2027x_check_atapi_dma,=0A=
+	.bmdma_setup		=3D ata_bmdma_setup,=0A=
+	.bmdma_start		=3D ata_bmdma_start,=0A=
+	.qc_prep		=3D ata_qc_prep,=0A=
+	.qc_issue		=3D ata_qc_issue_prot,=0A=
+	.eng_timeout		=3D ata_eng_timeout,=0A=
+=0A=
+	.irq_handler		=3D ata_interrupt,=0A=
+	.irq_clear		=3D ata_bmdma_irq_clear,=0A=
+=0A=
+	.port_start		=3D ata_port_start,=0A=
+	.port_stop		=3D ata_port_stop,=0A=
+};=0A=
+=0A=
+static struct ata_port_operations pdc2027x_pata133_ops =3D {=0A=
+	.port_disable		=3D ata_port_disable,=0A=
+	.set_piomode		=3D pdc2027x_set_piomode,   =0A=
+	.set_dmamode		=3D pdc2027x_set_dmamode,  =0A=
+=0A=
+	.tf_load		=3D ata_tf_load,=0A=
+	.tf_read		=3D ata_tf_read,=0A=
+	.check_status		=3D ata_check_status,=0A=
+	.exec_command		=3D ata_exec_command,=0A=
+	.dev_select		=3D ata_std_dev_select,=0A=
+=0A=
+	.phy_reset		=3D pdc2027x_phy_reset,   =0A=
+	.post_set_mode		=3D pdc2027x_post_set_mode,=0A=
+=0A=
+	.check_atapi_dma	=3D pdc2027x_check_atapi_dma,=0A=
+	.bmdma_setup		=3D ata_bmdma_setup,=0A=
+	.bmdma_start		=3D ata_bmdma_start,=0A=
+	.qc_prep		=3D ata_qc_prep,=0A=
+	.qc_issue		=3D ata_qc_issue_prot,=0A=
+	.eng_timeout		=3D ata_eng_timeout,=0A=
+=0A=
+	.irq_handler		=3D ata_interrupt,=0A=
+	.irq_clear		=3D ata_bmdma_irq_clear,=0A=
+=0A=
+	.port_start		=3D ata_port_start,=0A=
+	.port_stop		=3D ata_port_stop,=0A=
+};=0A=
+=0A=
+static struct ata_port_info pdc2027x_port_info[] =3D {=0A=
+	/* PDC_UDMA_100 */=0A=
+	{=0A=
+		.sht		=3D &pdc2027x_sht,=0A=
+		.host_flags	=3D ATA_FLAG_NO_LEGACY | ATA_FLAG_SLAVE_POSS | =0A=
+		                  ATA_FLAG_SRST,=0A=
+		.pio_mask	=3D 0x1f, /* pio0-4 */=0A=
+		.mwdma_mask	=3D 0x07, /* mwdma0-2 */=0A=
+		.udma_mask	=3D ATA_UDMA5, /* udma0-5 */=0A=
+		.port_ops	=3D &pdc2027x_pata100_ops,=0A=
+	},=0A=
+	/* PDC_UDMA_133 */=0A=
+	{=0A=
+		.sht		=3D &pdc2027x_sht,=0A=
+		.host_flags	=3D ATA_FLAG_NO_LEGACY | ATA_FLAG_SLAVE_POSS | =0A=
+                        	  ATA_FLAG_SRST,=0A=
+		.pio_mask	=3D 0x1f, /* pio0-4 */=0A=
+		.mwdma_mask	=3D 0x07, /* mwdma0-2 */=0A=
+		.udma_mask	=3D ATA_UDMA6, /* udma0-6 */=0A=
+		.port_ops	=3D &pdc2027x_pata133_ops,=0A=
+	},=0A=
+};=0A=
+=0A=
+MODULE_AUTHOR("Andre Hedrick, Frank Tiernan, Albert Lee");=0A=
+MODULE_DESCRIPTION("libata driver module for Promise PDC20268 to =
PDC20277");=0A=
+MODULE_LICENSE("GPL");=0A=
+MODULE_DEVICE_TABLE(pci, pdc2027x_pci_tbl);=0A=
+=0A=
+/**=0A=
+ * pdc_get_indexed_reg - Set pdc202xx extended register=0A=
+ * @ap: Port to which the extended register is set=0A=
+ * @index: index of the extended register=0A=
+ */=0A=
+static u8 pdc_get_indexed_reg(struct ata_port *ap, u8 index)=0A=
+{=0A=
+	u8 tmp8;=0A=
+=0A=
+	outb(index, ap->ioaddr.bmdma_addr + 1); =0A=
+	tmp8 =3D inb(ap->ioaddr.bmdma_addr + 3);=0A=
+=0A=
+	PDPRINTK("Get index reg%X[%X] \n", index, tmp8);=0A=
+	return tmp8;=0A=
+}=0A=
+/**=0A=
+ * pdc_set_indexed_reg - Read pdc202xx extended register=0A=
+ * @ap: Port to which the extended register is read=0A=
+ * @index: index of the extended register=0A=
+ */=0A=
+static void pdc_set_indexed_reg(struct ata_port *ap, u8 index, u8 value)=0A=
+{=0A=
+	outb(index, ap->ioaddr.bmdma_addr + 1); =0A=
+	outb(value, ap->ioaddr.bmdma_addr + 3);=0A=
+	PDPRINTK("Set index reg%X[%X] \n", index, value);=0A=
+}=0A=
+/**=0A=
+ *	pdc2027x_pata_cbl_detect - Probe host controller cable detect info=0A=
+ *	@ap: Port for which cable detect info is desired=0A=
+ *=0A=
+ *	Read 80c cable indicator from Promise extended register.  =0A=
+ *      This register is latched when the system is reset.=0A=
+ *=0A=
+ *	LOCKING:=0A=
+ *	None (inherited from caller).=0A=
+ */=0A=
+static void pdc2027x_cbl_detect(struct ata_port *ap)=0A=
+{=0A=
+	u8 cbl40c;=0A=
+=0A=
+	/* check cable detect results */=0A=
+	cbl40c =3D pdc_get_indexed_reg(ap, 0x0b) & 0x04;=0A=
+=0A=
+	if (cbl40c)=0A=
+		goto cbl40;=0A=
+=0A=
+	PDPRINTK("No cable or 80-conductor cable on port %d\n", ap->port_no);=0A=
+=0A=
+	ap->cbl =3D ATA_CBL_PATA80;=0A=
+	return;=0A=
+=0A=
+cbl40:=0A=
+	printk(KERN_INFO DRV_NAME ": 40-conductor cable detected on port =
%d\n", ap->port_no);=0A=
+	ap->cbl =3D ATA_CBL_PATA40;=0A=
+	ap->udma_mask &=3D ATA_UDMA_MASK_40C;=0A=
+}=0A=
+/**=0A=
+ * pdc2027x_port_enabled - Check extended register at 0x04 to see =
whether the port is enabled.=0A=
+ * @ap: Port to check=0A=
+ */=0A=
+static inline int pdc2027x_port_enabled(struct ata_port *ap)=0A=
+{=0A=
+	return pdc_get_indexed_reg(ap, 0x04) & 0x02;=0A=
+}=0A=
+/**=0A=
+ *	pdc2027x_phy_reset - Probe specified port on PATA host controller=0A=
+ *	@ap: Port to probe=0A=
+ *=0A=
+ *	Probe PATA phy.=0A=
+ *=0A=
+ *	LOCKING:=0A=
+ *	None (inherited from caller).=0A=
+ */=0A=
+static void pdc2027x_phy_reset(struct ata_port *ap)=0A=
+{=0A=
+	/* Check whether port enabled */=0A=
+	if (!pdc2027x_port_enabled(ap)) {=0A=
+		ata_port_disable(ap);=0A=
+		printk(KERN_INFO "ata%u: port disabled. ignoring.\n", ap->id);=0A=
+		return;=0A=
+	}=0A=
+=0A=
+	pdc2027x_cbl_detect(ap);=0A=
+	ata_port_probe(ap);=0A=
+	ata_bus_reset(ap);=0A=
+}=0A=
+/**=0A=
+ *	pdc2027x_set_piomode - Initialize host controller PATA PIO timings=0A=
+ *	@ap: Port to configure=0A=
+ *	@adev: um=0A=
+ *	@pio: PIO mode, 0 - 4=0A=
+ *=0A=
+ *	Set PIO mode for device.=0A=
+ *=0A=
+ *	LOCKING:=0A=
+ *	None (inherited from caller).=0A=
+ */=0A=
+static void pdc2027x_set_piomode(struct ata_port *ap, struct ata_device =
*adev)=0A=
+{=0A=
+	unsigned int pio      =3D adev->pio_mode - XFER_PIO_0;=0A=
+	unsigned int drive_dn =3D (ap->port_no ? 2 : 0) + adev->devno;=0A=
+	u8 adj		      =3D (drive_dn%2) ? 0x08 : 0x00;=0A=
+=0A=
+	PDPRINTK("adev->pio_mode[%X]\n", adev->pio_mode);=0A=
+=0A=
+	/* Sanity check */=0A=
+	if(pio > 4) {=0A=
+		printk(KERN_ERR DRV_NAME ": Unknown pio mode [%d] ignored\n", pio);=0A=
+		return;=0A=
+=0A=
+	}=0A=
+=0A=
+	/* Set the PIO timing registers using value table for 133MHz */=0A=
+	PDPRINTK("Set pio regs... \n");=0A=
+=0A=
+	pdc_set_indexed_reg(ap, 0x0c + adj, =
pdc2027x_pio_timing_tbl[pio].value0);=0A=
+	pdc_set_indexed_reg(ap, 0x0d + adj, =
pdc2027x_pio_timing_tbl[pio].value1);=0A=
+	pdc_set_indexed_reg(ap, 0x13 + adj, =
pdc2027x_pio_timing_tbl[pio].value2);=0A=
+=0A=
+	PDPRINTK("Set pio regs done\n");=0A=
+=0A=
+	PDPRINTK("Set to pio mode[%u] \n", pio);=0A=
+}=0A=
+/**=0A=
+ *	pdc2027x_set_dmamode - Initialize host controller PATA UDMA timings=0A=
+ *	@ap: Port to configure=0A=
+ *	@adev: um=0A=
+ *	@udma: udma mode, XFER_UDMA_0 to XFER_UDMA_6=0A=
+ *=0A=
+ *	Set UDMA mode for device.=0A=
+ *=0A=
+ *	LOCKING:=0A=
+ *	None (inherited from caller).=0A=
+ */=0A=
+static void pdc2027x_set_dmamode(struct ata_port *ap, struct ata_device =
*adev)=0A=
+{=0A=
+	unsigned int dma_mode	=3D adev->dma_mode;=0A=
+	unsigned int drive_dn	=3D (ap->port_no ? 2 : 0) + adev->devno;=0A=
+	u8 adj			=3D (drive_dn%2) ? 0x08 : 0x00;=0A=
+	u8 tmp8;=0A=
+=0A=
+	if((dma_mode >=3D XFER_UDMA_0) && =0A=
+	   (dma_mode <=3D XFER_UDMA_6)) {=0A=
+		/* Set the UDMA timing registers with value table for 133MHz */=0A=
+		unsigned int udma_mode =3D dma_mode & 0x07;=0A=
+=0A=
+		if (dma_mode =3D=3D XFER_UDMA_2) {=0A=
+			/*=0A=
+			 * Turn off tHOLD.=0A=
+			 * If tHOLD is '1', the hardware will add half clock for data hold =
time.=0A=
+			 * This code segment seems to be no effect. tHOLD will be =
overwritten below.=0A=
+			 */=0A=
+			tmp8 =3D pdc_get_indexed_reg(ap, 0x10 + adj);=0A=
+			pdc_set_indexed_reg(ap, 0x10 + adj, tmp8 & 0x7f);=0A=
+		} =0A=
+=0A=
+		PDPRINTK("Set udma regs... \n");=0A=
+		pdc_set_indexed_reg(ap, 0x10 + adj, =
pdc2027x_udma_timing_tbl[udma_mode].value0);=0A=
+		pdc_set_indexed_reg(ap, 0x11 + adj, =
pdc2027x_udma_timing_tbl[udma_mode].value1);=0A=
+		pdc_set_indexed_reg(ap, 0x12 + adj, =
pdc2027x_udma_timing_tbl[udma_mode].value2);=0A=
+		PDPRINTK("Set udma regs done\n");=0A=
+		=0A=
+		PDPRINTK("Set to udma mode[%u] \n", udma_mode);=0A=
+=0A=
+	} else  if((dma_mode >=3D XFER_MW_DMA_0) && =0A=
+		   (dma_mode <=3D XFER_MW_DMA_2)) {=0A=
+		/* Set the MDMA timing registers with value table for 133MHz */=0A=
+		unsigned int mdma_mode =3D dma_mode & 0x07;=0A=
+=0A=
+		PDPRINTK("Set mdma regs... \n");=0A=
+		pdc_set_indexed_reg(ap, 0x0e + adj, =
pdc2027x_mdma_timing_tbl[mdma_mode].value0);=0A=
+		pdc_set_indexed_reg(ap, 0x0f + adj, =
pdc2027x_mdma_timing_tbl[mdma_mode].value1);=0A=
+		PDPRINTK("Set mdma regs done\n");=0A=
+		=0A=
+		PDPRINTK("Set to mdma mode[%u] \n", mdma_mode);=0A=
+	} else {=0A=
+		printk(KERN_ERR DRV_NAME ": Unknown dma mode [%u] ignored\n", =
dma_mode);=0A=
+	}=0A=
+}=0A=
+=0A=
+/**=0A=
+ *	pdc2027x_post_set_mode - Set the timing registers back to correct =
values.=0A=
+ *	@ap: Port to configure=0A=
+ *	=0A=
+ *	The pdc2027x hardware will look at "SET FEATURES" and change the =
timing registers =0A=
+ *	automatically. The values set by the hardware might be incorrect, =
under 133Mhz PLL.=0A=
+ *	This function overwrites the possibly incorrect values set by the =
hardware to be correct.=0A=
+ */=0A=
+static void pdc2027x_post_set_mode(struct ata_port *ap)=0A=
+{=0A=
+	int i;=0A=
+=0A=
+	for (i =3D 0; i < ATA_MAX_DEVICES; i++) {=0A=
+		struct ata_device *dev =3D &ap->device[i];=0A=
+=0A=
+		if (ata_dev_present(dev)) {=0A=
+			u8 adj =3D (i % 2) ? 0x08 : 0x00;=0A=
+			u8 tmp8;=0A=
+			=0A=
+			pdc2027x_set_piomode(ap, dev);=0A=
+=0A=
+			/*=0A=
+			 * Enable prefetch if the device support PIO only.=0A=
+			 */=0A=
+			if (dev->xfer_shift =3D=3D ATA_SHIFT_PIO) { =0A=
+				tmp8 =3D pdc_get_indexed_reg(ap, 0x13 + adj);=0A=
+				pdc_set_indexed_reg(ap, 0x13 + adj, tmp8 | 0x02);=0A=
+				=0A=
+				PDPRINTK("Turn on prefetch\n");=0A=
+			} else {=0A=
+				pdc2027x_set_dmamode(ap, dev);=0A=
+			}=0A=
+		}=0A=
+	}=0A=
+}=0A=
+=0A=
+/**=0A=
+ *	pdc2027x_check_atapi_dma - Check whether ATAPI DMA can be supported =
for this command=0A=
+ *	@qc: Metadata associated with taskfile to check=0A=
+ *=0A=
+ *	LOCKING:=0A=
+ *	None (inherited from caller).=0A=
+ *=0A=
+ *	RETURNS: 0 when ATAPI DMA can be used=0A=
+ *		 1 otherwise=0A=
+ */=0A=
+static int pdc2027x_check_atapi_dma(struct ata_queued_cmd *qc)=0A=
+{=0A=
+	struct scsi_cmnd *cmd =3D qc->scsicmd;=0A=
+	int rc =3D 0;=0A=
+=0A=
+	/* pdc2027x can only do ATAPI DMA for specific buffer size */=0A=
+	if (cmd->request_bufflen % 256)=0A=
+		rc =3D 1;=0A=
+=0A=
+	return rc;=0A=
+}=0A=
+=0A=
+/**=0A=
+ * adjust_pll - Adjust the PLL input clock in Hz.=0A=
+ *=0A=
+ * @pdc_controller: controller specific information=0A=
+ * @probe_ent: For the port address=0A=
+ * @pll_clock: The input of PLL in HZ=0A=
+ */=0A=
+static void pdc_adjust_pll(struct ata_probe_ent *probe_ent, long =
pll_clock, unsigned int board_idx) =0A=
+{=0A=
+=0A=
+	u8 pll_ctl0, pll_ctl1;=0A=
+	long pll_clock_khz =3D pll_clock / 1000;=0A=
+	long pout_required =3D board_idx? PDC_133_MHZ:PDC_100_MHZ;=0A=
+	long ratio =3D pout_required / pll_clock_khz;=0A=
+	int F, R;=0A=
+	=0A=
+=0A=
+	/* Sanity check */=0A=
+	if (unlikely(pll_clock_khz < 5000L || pll_clock_khz > 70000L)) {=0A=
+		printk(KERN_ERR DRV_NAME ": Invalid PLL input clock %ldkHz, give =
up!\n", pll_clock_khz);=0A=
+		return;=0A=
+	} =0A=
+=0A=
+#ifdef PDC_DEBUG=0A=
+	PDPRINTK("pout_required is %ld\n", pout_required);=0A=
+=0A=
+	/* Show the current clock value of PLL control register=0A=
+	 * (maybe already configured by the firmware)=0A=
+	 */=0A=
+	outb(0x02, probe_ent->port[1].bmdma_addr + 0x01);=0A=
+	pll_ctl0 =3D inb(probe_ent->port[1].bmdma_addr + 0x03);=0A=
+	outb(0x03, probe_ent->port[1].bmdma_addr + 0x01);=0A=
+	pll_ctl1 =3D inb(probe_ent->port[1].bmdma_addr + 0x03);=0A=
+=0A=
+	PDPRINTK("pll_ctl[%X][%X]\n", pll_ctl0, pll_ctl1);=0A=
+#endif=0A=
+=0A=
+	/* =0A=
+	 * Calculate the ratio of F, R and OD=0A=
+	 * POUT =3D (F + 2) / (( R + 2) * NO)=0A=
+	 */=0A=
+	if (ratio < 8600L) { // 8.6x=0A=
+		/* Using NO =3D 0x01, R =3D 0x0D */=0A=
+		R =3D 0x0d;=0A=
+	} else if (ratio < 12900L) { // 12.9x=0A=
+		/* Using NO =3D 0x01, R =3D 0x08 */=0A=
+		R =3D 0x08;=0A=
+	} else if (ratio < 16100L) { // 16.1x=0A=
+		/* Using NO =3D 0x01, R =3D 0x06 */=0A=
+		R =3D 0x06;=0A=
+	} else if (ratio < 64000L) { // 64x=0A=
+		R =3D 0x00;=0A=
+	} else {=0A=
+		/* Invalid ratio */=0A=
+		printk(KERN_ERR DRV_NAME ": Invalid ratio %ld, give up!\n", ratio);=0A=
+		return;=0A=
+	}=0A=
+=0A=
+	F =3D (ratio * (R+2)) / 1000 - 2;=0A=
+=0A=
+	if (unlikely(F < 0 || F > 127)) {=0A=
+		/* Invalid F */=0A=
+		printk(KERN_ERR DRV_NAME ": F[%d] invalid!\n", F);=0A=
+		return;=0A=
+	}=0A=
+=0A=
+	PDPRINTK("F[%d] R[%d] ratio*1000[%ld]\n", F, R, ratio);=0A=
+=0A=
+	pll_ctl0 =3D (u8) F;=0A=
+	pll_ctl1 =3D (u8) R;=0A=
+=0A=
+	PDPRINTK("Writing pll_ctl[%X][%X]\n", pll_ctl0, pll_ctl1);=0A=
+=0A=
+	outb(0x02,     probe_ent->port[1].bmdma_addr + 0x01);=0A=
+	outb(pll_ctl0, probe_ent->port[1].bmdma_addr + 0x03);=0A=
+	outb(0x03,     probe_ent->port[1].bmdma_addr + 0x01);=0A=
+	outb(pll_ctl1, probe_ent->port[1].bmdma_addr + 0x03);=0A=
+=0A=
+	/* Wait the PLL circuit to be stable */=0A=
+	mdelay(30);=0A=
+=0A=
+#ifdef PDC_DEBUG=0A=
+	/*=0A=
+	 *  Show the current clock value of PLL control register=0A=
+	 * (maybe configured by the firmware)=0A=
+	 */=0A=
+	outb(0x02, probe_ent->port[1].bmdma_addr + 0x01);=0A=
+	pll_ctl0 =3D inb(probe_ent->port[1].bmdma_addr + 0x03);=0A=
+	outb(0x03, probe_ent->port[1].bmdma_addr + 0x01);=0A=
+	pll_ctl1 =3D inb(probe_ent->port[1].bmdma_addr + 0x03);=0A=
+=0A=
+	PDPRINTK("pll_ctl[%X][%X]\n", pll_ctl0, pll_ctl1);=0A=
+#endif=0A=
+=0A=
+	return;=0A=
+}=0A=
+/**=0A=
+ * detect_pll_input_clock - Detect the PLL input clock in Hz.=0A=
+ * @probe_ent: for the port address=0A=
+ * Ex. 16949000 on 33MHz PCI bus for pdc20275. =0A=
+ *     Half of the PCI clock.=0A=
+ */=0A=
+static long pdc_detect_pll_input_clock(struct ata_probe_ent *probe_ent) =0A=
+{=0A=
+	u8 scr1;=0A=
+	unsigned long ctr0;=0A=
+	unsigned long ctr1;=0A=
+	unsigned long ctr2 =3D 0;=0A=
+	unsigned long ctr3 =3D 0;=0A=
+=0A=
+	unsigned long start_count, end_count;=0A=
+	long pll_clock;=0A=
+=0A=
+	/* Read current counter value */=0A=
+	outb(0x20, probe_ent->port[0].bmdma_addr + 0x01);=0A=
+	ctr0 =3D inb(probe_ent->port[0].bmdma_addr + 0x03);=0A=
+	outb(0x21, probe_ent->port[0].bmdma_addr + 0x01);=0A=
+	ctr1 =3D inb(probe_ent->port[0].bmdma_addr + 0x03);=0A=
+	=0A=
+	outb(0x20, probe_ent->port[1].bmdma_addr + 0x01);=0A=
+	ctr2 =3D inb(probe_ent->port[1].bmdma_addr + 0x03);=0A=
+	outb(0x21, probe_ent->port[1].bmdma_addr + 0x01);=0A=
+	ctr3 =3D inb(probe_ent->port[1].bmdma_addr + 0x03);=0A=
+=0A=
+	start_count =3D (ctr3 << 23 ) | (ctr2 << 15) | (ctr1 << 8) | ctr0;=0A=
+=0A=
+	PDPRINTK("ctr0[%lX] ctr1[%lX] ctr2 [%lX] ctr3 [%lX]\n", ctr0, ctr1, =
ctr2, ctr3);=0A=
+=0A=
+	/* Start the test mode */=0A=
+	outb(0x01, probe_ent->port[0].bmdma_addr + 0x01);=0A=
+	scr1 =3D inb(probe_ent->port[0].bmdma_addr + 0x03);=0A=
+	PDPRINTK("scr1[%X]\n", scr1);=0A=
+	outb(scr1 | 0x40, probe_ent->port[0].bmdma_addr + 0x03);=0A=
+=0A=
+	/* Let the counter run for 1000 us. */=0A=
+	udelay(1000);=0A=
+=0A=
+	/* Read the counter values again */=0A=
+	outb(0x20, probe_ent->port[0].bmdma_addr + 0x01);=0A=
+	ctr0 =3D inb(probe_ent->port[0].bmdma_addr + 0x03);=0A=
+	outb(0x21, probe_ent->port[0].bmdma_addr + 0x01);=0A=
+	ctr1 =3D inb(probe_ent->port[0].bmdma_addr + 0x03);=0A=
+	=0A=
+	outb(0x20, probe_ent->port[1].bmdma_addr + 0x01);=0A=
+	ctr2 =3D inb(probe_ent->port[1].bmdma_addr + 0x03);=0A=
+	outb(0x21, probe_ent->port[1].bmdma_addr + 0x01);=0A=
+	ctr3 =3D inb(probe_ent->port[1].bmdma_addr + 0x03);=0A=
+=0A=
+	end_count =3D (ctr3 << 23 ) | (ctr2 << 15) | (ctr1 << 8) | ctr0;=0A=
+=0A=
+	PDPRINTK("ctr0[%lX] ctr1[%lX] ctr2 [%lX] ctr3 [%lX]\n", ctr0, ctr1, =
ctr2, ctr3);=0A=
+=0A=
+	/* Stop the test mode */=0A=
+	outb(0x01, probe_ent->port[0].bmdma_addr + 0x01);=0A=
+	scr1 =3D inb(probe_ent->port[0].bmdma_addr + 0x03);=0A=
+	PDPRINTK("scr1[%X]\n", scr1);=0A=
+	outb(scr1 & 0xBF, probe_ent->port[0].bmdma_addr + 0x03);=0A=
+=0A=
+	/* calculate the input clock in Hz */=0A=
+	pll_clock =3D (long) ((start_count - end_count) * 1000);=0A=
+=0A=
+	PDPRINTK("start[%lu] end[%lu] \n", start_count, end_count);=0A=
+	PDPRINTK("PLL input clock[%ld]Hz\n", pll_clock);=0A=
+=0A=
+	return pll_clock;=0A=
+}=0A=
+/**=0A=
+ * pdc_hardware_init - Initialize the hardware.=0A=
+ * @pdev: instance of pci_dev found=0A=
+ * @pdc_controller: controller specific information=0A=
+ * @pe:  for the port address=0A=
+ */=0A=
+static int pdc_hardware_init(struct pci_dev *pdev, struct ata_probe_ent =
*pe, unsigned int board_idx)=0A=
+{=0A=
+	long pll_clock;=0A=
+=0A=
+	/*=0A=
+	 * Detect PLL input clock rate.=0A=
+	 * On some system, where PCI bus is running at non-standard clock rate.=0A=
+	 * Ex. 25MHz or 40MHz, we have to adjust the cycle_time.=0A=
+	 * The pdc20275 controller employs PLL circuit to help correct timing =
registers setting.=0A=
+	 */=0A=
+	pll_clock =3D pdc_detect_pll_input_clock(pe);=0A=
+=0A=
+	if(pll_clock < 0) /* counter overflow? Try again. */=0A=
+		pll_clock =3D pdc_detect_pll_input_clock(pe);=0A=
+=0A=
+	printk(KERN_INFO DRV_NAME ": PLL input clock %ld kHz\n", =
pll_clock/1000);=0A=
+=0A=
+	/* Adjust PLL control register */=0A=
+	pdc_adjust_pll(pe, pll_clock, board_idx);=0A=
+=0A=
+	return 0;=0A=
+}=0A=
+/**=0A=
+ * pdc2027x_init_one - PCI probe function=0A=
+ * Called when an instance of PCI adapter is inserted.=0A=
+ * This function checks whether the hardware is supported,=0A=
+ * initialize hardware and register an instance of ata_host_set to =0A=
+ * libata by providing struct ata_probe_ent and ata_device_add().=0A=
+ * (implements struct pci_driver.probe() )=0A=
+ * =0A=
+ * @pdev: instance of pci_dev found=0A=
+ * @ent:  matching entry in the id_tbl[]=0A=
+ */=0A=
+static int __devinit pdc2027x_init_one(struct pci_dev *pdev, const =
struct pci_device_id *ent)=0A=
+{=0A=
+	static int printed_version;=0A=
+	unsigned int board_idx =3D (unsigned int) ent->driver_data;=0A=
+=0A=
+	struct ata_probe_ent *probe_ent =3D NULL;=0A=
+	int rc;=0A=
+=0A=
+	if (!printed_version++)=0A=
+		printk(KERN_DEBUG DRV_NAME " version " DRV_VERSION "\n");=0A=
+=0A=
+	rc =3D pci_enable_device(pdev);=0A=
+	if (rc)=0A=
+		return rc;=0A=
+=0A=
+	rc =3D pci_request_regions(pdev, DRV_NAME);=0A=
+	if (rc)=0A=
+		goto err_out;=0A=
+=0A=
+	rc =3D pci_set_dma_mask(pdev, ATA_DMA_MASK);=0A=
+	if (rc)=0A=
+		goto err_out_regions;=0A=
+=0A=
+	rc =3D pci_set_consistent_dma_mask(pdev, ATA_DMA_MASK);=0A=
+	if (rc)=0A=
+		goto err_out_regions;=0A=
+=0A=
+	/* Prepare the probe entry */=0A=
+	probe_ent =3D kmalloc(sizeof(*probe_ent), GFP_KERNEL);=0A=
+	if (probe_ent =3D=3D NULL) {=0A=
+		rc =3D -ENOMEM;=0A=
+		goto err_out_regions;=0A=
+	}=0A=
+=0A=
+	memset(probe_ent, 0, sizeof(*probe_ent));=0A=
+	probe_ent->dev =3D pci_dev_to_dev(pdev);=0A=
+	INIT_LIST_HEAD(&probe_ent->node);=0A=
+=0A=
+	probe_ent->sht		=3D pdc2027x_port_info[board_idx].sht;=0A=
+	probe_ent->host_flags	=3D pdc2027x_port_info[board_idx].host_flags;=0A=
+	probe_ent->pio_mask	=3D pdc2027x_port_info[board_idx].pio_mask;=0A=
+	probe_ent->udma_mask	=3D pdc2027x_port_info[board_idx].udma_mask;=0A=
+	probe_ent->port_ops	=3D pdc2027x_port_info[board_idx].port_ops;=0A=
+=0A=
+       	probe_ent->irq =3D pdev->irq;=0A=
+       	probe_ent->irq_flags =3D SA_SHIRQ;=0A=
+=0A=
+	probe_ent->port[0].cmd_addr =3D pci_resource_start(pdev, 0);=0A=
+	ata_std_ports(&probe_ent->port[0]);=0A=
+	probe_ent->port[0].altstatus_addr =3D=0A=
+		probe_ent->port[0].ctl_addr =3D=0A=
+		pci_resource_start(pdev, 1) | ATA_PCI_CTL_OFS;=0A=
+	probe_ent->port[0].bmdma_addr =3D pci_resource_start(pdev, 4);=0A=
+=0A=
+	probe_ent->port[1].cmd_addr =3D pci_resource_start(pdev, 2);=0A=
+	ata_std_ports(&probe_ent->port[1]);=0A=
+	probe_ent->port[1].altstatus_addr =3D=0A=
+		probe_ent->port[1].ctl_addr =3D=0A=
+		pci_resource_start(pdev, 3) | ATA_PCI_CTL_OFS;=0A=
+	probe_ent->port[1].bmdma_addr =3D pci_resource_start(pdev, 4) + 8;=0A=
+=0A=
+	probe_ent->n_ports =3D 2;=0A=
+=0A=
+	pci_set_master(pdev);=0A=
+	//pci_enable_intx(pdev);=0A=
+=0A=
+	/* initialize adapter */=0A=
+	if(pdc_hardware_init(pdev, probe_ent, board_idx) !=3D 0)=0A=
+		goto err_out_free_ent;=0A=
+=0A=
+	ata_device_add(probe_ent);=0A=
+	kfree(probe_ent);=0A=
+=0A=
+	return 0;=0A=
+=0A=
+err_out_free_ent:=0A=
+	kfree(probe_ent);=0A=
+err_out_regions:=0A=
+	pci_release_regions(pdev);=0A=
+err_out:=0A=
+	pci_disable_device(pdev);=0A=
+	return rc;=0A=
+}=0A=
+/**=0A=
+ * pdc2027x_remove_one - Called to remove a single instance of the=0A=
+ * adapter.=0A=
+ *=0A=
+ * @dev: The PCI device to remove.=0A=
+ * FIXME: module load/unload not working yet=0A=
+ */=0A=
+static void __devexit pdc2027x_remove_one(struct pci_dev *pdev)=0A=
+{=0A=
+	ata_pci_remove_one(pdev);=0A=
+}=0A=
+/**=0A=
+ * pdc2027x_init - Called after this module is loaded into the kernel.=0A=
+ */=0A=
+static int __init pdc2027x_init(void)=0A=
+{=0A=
+	return pci_module_init(&pdc2027x_pci_driver);=0A=
+}=0A=
+/**=0A=
+ * pdc2027x_exit - Called before this module unloaded from the kernel=0A=
+ */=0A=
+static void __exit pdc2027x_exit(void)=0A=
+{=0A=
+	pci_unregister_driver(&pdc2027x_pci_driver);=0A=
+}=0A=
+=0A=
+module_init(pdc2027x_init);=0A=
+module_exit(pdc2027x_exit);=0A=
diff -Nru linux-2.6.10/include/linux/libata.h =
linux-2.6.10-mod/include/linux/libata.h=0A=
--- linux-2.6.10/include/linux/libata.h	2004-12-25 05:33:49.000000000 =
+0800=0A=
+++ linux-2.6.10-mod/include/linux/libata.h	2005-02-22 =
15:12:43.000000000 +0800=0A=
@@ -37,8 +37,8 @@=0A=
 #undef ATA_VERBOSE_DEBUG	/* yet more debugging output */=0A=
 #undef ATA_IRQ_TRAP		/* define to ack screaming irqs */=0A=
 #undef ATA_NDEBUG		/* define to disable quick runtime checks */=0A=
-#undef ATA_ENABLE_ATAPI		/* define to enable ATAPI support */=0A=
-#undef ATA_ENABLE_PATA		/* define to enable PATA support in some=0A=
+#define ATA_ENABLE_ATAPI		/* define to enable ATAPI support */=0A=
+#define ATA_ENABLE_PATA		/* define to enable PATA support in some=0A=
 				 * low-level drivers */=0A=
 #undef ATAPI_ENABLE_DMADIR	/* enables ATAPI DMADIR bridge support */=0A=
 =0A=

------=_NextPart_000_001B_01C518F3.214F93B0--


