From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH] libata: apply grand renaming to pata drivers
Date: Wed, 16 Aug 2006 00:56:25 +0900
Message-ID: <20060815155625.GG6371@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.231]:60591 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1030363AbWHOP4d (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 15 Aug 2006 11:56:33 -0400
Received: by wx-out-0506.google.com with SMTP id s14so171632wxc
        for <linux-ide@vger.kernel.org>; Tue, 15 Aug 2006 08:56:32 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org

Apply grand renaming in #upstream to pata-drivers.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
This patch is available in the following git tree.

  http://htj.dyndns.org/git/?p=libata-tj.git;a=shortlog;h=grand-rename-pata-drivers
  git://htj.dyndns.org/libata-tj grand-rename-pata-drivers

Jeff, #grand-rename-pata-drivers pulls in the updated #upstream and
resolves conflicts in ata_piix.c, and this patch is dependent on how
conflict is resolved during pull.

This patch also has been verified by comparing generated assemblies.

Thanks.

 drivers/ata/ata_generic.c       |    2 +-
 drivers/ata/ata_piix.c          |    2 +-
 drivers/ata/pata_ali.c          |   22 +++++++++++-----------
 drivers/ata/pata_amd.c          |   28 ++++++++++++++--------------
 drivers/ata/pata_artop.c        |   22 +++++++++++-----------
 drivers/ata/pata_atiixp.c       |   12 ++++++------
 drivers/ata/pata_cmd64x.c       |   20 ++++++++++----------
 drivers/ata/pata_cs5520.c       |    8 ++++----
 drivers/ata/pata_cs5530.c       |    4 ++--
 drivers/ata/pata_cs5535.c       |    4 ++--
 drivers/ata/pata_cypress.c      |    4 ++--
 drivers/ata/pata_efar.c         |    8 ++++----
 drivers/ata/pata_hpt366.c       |   10 +++++-----
 drivers/ata/pata_hpt37x.c       |   32 ++++++++++++++++----------------
 drivers/ata/pata_hpt3x2n.c      |   16 ++++++++--------
 drivers/ata/pata_hpt3x3.c       |    6 +++---
 drivers/ata/pata_isapnp.c       |    8 ++++----
 drivers/ata/pata_it8172.c       |    8 ++++----
 drivers/ata/pata_it821x.c       |   14 +++++++-------
 drivers/ata/pata_jmicron.c      |    4 ++--
 drivers/ata/pata_legacy.c       |   12 ++++++------
 drivers/ata/pata_mpiix.c        |   10 +++++-----
 drivers/ata/pata_netcell.c      |    2 +-
 drivers/ata/pata_ns87410.c      |    6 +++---
 drivers/ata/pata_oldpiix.c      |    8 ++++----
 drivers/ata/pata_opti.c         |    4 ++--
 drivers/ata/pata_optidma.c      |   10 +++++-----
 drivers/ata/pata_pcmcia.c       |    6 +++---
 drivers/ata/pata_pdc2027x.c     |   10 +++++-----
 drivers/ata/pata_pdc202xx_old.c |   20 ++++++++++----------
 drivers/ata/pata_qdi.c          |   12 ++++++------
 drivers/ata/pata_radisys.c      |    6 +++---
 drivers/ata/pata_rz1000.c       |    2 +-
 drivers/ata/pata_sc1200.c       |    6 +++---
 drivers/ata/pata_serverworks.c  |   18 +++++++++---------
 drivers/ata/pata_sil680.c       |   12 ++++++------
 drivers/ata/pata_sis.c          |   38 +++++++++++++++++++-------------------
 drivers/ata/pata_sl82c105.c     |   12 ++++++------
 drivers/ata/pata_triflex.c      |    6 +++---
 drivers/ata/pata_via.c          |   24 ++++++++++++------------
 40 files changed, 229 insertions(+), 229 deletions(-)

diff --git a/drivers/ata/ata_generic.c b/drivers/ata/ata_generic.c
index cad6607..20b191d 100644
--- a/drivers/ata/ata_generic.c
+++ b/drivers/ata/ata_generic.c
@@ -169,7 +169,7 @@ static int ata_generic_init_one(struct p
 	u16 command;
 	static struct ata_port_info info = {
 		.sht = &generic_sht,
-		.host_flags = ATA_FLAG_SLAVE_POSS | ATA_FLAG_SRST,
+		.flags = ATA_FLAG_SLAVE_POSS | ATA_FLAG_SRST,
 		.pio_mask = 0x1f,
 		.mwdma_mask = 0x07,
 		.udma_mask = 0x3f,
diff --git a/drivers/ata/ata_piix.c b/drivers/ata/ata_piix.c
index 0cd8524..f78ae4a 100644
--- a/drivers/ata/ata_piix.c
+++ b/drivers/ata/ata_piix.c
@@ -631,7 +631,7 @@ static void piix_pata_error_handler(stru
  */
 static int ich_pata_prereset(struct ata_port *ap)
 {
-	struct pci_dev *pdev = to_pci_dev(ap->host_set->dev);
+	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
 
 	if (!pci_test_config_bits(pdev, &piix_enable_bits[ap->port_no])) {
 		ata_port_printk(ap, KERN_INFO, "port disabled. ignoring.\n");
diff --git a/drivers/ata/pata_ali.c b/drivers/ata/pata_ali.c
index c9041e1..0e0415e 100644
--- a/drivers/ata/pata_ali.c
+++ b/drivers/ata/pata_ali.c
@@ -71,7 +71,7 @@ static int ali_cable_override(struct pci
 
 static int ali_c2_cable_detect(struct ata_port *ap)
 {
-	struct pci_dev *pdev = to_pci_dev(ap->host_set->dev);
+	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
 	u8 ata66;
 
 	/* Certain laptops use short but suitable cables and don't
@@ -176,7 +176,7 @@ static unsigned long ali_20_filter(const
 
 static void ali_fifo_control(struct ata_port *ap, struct ata_device *adev, int on)
 {
-	struct pci_dev *pdev = to_pci_dev(ap->host_set->dev);
+	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
 	int pio_fifo = 0x54 + ap->port_no;
 	u8 fifo;
 	int shift = 4 * adev->devno;
@@ -207,7 +207,7 @@ static void ali_fifo_control(struct ata_
 
 static void ali_program_modes(struct ata_port *ap, struct ata_device *adev, struct ata_timing *t, u8 ultra)
 {
-	struct pci_dev *pdev = to_pci_dev(ap->host_set->dev);
+	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
 	int cas = 0x58 + 4 * ap->port_no;	/* Command timing */
 	int cbt = 0x59 + 4 * ap->port_no;	/* Command timing */
 	int drwt = 0x5A + 4 * ap->port_no + adev->devno; /* R/W timing */
@@ -283,7 +283,7 @@ static void ali_set_dmamode(struct ata_p
 	struct ata_device *pair = ata_dev_pair(adev);
 	struct ata_timing t;
 	unsigned long T =  1000000000 / 33333;	/* PCI clock based */
-	struct pci_dev *pdev = to_pci_dev(ap->host_set->dev);
+	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
 
 
 	if (adev->class == ATA_DEV_ATA)
@@ -509,14 +509,14 @@ static int ali_init_one(struct pci_dev *
 {
 	static struct ata_port_info info_early = {
 		.sht = &ali_sht,
-		.host_flags = ATA_FLAG_SLAVE_POSS | ATA_FLAG_SRST,
+		.flags = ATA_FLAG_SLAVE_POSS | ATA_FLAG_SRST,
 		.pio_mask = 0x1f,
 		.port_ops = &ali_early_port_ops
 	};
 	/* Revision 0x20 added DMA */
 	static struct ata_port_info info_20 = {
 		.sht = &ali_sht,
-		.host_flags = ATA_FLAG_SLAVE_POSS | ATA_FLAG_SRST | ATA_FLAG_PIO_LBA48,
+		.flags = ATA_FLAG_SLAVE_POSS | ATA_FLAG_SRST | ATA_FLAG_PIO_LBA48,
 		.pio_mask = 0x1f,
 		.mwdma_mask = 0x07,
 		.port_ops = &ali_20_port_ops
@@ -524,7 +524,7 @@ static int ali_init_one(struct pci_dev *
 	/* Revision 0x20 with support logic added UDMA */
 	static struct ata_port_info info_20_udma = {
 		.sht = &ali_sht,
-		.host_flags = ATA_FLAG_SLAVE_POSS | ATA_FLAG_SRST | ATA_FLAG_PIO_LBA48,
+		.flags = ATA_FLAG_SLAVE_POSS | ATA_FLAG_SRST | ATA_FLAG_PIO_LBA48,
 		.pio_mask = 0x1f,
 		.mwdma_mask = 0x07, 
 		.udma_mask = 0x07,	/* UDMA33 */
@@ -533,7 +533,7 @@ static int ali_init_one(struct pci_dev *
 	/* Revision 0xC2 adds UDMA66 */
 	static struct ata_port_info info_c2 = {
 		.sht = &ali_sht,
-		.host_flags = ATA_FLAG_SLAVE_POSS | ATA_FLAG_SRST | ATA_FLAG_PIO_LBA48,
+		.flags = ATA_FLAG_SLAVE_POSS | ATA_FLAG_SRST | ATA_FLAG_PIO_LBA48,
 		.pio_mask = 0x1f,
 		.mwdma_mask = 0x07,
 		.udma_mask = 0x1f,
@@ -542,7 +542,7 @@ static int ali_init_one(struct pci_dev *
 	/* Revision 0xC3 is UDMA100 */
 	static struct ata_port_info info_c3 = {
 		.sht = &ali_sht,
-		.host_flags = ATA_FLAG_SLAVE_POSS | ATA_FLAG_SRST | ATA_FLAG_PIO_LBA48,
+		.flags = ATA_FLAG_SLAVE_POSS | ATA_FLAG_SRST | ATA_FLAG_PIO_LBA48,
 		.pio_mask = 0x1f,
 		.mwdma_mask = 0x07,
 		.udma_mask = 0x3f,
@@ -551,7 +551,7 @@ static int ali_init_one(struct pci_dev *
 	/* Revision 0xC4 is UDMA133 */
 	static struct ata_port_info info_c4 = {
 		.sht = &ali_sht,
-		.host_flags = ATA_FLAG_SLAVE_POSS | ATA_FLAG_SRST | ATA_FLAG_PIO_LBA48,
+		.flags = ATA_FLAG_SLAVE_POSS | ATA_FLAG_SRST | ATA_FLAG_PIO_LBA48,
 		.pio_mask = 0x1f,
 		.mwdma_mask = 0x07,
 		.udma_mask = 0x7f,
@@ -560,7 +560,7 @@ static int ali_init_one(struct pci_dev *
 	/* Revision 0xC5 is UDMA133 with LBA48 DMA */
 	static struct ata_port_info info_c5 = {
 		.sht = &ali_sht,
-		.host_flags = ATA_FLAG_SLAVE_POSS | ATA_FLAG_SRST,
+		.flags = ATA_FLAG_SLAVE_POSS | ATA_FLAG_SRST,
 		.pio_mask = 0x1f,
 		.mwdma_mask = 0x07,
 		.udma_mask = 0x7f,
diff --git a/drivers/ata/pata_amd.c b/drivers/ata/pata_amd.c
index 14cc8a8..6ab5684 100644
--- a/drivers/ata/pata_amd.c
+++ b/drivers/ata/pata_amd.c
@@ -47,7 +47,7 @@ static void timing_setup(struct ata_port
 		6, 6, 5, 4, 0, 1, 1, 2, 2, 3, 3, 3, 3, 3, 3, 7
 	};
 
-	struct pci_dev *pdev = to_pci_dev(ap->host_set->dev);
+	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
 	struct ata_device *peer = ata_dev_pair(adev);
 	int dn = ap->port_no * 2 + adev->devno;
 	struct ata_timing at, apeer;
@@ -134,7 +134,7 @@ static int amd_pre_reset(struct ata_port
 		{ 0x40, 1, 0x01, 0x01 }
 	};
 
-	struct pci_dev *pdev = to_pci_dev(ap->host_set->dev);
+	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
 	u8 ata66;
 	
 	if (!pci_test_config_bits(pdev, &amd_enable_bits[ap->port_no])) {
@@ -161,7 +161,7 @@ static void amd_error_handler(struct ata
 
 static int amd_early_pre_reset(struct ata_port *ap)
 {
-	struct pci_dev *pdev = to_pci_dev(ap->host_set->dev);
+	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
 	static struct pci_bits amd_enable_bits[] = {
 		{ 0x40, 1, 0x02, 0x02 },
 		{ 0x40, 1, 0x01, 0x01 }
@@ -254,7 +254,7 @@ static void amd133_set_dmamode(struct at
 static int nv_pre_reset(struct ata_port *ap) {
 	static const u8 bitmask[2] = {0x03, 0xC0};
 
-	struct pci_dev *pdev = to_pci_dev(ap->host_set->dev);
+	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
 	u8 ata66;
 	u16 udma;
 
@@ -543,7 +543,7 @@ static int amd_init_one(struct pci_dev *
 	static struct ata_port_info info[10] = {
 		{	/* 0: AMD 7401 */
 			.sht = &amd_sht,
-			.host_flags = ATA_FLAG_SLAVE_POSS | ATA_FLAG_SRST,
+			.flags = ATA_FLAG_SLAVE_POSS | ATA_FLAG_SRST,
 			.pio_mask = 0x1f,
 			.mwdma_mask = 0x07,	/* No SWDMA */
 			.udma_mask = 0x07,	/* UDMA 33 */
@@ -551,7 +551,7 @@ static int amd_init_one(struct pci_dev *
 		},
 		{	/* 1: Early AMD7409 - no swdma */
 			.sht = &amd_sht,
-			.host_flags = ATA_FLAG_SLAVE_POSS | ATA_FLAG_SRST,
+			.flags = ATA_FLAG_SLAVE_POSS | ATA_FLAG_SRST,
 			.pio_mask = 0x1f,
 			.mwdma_mask = 0x07,
 			.udma_mask = 0x1f,	/* UDMA 66 */
@@ -559,7 +559,7 @@ static int amd_init_one(struct pci_dev *
 		},
 		{	/* 2: AMD 7409, no swdma errata */
 			.sht = &amd_sht,
-			.host_flags = ATA_FLAG_SLAVE_POSS | ATA_FLAG_SRST,
+			.flags = ATA_FLAG_SLAVE_POSS | ATA_FLAG_SRST,
 			.pio_mask = 0x1f,
 			.mwdma_mask = 0x07,
 			.udma_mask = 0x1f,	/* UDMA 66 */
@@ -567,7 +567,7 @@ static int amd_init_one(struct pci_dev *
 		},
 		{	/* 3: AMD 7411 */
 			.sht = &amd_sht,
-			.host_flags = ATA_FLAG_SLAVE_POSS | ATA_FLAG_SRST,
+			.flags = ATA_FLAG_SLAVE_POSS | ATA_FLAG_SRST,
 			.pio_mask = 0x1f,
 			.mwdma_mask = 0x07,
 			.udma_mask = 0x3f,	/* UDMA 100 */
@@ -575,7 +575,7 @@ static int amd_init_one(struct pci_dev *
 		},
 		{	/* 4: AMD 7441 */
 			.sht = &amd_sht,
-			.host_flags = ATA_FLAG_SLAVE_POSS | ATA_FLAG_SRST,
+			.flags = ATA_FLAG_SLAVE_POSS | ATA_FLAG_SRST,
 			.pio_mask = 0x1f,
 			.mwdma_mask = 0x07,
 			.udma_mask = 0x3f,	/* UDMA 100 */
@@ -583,7 +583,7 @@ static int amd_init_one(struct pci_dev *
 		},
 		{	/* 5: AMD 8111*/
 			.sht = &amd_sht,
-			.host_flags = ATA_FLAG_SLAVE_POSS | ATA_FLAG_SRST,
+			.flags = ATA_FLAG_SLAVE_POSS | ATA_FLAG_SRST,
 			.pio_mask = 0x1f,
 			.mwdma_mask = 0x07,
 			.udma_mask = 0x7f,	/* UDMA 133, no swdma */
@@ -591,7 +591,7 @@ static int amd_init_one(struct pci_dev *
 		},
 		{	/* 6: AMD 8111 UDMA 100 (Serenade) */
 			.sht = &amd_sht,
-			.host_flags = ATA_FLAG_SLAVE_POSS | ATA_FLAG_SRST,
+			.flags = ATA_FLAG_SLAVE_POSS | ATA_FLAG_SRST,
 			.pio_mask = 0x1f,
 			.mwdma_mask = 0x07,
 			.udma_mask = 0x3f,	/* UDMA 100, no swdma */
@@ -599,7 +599,7 @@ static int amd_init_one(struct pci_dev *
 		},
 		{	/* 7: Nvidia Nforce */
 			.sht = &amd_sht,
-			.host_flags = ATA_FLAG_SLAVE_POSS | ATA_FLAG_SRST,
+			.flags = ATA_FLAG_SLAVE_POSS | ATA_FLAG_SRST,
 			.pio_mask = 0x1f,
 			.mwdma_mask = 0x07,
 			.udma_mask = 0x3f,	/* UDMA 100 */
@@ -607,7 +607,7 @@ static int amd_init_one(struct pci_dev *
 		},
 		{	/* 8: Nvidia Nforce2 and later */
 			.sht = &amd_sht,
-			.host_flags = ATA_FLAG_SLAVE_POSS | ATA_FLAG_SRST,
+			.flags = ATA_FLAG_SLAVE_POSS | ATA_FLAG_SRST,
 			.pio_mask = 0x1f,
 			.mwdma_mask = 0x07,
 			.udma_mask = 0x7f,	/* UDMA 133, no swdma */
@@ -615,7 +615,7 @@ static int amd_init_one(struct pci_dev *
 		},
 		{	/* 9: AMD CS5536 (Geode companion) */
 			.sht = &amd_sht,
-			.host_flags = ATA_FLAG_SLAVE_POSS | ATA_FLAG_SRST,
+			.flags = ATA_FLAG_SLAVE_POSS | ATA_FLAG_SRST,
 			.pio_mask = 0x1f,
 			.mwdma_mask = 0x07,
 			.udma_mask = 0x3f,	/* UDMA 100 */
diff --git a/drivers/ata/pata_artop.c b/drivers/ata/pata_artop.c
index b566d99..d6ef3bf 100644
--- a/drivers/ata/pata_artop.c
+++ b/drivers/ata/pata_artop.c
@@ -41,7 +41,7 @@ static int clock = 0;
 
 static int artop6210_pre_reset(struct ata_port *ap)
 {
-	struct pci_dev *pdev = to_pci_dev(ap->host_set->dev);
+	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
 	const struct pci_bits artop_enable_bits[] = {
 		{ 0x4AU, 1U, 0x02UL, 0x02UL },	/* port 0 */
 		{ 0x4AU, 1U, 0x04UL, 0x04UL },	/* port 1 */
@@ -86,7 +86,7 @@ static int artop6260_pre_reset(struct at
 		{ 0x4AU, 1U, 0x04UL, 0x04UL },	/* port 1 */
 	};
 
-	struct pci_dev *pdev = to_pci_dev(ap->host_set->dev);
+	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
 	u8 tmp;
 
 	/* Odd numbered device ids are the units with enable bits (the -R cards) */
@@ -134,7 +134,7 @@ static void artop6260_error_handler(stru
 
 static void artop6210_load_piomode(struct ata_port *ap, struct ata_device *adev, unsigned int pio)
 {
-	struct pci_dev *pdev	= to_pci_dev(ap->host_set->dev);
+	struct pci_dev *pdev	= to_pci_dev(ap->host->dev);
 	int dn = adev->devno + 2 * ap->port_no;
 	const u16 timing[2][5] = {
 		{ 0x0000, 0x000A, 0x0008, 0x0303, 0x0301 },
@@ -161,7 +161,7 @@ static void artop6210_load_piomode(struc
 
 static void artop6210_set_piomode(struct ata_port *ap, struct ata_device *adev)
 {
-	struct pci_dev *pdev	= to_pci_dev(ap->host_set->dev);
+	struct pci_dev *pdev	= to_pci_dev(ap->host->dev);
 	int dn = adev->devno + 2 * ap->port_no;
 	u8 ultra;
 
@@ -188,7 +188,7 @@ static void artop6210_set_piomode(struct
 
 static void artop6260_load_piomode (struct ata_port *ap, struct ata_device *adev, unsigned int pio)
 {
-	struct pci_dev *pdev	= to_pci_dev(ap->host_set->dev);
+	struct pci_dev *pdev	= to_pci_dev(ap->host->dev);
 	int dn = adev->devno + 2 * ap->port_no;
 	const u8 timing[2][5] = {
 		{ 0x00, 0x0A, 0x08, 0x33, 0x31 },
@@ -215,7 +215,7 @@ static void artop6260_load_piomode (stru
 
 static void artop6260_set_piomode(struct ata_port *ap, struct ata_device *adev)
 {
-	struct pci_dev *pdev	= to_pci_dev(ap->host_set->dev);
+	struct pci_dev *pdev	= to_pci_dev(ap->host->dev);
 	u8 ultra;
 
 	artop6260_load_piomode(ap, adev, adev->pio_mode - XFER_PIO_0);
@@ -240,7 +240,7 @@ static void artop6260_set_piomode(struct
 static void artop6210_set_dmamode (struct ata_port *ap, struct ata_device *adev)
 {
 	unsigned int pio;
-	struct pci_dev *pdev	= to_pci_dev(ap->host_set->dev);
+	struct pci_dev *pdev	= to_pci_dev(ap->host->dev);
 	int dn = adev->devno + 2 * ap->port_no;
 	u8 ultra;
 
@@ -280,7 +280,7 @@ static void artop6210_set_dmamode (struc
 static void artop6260_set_dmamode (struct ata_port *ap, struct ata_device *adev)
 {
 	unsigned int pio	= adev->pio_mode - XFER_PIO_0;
-	struct pci_dev *pdev	= to_pci_dev(ap->host_set->dev);
+	struct pci_dev *pdev	= to_pci_dev(ap->host->dev);
 	u8 ultra;
 
 	if (adev->dma_mode == XFER_MW_DMA_0)
@@ -409,7 +409,7 @@ static int artop_init_one (struct pci_de
 	static int printed_version;
 	static struct ata_port_info info_6210 = {
 		.sht		= &artop_sht,
-		.host_flags	= ATA_FLAG_SLAVE_POSS | ATA_FLAG_SRST,
+		.flags		= ATA_FLAG_SLAVE_POSS | ATA_FLAG_SRST,
 		.pio_mask	= 0x1f,	/* pio0-4 */
 		.mwdma_mask	= 0x07, /* mwdma0-2 */
 		.udma_mask 	= ATA_UDMA2,
@@ -417,7 +417,7 @@ static int artop_init_one (struct pci_de
 	};
 	static struct ata_port_info info_626x = {
 		.sht		= &artop_sht,
-		.host_flags	= ATA_FLAG_SLAVE_POSS | ATA_FLAG_SRST,
+		.flags		= ATA_FLAG_SLAVE_POSS | ATA_FLAG_SRST,
 		.pio_mask	= 0x1f,	/* pio0-4 */
 		.mwdma_mask	= 0x07, /* mwdma0-2 */
 		.udma_mask 	= ATA_UDMA4,
@@ -425,7 +425,7 @@ static int artop_init_one (struct pci_de
 	};
 	static struct ata_port_info info_626x_fast = {
 		.sht		= &artop_sht,
-		.host_flags	= ATA_FLAG_SLAVE_POSS | ATA_FLAG_SRST,
+		.flags		= ATA_FLAG_SLAVE_POSS | ATA_FLAG_SRST,
 		.pio_mask	= 0x1f,	/* pio0-4 */
 		.mwdma_mask	= 0x07, /* mwdma0-2 */
 		.udma_mask 	= ATA_UDMA5,
diff --git a/drivers/ata/pata_atiixp.c b/drivers/ata/pata_atiixp.c
index ddbb79d..3f78a1e 100644
--- a/drivers/ata/pata_atiixp.c
+++ b/drivers/ata/pata_atiixp.c
@@ -35,7 +35,7 @@ enum {
 
 static int atiixp_pre_reset(struct ata_port *ap)
 {
-	struct pci_dev *pdev = to_pci_dev(ap->host_set->dev);
+	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
 	static struct pci_bits atiixp_enable_bits[] = {
 		{ 0x48, 1, 0x01, 0x00 },
 		{ 0x48, 1, 0x08, 0x00 }
@@ -69,7 +69,7 @@ static void atiixp_set_pio_timing(struct
 {
 	static u8 pio_timings[5] = { 0x5D, 0x47, 0x34, 0x22, 0x20 };
 
-	struct pci_dev *pdev = to_pci_dev(ap->host_set->dev);
+	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
 	int dn = 2 * ap->port_no + adev->devno;
 
 	/* Check this is correct - the order is odd in both drivers */
@@ -114,7 +114,7 @@ static void atiixp_set_dmamode(struct at
 {
 	static u8 mwdma_timings[5] = { 0x77, 0x21, 0x20 };
 
-	struct pci_dev *pdev = to_pci_dev(ap->host_set->dev);
+	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
 	int dma = adev->dma_mode;
 	int dn = 2 * ap->port_no + adev->devno;
 	int wanted_pio;
@@ -169,7 +169,7 @@ static void atiixp_bmdma_start(struct at
 	struct ata_port *ap = qc->ap;
 	struct ata_device *adev = qc->dev;
 
-	struct pci_dev *pdev = to_pci_dev(ap->host_set->dev);
+	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
 	int dn = (2 * ap->port_no) + adev->devno;
 	u16 tmp16;
 
@@ -193,7 +193,7 @@ static void atiixp_bmdma_start(struct at
 static void atiixp_bmdma_stop(struct ata_queued_cmd *qc)
 {
 	struct ata_port *ap = qc->ap;
-	struct pci_dev *pdev = to_pci_dev(ap->host_set->dev);
+	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
 	int dn = (2 * ap->port_no) + qc->dev->devno;
 	u16 tmp16;
 
@@ -259,7 +259,7 @@ static int atiixp_init_one(struct pci_de
 {
 	static struct ata_port_info info = {
 		.sht = &atiixp_sht,
-		.host_flags = ATA_FLAG_SLAVE_POSS | ATA_FLAG_SRST,
+		.flags = ATA_FLAG_SLAVE_POSS | ATA_FLAG_SRST,
 		.pio_mask = 0x1f,
 		.mwdma_mask = 0x06,	/* No MWDMA0 support */
 		.udma_mask = 0x3F,
diff --git a/drivers/ata/pata_cmd64x.c b/drivers/ata/pata_cmd64x.c
index 3af8bea..0328461 100644
--- a/drivers/ata/pata_cmd64x.c
+++ b/drivers/ata/pata_cmd64x.c
@@ -83,7 +83,7 @@ static int cmd64x_pre_reset(struct ata_p
 
 static int cmd648_pre_reset(struct ata_port *ap)
 {
-	struct pci_dev *pdev = to_pci_dev(ap->host_set->dev);
+	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
 	u8 r;
 
 	/* Check cable detect bits */
@@ -116,7 +116,7 @@ static void cmd648_error_handler(struct 
  
 static void cmd64x_set_piomode(struct ata_port *ap, struct ata_device *adev)
 {
-	struct pci_dev *pdev = to_pci_dev(ap->host_set->dev);
+	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
 	struct ata_timing t;
 	const unsigned long T = 1000000 / 33;
 	const u8 setup_data[] = { 0x40, 0x40, 0x40, 0x80, 0x00 };
@@ -203,7 +203,7 @@ static void cmd64x_set_dmamode(struct at
 		0x30, 0x20, 0x10
 	};
 	
-	struct pci_dev *pdev = to_pci_dev(ap->host_set->dev);
+	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
 	u8 regU, regD;
 
 	int pciU = UDIDETCR0 + 8 * ap->port_no;
@@ -237,7 +237,7 @@ static void cmd64x_set_dmamode(struct at
 static void cmd648_bmdma_stop(struct ata_queued_cmd *qc)
 {
 	struct ata_port *ap = qc->ap;
-	struct pci_dev *pdev = to_pci_dev(ap->host_set->dev);
+	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
 	u8 dma_intr;
 	int dma_reg = ap->port_no ? ARTTIM23_INTR_CH1 : CFR_INTR_CH0;
 	int dma_mask = ap->port_no ? ARTTIM2 : CFR;
@@ -387,21 +387,21 @@ static int cmd64x_init_one(struct pci_de
 	static struct ata_port_info cmd_info[6] = {
 		{	/* CMD 643 - no UDMA */
 			.sht = &cmd64x_sht,
-			.host_flags = ATA_FLAG_SLAVE_POSS | ATA_FLAG_SRST,
+			.flags = ATA_FLAG_SLAVE_POSS | ATA_FLAG_SRST,
 			.pio_mask = 0x1f,
 			.mwdma_mask = 0x07,
 			.port_ops = &cmd64x_port_ops
 		},
 		{	/* CMD 646 with broken UDMA */
 			.sht = &cmd64x_sht,
-			.host_flags = ATA_FLAG_SLAVE_POSS | ATA_FLAG_SRST,
+			.flags = ATA_FLAG_SLAVE_POSS | ATA_FLAG_SRST,
 			.pio_mask = 0x1f,
 			.mwdma_mask = 0x07,
 			.port_ops = &cmd64x_port_ops
 		},
 		{	/* CMD 646 with working UDMA */
 			.sht = &cmd64x_sht,
-			.host_flags = ATA_FLAG_SLAVE_POSS | ATA_FLAG_SRST,
+			.flags = ATA_FLAG_SLAVE_POSS | ATA_FLAG_SRST,
 			.pio_mask = 0x1f,
 			.mwdma_mask = 0x07,
 			.udma_mask = ATA_UDMA1,
@@ -409,14 +409,14 @@ static int cmd64x_init_one(struct pci_de
 		},
 		{	/* CMD 646 rev 1  */
 			.sht = &cmd64x_sht,
-			.host_flags = ATA_FLAG_SLAVE_POSS | ATA_FLAG_SRST,
+			.flags = ATA_FLAG_SLAVE_POSS | ATA_FLAG_SRST,
 			.pio_mask = 0x1f,
 			.mwdma_mask = 0x07,
 			.port_ops = &cmd646r1_port_ops
 		},
 		{	/* CMD 648 */
 			.sht = &cmd64x_sht,
-			.host_flags = ATA_FLAG_SLAVE_POSS | ATA_FLAG_SRST,
+			.flags = ATA_FLAG_SLAVE_POSS | ATA_FLAG_SRST,
 			.pio_mask = 0x1f,
 			.mwdma_mask = 0x07,
 			.udma_mask = ATA_UDMA2,
@@ -424,7 +424,7 @@ static int cmd64x_init_one(struct pci_de
 		},
 		{	/* CMD 649 */
 			.sht = &cmd64x_sht,
-			.host_flags = ATA_FLAG_SLAVE_POSS | ATA_FLAG_SRST,
+			.flags = ATA_FLAG_SLAVE_POSS | ATA_FLAG_SRST,
 			.pio_mask = 0x1f,
 			.mwdma_mask = 0x07,
 			.udma_mask = ATA_UDMA3,
diff --git a/drivers/ata/pata_cs5520.c b/drivers/ata/pata_cs5520.c
index f620808..792ce48 100644
--- a/drivers/ata/pata_cs5520.c
+++ b/drivers/ata/pata_cs5520.c
@@ -69,7 +69,7 @@ static const struct pio_clocks cs5520_pi
 
 static void cs5520_set_timings(struct ata_port *ap, struct ata_device *adev, int pio)
 {
-	struct pci_dev *pdev = to_pci_dev(ap->host_set->dev);
+	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
 	int slave = adev->devno;
 
 	pio -= XFER_PIO_0;
@@ -247,7 +247,7 @@ static int __devinit cs5520_init_one(str
 	probe[0].mwdma_mask = id->driver_data;
 	probe[0].irq = 14;
 	probe[0].irq_flags = 0;
-	probe[0].host_flags = ATA_FLAG_SLAVE_POSS|ATA_FLAG_SRST;
+	probe[0].port_flags = ATA_FLAG_SLAVE_POSS|ATA_FLAG_SRST;
 	probe[0].n_ports = 1;
 	probe[0].port[0].cmd_addr = 0x1F0;
 	probe[0].port[0].ctl_addr = 0x3F6;
@@ -292,9 +292,9 @@ static int __devinit cs5520_init_one(str
 static void __devexit cs5520_remove_one(struct pci_dev *pdev)
 {
 	struct device *dev = pci_dev_to_dev(pdev);
-	struct ata_host_set *host_set = dev_get_drvdata(dev);
+	struct ata_host *host = dev_get_drvdata(dev);
 
-	ata_host_set_remove(host_set);
+	ata_host_remove(host);
 	dev_set_drvdata(dev, NULL);
 }
 
diff --git a/drivers/ata/pata_cs5530.c b/drivers/ata/pata_cs5530.c
index 0d166e5..f3d8a3b 100644
--- a/drivers/ata/pata_cs5530.c
+++ b/drivers/ata/pata_cs5530.c
@@ -254,7 +254,7 @@ static int cs5530_init_one(struct pci_de
 	struct pci_dev *master_0 = NULL, *cs5530_0 = NULL;
 	static struct ata_port_info info = {
 		.sht = &cs5530_sht,
-		.host_flags = ATA_FLAG_SLAVE_POSS|ATA_FLAG_SRST,
+		.flags = ATA_FLAG_SLAVE_POSS|ATA_FLAG_SRST,
 		.pio_mask = 0x1f,
 		.mwdma_mask = 0x07,
 		.udma_mask = 0x07,
@@ -263,7 +263,7 @@ static int cs5530_init_one(struct pci_de
 	/* The docking connector doesn't do UDMA, and it seems not MWDMA */
 	static struct ata_port_info info_palmax_secondary = {
 		.sht = &cs5530_sht,
-		.host_flags = ATA_FLAG_SLAVE_POSS|ATA_FLAG_SRST,
+		.flags = ATA_FLAG_SLAVE_POSS|ATA_FLAG_SRST,
 		.pio_mask = 0x1f,
 		.port_ops = &cs5530_port_ops
 	};
diff --git a/drivers/ata/pata_cs5535.c b/drivers/ata/pata_cs5535.c
index 30b1a19..69d6b42 100644
--- a/drivers/ata/pata_cs5535.c
+++ b/drivers/ata/pata_cs5535.c
@@ -80,7 +80,7 @@ #define CS5535_BAD_PIO(timings) ( (timin
 static int cs5535_pre_reset(struct ata_port *ap)
 {
 	u8 cable;
-	struct pci_dev *pdev = to_pci_dev(ap->host_set->dev);
+	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
 
 	pci_read_config_byte(pdev, CS5535_CABLE_DETECT, &cable);
 	if (cable & 1)
@@ -236,7 +236,7 @@ static int cs5535_init_one(struct pci_de
 {
 	static struct ata_port_info info = {
 		.sht = &cs5535_sht,
-		.host_flags = ATA_FLAG_SLAVE_POSS|ATA_FLAG_SRST,
+		.flags = ATA_FLAG_SLAVE_POSS|ATA_FLAG_SRST,
 		.pio_mask = 0x1f,
 		.mwdma_mask = 0x07,
 		.udma_mask = 0x1f,
diff --git a/drivers/ata/pata_cypress.c b/drivers/ata/pata_cypress.c
index 0bf85ec..322043d 100644
--- a/drivers/ata/pata_cypress.c
+++ b/drivers/ata/pata_cypress.c
@@ -62,7 +62,7 @@ static void cy82c693_error_handler(struc
  
 static void cy82c693_set_piomode(struct ata_port *ap, struct ata_device *adev)
 {
-	struct pci_dev *pdev = to_pci_dev(ap->host_set->dev);
+	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
 	struct ata_timing t;
 	const unsigned long T = 1000000 / 33;
 	short time_16, time_8;
@@ -177,7 +177,7 @@ static int cy82c693_init_one(struct pci_
 {
 	static struct ata_port_info info = {
 		.sht = &cy82c693_sht,
-		.host_flags = ATA_FLAG_SLAVE_POSS | ATA_FLAG_SRST,
+		.flags = ATA_FLAG_SLAVE_POSS | ATA_FLAG_SRST,
 		.pio_mask = 0x1f,
 		.mwdma_mask = 0x07,
 		.port_ops = &cy82c693_port_ops
diff --git a/drivers/ata/pata_efar.c b/drivers/ata/pata_efar.c
index 62afeba..c30bc18 100644
--- a/drivers/ata/pata_efar.c
+++ b/drivers/ata/pata_efar.c
@@ -39,7 +39,7 @@ static int efar_pre_reset(struct ata_por
 		{ 0x43U, 1U, 0x80UL, 0x80UL },	/* port 1 */
 	};
 
-	struct pci_dev *pdev = to_pci_dev(ap->host_set->dev);
+	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
 	u8 tmp;
 
 	if (!pci_test_config_bits(pdev, &efar_enable_bits[ap->port_no])) {
@@ -82,7 +82,7 @@ static void efar_error_handler(struct at
 static void efar_set_piomode (struct ata_port *ap, struct ata_device *adev)
 {
 	unsigned int pio	= adev->pio_mode - XFER_PIO_0;
-	struct pci_dev *dev	= to_pci_dev(ap->host_set->dev);
+	struct pci_dev *dev	= to_pci_dev(ap->host->dev);
 	unsigned int idetm_port= ap->port_no ? 0x42 : 0x40;
 	u16 idetm_data;
 	int control = 0;
@@ -147,7 +147,7 @@ static void efar_set_piomode (struct ata
 
 static void efar_set_dmamode (struct ata_port *ap, struct ata_device *adev)
 {
-	struct pci_dev *dev	= to_pci_dev(ap->host_set->dev);
+	struct pci_dev *dev	= to_pci_dev(ap->host->dev);
 	u8 master_port		= ap->port_no ? 0x42 : 0x40;
 	u16 master_data;
 	u8 speed		= adev->dma_mode;
@@ -293,7 +293,7 @@ static int efar_init_one (struct pci_dev
 	static int printed_version;
 	static struct ata_port_info info = {
 		.sht		= &efar_sht,
-		.host_flags	= ATA_FLAG_SLAVE_POSS | ATA_FLAG_SRST,
+		.flags		= ATA_FLAG_SLAVE_POSS | ATA_FLAG_SRST,
 		.pio_mask	= 0x1f,	/* pio0-4 */
 		.mwdma_mask	= 0x07, /* mwdma1-2 */
 		.udma_mask 	= 0x0f, /* UDMA 66 */
diff --git a/drivers/ata/pata_hpt366.c b/drivers/ata/pata_hpt366.c
index 9443e7f..e54a0c5 100644
--- a/drivers/ata/pata_hpt366.c
+++ b/drivers/ata/pata_hpt366.c
@@ -209,7 +209,7 @@ static unsigned long hpt366_filter(const
  
 static u32 hpt36x_find_mode(struct ata_port *ap, int speed)
 {
-	struct hpt_clock *clocks = ap->host_set->private_data;
+	struct hpt_clock *clocks = ap->host->private_data;
 	
 	while(clocks->xfer_speed) {
 		if (clocks->xfer_speed == speed)
@@ -223,7 +223,7 @@ static u32 hpt36x_find_mode(struct ata_p
 static int hpt36x_pre_reset(struct ata_port *ap)
 {
 	u8 ata66;
-	struct pci_dev *pdev = to_pci_dev(ap->host_set->dev);
+	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
 	
 	pci_read_config_byte(pdev, 0x5A, &ata66);
 	if (ata66 & (1 << ap->port_no))
@@ -255,7 +255,7 @@ static void hpt36x_error_handler(struct 
  
 static void hpt366_set_piomode(struct ata_port *ap, struct ata_device *adev)
 {
-	struct pci_dev *pdev = to_pci_dev(ap->host_set->dev);
+	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
 	u32 addr1, addr2;
 	u32 reg;
 	u32 mode;
@@ -290,7 +290,7 @@ static void hpt366_set_piomode(struct at
  
 static void hpt366_set_dmamode(struct ata_port *ap, struct ata_device *adev)
 {
-	struct pci_dev *pdev = to_pci_dev(ap->host_set->dev);
+	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
 	u32 addr1, addr2;
 	u32 reg;
 	u32 mode;
@@ -396,7 +396,7 @@ static int hpt36x_init_one(struct pci_de
 {
 	static struct ata_port_info info_hpt366 = {
 		.sht = &hpt36x_sht,
-		.host_flags = ATA_FLAG_SLAVE_POSS | ATA_FLAG_SRST,
+		.flags = ATA_FLAG_SLAVE_POSS | ATA_FLAG_SRST,
 		.pio_mask = 0x1f,
 		.mwdma_mask = 0x07,
 		.udma_mask = 0x1f,
diff --git a/drivers/ata/pata_hpt37x.c b/drivers/ata/pata_hpt37x.c
index 2a3cd5c..7c3da53 100644
--- a/drivers/ata/pata_hpt37x.c
+++ b/drivers/ata/pata_hpt37x.c
@@ -336,7 +336,7 @@ static const struct hpt_chip hpt374 = {
  
 static u32 hpt37x_find_mode(struct ata_port *ap, int speed)
 {
-	struct hpt_clock *clocks = ap->host_set->private_data;
+	struct hpt_clock *clocks = ap->host->private_data;
 	
 	while(clocks->xfer_speed) {
 		if (clocks->xfer_speed == speed)
@@ -452,7 +452,7 @@ static unsigned long hpt370a_filter(cons
 static int hpt37x_pre_reset(struct ata_port *ap)
 {
 	u8 scr2, ata66;
-	struct pci_dev *pdev = to_pci_dev(ap->host_set->dev);
+	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
 	
 	pci_read_config_byte(pdev, 0x5B, &scr2);
 	pci_write_config_byte(pdev, 0x5B, scr2 & ~0x01);
@@ -491,7 +491,7 @@ static int hpt374_pre_reset(struct ata_p
 	u16 mcr3, mcr6;
 	u8 ata66;
 	
-	struct pci_dev *pdev = to_pci_dev(ap->host_set->dev);
+	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
 	/* Do the extra channel work */
 	pci_read_config_word(pdev, 0x52, &mcr3);
 	pci_read_config_word(pdev, 0x56, &mcr6);
@@ -529,7 +529,7 @@ static int hpt374_pre_reset(struct ata_p
  
 static void hpt374_error_handler(struct ata_port *ap)
 {
-	struct pci_dev *pdev = to_pci_dev(ap->host_set->dev);
+	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
 		
 	if (!(PCI_FUNC(pdev->devfn) & 1))
 		hpt37x_error_handler(ap);
@@ -547,7 +547,7 @@ static void hpt374_error_handler(struct 
  
 static void hpt370_set_piomode(struct ata_port *ap, struct ata_device *adev)
 {
-	struct pci_dev *pdev = to_pci_dev(ap->host_set->dev);
+	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
 	u32 addr1, addr2;
 	u32 reg;
 	u32 mode;
@@ -581,7 +581,7 @@ static void hpt370_set_piomode(struct at
  
 static void hpt370_set_dmamode(struct ata_port *ap, struct ata_device *adev)
 {
-	struct pci_dev *pdev = to_pci_dev(ap->host_set->dev);
+	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
 	u32 addr1, addr2;
 	u32 reg;
 	u32 mode;
@@ -615,7 +615,7 @@ static void hpt370_set_dmamode(struct at
 static void hpt370_bmdma_start(struct ata_queued_cmd *qc)
 {
 	struct ata_port *ap = qc->ap;
-	struct pci_dev *pdev = to_pci_dev(ap->host_set->dev);
+	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
 	pci_write_config_byte(pdev, 0x50 + 4 * ap->port_no, 0x37);
 	udelay(10);
 	ata_bmdma_start(qc);
@@ -631,7 +631,7 @@ static void hpt370_bmdma_start(struct at
 static void hpt370_bmdma_stop(struct ata_queued_cmd *qc)
 {
 	struct ata_port *ap = qc->ap;
-	struct pci_dev *pdev = to_pci_dev(ap->host_set->dev);
+	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
 	u8 dma_stat = inb(ap->ioaddr.bmdma_addr + 2);
 	u8 dma_cmd;
 	unsigned long bmdma = ap->ioaddr.bmdma_addr;
@@ -667,7 +667,7 @@ static void hpt370_bmdma_stop(struct ata
  
 static void hpt372_set_piomode(struct ata_port *ap, struct ata_device *adev)
 {
-	struct pci_dev *pdev = to_pci_dev(ap->host_set->dev);
+	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
 	u32 addr1, addr2;
 	u32 reg;
 	u32 mode;
@@ -702,7 +702,7 @@ static void hpt372_set_piomode(struct at
  
 static void hpt372_set_dmamode(struct ata_port *ap, struct ata_device *adev)
 {
-	struct pci_dev *pdev = to_pci_dev(ap->host_set->dev);
+	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
 	u32 addr1, addr2;
 	u32 reg;
 	u32 mode;
@@ -735,7 +735,7 @@ static void hpt372_set_dmamode(struct at
 static void hpt37x_bmdma_stop(struct ata_queued_cmd *qc)
 {
 	struct ata_port *ap = qc->ap;
-	struct pci_dev *pdev = to_pci_dev(ap->host_set->dev);
+	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
 	int mscreg = 0x50 + 2 * ap->port_no;
 	u8 bwsr_stat, msc_stat;
 	
@@ -1015,7 +1015,7 @@ static int hpt37x_init_one(struct pci_de
 	/* HPT370 - UDMA100 */
 	static struct ata_port_info info_hpt370 = {
 		.sht = &hpt37x_sht,
-		.host_flags = ATA_FLAG_SLAVE_POSS|ATA_FLAG_SRST,
+		.flags = ATA_FLAG_SLAVE_POSS|ATA_FLAG_SRST,
 		.pio_mask = 0x1f,
 		.mwdma_mask = 0x07,
 		.udma_mask = 0x3f,
@@ -1024,7 +1024,7 @@ static int hpt37x_init_one(struct pci_de
 	/* HPT370A - UDMA100 */
 	static struct ata_port_info info_hpt370a = {
 		.sht = &hpt37x_sht,
-		.host_flags = ATA_FLAG_SLAVE_POSS|ATA_FLAG_SRST,
+		.flags = ATA_FLAG_SLAVE_POSS|ATA_FLAG_SRST,
 		.pio_mask = 0x1f,
 		.mwdma_mask = 0x07,
 		.udma_mask = 0x3f,
@@ -1033,7 +1033,7 @@ static int hpt37x_init_one(struct pci_de
 	/* HPT371, 372 and friends - UDMA133 */
 	static struct ata_port_info info_hpt372 = {
 		.sht = &hpt37x_sht,
-		.host_flags = ATA_FLAG_SLAVE_POSS|ATA_FLAG_SRST,
+		.flags = ATA_FLAG_SLAVE_POSS|ATA_FLAG_SRST,
 		.pio_mask = 0x1f,
 		.mwdma_mask = 0x07,
 		.udma_mask = 0x7f,
@@ -1042,7 +1042,7 @@ static int hpt37x_init_one(struct pci_de
 	/* HPT371, 372 and friends - UDMA100 at 50MHz clock */
 	static struct ata_port_info info_hpt372_50 = {
 		.sht = &hpt37x_sht,
-		.host_flags = ATA_FLAG_SLAVE_POSS|ATA_FLAG_SRST,
+		.flags = ATA_FLAG_SLAVE_POSS|ATA_FLAG_SRST,
 		.pio_mask = 0x1f,
 		.mwdma_mask = 0x07,
 		.udma_mask = 0x3f,
@@ -1051,7 +1051,7 @@ static int hpt37x_init_one(struct pci_de
 	/* HPT374 - UDMA133 */
 	static struct ata_port_info info_hpt374 = {
 		.sht = &hpt37x_sht,
-		.host_flags = ATA_FLAG_SLAVE_POSS|ATA_FLAG_SRST,
+		.flags = ATA_FLAG_SLAVE_POSS|ATA_FLAG_SRST,
 		.pio_mask = 0x1f,
 		.mwdma_mask = 0x07,
 		.udma_mask = 0x7f,
diff --git a/drivers/ata/pata_hpt3x2n.c b/drivers/ata/pata_hpt3x2n.c
index 1098ee6..40fcda6 100644
--- a/drivers/ata/pata_hpt3x2n.c
+++ b/drivers/ata/pata_hpt3x2n.c
@@ -125,7 +125,7 @@ static u32 hpt3x2n_find_mode(struct ata_
 static int hpt3xn_pre_reset(struct ata_port *ap)
 {
 	u8 scr2, ata66;
-	struct pci_dev *pdev = to_pci_dev(ap->host_set->dev);
+	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
 	
 	pci_read_config_byte(pdev, 0x5B, &scr2);
 	pci_write_config_byte(pdev, 0x5B, scr2 & ~0x01);
@@ -169,7 +169,7 @@ static void hpt3x2n_error_handler(struct
  
 static void hpt3x2n_set_piomode(struct ata_port *ap, struct ata_device *adev)
 {
-	struct pci_dev *pdev = to_pci_dev(ap->host_set->dev);
+	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
 	u32 addr1, addr2;
 	u32 reg;
 	u32 mode;
@@ -202,7 +202,7 @@ static void hpt3x2n_set_piomode(struct a
  
 static void hpt3x2n_set_dmamode(struct ata_port *ap, struct ata_device *adev)
 {
-	struct pci_dev *pdev = to_pci_dev(ap->host_set->dev);
+	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
 	u32 addr1, addr2;
 	u32 reg;
 	u32 mode;
@@ -234,7 +234,7 @@ static void hpt3x2n_set_dmamode(struct a
 static void hpt3x2n_bmdma_stop(struct ata_queued_cmd *qc)
 {
 	struct ata_port *ap = qc->ap;
-	struct pci_dev *pdev = to_pci_dev(ap->host_set->dev);
+	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
 	int mscreg = 0x50 + 2 * ap->port_no;
 	u8 bwsr_stat, msc_stat;
 	
@@ -289,7 +289,7 @@ static void hpt3x2n_set_clock(struct ata
 
 static int hpt3x2n_pair_idle(struct ata_port *ap)
 {
-	struct ata_host_set *host = ap->host_set;
+	struct ata_host *host = ap->host;
 	struct ata_port *pair = host->ports[ap->port_no ^ 1];
 	
 	if (pair->hsm_task_state == HSM_ST_IDLE)
@@ -299,7 +299,7 @@ static int hpt3x2n_pair_idle(struct ata_
 
 static int hpt3x2n_use_dpll(struct ata_port *ap, int reading)
 {
-	long flags = (long)ap->host_set->private_data;
+	long flags = (long)ap->host->private_data;
 	/* See if we should use the DPLL */
 	if (reading == 0)
 		return USE_DPLL;	/* Needed for write */
@@ -312,7 +312,7 @@ static unsigned int hpt3x2n_qc_issue_pro
 {
 	struct ata_taskfile *tf = &qc->tf;
 	struct ata_port *ap = qc->ap;
-	int flags = (long)ap->host_set->private_data;
+	int flags = (long)ap->host->private_data;
 	
 	if (hpt3x2n_pair_idle(ap)) {
 		int dpll = hpt3x2n_use_dpll(ap, (tf->flags & ATA_TFLAG_WRITE));
@@ -477,7 +477,7 @@ static int hpt3x2n_init_one(struct pci_d
 	/* HPT372N and friends - UDMA133 */
 	static struct ata_port_info info = {
 		.sht = &hpt3x2n_sht,
-		.host_flags = ATA_FLAG_SLAVE_POSS | ATA_FLAG_SRST,
+		.flags = ATA_FLAG_SLAVE_POSS | ATA_FLAG_SRST,
 		.pio_mask = 0x1f,
 		.mwdma_mask = 0x07,
 		.udma_mask = 0x7f,
diff --git a/drivers/ata/pata_hpt3x3.c b/drivers/ata/pata_hpt3x3.c
index 456d6b1..c93406e 100644
--- a/drivers/ata/pata_hpt3x3.c
+++ b/drivers/ata/pata_hpt3x3.c
@@ -56,7 +56,7 @@ static void hpt3x3_error_handler(struct 
 
 static void hpt3x3_set_piomode(struct ata_port *ap, struct ata_device *adev)
 {
-	struct pci_dev *pdev = to_pci_dev(ap->host_set->dev);
+	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
 	u32 r1, r2;
 	int dn = 2 * ap->port_no + adev->devno;
 
@@ -82,7 +82,7 @@ static void hpt3x3_set_piomode(struct at
 
 static void hpt3x3_set_dmamode(struct ata_port *ap, struct ata_device *adev)
 {
-	struct pci_dev *pdev = to_pci_dev(ap->host_set->dev);
+	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
 	u32 r1, r2;
 	int dn = 2 * ap->port_no + adev->devno;
 	int mode_num = adev->dma_mode & 0x0F;
@@ -170,7 +170,7 @@ static int hpt3x3_init_one(struct pci_de
 {
 	static struct ata_port_info info = {
 		.sht = &hpt3x3_sht,
-		.host_flags = ATA_FLAG_SLAVE_POSS|ATA_FLAG_SRST,
+		.flags = ATA_FLAG_SLAVE_POSS|ATA_FLAG_SRST,
 		.pio_mask = 0x1f,
 		.mwdma_mask = 0x07,
 		.udma_mask = 0x07,
diff --git a/drivers/ata/pata_isapnp.c b/drivers/ata/pata_isapnp.c
index 2db7df7..73948c8 100644
--- a/drivers/ata/pata_isapnp.c
+++ b/drivers/ata/pata_isapnp.c
@@ -92,13 +92,13 @@ static int isapnp_init_one(struct pnp_de
 	ae.pio_mask = 1;		/* ISA so PIO 0 cycles */
 	ae.irq = pnp_irq(idev, 0);
 	ae.irq_flags = 0;
-	ae.host_flags = ATA_FLAG_SLAVE_POSS;
+	ae.port_flags = ATA_FLAG_SLAVE_POSS;
 	ae.port[0].cmd_addr = pnp_port_start(idev, 0);
 
 	if (pnp_port_valid(idev, 1) == 0) {
 		ae.port[0].altstatus_addr = pnp_port_start(idev, 1);
 		ae.port[0].ctl_addr = pnp_port_start(idev, 1);
-		ae.host_flags |= ATA_FLAG_SRST;
+		ae.port_flags |= ATA_FLAG_SRST;
 	}
 	ata_std_ports(&ae.port[0]);
 
@@ -118,9 +118,9 @@ static int isapnp_init_one(struct pnp_de
 static void isapnp_remove_one(struct pnp_dev *idev)
 {
 	struct device *dev = &idev->dev;
-	struct ata_host_set *host_set = dev_get_drvdata(dev);
+	struct ata_host *host = dev_get_drvdata(dev);
 
-	ata_host_set_remove(host_set);
+	ata_host_remove(host);
 	dev_set_drvdata(dev, NULL);
 }
 
diff --git a/drivers/ata/pata_it8172.c b/drivers/ata/pata_it8172.c
index d6c4744..f836719 100644
--- a/drivers/ata/pata_it8172.c
+++ b/drivers/ata/pata_it8172.c
@@ -57,7 +57,7 @@ static int it8172_pre_reset(struct ata_p
 		{ 0x40, 1, 0x00, 0x01 }
 	};
 
-	struct pci_dev *pdev = to_pci_dev(ap->host_set->dev);
+	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
 	
 	if (ap->port_no && !pci_test_config_bits(pdev, &it8172_enable_bits[ap->port_no])) {
 		ata_port_disable(ap);
@@ -85,7 +85,7 @@ static void it8172_error_handler(struct 
 
 static void it8172_set_pio_timing(struct ata_port *ap, struct ata_device *adev, int pio)
 {
-	struct pci_dev *pdev = to_pci_dev(ap->host_set->dev);
+	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
 	u16 reg40;
 
 	pci_read_config_word(pdev, 0x40, &reg40);
@@ -145,7 +145,7 @@ static void it8172_set_piomode(struct at
 
 static void it8172_set_dmamode(struct ata_port *ap, struct ata_device *adev)
 {
-	struct pci_dev *pdev = to_pci_dev(ap->host_set->dev);
+	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
 	int dn = (2 * ap->port_no) + adev->devno;
 	u8 reg48, reg4a;
 	int pio;
@@ -239,7 +239,7 @@ static int it8172_init_one(struct pci_de
 {
 	static struct ata_port_info info = {
 		.sht = &it8172_sht,
-		.host_flags = ATA_FLAG_SLAVE_POSS | ATA_FLAG_SRST,
+		.flags = ATA_FLAG_SLAVE_POSS | ATA_FLAG_SRST,
 		.pio_mask = 0x1f,
 		.mwdma_mask = 0x06,	/* No MWDMA0 support */
 		.udma_mask = 0x7,
diff --git a/drivers/ata/pata_it821x.c b/drivers/ata/pata_it821x.c
index f793612..c8a7798 100644
--- a/drivers/ata/pata_it821x.c
+++ b/drivers/ata/pata_it821x.c
@@ -150,7 +150,7 @@ static void it821x_error_handler(struct 
 
 static void it821x_program(struct ata_port *ap, struct ata_device *adev, u16 timing)
 {
-	struct pci_dev *pdev = to_pci_dev(ap->host_set->dev);
+	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
 	struct it821x_dev *itdev = ap->private_data;
 	int channel = ap->port_no;
 	u8 conf;
@@ -179,7 +179,7 @@ static void it821x_program(struct ata_po
 static void it821x_program_udma(struct ata_port *ap, struct ata_device *adev, u16 timing)
 {
 	struct it821x_dev *itdev = ap->private_data;
-	struct pci_dev *pdev = to_pci_dev(ap->host_set->dev);
+	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
 	int channel = ap->port_no;
 	int unit = adev->devno;
 	u8 conf;
@@ -209,7 +209,7 @@ static void it821x_program_udma(struct a
 
 static void it821x_clock_strategy(struct ata_port *ap, struct ata_device *adev)
 {
-	struct pci_dev *pdev = to_pci_dev(ap->host_set->dev);
+	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
 	struct it821x_dev *itdev = ap->private_data;
 	u8 unit = adev->devno;
 	struct ata_device *pair = ata_dev_pair(adev);
@@ -314,7 +314,7 @@ static void it821x_passthru_set_dmamode(
 	static const u16 udma[]	= 	{ 0x4433, 0x4231, 0x3121, 0x2121, 0x1111, 0x2211, 0x1111 };
 	static const u8 udma_want[] =   { ATA_ANY, ATA_50, ATA_ANY, ATA_66, ATA_66, ATA_50, ATA_66 };
 
-	struct pci_dev *pdev = to_pci_dev(ap->host_set->dev);
+	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
 	struct it821x_dev *itdev = ap->private_data;
 	int channel = ap->port_no;
 	int unit = adev->devno;
@@ -598,7 +598,7 @@ static int it821x_check_atapi_dma(struct
  
 static int it821x_port_start(struct ata_port *ap)
 {
-	struct pci_dev *pdev = to_pci_dev(ap->host_set->dev);
+	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
 	struct it821x_dev *itdev;
 	u8 conf;
 
@@ -774,14 +774,14 @@ static int it821x_init_one(struct pci_de
 	
 	static struct ata_port_info info_smart = {
 		.sht = &it821x_sht,
-		.host_flags = ATA_FLAG_SLAVE_POSS | ATA_FLAG_SRST,
+		.flags = ATA_FLAG_SLAVE_POSS | ATA_FLAG_SRST,
 		.pio_mask = 0x1f,
 		.mwdma_mask = 0x07,
 		.port_ops = &it821x_smart_port_ops
 	};
 	static struct ata_port_info info_passthru = {
 		.sht = &it821x_sht,
-		.host_flags = ATA_FLAG_SLAVE_POSS | ATA_FLAG_SRST,
+		.flags = ATA_FLAG_SLAVE_POSS | ATA_FLAG_SRST,
 		.pio_mask = 0x1f,
 		.mwdma_mask = 0x07,
 		.udma_mask = 0x7f,
diff --git a/drivers/ata/pata_jmicron.c b/drivers/ata/pata_jmicron.c
index 3f48f70..6832a64 100644
--- a/drivers/ata/pata_jmicron.c
+++ b/drivers/ata/pata_jmicron.c
@@ -41,7 +41,7 @@ typedef enum {
 
 static int jmicron_pre_reset(struct ata_port *ap)
 {
-	struct pci_dev *pdev = to_pci_dev(ap->host_set->dev);
+	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
 	u32 control;
 	u32 control5;
 	int port_mask = 1<< (4 * ap->port_no);
@@ -194,7 +194,7 @@ static int jmicron_init_one (struct pci_
 {
 	static struct ata_port_info info = {
 		.sht		= &jmicron_sht,
-		.host_flags	= ATA_FLAG_SLAVE_POSS | ATA_FLAG_SRST,
+		.flags	= ATA_FLAG_SLAVE_POSS | ATA_FLAG_SRST,
 
 		.pio_mask	= 0x1f,
 		.mwdma_mask	= 0x07,
diff --git a/drivers/ata/pata_legacy.c b/drivers/ata/pata_legacy.c
index ad01f93..eb51066 100644
--- a/drivers/ata/pata_legacy.c
+++ b/drivers/ata/pata_legacy.c
@@ -81,7 +81,7 @@ struct legacy_data {
 };
 
 static struct legacy_data legacy_data[NR_HOST];
-static struct ata_host_set *legacy_host[NR_HOST];
+static struct ata_host *legacy_host[NR_HOST];
 static int nr_legacy_host;
 
 
@@ -613,7 +613,7 @@ static void opti82c46x_set_piomode(struc
 	outb(0x83,  ap->ioaddr.nsect_addr);
 
 	/* We need to know this for quad device on the MVB */
-	ap->host_set->private_data = ap;
+	ap->host->private_data = ap;
 }
 
 /**
@@ -638,8 +638,8 @@ static unsigned int opti82c46x_qc_issue_
 
 	/* If timings are set and for the wrong channel (2nd test is
 	   due to a libata shortcoming and will eventually go I hope) */
-	if (ap->host_set->private_data != ap->host_set
-	    && ap->host_set->private_data != NULL)
+	if (ap->host->private_data != ap->host
+	    && ap->host->private_data != NULL)
 		opti82c46x_set_piomode(ap, adev);
 
 	return ata_qc_issue_prot(qc);
@@ -765,7 +765,7 @@ static __init int legacy_init_one(int po
 	ae.pio_mask = pio_modes;
 	ae.irq = irq;
 	ae.irq_flags = 0;
-	ae.host_flags = ATA_FLAG_SLAVE_POSS|ATA_FLAG_SRST;
+	ae.port_flags = ATA_FLAG_SLAVE_POSS|ATA_FLAG_SRST;
 	ae.port[0].cmd_addr = io;
 	ae.port[0].altstatus_addr = ctrl;
 	ae.port[0].ctl_addr =	ctrl;
@@ -922,7 +922,7 @@ static __exit void legacy_exit(void)
 		struct ata_port *ap =legacy_host[i]->ports[0];
 		unsigned long io = ap->ioaddr.cmd_addr;
 		unsigned long ctrl = ap->ioaddr.ctl_addr;
-		ata_host_set_remove(legacy_host[i]);
+		ata_host_remove(legacy_host[i]);
 		platform_device_unregister(ld->platform_dev);
 		if (ld->timing)
 			release_region(ld->timing, 2);
diff --git a/drivers/ata/pata_mpiix.c b/drivers/ata/pata_mpiix.c
index 12e6e2b..1958c4e 100644
--- a/drivers/ata/pata_mpiix.c
+++ b/drivers/ata/pata_mpiix.c
@@ -48,7 +48,7 @@ enum {
 
 static int mpiix_pre_reset(struct ata_port *ap)
 {
-	struct pci_dev *pdev = to_pci_dev(ap->host_set->dev);
+	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
 	static const struct pci_bits mpiix_enable_bits[] = {
 		{ 0x6D, 1, 0x80, 0x80 },
 		{ 0x6F, 1, 0x80, 0x80 }
@@ -96,7 +96,7 @@ static void mpiix_set_piomode(struct ata
 {
 	int control = 0;
 	int pio = adev->pio_mode - XFER_PIO_0;
-	struct pci_dev *pdev = to_pci_dev(ap->host_set->dev);
+	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
 	u16 idetim;
 	static const	 /* ISP  RTC */
 	u8 timings[][2]	= { { 0, 0 },
@@ -231,7 +231,7 @@ static int mpiix_init_one(struct pci_dev
 	probe[0].pio_mask = 0x1F;
 	probe[0].irq = 14;
 	probe[0].irq_flags = SA_SHIRQ;
-	probe[0].host_flags = ATA_FLAG_SLAVE_POSS | ATA_FLAG_SRST;
+	probe[0].port_flags = ATA_FLAG_SLAVE_POSS | ATA_FLAG_SRST;
 	probe[0].n_ports = 1;
 	probe[0].port[0].cmd_addr = 0x1F0;
 	probe[0].port[0].ctl_addr = 0x3F6;
@@ -271,9 +271,9 @@ static int mpiix_init_one(struct pci_dev
 static void __devexit mpiix_remove_one(struct pci_dev *pdev)
 {
 	struct device *dev = pci_dev_to_dev(pdev);
-	struct ata_host_set *host_set = dev_get_drvdata(dev);
+	struct ata_host *host = dev_get_drvdata(dev);
 
-	ata_host_set_remove(host_set);
+	ata_host_remove(host);
 	dev_set_drvdata(dev, NULL);
 }
 
diff --git a/drivers/ata/pata_netcell.c b/drivers/ata/pata_netcell.c
index d516d2d..e3a8577 100644
--- a/drivers/ata/pata_netcell.c
+++ b/drivers/ata/pata_netcell.c
@@ -121,7 +121,7 @@ static int netcell_init_one (struct pci_
 	static int printed_version;
 	static struct ata_port_info info = {
 		.sht		= &netcell_sht,
-		.host_flags	= ATA_FLAG_SLAVE_POSS | ATA_FLAG_SRST,
+		.flags		= ATA_FLAG_SLAVE_POSS | ATA_FLAG_SRST,
 		/* Actually we don't really care about these as the
 		   firmware deals with it */
 		.pio_mask	= 0x1f,	/* pio0-4 */
diff --git a/drivers/ata/pata_ns87410.c b/drivers/ata/pata_ns87410.c
index 0106db0..93d6646 100644
--- a/drivers/ata/pata_ns87410.c
+++ b/drivers/ata/pata_ns87410.c
@@ -39,7 +39,7 @@ #define DRV_VERSION "0.4.2"
 
 static int ns87410_pre_reset(struct ata_port *ap)
 {
-	struct pci_dev *pdev = to_pci_dev(ap->host_set->dev);
+	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
 	static const struct pci_bits ns87410_enable_bits[] = {
 		{ 0x43, 1, 0x08, 0x08 },
 		{ 0x47, 1, 0x08, 0x08 }
@@ -79,7 +79,7 @@ static void ns87410_error_handler(struct
 
 static void ns87410_set_piomode(struct ata_port *ap, struct ata_device *adev)
 {
-	struct pci_dev *pdev = to_pci_dev(ap->host_set->dev);
+	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
 	int port = 0x40 + 4 * ap->port_no;
 	u8 idetcr, idefr;
 	struct ata_timing at;
@@ -194,7 +194,7 @@ static int ns87410_init_one(struct pci_d
 {
 	static struct ata_port_info info = {
 		.sht = &ns87410_sht,
-		.host_flags = ATA_FLAG_SLAVE_POSS | ATA_FLAG_SRST,
+		.flags = ATA_FLAG_SLAVE_POSS | ATA_FLAG_SRST,
 		.pio_mask = 0x0F,
 		.port_ops = &ns87410_port_ops
 	};
diff --git a/drivers/ata/pata_oldpiix.c b/drivers/ata/pata_oldpiix.c
index 0fd2181..04c618a 100644
--- a/drivers/ata/pata_oldpiix.c
+++ b/drivers/ata/pata_oldpiix.c
@@ -36,7 +36,7 @@ #define DRV_VERSION	"0.5.1"
 
 static int oldpiix_pre_reset(struct ata_port *ap)
 {
-	struct pci_dev *pdev = to_pci_dev(ap->host_set->dev);
+	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
 	static const struct pci_bits oldpiix_enable_bits[] = {
 		{ 0x41U, 1U, 0x80UL, 0x80UL },	/* port 0 */
 		{ 0x43U, 1U, 0x80UL, 0x80UL },	/* port 1 */
@@ -79,7 +79,7 @@ static void oldpiix_pata_error_handler(s
 static void oldpiix_set_piomode (struct ata_port *ap, struct ata_device *adev)
 {
 	unsigned int pio	= adev->pio_mode - XFER_PIO_0;
-	struct pci_dev *dev	= to_pci_dev(ap->host_set->dev);
+	struct pci_dev *dev	= to_pci_dev(ap->host->dev);
 	unsigned int idetm_port= ap->port_no ? 0x42 : 0x40;
 	u16 idetm_data;
 	int control = 0;
@@ -139,7 +139,7 @@ static void oldpiix_set_piomode (struct 
 
 static void oldpiix_set_dmamode (struct ata_port *ap, struct ata_device *adev)
 {
-	struct pci_dev *dev	= to_pci_dev(ap->host_set->dev);
+	struct pci_dev *dev	= to_pci_dev(ap->host->dev);
 	u8 idetm_port		= ap->port_no ? 0x42 : 0x40;
 	u16 idetm_data;
 
@@ -291,7 +291,7 @@ static int oldpiix_init_one (struct pci_
 	static int printed_version;
 	static struct ata_port_info info = {
 		.sht		= &oldpiix_sht,
-		.host_flags	= ATA_FLAG_SLAVE_POSS | ATA_FLAG_SRST,
+		.flags		= ATA_FLAG_SLAVE_POSS | ATA_FLAG_SRST,
 		.pio_mask	= 0x1f,	/* pio0-4 */
 		.mwdma_mask	= 0x07, /* mwdma1-2 */
 		.port_ops	= &oldpiix_pata_ops,
diff --git a/drivers/ata/pata_opti.c b/drivers/ata/pata_opti.c
index 59dcb15..c3d0132 100644
--- a/drivers/ata/pata_opti.c
+++ b/drivers/ata/pata_opti.c
@@ -53,7 +53,7 @@ enum {
 
 static int opti_pre_reset(struct ata_port *ap)
 {
-	struct pci_dev *pdev = to_pci_dev(ap->host_set->dev);
+	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
 	static const struct pci_bits opti_enable_bits[] = {
 		{ 0x45, 1, 0x80, 0x00 },
 		{ 0x40, 1, 0x08, 0x00 }
@@ -244,7 +244,7 @@ static int opti_init_one(struct pci_dev 
 {
 	static struct ata_port_info info = {
 		.sht = &opti_sht,
-		.host_flags = ATA_FLAG_SLAVE_POSS | ATA_FLAG_SRST,
+		.flags = ATA_FLAG_SLAVE_POSS | ATA_FLAG_SRST,
 		.pio_mask = 0x1f,
 		.port_ops = &opti_port_ops
 	};
diff --git a/drivers/ata/pata_optidma.c b/drivers/ata/pata_optidma.c
index f4824dd..800aea7 100644
--- a/drivers/ata/pata_optidma.c
+++ b/drivers/ata/pata_optidma.c
@@ -54,7 +54,7 @@ static int pci_clock;	/* 0 = 33 1 = 25 *
  
 static int optidma_pre_reset(struct ata_port *ap)
 {
-	struct pci_dev *pdev = to_pci_dev(ap->host_set->dev);
+	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
 	static const struct pci_bits optidma_enable_bits = { 
 		0x40, 1, 0x08, 0x00
 	};
@@ -217,7 +217,7 @@ static void optidma_set_mode(struct ata_
 
 static void optiplus_set_mode(struct ata_port *ap, struct ata_device *adev, u8 mode)
 {
-	struct pci_dev *pdev = to_pci_dev(ap->host_set->dev);
+	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
 	u8 udcfg;
 	u8 udslave;
 	int dev2 = 2 * adev->devno;
@@ -335,7 +335,7 @@ static void optidma_post_set_mode(struct
 {
 	u8 r;
 	int nybble = 4 * ap->port_no;
-	struct pci_dev *pdev = to_pci_dev(ap->host_set->dev);
+	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
 	
 	pci_read_config_byte(pdev, 0x43, &r);
 	
@@ -481,14 +481,14 @@ static int optidma_init_one(struct pci_d
 {
 	static struct ata_port_info info_82c700 = {
 		.sht = &optidma_sht,
-		.host_flags = ATA_FLAG_SLAVE_POSS | ATA_FLAG_SRST,
+		.flags = ATA_FLAG_SLAVE_POSS | ATA_FLAG_SRST,
 		.pio_mask = 0x1f,
 		.mwdma_mask = 0x07,
 		.port_ops = &optidma_port_ops
 	};
 	static struct ata_port_info info_82c700_udma = {
 		.sht = &optidma_sht,
-		.host_flags = ATA_FLAG_SLAVE_POSS | ATA_FLAG_SRST,
+		.flags = ATA_FLAG_SLAVE_POSS | ATA_FLAG_SRST,
 		.pio_mask = 0x1f,
 		.mwdma_mask = 0x07,
 		.udma_mask = 0x07,
diff --git a/drivers/ata/pata_pcmcia.c b/drivers/ata/pata_pcmcia.c
index 3e94f30..2abe0a3 100644
--- a/drivers/ata/pata_pcmcia.c
+++ b/drivers/ata/pata_pcmcia.c
@@ -264,7 +264,7 @@ next_entry:
 	ae.pio_mask = 1;		/* ISA so PIO 0 cycles */
 	ae.irq = pdev->irq.AssignedIRQ;
 	ae.irq_flags = SA_SHIRQ;
-	ae.host_flags = ATA_FLAG_SLAVE_POSS | ATA_FLAG_SRST;
+	ae.port_flags = ATA_FLAG_SLAVE_POSS | ATA_FLAG_SRST;
 	ae.port[0].cmd_addr = io_base;
 	ae.port[0].altstatus_addr = ctl_base;
 	ae.port[0].ctl_addr = ctl_base;
@@ -304,8 +304,8 @@ static void pcmcia_remove_one(struct pcm
 	if (info != NULL) {
 		/* If we have attached the device to the ATA layer, detach it */
 		if (info->ndev) {
-			struct ata_host_set *host_set = dev_get_drvdata(dev);
-			ata_host_set_remove(host_set);
+			struct ata_host *host = dev_get_drvdata(dev);
+			ata_host_remove(host);
 			dev_set_drvdata(dev, NULL);
 		}
 		info->ndev = 0;
diff --git a/drivers/ata/pata_pdc2027x.c b/drivers/ata/pata_pdc2027x.c
index 4f713fc..56b8c1e 100644
--- a/drivers/ata/pata_pdc2027x.c
+++ b/drivers/ata/pata_pdc2027x.c
@@ -212,7 +212,7 @@ static struct ata_port_info pdc2027x_por
 	/* PDC_UDMA_100 */
 	{
 		.sht		= &pdc2027x_sht,
-		.host_flags	= ATA_FLAG_NO_LEGACY | ATA_FLAG_SLAVE_POSS |
+		.flags		= ATA_FLAG_NO_LEGACY | ATA_FLAG_SLAVE_POSS |
 		                  ATA_FLAG_MMIO,
 		.pio_mask	= 0x1f, /* pio0-4 */
 		.mwdma_mask	= 0x07, /* mwdma0-2 */
@@ -222,7 +222,7 @@ static struct ata_port_info pdc2027x_por
 	/* PDC_UDMA_133 */
 	{
 		.sht		= &pdc2027x_sht,
-		.host_flags	= ATA_FLAG_NO_LEGACY | ATA_FLAG_SLAVE_POSS |
+		.flags		= ATA_FLAG_NO_LEGACY | ATA_FLAG_SLAVE_POSS |
                         	  ATA_FLAG_MMIO,
 		.pio_mask	= 0x1f, /* pio0-4 */
 		.mwdma_mask	= 0x07, /* mwdma0-2 */
@@ -244,7 +244,7 @@ MODULE_DEVICE_TABLE(pci, pdc2027x_pci_tb
  */
 static inline void* port_mmio(struct ata_port *ap, unsigned int offset)
 {
-	return ap->host_set->mmio_base + ap->port_no * 0x100 + offset;
+	return ap->host->mmio_base + ap->port_no * 0x100 + offset;
 }
 
 /**
@@ -744,7 +744,7 @@ static void pdc_ata_setup_port(struct at
  * pdc2027x_init_one - PCI probe function
  * Called when an instance of PCI adapter is inserted.
  * This function checks whether the hardware is supported,
- * initialize hardware and register an instance of ata_host_set to
+ * initialize hardware and register an instance of ata_host to
  * libata by providing struct ata_probe_ent and ata_device_add().
  * (implements struct pci_driver.probe() )
  *
@@ -799,7 +799,7 @@ static int __devinit pdc2027x_init_one(s
 	base = (unsigned long) mmio_base;
 
 	probe_ent->sht		= pdc2027x_port_info[board_idx].sht;
-	probe_ent->host_flags	= pdc2027x_port_info[board_idx].host_flags;
+	probe_ent->port_flags	= pdc2027x_port_info[board_idx].flags;
 	probe_ent->pio_mask	= pdc2027x_port_info[board_idx].pio_mask;
 	probe_ent->mwdma_mask	= pdc2027x_port_info[board_idx].mwdma_mask;
 	probe_ent->udma_mask	= pdc2027x_port_info[board_idx].udma_mask;
diff --git a/drivers/ata/pata_pdc202xx_old.c b/drivers/ata/pata_pdc202xx_old.c
index 8ad79c1..6cb52b0 100644
--- a/drivers/ata/pata_pdc202xx_old.c
+++ b/drivers/ata/pata_pdc202xx_old.c
@@ -45,7 +45,7 @@ static void pdc2024x_error_handler(struc
 
 static int pdc2026x_pre_reset(struct ata_port *ap)
 {
-	struct pci_dev *pdev = to_pci_dev(ap->host_set->dev);
+	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
 	u16 cis;
 	
 	pci_read_config_word(pdev, 0x50, &cis);
@@ -75,7 +75,7 @@ static void pdc2026x_error_handler(struc
  
 static void pdc_configure_piomode(struct ata_port *ap, struct ata_device *adev, int pio)
 {
-	struct pci_dev *pdev = to_pci_dev(ap->host_set->dev);
+	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
 	int port = 0x60 + 4 * ap->port_no + 2 * adev->devno;
 	static u16 pio_timing[5] = {
 		0x0913, 0x050C , 0x0308, 0x0206, 0x0104
@@ -122,7 +122,7 @@ static void pdc_set_piomode(struct ata_p
  
 static void pdc_set_dmamode(struct ata_port *ap, struct ata_device *adev)
 {
-	struct pci_dev *pdev = to_pci_dev(ap->host_set->dev);
+	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
 	int port = 0x60 + 4 * ap->port_no + 2 * adev->devno;
 	static u8 udma_timing[6][2] = {
 		{ 0x60, 0x03 },	/* 33 Mhz Clock */
@@ -170,13 +170,13 @@ static void pdc2026x_bmdma_start(struct 
 	struct ata_taskfile *tf = &qc->tf;
 	int sel66 = ap->port_no ? 0x08: 0x02;
 
-	unsigned long master = ap->host_set->ports[0]->ioaddr.bmdma_addr;
+	unsigned long master = ap->host->ports[0]->ioaddr.bmdma_addr;
 	unsigned long clock = master + 0x11;
 	unsigned long atapi_reg = master + 0x20 + (4 * ap->port_no);
 	
 	u32 len;
 	
-	/* Check we keep host_set level locking here */
+	/* Check we keep host level locking here */
 	if (adev->dma_mode >= XFER_UDMA_2)
 		outb(inb(clock) | sel66, clock);
 	else
@@ -222,7 +222,7 @@ static void pdc2026x_bmdma_stop(struct a
 	
 	int sel66 = ap->port_no ? 0x08: 0x02;
 	/* The clock bits are in the same register for both channels */
-	unsigned long master = ap->host_set->ports[0]->ioaddr.bmdma_addr;
+	unsigned long master = ap->host->ports[0]->ioaddr.bmdma_addr;
 	unsigned long clock = master + 0x11;
 	unsigned long atapi_reg = master + 0x20 + (4 * ap->port_no);
 	
@@ -231,7 +231,7 @@ static void pdc2026x_bmdma_stop(struct a
 		outl(0, atapi_reg);
 		outb(inb(clock) & ~sel66, clock);
 	}
-	/* Check we keep host_set level locking here */
+	/* Check we keep host level locking here */
 	/* Flip back to 33Mhz for PIO */
 	if (adev->dma_mode >= XFER_UDMA_2)
 		outb(inb(clock) & ~sel66, clock);
@@ -344,7 +344,7 @@ static int pdc_init_one(struct pci_dev *
 	static struct ata_port_info info[3] = {
 		{
 			.sht = &pdc_sht,
-			.host_flags = ATA_FLAG_SLAVE_POSS | ATA_FLAG_SRST,
+			.flags = ATA_FLAG_SLAVE_POSS | ATA_FLAG_SRST,
 			.pio_mask = 0x1f,
 			.mwdma_mask = 0x07,
 			.udma_mask = ATA_UDMA2,
@@ -352,7 +352,7 @@ static int pdc_init_one(struct pci_dev *
 		}, 
 		{
 			.sht = &pdc_sht,
-			.host_flags = ATA_FLAG_SLAVE_POSS | ATA_FLAG_SRST,
+			.flags = ATA_FLAG_SLAVE_POSS | ATA_FLAG_SRST,
 			.pio_mask = 0x1f,
 			.mwdma_mask = 0x07,
 			.udma_mask = ATA_UDMA4,
@@ -360,7 +360,7 @@ static int pdc_init_one(struct pci_dev *
 		},
 		{
 			.sht = &pdc_sht,
-			.host_flags = ATA_FLAG_SLAVE_POSS | ATA_FLAG_SRST,
+			.flags = ATA_FLAG_SLAVE_POSS | ATA_FLAG_SRST,
 			.pio_mask = 0x1f,
 			.mwdma_mask = 0x07,
 			.udma_mask = ATA_UDMA5,
diff --git a/drivers/ata/pata_qdi.c b/drivers/ata/pata_qdi.c
index 5ddd708..ededb40 100644
--- a/drivers/ata/pata_qdi.c
+++ b/drivers/ata/pata_qdi.c
@@ -39,7 +39,7 @@ struct qdi_data {
 	
 };
 
-static struct ata_host_set *qdi_host[NR_HOST];
+static struct ata_host *qdi_host[NR_HOST];
 static struct qdi_data qdi_data[NR_HOST];
 static int nr_qdi_host;
 
@@ -52,7 +52,7 @@ #endif
 static void qdi6500_set_piomode(struct ata_port *ap, struct ata_device *adev)
 {
 	struct ata_timing t;
-	struct qdi_data *qdi = ap->host_set->private_data;
+	struct qdi_data *qdi = ap->host->private_data;
 	int active, recovery;
 	u8 timing;
 
@@ -76,7 +76,7 @@ static void qdi6500_set_piomode(struct a
 static void qdi6580_set_piomode(struct ata_port *ap, struct ata_device *adev)
 {
 	struct ata_timing t;
-	struct qdi_data *qdi = ap->host_set->private_data;
+	struct qdi_data *qdi = ap->host->private_data;
 	int active, recovery;
 	u8 timing;
 
@@ -113,7 +113,7 @@ static unsigned int qdi_qc_issue_prot(st
 {
 	struct ata_port *ap = qc->ap;
 	struct ata_device *adev = qc->dev;
-	struct qdi_data *qdi = ap->host_set->private_data;
+	struct qdi_data *qdi = ap->host->private_data;
 
 	if (qdi->clock[adev->devno] != qdi->last) {
 		if (adev->pio_mode) {
@@ -266,7 +266,7 @@ static __init int qdi_init_one(unsigned 
 	ae.n_ports = 1;
 	ae.irq = irq;
 	ae.irq_flags = 0;
-	ae.host_flags = ATA_FLAG_SLAVE_POSS | ATA_FLAG_SRST;
+	ae.port_flags = ATA_FLAG_SLAVE_POSS | ATA_FLAG_SRST;
 	ae.port[0].cmd_addr = io;
 	ae.port[0].altstatus_addr = ctrl;
 	ae.port[0].ctl_addr =	ctrl;
@@ -382,7 +382,7 @@ static __exit void qdi_exit(void)
 	int i;
 
 	for (i = 0; i < nr_qdi_host; i++) {
-		ata_host_set_remove(qdi_host[i]);
+		ata_host_remove(qdi_host[i]);
 		/* Free the control resource. The 6580 dual channel has the resources
 		 * claimed as a pair of 2 byte resources so we need no special cases...
 		 */
diff --git a/drivers/ata/pata_radisys.c b/drivers/ata/pata_radisys.c
index 7b58a47..6f7d052 100644
--- a/drivers/ata/pata_radisys.c
+++ b/drivers/ata/pata_radisys.c
@@ -68,7 +68,7 @@ static void radisys_pata_error_handler(s
 static void radisys_set_piomode (struct ata_port *ap, struct ata_device *adev)
 {
 	unsigned int pio	= adev->pio_mode - XFER_PIO_0;
-	struct pci_dev *dev	= to_pci_dev(ap->host_set->dev);
+	struct pci_dev *dev	= to_pci_dev(ap->host->dev);
 	u16 idetm_data;
 	int control = 0;
 
@@ -119,7 +119,7 @@ static void radisys_set_piomode (struct 
 
 static void radisys_set_dmamode (struct ata_port *ap, struct ata_device *adev)
 {
-	struct pci_dev *dev	= to_pci_dev(ap->host_set->dev);
+	struct pci_dev *dev	= to_pci_dev(ap->host->dev);
 	u16 idetm_data;
 	u8 udma_enable;
 	
@@ -286,7 +286,7 @@ static int radisys_init_one (struct pci_
 	static int printed_version;
 	static struct ata_port_info info = {
 		.sht		= &radisys_sht,
-		.host_flags	= ATA_FLAG_SLAVE_POSS | ATA_FLAG_SRST,
+		.flags		= ATA_FLAG_SLAVE_POSS | ATA_FLAG_SRST,
 		.pio_mask	= 0x1f,	/* pio0-4 */
 		.mwdma_mask	= 0x07, /* mwdma1-2 */
 		.udma_mask	= 0x14, /* UDMA33/66 only */
diff --git a/drivers/ata/pata_rz1000.c b/drivers/ata/pata_rz1000.c
index 60db8b2..3c6d84f 100644
--- a/drivers/ata/pata_rz1000.c
+++ b/drivers/ata/pata_rz1000.c
@@ -145,7 +145,7 @@ static int rz1000_init_one (struct pci_d
 	u16 reg;
 	static struct ata_port_info info = {
 		.sht = &rz1000_sht,
-		.host_flags = ATA_FLAG_SLAVE_POSS | ATA_FLAG_SRST,
+		.flags = ATA_FLAG_SLAVE_POSS | ATA_FLAG_SRST,
 		.pio_mask = 0x1f,
 		.port_ops = &rz1000_port_ops
 	};
diff --git a/drivers/ata/pata_sc1200.c b/drivers/ata/pata_sc1200.c
index 1be971a..9b42b9a 100644
--- a/drivers/ata/pata_sc1200.c
+++ b/drivers/ata/pata_sc1200.c
@@ -93,7 +93,7 @@ static void sc1200_set_piomode(struct at
 		{0xfff4fff4, 0xf35353d3, 0x814102f1, 0x42314231, 0x11311131}	// format1, 66Mhz
 	};
 
-	struct pci_dev *pdev = to_pci_dev(ap->host_set->dev);
+	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
 	u32 format;
 	unsigned int reg = 0x40 + 0x10 * ap->port_no;
 	int mode = adev->pio_mode - XFER_PIO_0;
@@ -129,7 +129,7 @@ static void sc1200_set_dmamode(struct at
 	};
 	
 	int clock = sc1200_clock();
-	struct pci_dev *pdev = to_pci_dev(ap->host_set->dev);
+	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
 	unsigned int reg = 0x40 + 0x10 * ap->port_no;
 	int mode = adev->dma_mode;
 	u32 format;
@@ -241,7 +241,7 @@ static int sc1200_init_one(struct pci_de
 {
 	static struct ata_port_info info = {
 		.sht = &sc1200_sht,
-		.host_flags = ATA_FLAG_SLAVE_POSS|ATA_FLAG_SRST,
+		.flags = ATA_FLAG_SLAVE_POSS|ATA_FLAG_SRST,
 		.pio_mask = 0x1f,
 		.mwdma_mask = 0x07,
 		.udma_mask = 0x07,
diff --git a/drivers/ata/pata_serverworks.c b/drivers/ata/pata_serverworks.c
index 8c0b248..3ec3003 100644
--- a/drivers/ata/pata_serverworks.c
+++ b/drivers/ata/pata_serverworks.c
@@ -66,7 +66,7 @@ static const char *csb_bad_ata100[] = {
  */
  
 static int dell_cable(struct ata_port *ap) {
-	struct pci_dev *pdev = to_pci_dev(ap->host_set->dev);
+	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
 	
 	if (pdev->subsystem_device & (1 << (ap->port_no + 14)))
 		return ATA_CBL_PATA80;
@@ -83,7 +83,7 @@ static int dell_cable(struct ata_port *a
  */
  
 static int sun_cable(struct ata_port *ap) {
-	struct pci_dev *pdev = to_pci_dev(ap->host_set->dev);
+	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
 	
 	if (pdev->subsystem_device & (1 << (ap->port_no + 14)))
 		return ATA_CBL_PATA80;
@@ -145,7 +145,7 @@ static struct sv_cable_table cable_detec
  */
  
 static int serverworks_pre_reset(struct ata_port *ap) {
-	struct pci_dev *pdev = to_pci_dev(ap->host_set->dev);
+	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
 	struct sv_cable_table *cb = cable_detect;
 
 	while(cb->device) {
@@ -257,7 +257,7 @@ static void serverworks_set_piomode(stru
 	int offset = 1 + (2 * ap->port_no) - adev->devno;
 	int devbits = (2 * ap->port_no + adev->devno) * 4;
 	u16 csb5_pio;
-	struct pci_dev *pdev = to_pci_dev(ap->host_set->dev);
+	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
 	int pio = adev->pio_mode - XFER_PIO_0;
 
 	pci_write_config_byte(pdev, 0x40 + offset, pio_mode[pio]);
@@ -288,7 +288,7 @@ static void serverworks_set_dmamode(stru
 	int devbits = (2 * ap->port_no + adev->devno);
 	u8 ultra;
 	u8 ultra_cfg;
-	struct pci_dev *pdev = to_pci_dev(ap->host_set->dev);
+	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
 
 	pci_read_config_byte(pdev, 0x54, &ultra_cfg);
 
@@ -484,28 +484,28 @@ static int serverworks_init_one(struct p
 	static struct ata_port_info info[4] = {
 		{ /* OSB4 */
 			.sht = &serverworks_sht,
-			.host_flags = ATA_FLAG_SLAVE_POSS | ATA_FLAG_SRST,
+			.flags = ATA_FLAG_SLAVE_POSS | ATA_FLAG_SRST,
 			.pio_mask = 0x1f,
 			.mwdma_mask = 0x07,
 			.udma_mask = 0x07,
 			.port_ops = &serverworks_osb4_port_ops
 		}, { /* OSB4 no UDMA */
 			.sht = &serverworks_sht,
-			.host_flags = ATA_FLAG_SLAVE_POSS | ATA_FLAG_SRST,
+			.flags = ATA_FLAG_SLAVE_POSS | ATA_FLAG_SRST,
 			.pio_mask = 0x1f,
 			.mwdma_mask = 0x07,
 			.udma_mask = 0x00,
 			.port_ops = &serverworks_osb4_port_ops
 		}, { /* CSB5 */
 			.sht = &serverworks_sht,
-			.host_flags = ATA_FLAG_SLAVE_POSS | ATA_FLAG_SRST,
+			.flags = ATA_FLAG_SLAVE_POSS | ATA_FLAG_SRST,
 			.pio_mask = 0x1f,
 			.mwdma_mask = 0x07,
 			.udma_mask = 0x1f,
 			.port_ops = &serverworks_csb_port_ops
 		}, { /* CSB5 - later revisions*/
 			.sht = &serverworks_sht,
-			.host_flags = ATA_FLAG_SLAVE_POSS | ATA_FLAG_SRST,
+			.flags = ATA_FLAG_SLAVE_POSS | ATA_FLAG_SRST,
 			.pio_mask = 0x1f,
 			.mwdma_mask = 0x07,
 			.udma_mask = 0x3f,
diff --git a/drivers/ata/pata_sil680.c b/drivers/ata/pata_sil680.c
index a0c3c7d..8f7db96 100644
--- a/drivers/ata/pata_sil680.c
+++ b/drivers/ata/pata_sil680.c
@@ -81,7 +81,7 @@ static unsigned long sil680_seldev(struc
  */
 
 static int sil680_cable_detect(struct ata_port *ap) {
-	struct pci_dev *pdev = to_pci_dev(ap->host_set->dev);
+	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
 	unsigned long addr = sil680_selreg(ap, 0);
 	u8 ata66;
 	pci_read_config_byte(pdev, addr, &ata66);
@@ -106,7 +106,7 @@ static int sil680_pre_reset(struct ata_p
 
 static int sil680_bus_reset(struct ata_port *ap,unsigned int *classes)
 {
-	struct pci_dev *pdev = to_pci_dev(ap->host_set->dev);
+	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
 	unsigned long addr = sil680_selreg(ap, 0);
 	u8 reset;
 
@@ -139,7 +139,7 @@ static void sil680_set_piomode(struct at
 
 	unsigned long tfaddr = sil680_selreg(ap, 0x02);
 	unsigned long addr = sil680_seldev(ap, adev, 0x04);
-	struct pci_dev *pdev = to_pci_dev(ap->host_set->dev);
+	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
 	int pio = adev->pio_mode - XFER_PIO_0;
 	int lowest_pio = pio;
 	u16 reg;
@@ -177,7 +177,7 @@ static void sil680_set_dmamode(struct at
 	};
 	static u16 dma_table[3] = { 0x2208, 0x10C2, 0x10C1 };
 
-	struct pci_dev *pdev = to_pci_dev(ap->host_set->dev);
+	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
 	unsigned long ma = sil680_seldev(ap, adev, 0x08);
 	unsigned long ua = sil680_seldev(ap, adev, 0x0C);
 	unsigned long addr_mask = 0x80 + 4 * ap->port_no;
@@ -266,7 +266,7 @@ static int sil680_init_one(struct pci_de
 {
 	static struct ata_port_info info = {
 		.sht = &sil680_sht,
-		.host_flags = ATA_FLAG_SLAVE_POSS | ATA_FLAG_SRST,
+		.flags = ATA_FLAG_SLAVE_POSS | ATA_FLAG_SRST,
 		.pio_mask = 0x1f,
 		.mwdma_mask = 0x07,
 		.udma_mask = 0x7f,
@@ -274,7 +274,7 @@ static int sil680_init_one(struct pci_de
 	};
 	static struct ata_port_info info_slow = {
 		.sht = &sil680_sht,
-		.host_flags = ATA_FLAG_SLAVE_POSS | ATA_FLAG_SRST,
+		.flags = ATA_FLAG_SLAVE_POSS | ATA_FLAG_SRST,
 		.pio_mask = 0x1f,
 		.mwdma_mask = 0x07,
 		.udma_mask = 0x3f,
diff --git a/drivers/ata/pata_sis.c b/drivers/ata/pata_sis.c
index 03ded9e..4ad7fb4 100644
--- a/drivers/ata/pata_sis.c
+++ b/drivers/ata/pata_sis.c
@@ -71,7 +71,7 @@ static int sis_133_pre_reset(struct ata_
 		{ 0x4aU, 1U, 0x04UL, 0x04UL },	/* port 1 */
 	};
 	
-	struct pci_dev *pdev = to_pci_dev(ap->host_set->dev);
+	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
 	u16 tmp;
 
 	if (!pci_test_config_bits(pdev, &sis_enable_bits[ap->port_no])) {
@@ -118,7 +118,7 @@ static int sis_66_pre_reset(struct ata_p
 		{ 0x4aU, 1U, 0x04UL, 0x04UL },	/* port 1 */
 	};
 
-	struct pci_dev *pdev = to_pci_dev(ap->host_set->dev);
+	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
 	u8 tmp;
 
 	if (!pci_test_config_bits(pdev, &sis_enable_bits[ap->port_no])) {
@@ -165,7 +165,7 @@ static int sis_old_pre_reset(struct ata_
 		{ 0x4aU, 1U, 0x04UL, 0x04UL },	/* port 1 */
 	};
 	
-	struct pci_dev *pdev = to_pci_dev(ap->host_set->dev);
+	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
 
 	if (!pci_test_config_bits(pdev, &sis_enable_bits[ap->port_no])) {
 		ata_port_disable(ap);
@@ -202,7 +202,7 @@ static void sis_old_error_handler(struct
 
 static void sis_set_fifo(struct ata_port *ap, struct ata_device *adev)
 {
-	struct pci_dev *pdev = to_pci_dev(ap->host_set->dev);
+	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
 	u8 fifoctrl;
 	u8 mask = 0x11;
 
@@ -234,7 +234,7 @@ static void sis_set_fifo(struct ata_port
 
 static void sis_old_set_piomode (struct ata_port *ap, struct ata_device *adev)
 {
-	struct pci_dev *pdev	= to_pci_dev(ap->host_set->dev);
+	struct pci_dev *pdev	= to_pci_dev(ap->host->dev);
 	int port = sis_port_base(adev);
 	u8 t1, t2;
 	int speed = adev->pio_mode - XFER_PIO_0;
@@ -271,7 +271,7 @@ static void sis_old_set_piomode (struct 
 
 static void sis_100_set_piomode (struct ata_port *ap, struct ata_device *adev)
 {
-	struct pci_dev *pdev	= to_pci_dev(ap->host_set->dev);
+	struct pci_dev *pdev	= to_pci_dev(ap->host->dev);
 	int port = sis_port_base(adev);
 	int speed = adev->pio_mode - XFER_PIO_0;
 
@@ -296,7 +296,7 @@ static void sis_100_set_piomode (struct 
 
 static void sis_133_set_piomode (struct ata_port *ap, struct ata_device *adev)
 {
-	struct pci_dev *pdev	= to_pci_dev(ap->host_set->dev);
+	struct pci_dev *pdev	= to_pci_dev(ap->host->dev);
 	int port = 0x40;
 	u32 t1;
 	u32 reg54;
@@ -350,7 +350,7 @@ static void sis_133_set_piomode (struct 
 
 static void sis_old_set_dmamode (struct ata_port *ap, struct ata_device *adev)
 {
-	struct pci_dev *pdev	= to_pci_dev(ap->host_set->dev);
+	struct pci_dev *pdev	= to_pci_dev(ap->host->dev);
 	int speed = adev->dma_mode - XFER_MW_DMA_0;
 	int drive_pci = sis_port_base(adev);
 	u16 timing;
@@ -389,7 +389,7 @@ static void sis_old_set_dmamode (struct 
 
 static void sis_66_set_dmamode (struct ata_port *ap, struct ata_device *adev)
 {
-	struct pci_dev *pdev	= to_pci_dev(ap->host_set->dev);
+	struct pci_dev *pdev	= to_pci_dev(ap->host->dev);
 	int speed = adev->dma_mode - XFER_MW_DMA_0;
 	int drive_pci = sis_port_base(adev);
 	u16 timing;
@@ -427,7 +427,7 @@ static void sis_66_set_dmamode (struct a
 
 static void sis_100_set_dmamode (struct ata_port *ap, struct ata_device *adev)
 {
-	struct pci_dev *pdev	= to_pci_dev(ap->host_set->dev);
+	struct pci_dev *pdev	= to_pci_dev(ap->host->dev);
 	int speed = adev->dma_mode - XFER_MW_DMA_0;
 	int drive_pci = sis_port_base(adev);
 	u16 timing;
@@ -462,7 +462,7 @@ static void sis_100_set_dmamode (struct 
 
 static void sis_133_early_set_dmamode (struct ata_port *ap, struct ata_device *adev)
 {
-	struct pci_dev *pdev	= to_pci_dev(ap->host_set->dev);
+	struct pci_dev *pdev	= to_pci_dev(ap->host->dev);
 	int speed = adev->dma_mode - XFER_MW_DMA_0;
 	int drive_pci = sis_port_base(adev);
 	u16 timing;
@@ -497,7 +497,7 @@ static void sis_133_early_set_dmamode (s
 
 static void sis_133_set_dmamode (struct ata_port *ap, struct ata_device *adev)
 {
-	struct pci_dev *pdev	= to_pci_dev(ap->host_set->dev);
+	struct pci_dev *pdev	= to_pci_dev(ap->host->dev);
 	int speed = adev->dma_mode - XFER_MW_DMA_0;
 	int port = 0x40;
 	u32 t1;
@@ -728,7 +728,7 @@ static const struct ata_port_operations 
 
 static struct ata_port_info sis_info = {
 	.sht		= &sis_sht,
-	.host_flags	= ATA_FLAG_SLAVE_POSS | ATA_FLAG_SRST,
+	.flags		= ATA_FLAG_SLAVE_POSS | ATA_FLAG_SRST,
 	.pio_mask	= 0x1f,	/* pio0-4 */
 	.mwdma_mask	= 0x07,
 	.udma_mask	= 0,
@@ -736,7 +736,7 @@ static struct ata_port_info sis_info = {
 };
 static struct ata_port_info sis_info33 = {
 	.sht		= &sis_sht,
-	.host_flags	= ATA_FLAG_SLAVE_POSS | ATA_FLAG_SRST,
+	.flags		= ATA_FLAG_SLAVE_POSS | ATA_FLAG_SRST,
 	.pio_mask	= 0x1f,	/* pio0-4 */
 	.mwdma_mask	= 0x07,
 	.udma_mask	= ATA_UDMA2,	/* UDMA 33 */
@@ -744,35 +744,35 @@ static struct ata_port_info sis_info33 =
 };
 static struct ata_port_info sis_info66 = {
 	.sht		= &sis_sht,
-	.host_flags	= ATA_FLAG_SLAVE_POSS | ATA_FLAG_SRST,
+	.flags		= ATA_FLAG_SLAVE_POSS | ATA_FLAG_SRST,
 	.pio_mask	= 0x1f,	/* pio0-4 */
 	.udma_mask	= ATA_UDMA4,	/* UDMA 66 */
 	.port_ops	= &sis_66_ops,
 };
 static struct ata_port_info sis_info100 = {
 	.sht		= &sis_sht,
-	.host_flags	= ATA_FLAG_SLAVE_POSS | ATA_FLAG_SRST,
+	.flags		= ATA_FLAG_SLAVE_POSS | ATA_FLAG_SRST,
 	.pio_mask	= 0x1f,	/* pio0-4 */
 	.udma_mask	= ATA_UDMA5,
 	.port_ops	= &sis_100_ops,
 };
 static struct ata_port_info sis_info100_early = {
 	.sht		= &sis_sht,
-	.host_flags	= ATA_FLAG_SLAVE_POSS | ATA_FLAG_SRST,
+	.flags		= ATA_FLAG_SLAVE_POSS | ATA_FLAG_SRST,
 	.udma_mask	= ATA_UDMA5,
 	.pio_mask	= 0x1f,	/* pio0-4 */
 	.port_ops	= &sis_66_ops,
 };
 static struct ata_port_info sis_info133 = {
 	.sht		= &sis_sht,
-	.host_flags	= ATA_FLAG_SLAVE_POSS | ATA_FLAG_SRST,
+	.flags		= ATA_FLAG_SLAVE_POSS | ATA_FLAG_SRST,
 	.pio_mask	= 0x1f,	/* pio0-4 */
 	.udma_mask	= ATA_UDMA6,
 	.port_ops	= &sis_133_ops,
 };
 static struct ata_port_info sis_info133_early = {
 	.sht		= &sis_sht,
-	.host_flags	= ATA_FLAG_SLAVE_POSS | ATA_FLAG_SRST,
+	.flags		= ATA_FLAG_SLAVE_POSS | ATA_FLAG_SRST,
 	.pio_mask	= 0x1f,	/* pio0-4 */
 	.udma_mask	= ATA_UDMA6,
 	.port_ops	= &sis_133_early_ops,
diff --git a/drivers/ata/pata_sl82c105.c b/drivers/ata/pata_sl82c105.c
index bc1d973..47b290b 100644
--- a/drivers/ata/pata_sl82c105.c
+++ b/drivers/ata/pata_sl82c105.c
@@ -47,7 +47,7 @@ static int sl82c105_pre_reset(struct ata
 		{ 0x40, 1, 0x01, 0x01 },
 		{ 0x40, 1, 0x10, 0x10 }
 	};
-	struct pci_dev *pdev = to_pci_dev(ap->host_set->dev);
+	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
 
 	if (ap->port_no && !pci_test_config_bits(pdev, &sl82c105_enable_bits[ap->port_no])) {
 		ata_port_disable(ap);
@@ -78,7 +78,7 @@ static void sl82c105_error_handler(struc
  
 static void sl82c105_configure_piomode(struct ata_port *ap, struct ata_device *adev, int pio)
 {
-	struct pci_dev *pdev = to_pci_dev(ap->host_set->dev);
+	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
 	static u16 pio_timing[5] = {
 		0x50D, 0x407, 0x304, 0x242, 0x240
 	};
@@ -115,7 +115,7 @@ static void sl82c105_set_piomode(struct 
  
 static void sl82c105_configure_dmamode(struct ata_port *ap, struct ata_device *adev)
 {
-	struct pci_dev *pdev = to_pci_dev(ap->host_set->dev);
+	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
 	static u16 dma_timing[3] = {
 		0x707, 0x201, 0x200
 	};
@@ -167,7 +167,7 @@ static void sl82c105_set_dmamode(struct 
  
 static void sl82c105_reset_engine(struct ata_port *ap)
 {
-	struct pci_dev *pdev = to_pci_dev(ap->host_set->dev);
+	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
 	u16 val;
 	
 	pci_read_config_word(pdev, 0x7E, &val);
@@ -320,14 +320,14 @@ static int sl82c105_init_one(struct pci_
 {
 	static struct ata_port_info info_dma = {
 		.sht = &sl82c105_sht,
-		.host_flags = ATA_FLAG_SLAVE_POSS | ATA_FLAG_SRST,
+		.flags = ATA_FLAG_SLAVE_POSS | ATA_FLAG_SRST,
 		.pio_mask = 0x1f,
 		.mwdma_mask = 0x07,
 		.port_ops = &sl82c105_port_ops
 	};
 	static struct ata_port_info info_early = {
 		.sht = &sl82c105_sht,
-		.host_flags = ATA_FLAG_SLAVE_POSS | ATA_FLAG_SRST,
+		.flags = ATA_FLAG_SLAVE_POSS | ATA_FLAG_SRST,
 		.pio_mask = 0x1f,
 		.port_ops = &sl82c105_port_ops
 	};
diff --git a/drivers/ata/pata_triflex.c b/drivers/ata/pata_triflex.c
index 549dc43..7dd6ea3 100644
--- a/drivers/ata/pata_triflex.c
+++ b/drivers/ata/pata_triflex.c
@@ -59,7 +59,7 @@ static int triflex_probe_init(struct ata
 		{ 0x80, 1, 0x02, 0x02 }
 	};
 
-	struct pci_dev *pdev = to_pci_dev(ap->host_set->dev);
+	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
 	
 	if (!pci_test_config_bits(pdev, &triflex_enable_bits[ap->port_no])) {
 		ata_port_disable(ap);
@@ -91,7 +91,7 @@ static void triflex_error_handler(struct
 
 static void triflex_load_timing(struct ata_port *ap, struct ata_device *adev, int speed)
 {
-	struct pci_dev *pdev = to_pci_dev(ap->host_set->dev);
+	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
 	u32 timing = 0;
 	u32 triflex_timing, old_triflex_timing;
 	int channel_offset = ap->port_no ? 0x74: 0x70;
@@ -236,7 +236,7 @@ static int triflex_init_one(struct pci_d
 {
 	static struct ata_port_info info = {
 		.sht = &triflex_sht,
-		.host_flags = ATA_FLAG_SLAVE_POSS | ATA_FLAG_SRST,
+		.flags = ATA_FLAG_SLAVE_POSS | ATA_FLAG_SRST,
 		.pio_mask = 0x1f,
 		.mwdma_mask = 0x07,
 		.port_ops = &triflex_port_ops
diff --git a/drivers/ata/pata_via.c b/drivers/ata/pata_via.c
index 3eab0d5..2580e16 100644
--- a/drivers/ata/pata_via.c
+++ b/drivers/ata/pata_via.c
@@ -131,7 +131,7 @@ static const struct via_isa_bridge {
  */
 
 static int via_cable_detect(struct ata_port *ap) {
-	struct pci_dev *pdev = to_pci_dev(ap->host_set->dev);
+	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
 	u32 ata66;
 
 	pci_read_config_dword(pdev, 0x50, &ata66);
@@ -145,7 +145,7 @@ static int via_cable_detect(struct ata_p
 
 static int via_pre_reset(struct ata_port *ap)
 {
-	const struct via_isa_bridge *config = ap->host_set->private_data;
+	const struct via_isa_bridge *config = ap->host->private_data;
 
 	if (!(config->flags & VIA_NO_ENABLES)) {
 		static const struct pci_bits via_enable_bits[] = {
@@ -153,7 +153,7 @@ static int via_pre_reset(struct ata_port
 			{ 0x40, 1, 0x01, 0x01 }
 		};
 
-		struct pci_dev *pdev = to_pci_dev(ap->host_set->dev);
+		struct pci_dev *pdev = to_pci_dev(ap->host->dev);
 		
 		if (!pci_test_config_bits(pdev, &via_enable_bits[ap->port_no])) {
 			ata_port_disable(ap);
@@ -200,7 +200,7 @@ static void via_error_handler(struct ata
 
 static void via_do_set_mode(struct ata_port *ap, struct ata_device *adev, int mode, int tdiv, int set_ast, int udma_type)
 {
-	struct pci_dev *pdev = to_pci_dev(ap->host_set->dev);
+	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
 	struct ata_device *peer = ata_dev_pair(adev);
 	struct ata_timing t, p;
 	static int via_clock = 33333;	/* Bus clock in kHZ - ought to be tunable one day */
@@ -263,7 +263,7 @@ static void via_do_set_mode(struct ata_p
 
 static void via_set_piomode(struct ata_port *ap, struct ata_device *adev)
 {
-	const struct via_isa_bridge *config = ap->host_set->private_data;
+	const struct via_isa_bridge *config = ap->host->private_data;
 	int set_ast = (config->flags & VIA_BAD_AST) ? 0 : 1;
 	int mode = config->flags & VIA_UDMA;
 	static u8 tclock[5] = { 1, 1, 2, 3, 4 };
@@ -274,7 +274,7 @@ static void via_set_piomode(struct ata_p
 
 static void via_set_dmamode(struct ata_port *ap, struct ata_device *adev)
 {
-	const struct via_isa_bridge *config = ap->host_set->private_data;
+	const struct via_isa_bridge *config = ap->host->private_data;
 	int set_ast = (config->flags & VIA_BAD_AST) ? 0 : 1;
 	int mode = config->flags & VIA_UDMA;
 	static u8 tclock[5] = { 1, 1, 2, 3, 4 };
@@ -385,7 +385,7 @@ static int via_init_one(struct pci_dev *
 	/* Early VIA without UDMA support */
 	static struct ata_port_info via_mwdma_info = {
 		.sht = &via_sht,
-		.host_flags = ATA_FLAG_SLAVE_POSS | ATA_FLAG_SRST,
+		.flags = ATA_FLAG_SLAVE_POSS | ATA_FLAG_SRST,
 		.pio_mask = 0x1f,
 		.mwdma_mask = 0x07,
 		.port_ops = &via_port_ops
@@ -393,7 +393,7 @@ static int via_init_one(struct pci_dev *
 	/* Ditto with IRQ masking required */
 	static struct ata_port_info via_mwdma_info_borked = {
 		.sht = &via_sht,
-		.host_flags = ATA_FLAG_SLAVE_POSS | ATA_FLAG_SRST,
+		.flags = ATA_FLAG_SLAVE_POSS | ATA_FLAG_SRST,
 		.pio_mask = 0x1f,
 		.mwdma_mask = 0x07,
 		.port_ops = &via_port_ops_noirq,
@@ -401,7 +401,7 @@ static int via_init_one(struct pci_dev *
 	/* VIA UDMA 33 devices (and borked 66) */
 	static struct ata_port_info via_udma33_info = {
 		.sht = &via_sht,
-		.host_flags = ATA_FLAG_SLAVE_POSS | ATA_FLAG_SRST,
+		.flags = ATA_FLAG_SLAVE_POSS | ATA_FLAG_SRST,
 		.pio_mask = 0x1f,
 		.mwdma_mask = 0x07,
 		.udma_mask = 0x7,
@@ -410,7 +410,7 @@ static int via_init_one(struct pci_dev *
 	/* VIA UDMA 66 devices */
 	static struct ata_port_info via_udma66_info = {
 		.sht = &via_sht,
-		.host_flags = ATA_FLAG_SLAVE_POSS | ATA_FLAG_SRST,
+		.flags = ATA_FLAG_SLAVE_POSS | ATA_FLAG_SRST,
 		.pio_mask = 0x1f,
 		.mwdma_mask = 0x07,
 		.udma_mask = 0x1f,
@@ -419,7 +419,7 @@ static int via_init_one(struct pci_dev *
 	/* VIA UDMA 100 devices */
 	static struct ata_port_info via_udma100_info = {
 		.sht = &via_sht,
-		.host_flags = ATA_FLAG_SLAVE_POSS | ATA_FLAG_SRST,
+		.flags = ATA_FLAG_SLAVE_POSS | ATA_FLAG_SRST,
 		.pio_mask = 0x1f,
 		.mwdma_mask = 0x07,
 		.udma_mask = 0x3f,
@@ -428,7 +428,7 @@ static int via_init_one(struct pci_dev *
 	/* UDMA133 with bad AST (All current 133) */
 	static struct ata_port_info via_udma133_info = {
 		.sht = &via_sht,
-		.host_flags = ATA_FLAG_SLAVE_POSS | ATA_FLAG_SRST,
+		.flags = ATA_FLAG_SLAVE_POSS | ATA_FLAG_SRST,
 		.pio_mask = 0x1f,
 		.mwdma_mask = 0x07,
 		.udma_mask = 0x7f,	/* FIXME: should check north bridge */
-- 
1.4.1.1

