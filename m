From: Alek Du <alek.du@intel.com>
Subject: [PATCH] ata: Add Intel SCH PATA support (revised)
Date: Mon, 28 Apr 2008 12:05:17 +0800
Message-ID: <20080428120517.3025b6c6@dxy.sh.intel.com>
References: <20080426140007.63cfeede@dxy.sh.intel.com>
	<20080426103012.21dcf0fb@core>
	<20080427075115.3ea40204@dxy.sh.intel.com>
	<20080427093434.182a2137@core>
	<20080427220315.794a6df3@dxy.sh.intel.com>
	<20080427153111.3438dce8@core>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:23965 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750794AbYD1EMG (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 28 Apr 2008 00:12:06 -0400
In-Reply-To: <20080427153111.3438dce8@core>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, jgarzik@pobox.com
Cc: linux-ide@vger.kernel.org

Hi Alan, Jeff

I re-write the patch according to the kind comments from Alan, I also did the test on my SCH machine. Please review it again. Thanks a lot.

This patch adds Intel SCH chipsets (US15W, US15L, UL11L) PATA controller
support.

Signed-off-by: Alek Du <alek.du@intel.com>
---
 drivers/ata/ata_piix.c  |   29 +++++++++++++++++++++++++++++
 drivers/ide/pci/piix.c  |    2 ++
 include/linux/pci_ids.h |    2 ++
 3 files changed, 33 insertions(+), 0 deletions(-)

diff --git a/drivers/ata/ata_piix.c b/drivers/ata/ata_piix.c
index ea2c764..863c473 100644
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
@@ -164,6 +165,7 @@ static void piix_set_piomode(struct ata_port *ap, struct ata_device *adev);
 static void piix_set_dmamode(struct ata_port *ap, struct ata_device *adev);
 static void ich_set_dmamode(struct ata_port *ap, struct ata_device *adev);
 static int ich_pata_cable_detect(struct ata_port *ap);
+static int sch_pata_cable_detect(struct ata_port *ap);
 static u8 piix_vmw_bmdma_status(struct ata_port *ap);
 static int piix_sidpr_scr_read(struct ata_port *ap, unsigned int reg, u32 *val);
 static int piix_sidpr_scr_write(struct ata_port *ap, unsigned int reg, u32 val);
@@ -216,6 +218,8 @@ static const struct pci_device_id piix_pci_tbl[] = {
 	{ 0x8086, 0x269E, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich_pata_100 },
 	/* ICH8 Mobile PATA Controller */
 	{ 0x8086, 0x2850, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich_pata_100 },
+	/* Intel SCH PATA Controller */
+	{ 0x8086, 0x811A, PCI_ANY_ID, PCI_ANY_ID, 0, 0, sch_pata_100 },
 
 	/* NOTE: The following PCI ids must be kept in sync with the
 	 * list in drivers/pci/quirks.c.
@@ -311,6 +315,13 @@ static struct ata_port_operations ich_pata_ops = {
 	.set_dmamode		= ich_set_dmamode,
 };
 
+static struct ata_port_operations sch_pata_ops = {
+	.inherits		= &piix_pata_ops,
+	.cable_detect		= sch_pata_cable_detect,
+	.prereset		= ata_sff_prereset,
+	.set_dmamode		= ich_set_dmamode,
+};
+
 static struct ata_port_operations piix_sata_ops = {
 	.inherits		= &ata_bmdma_port_ops,
 };
@@ -470,6 +481,15 @@ static struct ata_port_info piix_port_info[] = {
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
@@ -614,6 +634,15 @@ static int ich_pata_cable_detect(struct ata_port *ap)
 }
 
 /**
+ * 	Intel SCH PATA controller could not detect cable type
+ * 	and always return ATA_CBL_PATA_UNK here.
+ */
+static int sch_pata_cable_detect(struct ata_port *ap)
+{
+	return ATA_CBL_PATA_UNK;
+}
+
+/**
  *	piix_pata_prereset - prereset for PATA host controller
  *	@link: Target link
  *	@deadline: deadline jiffies for the operation
diff --git a/drivers/ide/pci/piix.c b/drivers/ide/pci/piix.c
index 21c5dd2..31607fe 100644
--- a/drivers/ide/pci/piix.c
+++ b/drivers/ide/pci/piix.c
@@ -380,6 +380,7 @@ static const struct ide_port_info piix_pci_info[] __devinitdata = {
 	/* 22 */ DECLARE_ICH_DEV("ICH4",	ATA_UDMA5),
 	/* 23 */ DECLARE_ICH_DEV("ESB2",	ATA_UDMA5),
 	/* 24 */ DECLARE_ICH_DEV("ICH8M",	ATA_UDMA5),
+	/* 25 */ DECLARE_ICH_DEV("SCH",		ATA_UDMA5),
 };
 
 /**
@@ -453,6 +454,7 @@ static const struct pci_device_id piix_pci_tbl[] = {
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

Thanks,
Alek


On Sun, 27 Apr 2008 22:31:11 +0800
"Alan Cox" <alan@lxorguk.ukuu.org.uk> wrote:

> Re: [PATCH] ata: Add Intel SCH PATA support
> 
> On Sun, 27 Apr 2008 22:03:15 +0800
> Alek Du <alek.du@intel.com> wrote:
> 
> > Alan,
> >
> > One problem I still do not understand, if I return PATA_UNK for cable detection result, could the
> > driver finally set the disk to UDMA5 mode if I plug in 80 wire disk?
> 
> You tell me - you've got the hardware documentation I assume. Assuming the
> system implements detection then it should. If a PATA controller doesn't
> implement any detection (cable or host side) and it does UDMA5 then I
> believe the correct description for it is usually "broken" as people will
> have horrible problems trying to use things like flash drives with it.
> 
> Alan
