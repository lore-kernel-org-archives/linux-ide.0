From: "Albert Lee" <albertcc@tw.ibm.com>
Subject: Re: [PATCH/RFC] Port of pdc202xx_new driver to libata
Date: Mon, 18 Oct 2004 18:30:43 +0800
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <001901c4b4fd$88204bc0$294bbf09@tw.ibm.com>
References: <00bb01c4b10c$4b2ab330$7301a8c0@tw.ibm.com> <58cb370e04101312321c78f3b8@mail.gmail.com> <416D88FA.1050200@pobox.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0016_01C4B540.93DA53F0"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from bluehawaii.tikira.net ([61.62.22.51]:37869 "EHLO
	bluehawaii.tikira.net") by vger.kernel.org with ESMTP
	id S265996AbUJRKcU (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 18 Oct 2004 06:32:20 -0400
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: IDE Linux <linux-ide@vger.kernel.org>

This is a multi-part message in MIME format.

------=_NextPart_000_0016_01C4B540.93DA53F0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

Hi, Jeff and Bart:

  Thanks for your review and sorry for the late reply.
The updated patch is attached for your review/comment.
(The patch is against libata-dev-2.6)

1.
> why not jus pata_pdc_new? or pata_pdc_27x?

 changed to "pata_pdc2027x".

2.
>  This table is redundant:
>* official names (more detailed) can be get from lspci
>* PDC_UDMA_[100,133] implies PDC_[100,133]_MHZ
>* max UDMA rate is available from ata_port_info etc.

Fixed.

3.
>> + /* For UDMA33, no 80c support is required */
>> + if ((ap->udma_mask & ~ATA_UDMA_MASK_40C) == 0)
>> +  goto cbl40;
>
>this can't happen

Removed.


4.
> pds_set_pio() should be called only once
> pdc_set_ultra() should be called only once

Fixed.

5.
>> + /* Enable the ROM */
>> + if (pdev->resource[PCI_ROM_RESOURCE].start) {
>> +  pci_write_config_dword(pdev, PCI_ROM_ADDRESS,
>> +   pdev->resource[PCI_ROM_RESOURCE].start | PCI_ROM_ADDRESS_ENABLE);
>> +  printk(KERN_INFO DRV_NAME ": ROM enabled at 0x%08lx\n",
>> +         pdev->resource[PCI_ROM_RESOURCE].start);
>> + }
> is this really needed?

Removed.

6.
>> +  * FIXME: If this driver happens to only be useful on Apple's K2, then
>> +  * we should check that here as it has a normal Serverworks ID
>> +  */
>
>cut'n'paste mistake

 Fixed.

7.
> pdc_hardware_init() seems to be the only reason
> why generic ata_pci_init_one() can't be used here,
> what about adding sth. like ->init_device() to
> struct ata_port_info?

 Could this be fixed later?
(I am afraid to touch the core. Need more time to study.)

Thanks,

Albert Lee

----- Original Message ----- 
From: "Jeff Garzik" <jgarzik@pobox.com>
To: "Bartlomiej Zolnierkiewicz" <bzolnier@gmail.com>; "Albert Lee"
<albertcc@tw.ibm.com>
Cc: "IDE Linux" <linux-ide@vger.kernel.org>
Sent: Thursday, October 14, 2004 3:58 AM
Subject: Re: [PATCH/RFC] Port of pdc202xx_new driver to libata


>
> I'll use this message to respond to both Albert and you (Bart).
>
> Bartlomiej Zolnierkiewicz wrote:
> > On Wed, 13 Oct 2004 18:06:19 +0800, Albert Lee <albertcc@tw.ibm.com>
wrote:
> >
> >>Hi, Jeff and Bart:
> >
> >
> > Hi!
> >
> >
> >>  I am trying to port the Promise pdc202xx_new driver to libata and
adding
> >>the
> >>PLL tuning code to it. (The motivation is hotplug of the Promise host
> >>adapter.)
> >
> >
> > I have libata version of pdc202xx_new for a long time now
> > but this one looks superior as it handles PLL. :-)
> >
> >
> >>The ported driver has been tested with pdc20269 and pdc20275 on i386 and
> >>x86_64 boxes, with 33 MHz PCI bus and 66 MHz PCI bus respectively.
> >>It seems to be working fine with harddisk drives.
>
> I got a report that sata_promise has problems in some >=66Mhz
> configurations, but works fine with 33Mhz configuration.  I bet I could
> learn a few things from this driver too, as the concepts probably apply
> to newer hardware.
>
>
> >>(However, CD-ROM drives not working yet, even when
> >>ATA_ENABLE_PATA and ATA_ENABLE_ATAPI are enabled.)
> >
> >
> > Somehow this doesn't surprise me...
>
> hehe :)
>
>
> >>My question is, in the current kernel, the IDE subsystem drives PATA
chips
> >>and libata drives SATA chips. Will PATA driver like this be accepted
into
> >>libata?
> >
> >
> > My opinion is: yes but not now, final answer is of course left to Jeff.
>
> With the progress currently being made, I think my preference would be
> to start collecting PATA drivers such this in my libata-dev queue.
>
> I would not send these PATA drivers upstream until the PATA to-do items
> are complete (see other email), but it would be nice to have a central
> location (both BK and patch on kernel.org) for developers and users to
> mess with PATA support.
>
> So, send PATA drivers to me and I will merge... but please understand
> that I will not send upstream for quite some time.
>
>
>
> >>Albert Lee
> >>(The patch is against 2.6.8.1.)
> >
> >
> > It seems your mail client screwed it.
> >
> > I will try to comment on the patch anyway...
>
> I agree with Bart's comments on the patch.  It was also mangled here.
>
> Albert, if you would resend a patch with Bart's fixes, I'll merge into
> libata-dev.
>
> My own comments:
>
> >> obj-$(CONFIG_SCSI_ATA_PIIX) += libata.o ata_piix.o
> >>> +obj-$(CONFIG_SCSI_PATA_PDC_NEW) += libata.o pata_pdc202xx_new.o
> >
> >
> > why not jus pata_pdc_new? or pata_pdc_27x?
>
> I would prefer to eliminate the "_new" suffix.  Other than that I don't
> really care.  If I had written the driver, I would have named it
> pata_pdc202xx I suppose.
>
>
> > +} pdc_pata_controller_tbl [] = {
> >> + { "Ultra100 TX2",        PDC_UDMA_100, PDC_100_MHZ }, /* pdc20268 */
> >> + { "Ultra133 TX2",        PDC_UDMA_133, PDC_133_MHZ }, /* pdc20269 */
> >> + { "FastTrak LP/TX2/TX4", PDC_UDMA_100, PDC_100_MHZ }, /* pdc20270 */
> >> + { "FastTrak TX2000",     PDC_UDMA_133, PDC_133_MHZ }, /* pdc20271 */
> >> + { "MBUltra133",          PDC_UDMA_133, PDC_133_MHZ }, /* pdc20275 */
> >> + { "MBFastTrak 133 Lite", PDC_UDMA_133, PDC_133_MHZ }, /* pdc20276 */
> >> + { "SBFastTrak 133 Lite", PDC_UDMA_133, PDC_133_MHZ }, /* pdc20277 */
> >> +};
>
> In general I prefer to eliminate _all_ "marketing strings" from all
> drivers.  Model names appear on the market far faster than any
> maintainer could hope to keep up.  (granted, this is old hardware and
> not changing, in this case)  So as a general rule, it is preferred to
> only use strings when absolutely necessary, eliminating them completely
> if at all possible.
>
> > what exacty (besides PLL support) are the advantages
> > of libata driver?
>
> IDE controller hotplug is a lot easier, and proper locking is already
> there :)
>
> Jeff
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-ide" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

------=_NextPart_000_0016_01C4B540.93DA53F0
Content-Type: application/octet-stream;
	name="pdc2027x.diff"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="pdc2027x.diff"

diff -Nru libata-pdc-2.6-ori/drivers/scsi/Kconfig =
libata-pdc-2.6/drivers/scsi/Kconfig=0A=
--- libata-pdc-2.6-ori/drivers/scsi/Kconfig	2004-10-18 =
17:25:52.000000000 +0800=0A=
+++ libata-pdc-2.6/drivers/scsi/Kconfig	2004-10-18 17:27:36.759587840 =
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
diff -Nru libata-pdc-2.6-ori/drivers/scsi/Makefile =
libata-pdc-2.6/drivers/scsi/Makefile=0A=
--- libata-pdc-2.6-ori/drivers/scsi/Makefile	2004-10-18 =
17:25:52.000000000 +0800=0A=
+++ libata-pdc-2.6/drivers/scsi/Makefile	2004-10-18 17:27:36.796582216 =
+0800=0A=
@@ -124,6 +124,7 @@=0A=
 obj-$(CONFIG_SCSI_SATA_AHCI)	+=3D libata.o ahci.o=0A=
 obj-$(CONFIG_SCSI_SATA_SVW)	+=3D libata.o sata_svw.o=0A=
 obj-$(CONFIG_SCSI_ATA_PIIX)	+=3D libata.o ata_piix.o=0A=
+obj-$(CONFIG_SCSI_PATA_PDC2027X)+=3D libata.o pata_pdc2027x.o=0A=
 obj-$(CONFIG_SCSI_SATA_PROMISE)	+=3D libata.o sata_promise.o=0A=
 obj-$(CONFIG_SCSI_SATA_SIL)	+=3D libata.o sata_sil.o=0A=
 obj-$(CONFIG_SCSI_SATA_VIA)	+=3D libata.o sata_via.o=0A=
diff -Nru libata-pdc-2.6-ori/drivers/scsi/pata_pdc2027x.c =
libata-pdc-2.6/drivers/scsi/pata_pdc2027x.c=0A=
--- libata-pdc-2.6-ori/drivers/scsi/pata_pdc2027x.c	1970-01-01 =
08:00:00.000000000 +0800=0A=
+++ libata-pdc-2.6/drivers/scsi/pata_pdc2027x.c	2004-10-18 =
17:27:37.993400272 +0800=0A=
@@ -0,0 +1,758 @@=0A=
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
+#define DRV_VERSION	"0.52"=0A=
+#undef PDC_DEBUG=0A=
+#undef PDC_20276_QUIRK=0A=
+#undef PDC_20270_QUIRK=0A=
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
+=0A=
+/* =0A=
+ * ATA Timing Tables based on 133MHz controller clock.=0A=
+ * These tables are only used when the controller is in 133MHz clock.=0A=
+ * If the controller is in 100MHz clock, the ASIC hardware will =0A=
+ * set the timing registers automatically when "set feature" command =0A=
+ * issued to the device. However, if the controller clock is 133MHz, =0A=
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
+static struct ata_port_operations pdc2027x_pata_ops =3D {=0A=
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
+=0A=
+	.bmdma_setup            =3D ata_bmdma_setup,=0A=
+	.bmdma_start            =3D ata_bmdma_start,=0A=
+	.qc_prep		=3D ata_qc_prep,=0A=
+	.qc_issue		=3D ata_qc_issue_prot,=0A=
+	.eng_timeout		=3D ata_eng_timeout,=0A=
+=0A=
+	.irq_handler		=3D ata_interrupt,=0A=
+	.irq_clear              =3D ata_bmdma_irq_clear,=0A=
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
+		.pio_mask	=3D 0x03, /* pio3-4 */=0A=
+		.mwdma_mask	=3D 0x06, /* mwdma1-2 */=0A=
+		.udma_mask	=3D ATA_UDMA5,=0A=
+		.port_ops	=3D &pdc2027x_pata_ops,=0A=
+	},=0A=
+	/* PDC_UDMA_133 */=0A=
+	{=0A=
+		.sht		=3D &pdc2027x_sht,=0A=
+		.host_flags	=3D ATA_FLAG_NO_LEGACY | ATA_FLAG_SLAVE_POSS | =0A=
+                        	  ATA_FLAG_SRST,=0A=
+		.pio_mask	=3D 0x03, /* pio3-4 */=0A=
+		.mwdma_mask	=3D 0x06, /* mwdma1-2 */=0A=
+		.udma_mask	=3D ATA_UDMA6,=0A=
+		.port_ops	=3D &pdc2027x_pata_ops,=0A=
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
+	u8 tmp8;=0A=
+=0A=
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
+	/*=0A=
+	 *  Check whether the device supports turning off IORDY.=0A=
+	 * For PIO3 and above, the device must support IORDY and set bit 10 =0A=
+	 */=0A=
+	if (adev->id[49] & 0x400) { =0A=
+		/* IORDY_EN & PREFETCH_EN */=0A=
+		/* Turn on Prefetch */=0A=
+		tmp8 =3D pdc_get_indexed_reg(ap, 0x13 + adj);=0A=
+		pdc_set_indexed_reg(ap, 0x13 + adj, tmp8 | 0x03);=0A=
+=0A=
+		PDPRINTK("Turn on prefetch\n");=0A=
+	}=0A=
+=0A=
+	printk(KERN_INFO DRV_NAME ": Set to pio mode[%u] \n", pio);=0A=
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
+		printk(KERN_INFO DRV_NAME ": Set to udma mode[%u] \n", udma_mode);=0A=
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
+		printk(KERN_INFO DRV_NAME ": Set to mdma mode[%u] \n", mdma_mode);=0A=
+	} else {=0A=
+		printk(KERN_ERR DRV_NAME ": Unknown dma mode [%u] ignored\n", =
dma_mode);=0A=
+	}=0A=
+}=0A=
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
+	/* Enable the ROM */=0A=
+	/*=0A=
+	if (pdev->resource[PCI_ROM_RESOURCE].start) {=0A=
+		pci_write_config_dword(pdev, PCI_ROM_ADDRESS,=0A=
+			pdev->resource[PCI_ROM_RESOURCE].start | PCI_ROM_ADDRESS_ENABLE);=0A=
+		printk(KERN_INFO DRV_NAME ": ROM enabled at 0x%08lx\n",=0A=
+		       pdev->resource[PCI_ROM_RESOURCE].start);=0A=
+	}=0A=
+	*/=0A=
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
+#ifdef PDC_20276_QUIRK=0A=
+	/*=0A=
+	 * Skip Promise PDC20276 attached to I2O RAID controller =0A=
+	 */=0A=
+	if ((pdev->device =3D=3D PCI_DEVICE_ID_PROMISE_20276) &&=0A=
+	    (pdev->bus->self) &&=0A=
+	    (pdev->bus->self->vendor =3D=3D PCI_VENDOR_ID_INTEL) &&=0A=
+	    ((pdev->bus->self->device =3D=3D PCI_DEVICE_ID_INTEL_I960) ||=0A=
+	     (pdev->bus->self->device =3D=3D PCI_DEVICE_ID_INTEL_I960RM))) {=0A=
+		printk(KERN_INFO DRV_NAME ": Skipping Promise PDC20276 "=0A=
+		       "attached to I2O RAID controller.\n");=0A=
+		return -ENODEV;=0A=
+	}=0A=
+#endif=0A=
+=0A=
+#ifdef PDC_20270_QUIRK=0A=
+	/*=0A=
+	 * Special IRQ handling for Promise PDC20270 attached to the =0A=
+	 * DEC DC21150 PCI south bridge.  (DC21150 PCI bridge can be found =0A=
+	 * on Compaq ProLiant 800 and ProLiant 1600 servers.) =0A=
+	 * FIXME: Not tested yet on libata.=0A=
+	 */=0A=
+	if ((pdev->device =3D=3D PCI_DEVICE_ID_PROMISE_20270) &&=0A=
+	    (pdev->bus->self) &&=0A=
+	    (pdev->bus->self->vendor =3D=3D PCI_VENDOR_ID_DEC) &&=0A=
+	    (pdev->bus->self->device =3D=3D PCI_DEVICE_ID_DEC_21150)) {=0A=
+		struct pci_dev *findev =3D NULL;=0A=
+=0A=
+		if (PCI_SLOT(pdev->devfn) & 2) {=0A=
+			/* This pdc20270 is in PCI slot with bit 1 set.=0A=
+			 * Find the other pdc20270 in PCI slot with bit 1 cleared.=0A=
+			 * If found, override my IRQ setting to irq of that device.=0A=
+			 */=0A=
+			//d->extra =3D 0; // No extra DMA address on pdc20270=0A=
+					   =0A=
+			while ((findev =3D pci_find_device(PCI_ANY_ID, PCI_ANY_ID, findev)) =
!=3D NULL) {=0A=
+				if ((findev->vendor =3D=3D pdev->vendor) &&=0A=
+				    (findev->device =3D=3D pdev->device) &&=0A=
+				    (!(PCI_SLOT(findev->devfn) & 2))) {=0A=
+					=0A=
+					if (pdev->irq !=3D findev->irq) {=0A=
+						// Override the IRQ setting=0A=
+						pdev->irq =3D findev->irq;=0A=
+						break;=0A=
+					}=0A=
+				}=0A=
+			}=0A=
+		}=0A=
+=0A=
+	}=0A=
+#endif=0A=
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
+	probe_ent->pdev =3D pdev;=0A=
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
=0A=

------=_NextPart_000_0016_01C4B540.93DA53F0--

