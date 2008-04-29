From: Alek Du <alek.du@intel.com>
Subject: Re: [PATCH] ata: Add Intel SCH PATA support (revised)
Date: Tue, 29 Apr 2008 11:39:05 +0800
Message-ID: <20080429113905.757703fd@dxy.sh.intel.com>
References: <20080426140007.63cfeede@dxy.sh.intel.com>
	<20080428094123.59d055c7@core>
	<20080428170751.097bdbe6@dxy.sh.intel.com>
	<200804282101.33012.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:43166 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751795AbYD2Dpz (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 28 Apr 2008 23:45:55 -0400
In-Reply-To: <200804282101.33012.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org

Hi Alan and Bartlomiej,

Modified the patch again. Add and use DECLARE_SCH_DEV instead of DECLARE_ICH_DEV
to avoid enable_bits. But I still use ATA_CBL_UNK, because according to my test,
it works fine -- it could set the disk to UDMA5 mode when using 80 wire cable.
Please review it again, thanks.

This patch adds Intel SCH chipsets (US15W, US15L, UL11L) PATA controller
support.

Signed-off-by: Alek Du <alek.du@intel.com>
---
 drivers/ata/ata_piix.c  |   19 +++++++++++++++++++
 drivers/ide/pci/piix.c  |   15 +++++++++++++++
 include/linux/pci_ids.h |    2 ++
 3 files changed, 36 insertions(+), 0 deletions(-)

diff --git a/drivers/ata/ata_piix.c b/drivers/ata/ata_piix.c
index ea2c764..4ec4178 100644
--- a/drivers/ata/ata_piix.c
+++ b/drivers/ata/ata_piix.c
@@ -136,6 +136,7 @@ enum piix_controller_ids {
 	ich_pata_33,		/* ICH up to UDMA 33 only */
 	ich_pata_66,		/* ICH up to 66 Mhz */
 	ich_pata_100,		/* ICH up to UDMA 100 */
+	sch_pata_100,		/* SCH up to UDMA 100 */
 	ich5_sata,
 	ich6_sata,
 	ich6m_sata,
@@ -216,6 +217,8 @@ static const struct pci_device_id piix_pci_tbl[] = {
 	{ 0x8086, 0x269E, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich_pata_100 },
 	/* ICH8 Mobile PATA Controller */
 	{ 0x8086, 0x2850, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich_pata_100 },
+	/* Intel SCH PATA Controller */
+	{ 0x8086, 0x811A, PCI_ANY_ID, PCI_ANY_ID, 0, 0, sch_pata_100 },
 
 	/* NOTE: The following PCI ids must be kept in sync with the
 	 * list in drivers/pci/quirks.c.
@@ -311,6 +314,13 @@ static struct ata_port_operations ich_pata_ops = {
 	.set_dmamode		= ich_set_dmamode,
 };
 
+static struct ata_port_operations sch_pata_ops = {
+	.inherits		= &piix_pata_ops,
+	.cable_detect		= ata_cable_unknown,
+	.prereset		= ata_sff_prereset,
+	.set_dmamode		= ich_set_dmamode,
+};
+
 static struct ata_port_operations piix_sata_ops = {
 	.inherits		= &ata_bmdma_port_ops,
 };
@@ -470,6 +480,15 @@ static struct ata_port_info piix_port_info[] = {
 		.port_ops	= &ich_pata_ops,
 	},
 
+	[sch_pata_100] =
+	{
+		.flags		= PIIX_PATA_FLAGS | PIIX_FLAG_CHECKINTR,
+		.pio_mask	= 0x1f,	/* pio0-4 */
+		.mwdma_mask	= 0x06, /* mwdma1-2 */
+		.udma_mask	= ATA_UDMA5, /* udma0-5 */
+		.port_ops	= &sch_pata_ops,
+	},
+
 	[ich5_sata] =
 	{
 		.flags		= PIIX_SATA_FLAGS,
diff --git a/drivers/ide/pci/piix.c b/drivers/ide/pci/piix.c
index 21c5dd2..d224a67 100644
--- a/drivers/ide/pci/piix.c
+++ b/drivers/ide/pci/piix.c
@@ -340,6 +340,19 @@ static const struct ide_port_ops piix_port_ops = {
 		.udma_mask	= udma, \
 	}
 
+#define DECLARE_SCH_DEV(name_str, udma) \
+	{ \
+		.name		= name_str, \
+		.init_chipset	= init_chipset_ich, \
+		.init_hwif	= init_hwif_ich, \
+		.port_ops	= &piix_port_ops, \
+		.host_flags	= IDE_HFLAGS_PIIX, \
+		.pio_mask	= ATA_PIO4, \
+		.swdma_mask	= ATA_SWDMA2_ONLY, \
+		.mwdma_mask	= ATA_MWDMA12_ONLY, \
+		.udma_mask	= udma, \
+	}
+
 static const struct ide_port_info piix_pci_info[] __devinitdata = {
 	/*  0 */ DECLARE_PIIX_DEV("PIIXa",	0x00),	/* no udma */
 	/*  1 */ DECLARE_PIIX_DEV("PIIXb",	0x00),	/* no udma */
@@ -380,6 +393,7 @@ static const struct ide_port_info piix_pci_info[] __devinitdata = {
 	/* 22 */ DECLARE_ICH_DEV("ICH4",	ATA_UDMA5),
 	/* 23 */ DECLARE_ICH_DEV("ESB2",	ATA_UDMA5),
 	/* 24 */ DECLARE_ICH_DEV("ICH8M",	ATA_UDMA5),
+	/* 25 */ DECLARE_SCH_DEV("SCH",		ATA_UDMA5),
 };
 
 /**
@@ -453,6 +467,7 @@ static const struct pci_device_id piix_pci_tbl[] = {
 	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_82801DB_1),  22 },
 	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_ESB2_18),    23 },
 	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_ICH8_6),     24 },
+	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_SCH_IDE),    25 },
 	{ 0, },
 };
 MODULE_DEVICE_TABLE(pci, piix_pci_tbl);
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index 70eb3c8..e5a53da 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -2413,6 +2413,8 @@
 #define PCI_DEVICE_ID_INTEL_82443GX_0	0x71a0
 #define PCI_DEVICE_ID_INTEL_82443GX_2	0x71a2
 #define PCI_DEVICE_ID_INTEL_82372FB_1	0x7601
+#define PCI_DEVICE_ID_INTEL_SCH_LPC	0x8119
+#define PCI_DEVICE_ID_INTEL_SCH_IDE	0x811a
 #define PCI_DEVICE_ID_INTEL_82454GX	0x84c4
 #define PCI_DEVICE_ID_INTEL_82450GX	0x84c5
 #define PCI_DEVICE_ID_INTEL_82451NX	0x84ca
-- 
1.5.2.5




On Tue, 29 Apr 2008 03:01:32 +0800
"Bartlomiej Zolnierkiewicz" <bzolnier@gmail.com> wrote:

> > diff --git a/drivers/ide/pci/piix.c b/drivers/ide/pci/piix.c
> > index 21c5dd2..31607fe 100644
> > --- a/drivers/ide/pci/piix.c
> > +++ b/drivers/ide/pci/piix.c
> > @@ -380,6 +380,7 @@ static const struct ide_port_info piix_pci_info[] __devinitdata = {
> >       /* 22 */ DECLARE_ICH_DEV("ICH4",        ATA_UDMA5),
> >       /* 23 */ DECLARE_ICH_DEV("ESB2",        ATA_UDMA5),
> >       /* 24 */ DECLARE_ICH_DEV("ICH8M",       ATA_UDMA5),
> > +     /* 25 */ DECLARE_ICH_DEV("SCH",         ATA_UDMA5),
> 
> DECLARE_ICH_DEV() cannot be used here - seems like DEFINE_SCH_DEV()
> needs to be defined (which will lack .enablebits field but otherwise
> be identical to DECLARE_ICH_DEV)
> 
> also seems that piix_cable_detect() should be updated to check for
> dev->device == PCI_DEVICE_ID_INTEL_SCH_IDE and return ATA_CBL_PATA80
> (it is OK to use it instead of ATA_CBL_UNK in drivers/ide/ - generic
> cable detection code won't override drive side cable detection).
> 
> otherwise everything looks good
> 
> Thanks,
> Bart
