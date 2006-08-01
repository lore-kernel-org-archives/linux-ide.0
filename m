From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH] libata: convert pata drivers use port_no instead of hard_port_no
Date: Wed, 2 Aug 2006 05:17:13 +0900
Message-ID: <20060801201713.GB6371@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.178]:2577 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1161020AbWHAUR0 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 1 Aug 2006 16:17:26 -0400
Received: by py-out-1112.google.com with SMTP id t32so1325742pyc
        for <linux-ide@vger.kernel.org>; Tue, 01 Aug 2006 13:17:20 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@osdl.org>, linux-ide@vger.kernel.org

Now that port_no always equlas hard_port_no, convert pata drivers to
use port_no instead of hard_port_no and kill all hard_port_no related
stuff in those drivers.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

This patch should be applied *after* merging upstream legacy handling
updates.  This posting is for review only.  Please pull/fetch from git
tree mentioned in the following mail for merge.

  http://article.gmane.org/gmane.linux.ide/12347

Thanks.

 drivers/scsi/ata_piix.c          |   16 ++++++++--------
 drivers/scsi/pata_ali.c          |   12 ++++++------
 drivers/scsi/pata_amd.c          |   12 ++++++------
 drivers/scsi/pata_artop.c        |   22 +++++++++++-----------
 drivers/scsi/pata_atiixp.c       |   14 +++++++-------
 drivers/scsi/pata_cmd64x.c       |   16 ++++++++--------
 drivers/scsi/pata_cs5520.c       |    8 +++-----
 drivers/scsi/pata_cs5530.c       |    4 ++--
 drivers/scsi/pata_cypress.c      |    2 +-
 drivers/scsi/pata_efar.c         |   16 ++++++++--------
 drivers/scsi/pata_hpt366.c       |   10 +++++-----
 drivers/scsi/pata_hpt37x.c       |   30 +++++++++++++++---------------
 drivers/scsi/pata_hpt3x2n.c      |   16 ++++++++--------
 drivers/scsi/pata_hpt3x3.c       |    4 ++--
 drivers/scsi/pata_it8172.c       |    4 ++--
 drivers/scsi/pata_it821x.c       |   12 ++++++------
 drivers/scsi/pata_mpiix.c        |    5 +----
 drivers/scsi/pata_ns87410.c      |    4 ++--
 drivers/scsi/pata_oldpiix.c      |    6 +++---
 drivers/scsi/pata_opti.c         |    2 +-
 drivers/scsi/pata_optidma.c      |    8 ++++----
 drivers/scsi/pata_pdc202xx_old.c |   14 +++++++-------
 drivers/scsi/pata_sc1200.c       |    4 ++--
 drivers/scsi/pata_serverworks.c  |   20 ++++++++++----------
 drivers/scsi/pata_sil680.c       |    6 +++---
 drivers/scsi/pata_sis.c          |   18 +++++++++---------
 drivers/scsi/pata_sl82c105.c     |    6 +++---
 drivers/scsi/pata_triflex.c      |    4 ++--
 drivers/scsi/pata_via.c          |    8 ++++----
 29 files changed, 149 insertions(+), 154 deletions(-)

c036ec86b67a180cafb05c8af577aa84aac0186f
diff --git a/drivers/scsi/ata_piix.c b/drivers/scsi/ata_piix.c
index f1cbe0c..c74038d 100644
--- a/drivers/scsi/ata_piix.c
+++ b/drivers/scsi/ata_piix.c
@@ -633,7 +633,7 @@ static int ich_pata_prereset(struct ata_
 {
 	struct pci_dev *pdev = to_pci_dev(ap->host_set->dev);
 
-	if (!pci_test_config_bits(pdev, &piix_enable_bits[ap->hard_port_no])) {
+	if (!pci_test_config_bits(pdev, &piix_enable_bits[ap->port_no])) {
 		ata_port_printk(ap, KERN_INFO, "port disabled. ignoring.\n");
 		ap->eh_context.i.action &= ~ATA_EH_RESET_MASK;
 		return 0;
@@ -756,9 +756,9 @@ static void piix_set_piomode (struct ata
 		/* enable PPE1, IE1 and TIME1 as needed */
 		master_data |= (control << 4);
 		pci_read_config_byte(dev, slave_port, &slave_data);
-		slave_data &= (ap->hard_port_no ? 0x0f : 0xf0);
+		slave_data &= (ap->port_no ? 0x0f : 0xf0);
 		/* Load the timing nibble for this slave */
-		slave_data |= ((timings[pio][0] << 2) | timings[pio][1]) << (ap->hard_port_no ? 4 : 0);
+		slave_data |= ((timings[pio][0] << 2) | timings[pio][1]) << (ap->port_no ? 4 : 0);
 	} else {
 		/* Master keeps the bits in a different format */
 		master_data &= 0xccf8;
@@ -777,7 +777,7 @@ static void piix_set_piomode (struct ata
 	   
 	if (ap->udma_mask) {
 		pci_read_config_byte(dev, 0x48, &udma_enable);
-		udma_enable &= ~(1 << (2 * ap->hard_port_no + adev->devno));
+		udma_enable &= ~(1 << (2 * ap->port_no + adev->devno));
 		pci_write_config_byte(dev, 0x48, udma_enable);
 	}
 }
@@ -798,10 +798,10 @@ static void piix_set_piomode (struct ata
 static void do_pata_set_dmamode (struct ata_port *ap, struct ata_device *adev, int isich)
 {
 	struct pci_dev *dev	= to_pci_dev(ap->host_set->dev);
-	u8 master_port		= ap->hard_port_no ? 0x42 : 0x40;
+	u8 master_port		= ap->port_no ? 0x42 : 0x40;
 	u16 master_data;
 	u8 speed		= adev->dma_mode;
-	int devid		= adev->devno + 2 * ap->hard_port_no;
+	int devid		= adev->devno + 2 * ap->port_no;
 	u8 udma_enable;
 	
 	static const	 /* ISP  RTC */
@@ -879,9 +879,9 @@ static void do_pata_set_dmamode (struct 
 			master_data &= 0xFF4F;  /* Mask out IORDY|TIME1|DMAONLY */
 			master_data |= control << 4;
 			pci_read_config_byte(dev, 0x44, &slave_data);
-			slave_data &= (0x0F + 0xE1 * ap->hard_port_no);
+			slave_data &= (0x0F + 0xE1 * ap->port_no);
 			/* Load the matching timing */
-			slave_data |= ((timings[pio][0] << 2) | timings[pio][1]) << (ap->hard_port_no ? 4 : 0);
+			slave_data |= ((timings[pio][0] << 2) | timings[pio][1]) << (ap->port_no ? 4 : 0);
 			pci_write_config_byte(dev, 0x44, slave_data);
 		} else { 	/* Master */
 			master_data &= 0xCCF4;	/* Mask out IORDY|TIME1|DMAONLY 
diff --git a/drivers/scsi/pata_ali.c b/drivers/scsi/pata_ali.c
index 91f00c7..c3ce5e2 100644
--- a/drivers/scsi/pata_ali.c
+++ b/drivers/scsi/pata_ali.c
@@ -83,7 +83,7 @@ static int ali_c2_cable_detect(struct at
 	/* Host view cable detect 0x4A bit 0 primary bit 1 secondary
 	   Bit set for 40 pin */
 	pci_read_config_byte(pdev, 0x4A, &ata66);
-	if (ata66 & (1 << ap->hard_port_no))
+	if (ata66 & (1 << ap->port_no))
 		return ATA_CBL_PATA40;
 	else
 		return ATA_CBL_PATA80;
@@ -177,7 +177,7 @@ static unsigned long ali_20_filter(const
 static void ali_fifo_control(struct ata_port *ap, struct ata_device *adev, int on)
 {
 	struct pci_dev *pdev = to_pci_dev(ap->host_set->dev);
-	int pio_fifo = 0x54 + ap->hard_port_no;
+	int pio_fifo = 0x54 + ap->port_no;
 	u8 fifo;
 	int shift = 4 * adev->devno;
 
@@ -208,10 +208,10 @@ static void ali_fifo_control(struct ata_
 static void ali_program_modes(struct ata_port *ap, struct ata_device *adev, struct ata_timing *t, u8 ultra)
 {
 	struct pci_dev *pdev = to_pci_dev(ap->host_set->dev);
-	int cas = 0x58 + 4 * ap->hard_port_no;	/* Command timing */
-	int cbt = 0x59 + 4 * ap->hard_port_no;	/* Command timing */
-	int drwt = 0x5A + 4 * ap->hard_port_no + adev->devno; /* R/W timing */
-	int udmat = 0x56 + ap->hard_port_no;	/* UDMA timing */
+	int cas = 0x58 + 4 * ap->port_no;	/* Command timing */
+	int cbt = 0x59 + 4 * ap->port_no;	/* Command timing */
+	int drwt = 0x5A + 4 * ap->port_no + adev->devno; /* R/W timing */
+	int udmat = 0x56 + ap->port_no;	/* UDMA timing */
 	int shift = 4 * adev->devno;
 	u8 udma;
 
diff --git a/drivers/scsi/pata_amd.c b/drivers/scsi/pata_amd.c
index c9e87d0..14cc8a8 100644
--- a/drivers/scsi/pata_amd.c
+++ b/drivers/scsi/pata_amd.c
@@ -49,7 +49,7 @@ static void timing_setup(struct ata_port
 
 	struct pci_dev *pdev = to_pci_dev(ap->host_set->dev);
 	struct ata_device *peer = ata_dev_pair(adev);
-	int dn = ap->hard_port_no * 2 + adev->devno;
+	int dn = ap->port_no * 2 + adev->devno;
 	struct ata_timing at, apeer;
 	int T, UT;
 	const int amd_clock = 33333;	/* KHz. */
@@ -137,14 +137,14 @@ static int amd_pre_reset(struct ata_port
 	struct pci_dev *pdev = to_pci_dev(ap->host_set->dev);
 	u8 ata66;
 	
-	if (!pci_test_config_bits(pdev, &amd_enable_bits[ap->hard_port_no])) {
+	if (!pci_test_config_bits(pdev, &amd_enable_bits[ap->port_no])) {
 		ata_port_disable(ap);
 		printk(KERN_INFO "ata%u: port disabled. ignoring.\n", ap->id);
 		return 0;
 	}
 
 	pci_read_config_byte(pdev, 0x42, &ata66);
-	if (ata66 & bitmask[ap->hard_port_no])
+	if (ata66 & bitmask[ap->port_no])
 		ap->cbl = ATA_CBL_PATA80;
 	else
 		ap->cbl = ATA_CBL_PATA40;
@@ -167,7 +167,7 @@ static int amd_early_pre_reset(struct at
 		{ 0x40, 1, 0x01, 0x01 }
 	};
 
-	if (!pci_test_config_bits(pdev, &amd_enable_bits[ap->hard_port_no])) {
+	if (!pci_test_config_bits(pdev, &amd_enable_bits[ap->port_no])) {
 		ata_port_disable(ap);
 		printk(KERN_INFO "ata%u: port disabled. ignoring.\n", ap->id);
 		return 0;
@@ -259,7 +259,7 @@ static int nv_pre_reset(struct ata_port 
 	u16 udma;
 
 	pci_read_config_byte(pdev, 0x52, &ata66);
-	if (ata66 & bitmask[ap->hard_port_no])
+	if (ata66 & bitmask[ap->port_no])
 		ap->cbl = ATA_CBL_PATA80;
 	else
 		ap->cbl = ATA_CBL_PATA40;
@@ -267,7 +267,7 @@ static int nv_pre_reset(struct ata_port 
 	/* We now have to double check because the Nvidia boxes BIOS
 	   doesn't always set the cable bits but does set mode bits */
 
-	pci_read_config_word(pdev, 0x62 - 2 * ap->hard_port_no, &udma);
+	pci_read_config_word(pdev, 0x62 - 2 * ap->port_no, &udma);
 	if ((udma & 0xC4) == 0xC4 || (udma & 0xC400) == 0xC400)
 		ap->cbl = ATA_CBL_PATA80;
 	return ata_std_prereset(ap);
diff --git a/drivers/scsi/pata_artop.c b/drivers/scsi/pata_artop.c
index e8b408f..b566d99 100644
--- a/drivers/scsi/pata_artop.c
+++ b/drivers/scsi/pata_artop.c
@@ -47,7 +47,7 @@ static int artop6210_pre_reset(struct at
 		{ 0x4AU, 1U, 0x04UL, 0x04UL },	/* port 1 */
 	};
 
-	if (!pci_test_config_bits(pdev, &artop_enable_bits[ap->hard_port_no])) {
+	if (!pci_test_config_bits(pdev, &artop_enable_bits[ap->port_no])) {
 		ata_port_disable(ap);
 		printk(KERN_INFO "ata%u: port disabled. ignoring.\n", ap->id);
 		return 0;
@@ -90,13 +90,13 @@ static int artop6260_pre_reset(struct at
 	u8 tmp;
 
 	/* Odd numbered device ids are the units with enable bits (the -R cards) */
-	if (pdev->device % 1 && !pci_test_config_bits(pdev, &artop_enable_bits[ap->hard_port_no])) {
+	if (pdev->device % 1 && !pci_test_config_bits(pdev, &artop_enable_bits[ap->port_no])) {
 		ata_port_disable(ap);
 		printk(KERN_INFO "ata%u: port disabled. ignoring.\n", ap->id);
 		return 0;
 	}
 	pci_read_config_byte(pdev, 0x49, &tmp);
-	if (tmp & (1 >> ap->hard_port_no))
+	if (tmp & (1 >> ap->port_no))
 		ap->cbl = ATA_CBL_PATA40;
 	else
 		ap->cbl = ATA_CBL_PATA80;
@@ -135,7 +135,7 @@ static void artop6260_error_handler(stru
 static void artop6210_load_piomode(struct ata_port *ap, struct ata_device *adev, unsigned int pio)
 {
 	struct pci_dev *pdev	= to_pci_dev(ap->host_set->dev);
-	int dn = adev->devno + 2 * ap->hard_port_no;
+	int dn = adev->devno + 2 * ap->port_no;
 	const u16 timing[2][5] = {
 		{ 0x0000, 0x000A, 0x0008, 0x0303, 0x0301 },
 		{ 0x0700, 0x070A, 0x0708, 0x0403, 0x0401 }
@@ -162,7 +162,7 @@ static void artop6210_load_piomode(struc
 static void artop6210_set_piomode(struct ata_port *ap, struct ata_device *adev)
 {
 	struct pci_dev *pdev	= to_pci_dev(ap->host_set->dev);
-	int dn = adev->devno + 2 * ap->hard_port_no;
+	int dn = adev->devno + 2 * ap->port_no;
 	u8 ultra;
 
 	artop6210_load_piomode(ap, adev, adev->pio_mode - XFER_PIO_0);
@@ -189,7 +189,7 @@ static void artop6210_set_piomode(struct
 static void artop6260_load_piomode (struct ata_port *ap, struct ata_device *adev, unsigned int pio)
 {
 	struct pci_dev *pdev	= to_pci_dev(ap->host_set->dev);
-	int dn = adev->devno + 2 * ap->hard_port_no;
+	int dn = adev->devno + 2 * ap->port_no;
 	const u8 timing[2][5] = {
 		{ 0x00, 0x0A, 0x08, 0x33, 0x31 },
 		{ 0x70, 0x7A, 0x78, 0x43, 0x41 }
@@ -221,9 +221,9 @@ static void artop6260_set_piomode(struct
 	artop6260_load_piomode(ap, adev, adev->pio_mode - XFER_PIO_0);
 
 	/* Clear the UDMA mode bits (set_dmamode will redo this if needed) */
-	pci_read_config_byte(pdev, 0x44 + ap->hard_port_no, &ultra);
+	pci_read_config_byte(pdev, 0x44 + ap->port_no, &ultra);
 	ultra &= ~(7 << (4  * adev->devno));	/* One nibble per drive */
-	pci_write_config_byte(pdev, 0x44 + ap->hard_port_no, ultra);
+	pci_write_config_byte(pdev, 0x44 + ap->port_no, ultra);
 }
 
 /**
@@ -241,7 +241,7 @@ static void artop6210_set_dmamode (struc
 {
 	unsigned int pio;
 	struct pci_dev *pdev	= to_pci_dev(ap->host_set->dev);
-	int dn = adev->devno + 2 * ap->hard_port_no;
+	int dn = adev->devno + 2 * ap->port_no;
 	u8 ultra;
 
 	if (adev->dma_mode == XFER_MW_DMA_0)
@@ -292,7 +292,7 @@ static void artop6260_set_dmamode (struc
 	artop6260_load_piomode(ap, adev, pio);
 
 	/* Add ultra DMA bits if in UDMA mode */
-	pci_read_config_byte(pdev, 0x44 + ap->hard_port_no, &ultra);
+	pci_read_config_byte(pdev, 0x44 + ap->port_no, &ultra);
 	ultra &= ~(7 << (4  * adev->devno));	/* One nibble per drive */
 	if (adev->dma_mode >= XFER_UDMA_0) {
 		u8 mode = adev->dma_mode - XFER_UDMA_0 + 1 - clock;
@@ -300,7 +300,7 @@ static void artop6260_set_dmamode (struc
 			mode = 1;
 		ultra |= (mode << (4 * adev->devno));
 	}
-	pci_write_config_byte(pdev, 0x44 + ap->hard_port_no, ultra);
+	pci_write_config_byte(pdev, 0x44 + ap->port_no, ultra);
 }
 
 static struct scsi_host_template artop_sht = {
diff --git a/drivers/scsi/pata_atiixp.c b/drivers/scsi/pata_atiixp.c
index 072e15f..ddbb79d 100644
--- a/drivers/scsi/pata_atiixp.c
+++ b/drivers/scsi/pata_atiixp.c
@@ -41,7 +41,7 @@ static int atiixp_pre_reset(struct ata_p
 		{ 0x48, 1, 0x08, 0x00 }
 	};
 
-	if (!pci_test_config_bits(pdev, &atiixp_enable_bits[ap->hard_port_no])) {
+	if (!pci_test_config_bits(pdev, &atiixp_enable_bits[ap->port_no])) {
 		ata_port_disable(ap);
 		printk(KERN_INFO "ata%u: port disabled. ignoring.\n", ap->id);
 		return 0;
@@ -70,10 +70,10 @@ static void atiixp_set_pio_timing(struct
 	static u8 pio_timings[5] = { 0x5D, 0x47, 0x34, 0x22, 0x20 };
 
 	struct pci_dev *pdev = to_pci_dev(ap->host_set->dev);
-	int dn = 2 * ap->hard_port_no + adev->devno;
+	int dn = 2 * ap->port_no + adev->devno;
 
 	/* Check this is correct - the order is odd in both drivers */
-	int timing_shift = (16 * ap->hard_port_no) + 8 * (adev->devno ^ 1);
+	int timing_shift = (16 * ap->port_no) + 8 * (adev->devno ^ 1);
 	u16 pio_mode_data, pio_timing_data;
 
 	pci_read_config_word(pdev, ATIIXP_IDE_PIO_MODE, &pio_mode_data);
@@ -116,7 +116,7 @@ static void atiixp_set_dmamode(struct at
 
 	struct pci_dev *pdev = to_pci_dev(ap->host_set->dev);
 	int dma = adev->dma_mode;
-	int dn = 2 * ap->hard_port_no + adev->devno;
+	int dn = 2 * ap->port_no + adev->devno;
 	int wanted_pio;
 
 	if (adev->dma_mode >= XFER_UDMA_0) {
@@ -131,7 +131,7 @@ static void atiixp_set_dmamode(struct at
 	} else {
 		u16 mwdma_timing_data;
 		/* Check this is correct - the order is odd in both drivers */
-		int timing_shift = (16 * ap->hard_port_no) + 8 * (adev->devno ^ 1);
+		int timing_shift = (16 * ap->port_no) + 8 * (adev->devno ^ 1);
 
 		dma -= XFER_MW_DMA_0;
 
@@ -170,7 +170,7 @@ static void atiixp_bmdma_start(struct at
 	struct ata_device *adev = qc->dev;
 
 	struct pci_dev *pdev = to_pci_dev(ap->host_set->dev);
-	int dn = (2 * ap->hard_port_no) + adev->devno;
+	int dn = (2 * ap->port_no) + adev->devno;
 	u16 tmp16;
 
 	pci_read_config_word(pdev, ATIIXP_IDE_UDMA_CONTROL, &tmp16);
@@ -194,7 +194,7 @@ static void atiixp_bmdma_stop(struct ata
 {
 	struct ata_port *ap = qc->ap;
 	struct pci_dev *pdev = to_pci_dev(ap->host_set->dev);
-	int dn = (2 * ap->hard_port_no) + qc->dev->devno;
+	int dn = (2 * ap->port_no) + qc->dev->devno;
 	u16 tmp16;
 
 	pci_read_config_word(pdev, ATIIXP_IDE_UDMA_CONTROL, &tmp16);
diff --git a/drivers/scsi/pata_cmd64x.c b/drivers/scsi/pata_cmd64x.c
index d64e1c1..3af8bea 100644
--- a/drivers/scsi/pata_cmd64x.c
+++ b/drivers/scsi/pata_cmd64x.c
@@ -88,7 +88,7 @@ static int cmd648_pre_reset(struct ata_p
 
 	/* Check cable detect bits */
 	pci_read_config_byte(pdev, BMIDECSR, &r);
-	if (r & (1 << ap->hard_port_no))
+	if (r & (1 << ap->port_no))
 		ap->cbl = ATA_CBL_PATA80;
 	else	
 		ap->cbl = ATA_CBL_PATA40;
@@ -133,15 +133,15 @@ static void cmd64x_set_piomode(struct at
 		{ DRWTIM2, DRWTIM3 }
 	};
 	
-	int arttim = arttim_port[ap->hard_port_no][adev->devno];
-	int drwtim = drwtim_port[ap->hard_port_no][adev->devno];
+	int arttim = arttim_port[ap->port_no][adev->devno];
+	int drwtim = drwtim_port[ap->port_no][adev->devno];
 	
 	
 	if (ata_timing_compute(adev, adev->pio_mode, &t, T, 0) < 0) {
 		printk(KERN_ERR DRV_NAME ": mode computation failed.\n");
 		return;
 	}
-	if (ap->hard_port_no) {
+	if (ap->port_no) {
 		/* Slave has shared address setup */
 		struct ata_device *pair = ata_dev_pair(adev);
 		
@@ -206,8 +206,8 @@ static void cmd64x_set_dmamode(struct at
 	struct pci_dev *pdev = to_pci_dev(ap->host_set->dev);
 	u8 regU, regD;
 
-	int pciU = UDIDETCR0 + 8 * ap->hard_port_no;
-	int pciD = BMIDESR0 + 8 * ap->hard_port_no;
+	int pciU = UDIDETCR0 + 8 * ap->port_no;
+	int pciD = BMIDESR0 + 8 * ap->port_no;
 	int shift = 2 * adev->devno;
 	
 	pci_read_config_byte(pdev, pciD, &regD);
@@ -239,8 +239,8 @@ static void cmd648_bmdma_stop(struct ata
 	struct ata_port *ap = qc->ap;
 	struct pci_dev *pdev = to_pci_dev(ap->host_set->dev);
 	u8 dma_intr;
-	int dma_reg = ap->hard_port_no ? ARTTIM23_INTR_CH1 : CFR_INTR_CH0;
-	int dma_mask = ap->hard_port_no ? ARTTIM2 : CFR;
+	int dma_reg = ap->port_no ? ARTTIM23_INTR_CH1 : CFR_INTR_CH0;
+	int dma_mask = ap->port_no ? ARTTIM2 : CFR;
 	
 	ata_bmdma_stop(qc);
 	
diff --git a/drivers/scsi/pata_cs5520.c b/drivers/scsi/pata_cs5520.c
index ac180a8..f620808 100644
--- a/drivers/scsi/pata_cs5520.c
+++ b/drivers/scsi/pata_cs5520.c
@@ -75,16 +75,16 @@ static void cs5520_set_timings(struct at
 	pio -= XFER_PIO_0;
 
 	/* Channel command timing */
-	pci_write_config_byte(pdev, 0x62 + ap->hard_port_no,
+	pci_write_config_byte(pdev, 0x62 + ap->port_no,
 				(cs5520_pio_clocks[pio].recovery << 4) |
 				(cs5520_pio_clocks[pio].assert));
 	/* FIXME: should these use address ? */
 	/* Read command timing */
-	pci_write_config_byte(pdev, 0x64 +  4*ap->hard_port_no + slave,
+	pci_write_config_byte(pdev, 0x64 +  4*ap->port_no + slave,
 				(cs5520_pio_clocks[pio].recovery << 4) |
 				(cs5520_pio_clocks[pio].assert));
 	/* Write command timing */
-	pci_write_config_byte(pdev, 0x66 +  4*ap->hard_port_no + slave,
+	pci_write_config_byte(pdev, 0x66 +  4*ap->port_no + slave,
 				(cs5520_pio_clocks[pio].recovery << 4) |
 				(cs5520_pio_clocks[pio].assert));
 }
@@ -248,7 +248,6 @@ static int __devinit cs5520_init_one(str
 	probe[0].irq = 14;
 	probe[0].irq_flags = 0;
 	probe[0].host_flags = ATA_FLAG_SLAVE_POSS|ATA_FLAG_SRST;
-	probe[0].legacy_mode = 1;
 	probe[0].n_ports = 1;
 	probe[0].port[0].cmd_addr = 0x1F0;
 	probe[0].port[0].ctl_addr = 0x3F6;
@@ -261,7 +260,6 @@ static int __devinit cs5520_init_one(str
 	probe[1] = probe[0];
 	INIT_LIST_HEAD(&probe[1].node);
 	probe[1].irq = 15;
-	probe[1].hard_port_no = 1;
 	probe[1].port[0].cmd_addr = 0x170;
 	probe[1].port[0].ctl_addr = 0x376;
 	probe[1].port[0].altstatus_addr = 0x376;
diff --git a/drivers/scsi/pata_cs5530.c b/drivers/scsi/pata_cs5530.c
index 7d367ff..0d166e5 100644
--- a/drivers/scsi/pata_cs5530.c
+++ b/drivers/scsi/pata_cs5530.c
@@ -52,7 +52,7 @@ static void cs5530_set_piomode(struct at
 		{0x00009172, 0x00012171, 0x00020080, 0x00032010, 0x00040010},
 		{0xd1329172, 0x71212171, 0x30200080, 0x20102010, 0x00100010}
 	};
-	unsigned long base = ( ap->ioaddr.bmdma_addr & ~0x0F) + 0x20 + 0x10 * ap->hard_port_no;
+	unsigned long base = ( ap->ioaddr.bmdma_addr & ~0x0F) + 0x20 + 0x10 * ap->port_no;
 	u32 tuning;
 	int format;
 
@@ -79,7 +79,7 @@ static void cs5530_set_piomode(struct at
 
 static void cs5530_set_dmamode(struct ata_port *ap, struct ata_device *adev)
 {
-	unsigned long base = ( ap->ioaddr.bmdma_addr & ~0x0F) + 0x20 + 0x10 * ap->hard_port_no;
+	unsigned long base = ( ap->ioaddr.bmdma_addr & ~0x0F) + 0x20 + 0x10 * ap->port_no;
 	u32 tuning, timing = 0;
 	u8 reg;
 
diff --git a/drivers/scsi/pata_cypress.c b/drivers/scsi/pata_cypress.c
index 59dfd01..0bf85ec 100644
--- a/drivers/scsi/pata_cypress.c
+++ b/drivers/scsi/pata_cypress.c
@@ -109,7 +109,7 @@ static void cy82c693_set_piomode(struct 
  
 static void cy82c693_set_dmamode(struct ata_port *ap, struct ata_device *adev)
 {
-	int reg = CY82_INDEX_CHANNEL0 + ap->hard_port_no;
+	int reg = CY82_INDEX_CHANNEL0 + ap->port_no;
 	
 	/* Be afraid, be very afraid. Magic registers  in low I/O space */
 	outb(reg, 0x22);
diff --git a/drivers/scsi/pata_efar.c b/drivers/scsi/pata_efar.c
index a554aa2..62afeba 100644
--- a/drivers/scsi/pata_efar.c
+++ b/drivers/scsi/pata_efar.c
@@ -42,13 +42,13 @@ static int efar_pre_reset(struct ata_por
 	struct pci_dev *pdev = to_pci_dev(ap->host_set->dev);
 	u8 tmp;
 
-	if (!pci_test_config_bits(pdev, &efar_enable_bits[ap->hard_port_no])) {
+	if (!pci_test_config_bits(pdev, &efar_enable_bits[ap->port_no])) {
 		ata_port_disable(ap);
 		printk(KERN_INFO "ata%u: port disabled. ignoring.\n", ap->id);
 		return 0;
 	}
 	pci_read_config_byte(pdev, 0x47, &tmp);
-	if (tmp & (2 >> ap->hard_port_no))
+	if (tmp & (2 >> ap->port_no))
 		ap->cbl = ATA_CBL_PATA40;
 	else
 		ap->cbl = ATA_CBL_PATA80;
@@ -83,7 +83,7 @@ static void efar_set_piomode (struct ata
 {
 	unsigned int pio	= adev->pio_mode - XFER_PIO_0;
 	struct pci_dev *dev	= to_pci_dev(ap->host_set->dev);
-	unsigned int idetm_port= ap->hard_port_no ? 0x42 : 0x40;
+	unsigned int idetm_port= ap->port_no ? 0x42 : 0x40;
 	u16 idetm_data;
 	int control = 0;
 
@@ -117,7 +117,7 @@ static void efar_set_piomode (struct ata
 		idetm_data |= (timings[pio][0] << 12) |
 			(timings[pio][1] << 8);
 	} else {
-		int shift = 4 * ap->hard_port_no;
+		int shift = 4 * ap->port_no;
 		u8 slave_data;
 
 		idetm_data &= 0xCC0F;
@@ -148,10 +148,10 @@ static void efar_set_piomode (struct ata
 static void efar_set_dmamode (struct ata_port *ap, struct ata_device *adev)
 {
 	struct pci_dev *dev	= to_pci_dev(ap->host_set->dev);
-	u8 master_port		= ap->hard_port_no ? 0x42 : 0x40;
+	u8 master_port		= ap->port_no ? 0x42 : 0x40;
 	u16 master_data;
 	u8 speed		= adev->dma_mode;
-	int devid		= adev->devno + 2 * ap->hard_port_no;
+	int devid		= adev->devno + 2 * ap->port_no;
 	u8 udma_enable;
 
 	static const	 /* ISP  RTC */
@@ -202,9 +202,9 @@ static void efar_set_dmamode (struct ata
 			master_data &= 0xFF4F;  /* Mask out IORDY|TIME1|DMAONLY */
 			master_data |= control << 4;
 			pci_read_config_byte(dev, 0x44, &slave_data);
-			slave_data &= (0x0F + 0xE1 * ap->hard_port_no);
+			slave_data &= (0x0F + 0xE1 * ap->port_no);
 			/* Load the matching timing */
-			slave_data |= ((timings[pio][0] << 2) | timings[pio][1]) << (ap->hard_port_no ? 4 : 0);
+			slave_data |= ((timings[pio][0] << 2) | timings[pio][1]) << (ap->port_no ? 4 : 0);
 			pci_write_config_byte(dev, 0x44, slave_data);
 		} else { 	/* Master */
 			master_data &= 0xCCF4;	/* Mask out IORDY|TIME1|DMAONLY
diff --git a/drivers/scsi/pata_hpt366.c b/drivers/scsi/pata_hpt366.c
index 82696ac..9443e7f 100644
--- a/drivers/scsi/pata_hpt366.c
+++ b/drivers/scsi/pata_hpt366.c
@@ -226,7 +226,7 @@ static int hpt36x_pre_reset(struct ata_p
 	struct pci_dev *pdev = to_pci_dev(ap->host_set->dev);
 	
 	pci_read_config_byte(pdev, 0x5A, &ata66);
-	if (ata66 & (1 << ap->hard_port_no))
+	if (ata66 & (1 << ap->port_no))
 		ap->cbl = ATA_CBL_PATA40;
 	else
 		ap->cbl = ATA_CBL_PATA80;
@@ -261,8 +261,8 @@ static void hpt366_set_piomode(struct at
 	u32 mode;
 	u8 fast;
 
-	addr1 = 0x40 + 4 * (adev->devno + 2 * ap->hard_port_no);
-	addr2 = 0x51 + 4 * ap->hard_port_no;
+	addr1 = 0x40 + 4 * (adev->devno + 2 * ap->port_no);
+	addr2 = 0x51 + 4 * ap->port_no;
 	
 	/* Fast interrupt prediction disable, hold off interrupt disable */
 	pci_read_config_byte(pdev, addr2, &fast);
@@ -296,8 +296,8 @@ static void hpt366_set_dmamode(struct at
 	u32 mode;
 	u8 fast;
 
-	addr1 = 0x40 + 4 * (adev->devno + 2 * ap->hard_port_no);
-	addr2 = 0x51 + 4 * ap->hard_port_no;
+	addr1 = 0x40 + 4 * (adev->devno + 2 * ap->port_no);
+	addr2 = 0x51 + 4 * ap->port_no;
 	
 	/* Fast interrupt prediction disable, hold off interrupt disable */
 	pci_read_config_byte(pdev, addr2, &fast);
diff --git a/drivers/scsi/pata_hpt37x.c b/drivers/scsi/pata_hpt37x.c
index 68fc576..2a3cd5c 100644
--- a/drivers/scsi/pata_hpt37x.c
+++ b/drivers/scsi/pata_hpt37x.c
@@ -461,7 +461,7 @@ static int hpt37x_pre_reset(struct ata_p
 	/* Restore state */
 	pci_write_config_byte(pdev, 0x5B, scr2);
 	
-	if (ata66 & (1 << ap->hard_port_no))
+	if (ata66 & (1 << ap->port_no))
 		ap->cbl = ATA_CBL_PATA40;
 	else
 		ap->cbl = ATA_CBL_PATA80;
@@ -505,7 +505,7 @@ static int hpt374_pre_reset(struct ata_p
 	pci_write_config_word(pdev, 0x52, mcr3);
 	pci_write_config_word(pdev, 0x56, mcr6);
 	
-	if (ata66 & (1 << ap->hard_port_no))
+	if (ata66 & (1 << ap->port_no))
 		ap->cbl = ATA_CBL_PATA40;
 	else
 		ap->cbl = ATA_CBL_PATA80;
@@ -553,8 +553,8 @@ static void hpt370_set_piomode(struct at
 	u32 mode;
 	u8 fast;
 
-	addr1 = 0x40 + 4 * (adev->devno + 2 * ap->hard_port_no);
-	addr2 = 0x51 + 4 * ap->hard_port_no;
+	addr1 = 0x40 + 4 * (adev->devno + 2 * ap->port_no);
+	addr2 = 0x51 + 4 * ap->port_no;
 	
 	/* Fast interrupt prediction disable, hold off interrupt disable */
 	pci_read_config_byte(pdev, addr2, &fast);
@@ -587,8 +587,8 @@ static void hpt370_set_dmamode(struct at
 	u32 mode;
 	u8 fast;
 
-	addr1 = 0x40 + 4 * (adev->devno + 2 * ap->hard_port_no);
-	addr2 = 0x51 + 4 * ap->hard_port_no;
+	addr1 = 0x40 + 4 * (adev->devno + 2 * ap->port_no);
+	addr2 = 0x51 + 4 * ap->port_no;
 	
 	/* Fast interrupt prediction disable, hold off interrupt disable */
 	pci_read_config_byte(pdev, addr2, &fast);
@@ -616,7 +616,7 @@ static void hpt370_bmdma_start(struct at
 {
 	struct ata_port *ap = qc->ap;
 	struct pci_dev *pdev = to_pci_dev(ap->host_set->dev);
-	pci_write_config_byte(pdev, 0x50 + 4 * ap->hard_port_no, 0x37);
+	pci_write_config_byte(pdev, 0x50 + 4 * ap->port_no, 0x37);
 	udelay(10);
 	ata_bmdma_start(qc);
 }
@@ -642,7 +642,7 @@ static void hpt370_bmdma_stop(struct ata
 	}
 	if (dma_stat & 0x01) {
 		/* Clear the engine */
-		pci_write_config_byte(pdev, 0x50 + 4 * ap->hard_port_no, 0x37);
+		pci_write_config_byte(pdev, 0x50 + 4 * ap->port_no, 0x37);
 		udelay(10);
 		/* Stop DMA */
 		dma_cmd = inb(bmdma );
@@ -651,7 +651,7 @@ static void hpt370_bmdma_stop(struct ata
 		dma_stat = inb(bmdma + 2);
 		outb(dma_stat | 0x06 , bmdma + 2);
 		/* Clear the engine */
-		pci_write_config_byte(pdev, 0x50 + 4 * ap->hard_port_no, 0x37);
+		pci_write_config_byte(pdev, 0x50 + 4 * ap->port_no, 0x37);
 		udelay(10);
 	}
 	ata_bmdma_stop(qc);
@@ -673,8 +673,8 @@ static void hpt372_set_piomode(struct at
 	u32 mode;
 	u8 fast;
 
-	addr1 = 0x40 + 4 * (adev->devno + 2 * ap->hard_port_no);
-	addr2 = 0x51 + 4 * ap->hard_port_no;
+	addr1 = 0x40 + 4 * (adev->devno + 2 * ap->port_no);
+	addr2 = 0x51 + 4 * ap->port_no;
 	
 	/* Fast interrupt prediction disable, hold off interrupt disable */
 	pci_read_config_byte(pdev, addr2, &fast);
@@ -708,8 +708,8 @@ static void hpt372_set_dmamode(struct at
 	u32 mode;
 	u8 fast;
 
-	addr1 = 0x40 + 4 * (adev->devno + 2 * ap->hard_port_no);
-	addr2 = 0x51 + 4 * ap->hard_port_no;
+	addr1 = 0x40 + 4 * (adev->devno + 2 * ap->port_no);
+	addr2 = 0x51 + 4 * ap->port_no;
 	
 	/* Fast interrupt prediction disable, hold off interrupt disable */
 	pci_read_config_byte(pdev, addr2, &fast);
@@ -736,12 +736,12 @@ static void hpt37x_bmdma_stop(struct ata
 {
 	struct ata_port *ap = qc->ap;
 	struct pci_dev *pdev = to_pci_dev(ap->host_set->dev);
-	int mscreg = 0x50 + 2 * ap->hard_port_no;
+	int mscreg = 0x50 + 2 * ap->port_no;
 	u8 bwsr_stat, msc_stat;
 	
 	pci_read_config_byte(pdev, 0x6A, &bwsr_stat);
 	pci_read_config_byte(pdev, mscreg, &msc_stat);
-	if (bwsr_stat & (1 << ap->hard_port_no))
+	if (bwsr_stat & (1 << ap->port_no))
 		pci_write_config_byte(pdev, mscreg, msc_stat | 0x30);
 	ata_bmdma_stop(qc);
 }
diff --git a/drivers/scsi/pata_hpt3x2n.c b/drivers/scsi/pata_hpt3x2n.c
index f2e400b..1098ee6 100644
--- a/drivers/scsi/pata_hpt3x2n.c
+++ b/drivers/scsi/pata_hpt3x2n.c
@@ -134,7 +134,7 @@ static int hpt3xn_pre_reset(struct ata_p
 	/* Restore state */
 	pci_write_config_byte(pdev, 0x5B, scr2);
 	
-	if (ata66 & (1 << ap->hard_port_no))
+	if (ata66 & (1 << ap->port_no))
 		ap->cbl = ATA_CBL_PATA40;
 	else
 		ap->cbl = ATA_CBL_PATA80;
@@ -175,8 +175,8 @@ static void hpt3x2n_set_piomode(struct a
 	u32 mode;
 	u8 fast;
 
-	addr1 = 0x40 + 4 * (adev->devno + 2 * ap->hard_port_no);
-	addr2 = 0x51 + 4 * ap->hard_port_no;
+	addr1 = 0x40 + 4 * (adev->devno + 2 * ap->port_no);
+	addr2 = 0x51 + 4 * ap->port_no;
 	
 	/* Fast interrupt prediction disable, hold off interrupt disable */
 	pci_read_config_byte(pdev, addr2, &fast);
@@ -208,8 +208,8 @@ static void hpt3x2n_set_dmamode(struct a
 	u32 mode;
 	u8 fast;
 
-	addr1 = 0x40 + 4 * (adev->devno + 2 * ap->hard_port_no);
-	addr2 = 0x51 + 4 * ap->hard_port_no;
+	addr1 = 0x40 + 4 * (adev->devno + 2 * ap->port_no);
+	addr2 = 0x51 + 4 * ap->port_no;
 	
 	/* Fast interrupt prediction disable, hold off interrupt disable */
 	pci_read_config_byte(pdev, addr2, &fast);
@@ -235,12 +235,12 @@ static void hpt3x2n_bmdma_stop(struct at
 {
 	struct ata_port *ap = qc->ap;
 	struct pci_dev *pdev = to_pci_dev(ap->host_set->dev);
-	int mscreg = 0x50 + 2 * ap->hard_port_no;
+	int mscreg = 0x50 + 2 * ap->port_no;
 	u8 bwsr_stat, msc_stat;
 	
 	pci_read_config_byte(pdev, 0x6A, &bwsr_stat);
 	pci_read_config_byte(pdev, mscreg, &msc_stat);
-	if (bwsr_stat & (1 << ap->hard_port_no))
+	if (bwsr_stat & (1 << ap->port_no))
 		pci_write_config_byte(pdev, mscreg, msc_stat | 0x30);
 	ata_bmdma_stop(qc);
 }
@@ -290,7 +290,7 @@ static void hpt3x2n_set_clock(struct ata
 static int hpt3x2n_pair_idle(struct ata_port *ap)
 {
 	struct ata_host_set *host = ap->host_set;
-	struct ata_port *pair = host->ports[ap->hard_port_no ^ 1];
+	struct ata_port *pair = host->ports[ap->port_no ^ 1];
 	
 	if (pair->hsm_task_state == HSM_ST_IDLE)
 		return 1;
diff --git a/drivers/scsi/pata_hpt3x3.c b/drivers/scsi/pata_hpt3x3.c
index 88c79f6..456d6b1 100644
--- a/drivers/scsi/pata_hpt3x3.c
+++ b/drivers/scsi/pata_hpt3x3.c
@@ -58,7 +58,7 @@ static void hpt3x3_set_piomode(struct at
 {
 	struct pci_dev *pdev = to_pci_dev(ap->host_set->dev);
 	u32 r1, r2;
-	int dn = 2 * ap->hard_port_no + adev->devno;
+	int dn = 2 * ap->port_no + adev->devno;
 
 	pci_read_config_dword(pdev, 0x44, &r1);
 	pci_read_config_dword(pdev, 0x48, &r2);
@@ -84,7 +84,7 @@ static void hpt3x3_set_dmamode(struct at
 {
 	struct pci_dev *pdev = to_pci_dev(ap->host_set->dev);
 	u32 r1, r2;
-	int dn = 2 * ap->hard_port_no + adev->devno;
+	int dn = 2 * ap->port_no + adev->devno;
 	int mode_num = adev->dma_mode & 0x0F;
 
 	pci_read_config_dword(pdev, 0x44, &r1);
diff --git a/drivers/scsi/pata_it8172.c b/drivers/scsi/pata_it8172.c
index a5316e0..d6c4744 100644
--- a/drivers/scsi/pata_it8172.c
+++ b/drivers/scsi/pata_it8172.c
@@ -59,7 +59,7 @@ static int it8172_pre_reset(struct ata_p
 
 	struct pci_dev *pdev = to_pci_dev(ap->host_set->dev);
 	
-	if (ap->hard_port_no && !pci_test_config_bits(pdev, &it8172_enable_bits[ap->hard_port_no])) {
+	if (ap->port_no && !pci_test_config_bits(pdev, &it8172_enable_bits[ap->port_no])) {
 		ata_port_disable(ap);
 		printk(KERN_INFO "ata%u: port disabled. ignoring.\n", ap->id);
 		return 0;
@@ -146,7 +146,7 @@ static void it8172_set_piomode(struct at
 static void it8172_set_dmamode(struct ata_port *ap, struct ata_device *adev)
 {
 	struct pci_dev *pdev = to_pci_dev(ap->host_set->dev);
-	int dn = (2 * ap->hard_port_no) + adev->devno;
+	int dn = (2 * ap->port_no) + adev->devno;
 	u8 reg48, reg4a;
 	int pio;
 
diff --git a/drivers/scsi/pata_it821x.c b/drivers/scsi/pata_it821x.c
index be07da7..f793612 100644
--- a/drivers/scsi/pata_it821x.c
+++ b/drivers/scsi/pata_it821x.c
@@ -152,7 +152,7 @@ static void it821x_program(struct ata_po
 {
 	struct pci_dev *pdev = to_pci_dev(ap->host_set->dev);
 	struct it821x_dev *itdev = ap->private_data;
-	int channel = ap->hard_port_no;
+	int channel = ap->port_no;
 	u8 conf;
 
 	/* Program PIO/MWDMA timing bits */
@@ -180,7 +180,7 @@ static void it821x_program_udma(struct a
 {
 	struct it821x_dev *itdev = ap->private_data;
 	struct pci_dev *pdev = to_pci_dev(ap->host_set->dev);
-	int channel = ap->hard_port_no;
+	int channel = ap->port_no;
 	int unit = adev->devno;
 	u8 conf;
 
@@ -246,8 +246,8 @@ static void it821x_clock_strategy(struct
 		sel = 1;
 	}
 	pci_read_config_byte(pdev, 0x50, &v);
-	v &= ~(1 << (1 + ap->hard_port_no));
-	v |= sel << (1 + ap->hard_port_no);
+	v &= ~(1 << (1 + ap->port_no));
+	v |= sel << (1 + ap->port_no);
 	pci_write_config_byte(pdev, 0x50, v);
 
 	/*
@@ -316,7 +316,7 @@ static void it821x_passthru_set_dmamode(
 
 	struct pci_dev *pdev = to_pci_dev(ap->host_set->dev);
 	struct it821x_dev *itdev = ap->private_data;
-	int channel = ap->hard_port_no;
+	int channel = ap->port_no;
 	int unit = adev->devno;
 	u8 conf;
 
@@ -624,7 +624,7 @@ static int it821x_port_start(struct ata_
 		/* No ATAPI DMA in this mode either */
 	}
 	/* Pull the current clocks from 0x50 */
-	if (conf & (1 << (1 + ap->hard_port_no)))
+	if (conf & (1 << (1 + ap->port_no)))
 		itdev->clock_mode = ATA_50;
 	else
 		itdev->clock_mode = ATA_66;
diff --git a/drivers/scsi/pata_mpiix.c b/drivers/scsi/pata_mpiix.c
index 7b571ac..12e6e2b 100644
--- a/drivers/scsi/pata_mpiix.c
+++ b/drivers/scsi/pata_mpiix.c
@@ -54,7 +54,7 @@ static int mpiix_pre_reset(struct ata_po
 		{ 0x6F, 1, 0x80, 0x80 }
 	};
 
-	if (!pci_test_config_bits(pdev, &mpiix_enable_bits[ap->hard_port_no])) {
+	if (!pci_test_config_bits(pdev, &mpiix_enable_bits[ap->port_no])) {
 		ata_port_disable(ap);
 		printk(KERN_INFO "ata%u: port disabled. ignoring.\n", ap->id);
 		return 0;
@@ -232,8 +232,6 @@ static int mpiix_init_one(struct pci_dev
 	probe[0].irq = 14;
 	probe[0].irq_flags = SA_SHIRQ;
 	probe[0].host_flags = ATA_FLAG_SLAVE_POSS | ATA_FLAG_SRST;
-	probe[0].legacy_mode = 1;
-	probe[0].hard_port_no = 0;
 	probe[0].n_ports = 1;
 	probe[0].port[0].cmd_addr = 0x1F0;
 	probe[0].port[0].ctl_addr = 0x3F6;
@@ -245,7 +243,6 @@ static int mpiix_init_one(struct pci_dev
 	INIT_LIST_HEAD(&probe[1].node);
 	probe[1] = probe[0];
 	probe[1].irq = 15;
-	probe[1].hard_port_no = 1;
 	probe[1].port[0].cmd_addr = 0x170;
 	probe[1].port[0].ctl_addr = 0x376;
 	probe[1].port[0].altstatus_addr = 0x376;
diff --git a/drivers/scsi/pata_ns87410.c b/drivers/scsi/pata_ns87410.c
index 528b3ad..0106db0 100644
--- a/drivers/scsi/pata_ns87410.c
+++ b/drivers/scsi/pata_ns87410.c
@@ -45,7 +45,7 @@ static int ns87410_pre_reset(struct ata_
 		{ 0x47, 1, 0x08, 0x08 }
 	};
 
-	if (!pci_test_config_bits(pdev, &ns87410_enable_bits[ap->hard_port_no])) {
+	if (!pci_test_config_bits(pdev, &ns87410_enable_bits[ap->port_no])) {
 		ata_port_disable(ap);
 		printk(KERN_INFO "ata%u: port disabled. ignoring.\n", ap->id);
 		return 0;
@@ -80,7 +80,7 @@ static void ns87410_error_handler(struct
 static void ns87410_set_piomode(struct ata_port *ap, struct ata_device *adev)
 {
 	struct pci_dev *pdev = to_pci_dev(ap->host_set->dev);
-	int port = 0x40 + 4 * ap->hard_port_no;
+	int port = 0x40 + 4 * ap->port_no;
 	u8 idetcr, idefr;
 	struct ata_timing at;
 
diff --git a/drivers/scsi/pata_oldpiix.c b/drivers/scsi/pata_oldpiix.c
index 50d0c19..0fd2181 100644
--- a/drivers/scsi/pata_oldpiix.c
+++ b/drivers/scsi/pata_oldpiix.c
@@ -42,7 +42,7 @@ static int oldpiix_pre_reset(struct ata_
 		{ 0x43U, 1U, 0x80UL, 0x80UL },	/* port 1 */
 	};
 
-	if (!pci_test_config_bits(pdev, &oldpiix_enable_bits[ap->hard_port_no])) {
+	if (!pci_test_config_bits(pdev, &oldpiix_enable_bits[ap->port_no])) {
 		ata_port_disable(ap);
 		printk(KERN_INFO "ata%u: port disabled. ignoring.\n", ap->id);
 		return 0;
@@ -80,7 +80,7 @@ static void oldpiix_set_piomode (struct 
 {
 	unsigned int pio	= adev->pio_mode - XFER_PIO_0;
 	struct pci_dev *dev	= to_pci_dev(ap->host_set->dev);
-	unsigned int idetm_port= ap->hard_port_no ? 0x42 : 0x40;
+	unsigned int idetm_port= ap->port_no ? 0x42 : 0x40;
 	u16 idetm_data;
 	int control = 0;
 
@@ -140,7 +140,7 @@ static void oldpiix_set_piomode (struct 
 static void oldpiix_set_dmamode (struct ata_port *ap, struct ata_device *adev)
 {
 	struct pci_dev *dev	= to_pci_dev(ap->host_set->dev);
-	u8 idetm_port		= ap->hard_port_no ? 0x42 : 0x40;
+	u8 idetm_port		= ap->port_no ? 0x42 : 0x40;
 	u16 idetm_data;
 
 	static const	 /* ISP  RTC */
diff --git a/drivers/scsi/pata_opti.c b/drivers/scsi/pata_opti.c
index 5bc9f54..59dcb15 100644
--- a/drivers/scsi/pata_opti.c
+++ b/drivers/scsi/pata_opti.c
@@ -59,7 +59,7 @@ static int opti_pre_reset(struct ata_por
 		{ 0x40, 1, 0x08, 0x00 }
 	};
 
-	if (!pci_test_config_bits(pdev, &opti_enable_bits[ap->hard_port_no])) {
+	if (!pci_test_config_bits(pdev, &opti_enable_bits[ap->port_no])) {
 		ata_port_disable(ap);
 		printk(KERN_INFO "ata%u: port disabled. ignoring.\n", ap->id);
 		return 0;
diff --git a/drivers/scsi/pata_optidma.c b/drivers/scsi/pata_optidma.c
index 5216e8a..f4824dd 100644
--- a/drivers/scsi/pata_optidma.c
+++ b/drivers/scsi/pata_optidma.c
@@ -59,7 +59,7 @@ static int optidma_pre_reset(struct ata_
 		0x40, 1, 0x08, 0x00
 	};
 
-	if (ap->hard_port_no && !pci_test_config_bits(pdev, &optidma_enable_bits)) {
+	if (ap->port_no && !pci_test_config_bits(pdev, &optidma_enable_bits)) {
 		ata_port_disable(ap);
 		printk(KERN_INFO "ata%u: port disabled. ignoring.\n", ap->id);
 		return 0;
@@ -221,7 +221,7 @@ static void optiplus_set_mode(struct ata
 	u8 udcfg;
 	u8 udslave;
 	int dev2 = 2 * adev->devno;
-	int unit = 2 * ap->hard_port_no + adev->devno;
+	int unit = 2 * ap->port_no + adev->devno;
 	int udma = mode - XFER_UDMA_0;
 	
 	pci_read_config_byte(pdev, 0x44, &udcfg);
@@ -230,7 +230,7 @@ static void optiplus_set_mode(struct ata
 		optidma_set_mode(ap, adev, adev->dma_mode);
 	} else {
 		udcfg |=  (1 << unit);
-		if (ap->hard_port_no) {
+		if (ap->port_no) {
 			pci_read_config_byte(pdev, 0x45, &udslave);
 			udslave &= ~(0x03 << dev2);
 			udslave |= (udma << dev2);
@@ -334,7 +334,7 @@ static u8 optidma_make_bits43(struct ata
 static void optidma_post_set_mode(struct ata_port *ap)
 {
 	u8 r;
-	int nybble = 4 * ap->hard_port_no;
+	int nybble = 4 * ap->port_no;
 	struct pci_dev *pdev = to_pci_dev(ap->host_set->dev);
 	
 	pci_read_config_byte(pdev, 0x43, &r);
diff --git a/drivers/scsi/pata_pdc202xx_old.c b/drivers/scsi/pata_pdc202xx_old.c
index c3c797a..8ad79c1 100644
--- a/drivers/scsi/pata_pdc202xx_old.c
+++ b/drivers/scsi/pata_pdc202xx_old.c
@@ -49,7 +49,7 @@ static int pdc2026x_pre_reset(struct ata
 	u16 cis;
 	
 	pci_read_config_word(pdev, 0x50, &cis);
-	if (cis & (1 << (10 + ap->hard_port_no)))
+	if (cis & (1 << (10 + ap->port_no)))
 		ap->cbl = ATA_CBL_PATA80;
 	else
 		ap->cbl = ATA_CBL_PATA40;
@@ -76,7 +76,7 @@ static void pdc2026x_error_handler(struc
 static void pdc_configure_piomode(struct ata_port *ap, struct ata_device *adev, int pio)
 {
 	struct pci_dev *pdev = to_pci_dev(ap->host_set->dev);
-	int port = 0x60 + 4 * ap->hard_port_no + 2 * adev->devno;
+	int port = 0x60 + 4 * ap->port_no + 2 * adev->devno;
 	static u16 pio_timing[5] = {
 		0x0913, 0x050C , 0x0308, 0x0206, 0x0104
 	};
@@ -123,7 +123,7 @@ static void pdc_set_piomode(struct ata_p
 static void pdc_set_dmamode(struct ata_port *ap, struct ata_device *adev)
 {
 	struct pci_dev *pdev = to_pci_dev(ap->host_set->dev);
-	int port = 0x60 + 4 * ap->hard_port_no + 2 * adev->devno;
+	int port = 0x60 + 4 * ap->port_no + 2 * adev->devno;
 	static u8 udma_timing[6][2] = {
 		{ 0x60, 0x03 },	/* 33 Mhz Clock */
 		{ 0x40, 0x02 },
@@ -168,11 +168,11 @@ static void pdc2026x_bmdma_start(struct 
 	struct ata_port *ap = qc->ap;
 	struct ata_device *adev = qc->dev;
 	struct ata_taskfile *tf = &qc->tf;
-	int sel66 = ap->hard_port_no ? 0x08: 0x02;
+	int sel66 = ap->port_no ? 0x08: 0x02;
 
 	unsigned long master = ap->host_set->ports[0]->ioaddr.bmdma_addr;
 	unsigned long clock = master + 0x11;
-	unsigned long atapi_reg = master + 0x20 + (4 * ap->hard_port_no);
+	unsigned long atapi_reg = master + 0x20 + (4 * ap->port_no);
 	
 	u32 len;
 	
@@ -220,11 +220,11 @@ static void pdc2026x_bmdma_stop(struct a
 	struct ata_device *adev = qc->dev;
 	struct ata_taskfile *tf = &qc->tf;
 	
-	int sel66 = ap->hard_port_no ? 0x08: 0x02;
+	int sel66 = ap->port_no ? 0x08: 0x02;
 	/* The clock bits are in the same register for both channels */
 	unsigned long master = ap->host_set->ports[0]->ioaddr.bmdma_addr;
 	unsigned long clock = master + 0x11;
-	unsigned long atapi_reg = master + 0x20 + (4 * ap->hard_port_no);
+	unsigned long atapi_reg = master + 0x20 + (4 * ap->port_no);
 	
 	/* Cases the state machine will not complete correctly */
 	if (tf->protocol == ATA_PROT_ATAPI_DMA || ( tf->flags & ATA_TFLAG_LBA48)) {
diff --git a/drivers/scsi/pata_sc1200.c b/drivers/scsi/pata_sc1200.c
index 87bb8df..1be971a 100644
--- a/drivers/scsi/pata_sc1200.c
+++ b/drivers/scsi/pata_sc1200.c
@@ -95,7 +95,7 @@ static void sc1200_set_piomode(struct at
 
 	struct pci_dev *pdev = to_pci_dev(ap->host_set->dev);
 	u32 format;
-	unsigned int reg = 0x40 + 0x10 * ap->hard_port_no;
+	unsigned int reg = 0x40 + 0x10 * ap->port_no;
 	int mode = adev->pio_mode - XFER_PIO_0;
 	
 	pci_read_config_dword(pdev, reg + 4, &format);
@@ -130,7 +130,7 @@ static void sc1200_set_dmamode(struct at
 	
 	int clock = sc1200_clock();
 	struct pci_dev *pdev = to_pci_dev(ap->host_set->dev);
-	unsigned int reg = 0x40 + 0x10 * ap->hard_port_no;
+	unsigned int reg = 0x40 + 0x10 * ap->port_no;
 	int mode = adev->dma_mode;
 	u32 format;
 
diff --git a/drivers/scsi/pata_serverworks.c b/drivers/scsi/pata_serverworks.c
index 1071f9f..8c0b248 100644
--- a/drivers/scsi/pata_serverworks.c
+++ b/drivers/scsi/pata_serverworks.c
@@ -68,7 +68,7 @@ static const char *csb_bad_ata100[] = {
 static int dell_cable(struct ata_port *ap) {
 	struct pci_dev *pdev = to_pci_dev(ap->host_set->dev);
 	
-	if (pdev->subsystem_device & (1 << (ap->hard_port_no + 14)))
+	if (pdev->subsystem_device & (1 << (ap->port_no + 14)))
 		return ATA_CBL_PATA80;
 	return ATA_CBL_PATA40;
 }
@@ -85,7 +85,7 @@ static int dell_cable(struct ata_port *a
 static int sun_cable(struct ata_port *ap) {
 	struct pci_dev *pdev = to_pci_dev(ap->host_set->dev);
 	
-	if (pdev->subsystem_device & (1 << (ap->hard_port_no + 14)))
+	if (pdev->subsystem_device & (1 << (ap->port_no + 14)))
 		return ATA_CBL_PATA80;
 	return ATA_CBL_PATA40;
 }
@@ -254,8 +254,8 @@ static unsigned long serverworks_csb_fil
 static void serverworks_set_piomode(struct ata_port *ap, struct ata_device *adev)
 {
 	static const u8 pio_mode[] = { 0x5d, 0x47, 0x34, 0x22, 0x20 };
-	int offset = 1 + (2 * ap->hard_port_no) - adev->devno;
-	int devbits = (2 * ap->hard_port_no + adev->devno) * 4;
+	int offset = 1 + (2 * ap->port_no) - adev->devno;
+	int devbits = (2 * ap->port_no + adev->devno) * 4;
 	u16 csb5_pio;
 	struct pci_dev *pdev = to_pci_dev(ap->host_set->dev);
 	int pio = adev->pio_mode - XFER_PIO_0;
@@ -284,8 +284,8 @@ static void serverworks_set_piomode(stru
 static void serverworks_set_dmamode(struct ata_port *ap, struct ata_device *adev)
 {
 	static const u8 dma_mode[] = { 0x77, 0x21, 0x20 };
-	int offset = 1 + 2 * ap->hard_port_no - adev->devno;
-	int devbits = (2 * ap->hard_port_no + adev->devno);
+	int offset = 1 + 2 * ap->port_no - adev->devno;
+	int devbits = (2 * ap->port_no + adev->devno);
 	u8 ultra;
 	u8 ultra_cfg;
 	struct pci_dev *pdev = to_pci_dev(ap->host_set->dev);
@@ -295,11 +295,11 @@ static void serverworks_set_dmamode(stru
 	if (adev->dma_mode >= XFER_UDMA_0) {
 		pci_write_config_byte(pdev, 0x44 + offset,  0x20);
 
-		pci_read_config_byte(pdev, 0x56 + ap->hard_port_no, &ultra);
-		ultra &= ~(0x0F << (ap->hard_port_no * 4));
+		pci_read_config_byte(pdev, 0x56 + ap->port_no, &ultra);
+		ultra &= ~(0x0F << (ap->port_no * 4));
 		ultra |= (adev->dma_mode - XFER_UDMA_0)
-					<< (ap->hard_port_no * 4);
-		pci_write_config_byte(pdev, 0x56 + ap->hard_port_no, ultra);
+					<< (ap->port_no * 4);
+		pci_write_config_byte(pdev, 0x56 + ap->port_no, ultra);
 
 		ultra_cfg |=  (1 << devbits);
 	} else {
diff --git a/drivers/scsi/pata_sil680.c b/drivers/scsi/pata_sil680.c
index c9d6079..a0c3c7d 100644
--- a/drivers/scsi/pata_sil680.c
+++ b/drivers/scsi/pata_sil680.c
@@ -49,7 +49,7 @@ #define DRV_VERSION "0.3.2"
 static unsigned long sil680_selreg(struct ata_port *ap, int r)
 {
 	unsigned long base = 0xA0 + r;
-	base += (ap->hard_port_no << 4);
+	base += (ap->port_no << 4);
 	return base;
 }
 
@@ -66,7 +66,7 @@ static unsigned long sil680_selreg(struc
 static unsigned long sil680_seldev(struct ata_port *ap, struct ata_device *adev, int r)
 {
 	unsigned long base = 0xA0 + r;
-	base += (ap->hard_port_no << 4);
+	base += (ap->port_no << 4);
 	base |= adev->devno ? 2 : 0;
 	return base;
 }
@@ -180,7 +180,7 @@ static void sil680_set_dmamode(struct at
 	struct pci_dev *pdev = to_pci_dev(ap->host_set->dev);
 	unsigned long ma = sil680_seldev(ap, adev, 0x08);
 	unsigned long ua = sil680_seldev(ap, adev, 0x0C);
-	unsigned long addr_mask = 0x80 + 4 * ap->hard_port_no;
+	unsigned long addr_mask = 0x80 + 4 * ap->port_no;
 	int port_shift = adev->devno * 4;
 	u8 scsc, mode;
 	u16 multi, ultra;
diff --git a/drivers/scsi/pata_sis.c b/drivers/scsi/pata_sis.c
index d14ce11..03ded9e 100644
--- a/drivers/scsi/pata_sis.c
+++ b/drivers/scsi/pata_sis.c
@@ -53,7 +53,7 @@ struct sis_chipset {
 
 static int sis_port_base(struct ata_device *adev)
 {
-	return  0x40 + (4 * adev->ap->hard_port_no) +  (2 * adev->devno);
+	return  0x40 + (4 * adev->ap->port_no) +  (2 * adev->devno);
 }
 
 /**
@@ -74,13 +74,13 @@ static int sis_133_pre_reset(struct ata_
 	struct pci_dev *pdev = to_pci_dev(ap->host_set->dev);
 	u16 tmp;
 
-	if (!pci_test_config_bits(pdev, &sis_enable_bits[ap->hard_port_no])) {
+	if (!pci_test_config_bits(pdev, &sis_enable_bits[ap->port_no])) {
 		ata_port_disable(ap);
 		printk(KERN_INFO "ata%u: port disabled. ignoring.\n", ap->id);
 		return 0;
 	}
 	/* The top bit of this register is the cable detect bit */
-	pci_read_config_word(pdev, 0x50 + 2 * ap->hard_port_no, &tmp);
+	pci_read_config_word(pdev, 0x50 + 2 * ap->port_no, &tmp);
 	if (tmp & 0x8000)
 		ap->cbl = ATA_CBL_PATA40;
 	else
@@ -121,14 +121,14 @@ static int sis_66_pre_reset(struct ata_p
 	struct pci_dev *pdev = to_pci_dev(ap->host_set->dev);
 	u8 tmp;
 
-	if (!pci_test_config_bits(pdev, &sis_enable_bits[ap->hard_port_no])) {
+	if (!pci_test_config_bits(pdev, &sis_enable_bits[ap->port_no])) {
 		ata_port_disable(ap);
 		printk(KERN_INFO "ata%u: port disabled. ignoring.\n", ap->id);
 		return 0;
 	}
 	/* Older chips keep cable detect in bits 4/5 of reg 0x48 */
 	pci_read_config_byte(pdev, 0x48, &tmp);
-	tmp >>= ap->hard_port_no;
+	tmp >>= ap->port_no;
 	if (tmp & 0x10)
 		ap->cbl = ATA_CBL_PATA40;
 	else
@@ -167,7 +167,7 @@ static int sis_old_pre_reset(struct ata_
 	
 	struct pci_dev *pdev = to_pci_dev(ap->host_set->dev);
 
-	if (!pci_test_config_bits(pdev, &sis_enable_bits[ap->hard_port_no])) {
+	if (!pci_test_config_bits(pdev, &sis_enable_bits[ap->port_no])) {
 		ata_port_disable(ap);
 		printk(KERN_INFO "ata%u: port disabled. ignoring.\n", ap->id);
 		return 0;
@@ -206,7 +206,7 @@ static void sis_set_fifo(struct ata_port
 	u8 fifoctrl;
 	u8 mask = 0x11;
 
-	mask <<= (2 * ap->hard_port_no);
+	mask <<= (2 * ap->port_no);
 	mask <<= adev->devno;
 
 	/* This holds various bits including the FIFO control */
@@ -323,7 +323,7 @@ static void sis_133_set_piomode (struct 
 	pci_read_config_dword(pdev, 0x54, &reg54);
 	if (reg54 & 0x40000000)
 		port = 0x70;
-	port += 8 * ap->hard_port_no +  4 * adev->devno;
+	port += 8 * ap->port_no +  4 * adev->devno;
 
 	pci_read_config_dword(pdev, port, &t1);
 	t1 &= 0xC0C00FFF;	/* Mask out timing */
@@ -511,7 +511,7 @@ static void sis_133_set_dmamode (struct 
 	pci_read_config_dword(pdev, 0x54, &reg54);
 	if (reg54 & 0x40000000)
 		port = 0x70;
-	port += (8 * ap->hard_port_no) +  (4 * adev->devno);
+	port += (8 * ap->port_no) +  (4 * adev->devno);
 
 	pci_read_config_dword(pdev, port, &t1);
 
diff --git a/drivers/scsi/pata_sl82c105.c b/drivers/scsi/pata_sl82c105.c
index 4ef0cf0..bc1d973 100644
--- a/drivers/scsi/pata_sl82c105.c
+++ b/drivers/scsi/pata_sl82c105.c
@@ -49,7 +49,7 @@ static int sl82c105_pre_reset(struct ata
 	};
 	struct pci_dev *pdev = to_pci_dev(ap->host_set->dev);
 
-	if (ap->hard_port_no && !pci_test_config_bits(pdev, &sl82c105_enable_bits[ap->hard_port_no])) {
+	if (ap->port_no && !pci_test_config_bits(pdev, &sl82c105_enable_bits[ap->port_no])) {
 		ata_port_disable(ap);
 		dev_printk(KERN_INFO, &pdev->dev, "port disabled. ignoring.\n");
 		return 0;
@@ -83,7 +83,7 @@ static void sl82c105_configure_piomode(s
 		0x50D, 0x407, 0x304, 0x242, 0x240
 	};
 	u16 dummy;
-	int timing = 0x44 + (8 * ap->hard_port_no) + (4 * adev->devno);
+	int timing = 0x44 + (8 * ap->port_no) + (4 * adev->devno);
 	
 	pci_write_config_word(pdev, timing, pio_timing[pio]);
 	/* Can we lose this oddity of the old driver */
@@ -120,7 +120,7 @@ static void sl82c105_configure_dmamode(s
 		0x707, 0x201, 0x200
 	};
 	u16 dummy;
-	int timing = 0x44 + (8 * ap->hard_port_no) + (4 * adev->devno);
+	int timing = 0x44 + (8 * ap->port_no) + (4 * adev->devno);
 	int dma = adev->dma_mode - XFER_MW_DMA_0;
 	
 	pci_write_config_word(pdev, timing, dma_timing[dma]);
diff --git a/drivers/scsi/pata_triflex.c b/drivers/scsi/pata_triflex.c
index 25816b7..549dc43 100644
--- a/drivers/scsi/pata_triflex.c
+++ b/drivers/scsi/pata_triflex.c
@@ -61,7 +61,7 @@ static int triflex_probe_init(struct ata
 
 	struct pci_dev *pdev = to_pci_dev(ap->host_set->dev);
 	
-	if (!pci_test_config_bits(pdev, &triflex_enable_bits[ap->hard_port_no])) {
+	if (!pci_test_config_bits(pdev, &triflex_enable_bits[ap->port_no])) {
 		ata_port_disable(ap);
 		printk(KERN_INFO "ata%u: port disabled. ignoring.\n", ap->id);
 		return 0;
@@ -94,7 +94,7 @@ static void triflex_load_timing(struct a
 	struct pci_dev *pdev = to_pci_dev(ap->host_set->dev);
 	u32 timing = 0;
 	u32 triflex_timing, old_triflex_timing;
-	int channel_offset = ap->hard_port_no ? 0x74: 0x70;
+	int channel_offset = ap->port_no ? 0x74: 0x70;
 	unsigned int is_slave	= (adev->devno != 0);
 
 
diff --git a/drivers/scsi/pata_via.c b/drivers/scsi/pata_via.c
index 41c3bad..3eab0d5 100644
--- a/drivers/scsi/pata_via.c
+++ b/drivers/scsi/pata_via.c
@@ -137,7 +137,7 @@ static int via_cable_detect(struct ata_p
 	pci_read_config_dword(pdev, 0x50, &ata66);
 	/* Check both the drive cable reporting bits, we might not have
 	   two drives */
-	if (ata66 & (0x10100000 >> (16 * ap->hard_port_no)))
+	if (ata66 & (0x10100000 >> (16 * ap->port_no)))
 		return ATA_CBL_PATA80;
 	else
 		return ATA_CBL_PATA40;
@@ -155,7 +155,7 @@ static int via_pre_reset(struct ata_port
 
 		struct pci_dev *pdev = to_pci_dev(ap->host_set->dev);
 		
-		if (!pci_test_config_bits(pdev, &via_enable_bits[ap->hard_port_no])) {
+		if (!pci_test_config_bits(pdev, &via_enable_bits[ap->port_no])) {
 			ata_port_disable(ap);
 			printk(KERN_INFO "ata%u: port disabled. ignoring.\n", ap->id);
 			return 0;
@@ -207,7 +207,7 @@ static void via_do_set_mode(struct ata_p
 	unsigned long T =  1000000000 / via_clock;
 	unsigned long UT = T/tdiv;
 	int ut;
-	int offset = 3 - (2*ap->hard_port_no) - adev->devno;
+	int offset = 3 - (2*ap->port_no) - adev->devno;
 
 
 	/* Calculate the timing values we require */
@@ -233,7 +233,7 @@ static void via_do_set_mode(struct ata_p
 	}
 
 	/* Load the PIO mode bits */
-	pci_write_config_byte(pdev, 0x4F - ap->hard_port_no,
+	pci_write_config_byte(pdev, 0x4F - ap->port_no,
 		((FIT(t.act8b, 1, 16) - 1) << 4) | (FIT(t.rec8b, 1, 16) - 1));
 	pci_write_config_byte(pdev, 0x48 + offset,
 		((FIT(t.active, 1, 16) - 1) << 4) | (FIT(t.recover, 1, 16) - 1));
-- 
1.3.2

