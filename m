From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 45/64] via82cxxx: fix UDMA settings programming
Date: Mon, 18 Jan 2010 18:20:21 +0100
Message-ID: <20100118172021.14623.2326.sendpatchset@localhost>
References: <20100118171349.14623.90030.sendpatchset@localhost>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755364Ab0ARRVr@vger.kernel.org>
In-Reply-To: <20100118171349.14623.90030.sendpatchset@localhost>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] via82cxxx: fix UDMA settings programming

* preserve 80-wire cable detection bit
* don't clear UDMA settings when programming PIO/MWDMA modes

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/via82cxxx.c |   19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

Index: b/drivers/ide/via82cxxx.c
===================================================================
--- a/drivers/ide/via82cxxx.c
+++ b/drivers/ide/via82cxxx.c
@@ -146,10 +146,25 @@ static void via_set_speed(ide_hwif_t *hw
 	case ATA_UDMA4: t = timing->udma ? (0xe8 | (clamp_val(timing->udma, 2, 9) - 2)) : 0x0f; break;
 	case ATA_UDMA5: t = timing->udma ? (0xe0 | (clamp_val(timing->udma, 2, 9) - 2)) : 0x07; break;
 	case ATA_UDMA6: t = timing->udma ? (0xe0 | (clamp_val(timing->udma, 2, 9) - 2)) : 0x07; break;
-	default: return;
 	}
 
-	pci_write_config_byte(dev, VIA_UDMA_TIMING + (3 - dn), t);
+	/* Set UDMA unless device is not UDMA capable */
+	if (vdev->via_config->udma_mask) {
+		u8 udma_etc;
+
+		pci_read_config_byte(dev, VIA_UDMA_TIMING + 3 - dn, &udma_etc);
+
+		/* clear transfer mode bit */
+		udma_etc &= ~0x20;
+
+		if (timing->udma) {
+			/* preserve 80-wire cable detection bit */
+			udma_etc &= 0x10;
+			udma_etc |= t;
+		}
+
+		pci_write_config_byte(dev, VIA_UDMA_TIMING + 3 - dn, udma_etc);
+	}
 }
 
 /**
