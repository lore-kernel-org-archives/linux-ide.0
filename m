From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 64/86] pata_radisys: unify code for programming PIO and MWDMA timings
Date: Wed, 25 Nov 2009 18:10:03 +0100
Message-ID: <20091125171003.5446.66341.sendpatchset@localhost>
References: <20091125170218.5446.13513.sendpatchset@localhost>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1759404AbZKYRKv@vger.kernel.org>
In-Reply-To: <20091125170218.5446.13513.sendpatchset@localhost>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] pata_radisys: unify code for programming PIO and MWDMA timings

It results in ~6% decrease in the driver LOC count and also ~1%
decrease in the driver binary size (as measured on x86-32).

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ata/pata_radisys.c |   66 +++++++++++++++++----------------------------
 1 file changed, 25 insertions(+), 41 deletions(-)

Index: b/drivers/ata/pata_radisys.c
===================================================================
--- a/drivers/ata/pata_radisys.c
+++ b/drivers/ata/pata_radisys.c
@@ -26,20 +26,9 @@
 #define DRV_NAME	"pata_radisys"
 #define DRV_VERSION	"0.4.4"
 
-/**
- *	radisys_set_piomode - Initialize host controller PATA PIO timings
- *	@ap: ATA port
- *	@adev: Device whose timings we are configuring
- *
- *	Set PIO mode for device, in host controller PCI config space.
- *
- *	LOCKING:
- *	None (inherited from caller).
- */
-
-static void radisys_set_piomode (struct ata_port *ap, struct ata_device *adev)
+static void radisys_set_timings(struct ata_port *ap, struct ata_device *adev,
+				u8 pio, bool use_mwdma)
 {
-	unsigned int pio	= adev->pio_mode - XFER_PIO_0;
 	struct pci_dev *dev	= to_pci_dev(ap->host->dev);
 	u16 idetm_data;
 	int control = 0;
@@ -52,7 +41,7 @@ static void radisys_set_piomode (struct
 	 */
 
 	static const	 /* ISP  RTC */
-	u8 timings[][2]	= { { 0, 0 },	/* Check me */
+	u8 timings[][2]	= { { 0, 0 },
 			    { 0, 0 },
 			    { 1, 1 },
 			    { 2, 2 },
@@ -62,6 +51,10 @@ static void radisys_set_piomode (struct
 		control |= 1;	/* TIME1 enable */
 	if (ata_pio_need_iordy(adev))
 		control |= 2;	/* IE IORDY */
+	/* If the drive MWDMA is faster than it can do PIO then
+	   we must force PIO0 for PIO cycles. */
+	if (use_mwdma && adev->pio_mode < (XFER_PIO_0 + pio))
+		control = 1;
 
 	pci_read_config_word(dev, 0x40, &idetm_data);
 
@@ -78,6 +71,22 @@ static void radisys_set_piomode (struct
 }
 
 /**
+ *	radisys_set_piomode - Initialize host controller PATA PIO timings
+ *	@ap: ATA port
+ *	@adev: Device whose timings we are configuring
+ *
+ *	Set PIO mode for device, in host controller PCI config space.
+ *
+ *	LOCKING:
+ *	None (inherited from caller).
+ */
+
+static void radisys_set_piomode(struct ata_port *ap, struct ata_device *adev)
+{
+	radisys_set_timings(ap, adev, adev->pio_mode - XFER_PIO_0, 0);
+}
+
+/**
  *	radisys_set_dmamode - Initialize host controller PATA DMA timings
  *	@ap: Port whose timings we are configuring
  *	@adev: Device to program
@@ -91,22 +100,10 @@ static void radisys_set_piomode (struct
 static void radisys_set_dmamode (struct ata_port *ap, struct ata_device *adev)
 {
 	struct pci_dev *dev	= to_pci_dev(ap->host->dev);
-	u16 idetm_data;
 	u8 udma_enable;
 
-	static const	 /* ISP  RTC */
-	u8 timings[][2]	= { { 0, 0 },
-			    { 0, 0 },
-			    { 1, 1 },
-			    { 2, 2 },
-			    { 3, 3 }, };
-
-	/*
-	 * MWDMA is driven by the PIO timings. We must also enable
-	 * IORDY unconditionally.
-	 */
+	/* MWDMA is driven by the PIO timings. */
 
-	pci_read_config_word(dev, 0x40, &idetm_data);
 	pci_read_config_byte(dev, 0x48, &udma_enable);
 
 	if (adev->dma_mode < XFER_UDMA_0) {
@@ -115,20 +112,8 @@ static void radisys_set_dmamode (struct
 			XFER_PIO_0, XFER_PIO_3, XFER_PIO_4
 		};
 		int pio = needed_pio[mwdma] - XFER_PIO_0;
-		int control = 3;	/* IORDY|TIME0 */
-
-		/* If the drive MWDMA is faster than it can do PIO then
-		   we must force PIO0 for PIO cycles. */
-
-		if (adev->pio_mode < needed_pio[mwdma])
-			control = 1;
 
-		/* Mask out the relevant control and timing bits we will load. Also
-		   clear the other drive TIME register as a precaution */
-
-		idetm_data &= 0xCCCC;
-		idetm_data |= control << (4 * adev->devno);
-		idetm_data |= (timings[pio][0] << 12) | (timings[pio][1] << 8);
+		radisys_set_timings(ap, adev, pio, 1);
 
 		udma_enable &= ~(1 << adev->devno);
 	} else {
@@ -147,7 +132,6 @@ static void radisys_set_dmamode (struct
 
 		udma_enable |= (1 << adev->devno);
 	}
-	pci_write_config_word(dev, 0x40, idetm_data);
 	pci_write_config_byte(dev, 0x48, udma_enable);
 
 	/* Track which port is configured */
