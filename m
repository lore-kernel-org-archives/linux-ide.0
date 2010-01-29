From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 33/68] pata_amd: move code to be re-used by ide2libata to pata_amd.h
Date: Fri, 29 Jan 2010 17:06:41 +0100
Message-ID: <20100129160641.21495.77291.sendpatchset@localhost>
References: <20100129160308.21495.14120.sendpatchset@localhost>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754881Ab0A2QHP@vger.kernel.org>
In-Reply-To: <20100129160308.21495.14120.sendpatchset@localhost>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] pata_amd: move code to be re-used by ide2libata to pata_amd.h

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ata/pata_amd.c |   87 ----------------------------------------------
 drivers/ata/pata_amd.h |   92 +++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 93 insertions(+), 86 deletions(-)

Index: b/drivers/ata/pata_amd.c
===================================================================
--- a/drivers/ata/pata_amd.c
+++ b/drivers/ata/pata_amd.c
@@ -26,92 +26,7 @@
 #define DRV_NAME "pata_amd"
 #define DRV_VERSION "0.4.1"
 
-/**
- *	timing_setup		-	shared timing computation and load
- *	@ap: ATA port being set up
- *	@adev: drive being configured
- *	@offset: port offset
- *	@speed: target speed
- *	@clock: clock multiplier (number of times 33MHz for this part)
- *
- *	Perform the actual timing set up for Nvidia or AMD PATA devices.
- *	The actual devices vary so they all call into this helper function
- *	providing the clock multipler and offset (because AMD and Nvidia put
- *	the ports at different locations).
- */
-
-static void timing_setup(struct ata_port *ap, struct ata_device *adev, int offset, int speed, int clock)
-{
-	static const unsigned char amd_cyc2udma[] = {
-		6, 6, 5, 4, 0, 1, 1, 2, 2, 3, 3, 3, 3, 3, 3, 7
-	};
-
-	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
-	struct ata_device *peer = ata_dev_pair(adev);
-	int dn = ap->port_no * 2 + adev->devno;
-	struct ata_timing at, apeer;
-	int T, UT;
-	const int amd_clock = 33333;	/* KHz. */
-	u8 t;
-
-	T = 1000000000 / amd_clock;
-	UT = T;
-	if (clock >= 2)
-		UT = T / 2;
-
-	ata_timing_compute(adev->id, speed, adev->pio_mode, &at, T, UT);
-
-	if (peer) {
-		ata_timing_compute(peer->id, peer->pio_mode,
-				   peer->pio_mode, &apeer, T, UT);
-		ata_timing_merge(&apeer, &at, &at, ATA_TIMING_8BIT);
-	}
-
-	if (speed == XFER_UDMA_5 && amd_clock <= 33333) at.udma = 1;
-	if (speed == XFER_UDMA_6 && amd_clock <= 33333) at.udma = 15;
-
-	/*
-	 *	Now do the setup work
-	 */
-
-	/* Configure the address set up timing */
-	pci_read_config_byte(pdev, offset + 0x0C, &t);
-	t = (t & ~(3 << ((3 - dn) << 1))) | ((clamp_val(at.setup, 1, 4) - 1) << ((3 - dn) << 1));
-	pci_write_config_byte(pdev, offset + 0x0C , t);
-
-	/* Configure the 8bit I/O timing */
-	pci_write_config_byte(pdev, offset + 0x0E + (1 - (dn >> 1)),
-		((clamp_val(at.act8b, 1, 16) - 1) << 4) | (clamp_val(at.rec8b, 1, 16) - 1));
-
-	/* Drive timing */
-	pci_write_config_byte(pdev, offset + 0x08 + (3 - dn),
-		((clamp_val(at.active, 1, 16) - 1) << 4) | (clamp_val(at.recover, 1, 16) - 1));
-
-	switch (clock) {
-		case 1:
-		t = at.udma ? (0xc0 | (clamp_val(at.udma, 2, 5) - 2)) : 0x03;
-		break;
-
-		case 2:
-		t = at.udma ? (0xc0 | amd_cyc2udma[clamp_val(at.udma, 2, 10)]) : 0x03;
-		break;
-
-		case 3:
-		t = at.udma ? (0xc0 | amd_cyc2udma[clamp_val(at.udma, 1, 10)]) : 0x03;
-		break;
-
-		case 4:
-		t = at.udma ? (0xc0 | amd_cyc2udma[clamp_val(at.udma, 1, 15)]) : 0x03;
-		break;
-
-		default:
-			return;
-	}
-
-	/* UDMA timing */
-	if (at.udma)
-		pci_write_config_byte(pdev, offset + 0x10 + (3 - dn), t);
-}
+#include "pata_amd.h"
 
 /**
  *	amd_pre_reset		-	perform reset handling
Index: b/drivers/ata/pata_amd.h
===================================================================
--- /dev/null
+++ b/drivers/ata/pata_amd.h
@@ -0,0 +1,92 @@
+
+/**
+ *	timing_setup		-	shared timing computation and load
+ *	@ap: ATA port being set up
+ *	@adev: drive being configured
+ *	@offset: port offset
+ *	@speed: target speed
+ *	@clock: clock multiplier (number of times 33MHz for this part)
+ *
+ *	Perform the actual timing set up for Nvidia or AMD PATA devices.
+ *	The actual devices vary so they all call into this helper function
+ *	providing the clock multipler and offset (because AMD and Nvidia put
+ *	the ports at different locations).
+ */
+
+static void timing_setup(struct ata_port *ap, struct ata_device *adev,
+			 int offset, int speed, int clock)
+{
+	static const unsigned char amd_cyc2udma[] = {
+		6, 6, 5, 4, 0, 1, 1, 2, 2, 3, 3, 3, 3, 3, 3, 7
+	};
+
+	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
+	struct ata_device *peer = ata_dev_pair(adev);
+	int dn = ap->port_no * 2 + adev->devno;
+	struct ata_timing at, apeer;
+	int T, UT;
+	const int amd_clock = 33333;	/* KHz. */
+	u8 t;
+
+	T = 1000000000 / amd_clock;
+	UT = T;
+	if (clock >= 2)
+		UT = T / 2;
+
+	ata_timing_compute(adev->id, speed, adev->pio_mode, &at, T, UT);
+
+	if (peer) {
+		ata_timing_compute(peer->id, peer->pio_mode,
+				   peer->pio_mode, &apeer, T, UT);
+		ata_timing_merge(&apeer, &at, &at, ATA_TIMING_8BIT);
+	}
+
+	if (speed == XFER_UDMA_5 && amd_clock <= 33333)
+		at.udma = 1;
+	if (speed == XFER_UDMA_6 && amd_clock <= 33333)
+		at.udma = 15;
+
+	/*
+	 *	Now do the setup work
+	 */
+
+	/* Configure the address set up timing */
+	pci_read_config_byte(pdev, offset + 0x0C, &t);
+	t = (t & ~(3 << ((3 - dn) << 1))) |
+	    ((clamp_val(at.setup, 1, 4) - 1) << ((3 - dn) << 1));
+	pci_write_config_byte(pdev, offset + 0x0C , t);
+
+	/* Configure the 8bit I/O timing */
+	pci_write_config_byte(pdev, offset + 0x0E + (1 - (dn >> 1)),
+		((clamp_val(at.act8b, 1, 16) - 1) << 4) |
+		(clamp_val(at.rec8b, 1, 16) - 1));
+
+	/* Drive timing */
+	pci_write_config_byte(pdev, offset + 0x08 + (3 - dn),
+		((clamp_val(at.active, 1, 16) - 1) << 4) |
+		(clamp_val(at.recover, 1, 16) - 1));
+
+	switch (clock) {
+	case 1:
+		t = at.udma ? (0xc0 | (clamp_val(at.udma, 2, 5) - 2)) : 0x03;
+		break;
+	case 2:
+		t = at.udma ? (0xc0 | amd_cyc2udma[clamp_val(at.udma, 2, 10)])
+			    : 0x03;
+		break;
+	case 3:
+		t = at.udma ? (0xc0 | amd_cyc2udma[clamp_val(at.udma, 1, 10)])
+			    : 0x03;
+		break;
+	case 4:
+		t = at.udma ? (0xc0 | amd_cyc2udma[clamp_val(at.udma, 1, 15)])
+			    : 0x03;
+		break;
+	default:
+		return;
+	}
+
+	/* UDMA timing */
+	if (at.udma)
+		pci_write_config_byte(pdev, offset + 0x10 + (3 - dn), t);
+}
