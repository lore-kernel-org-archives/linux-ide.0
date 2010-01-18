From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 22/64] pata_via: fix address setup timings underlocking
Date: Mon, 18 Jan 2010 18:17:03 +0100
Message-ID: <20100118171703.14623.85025.sendpatchset@localhost>
References: <20100118171349.14623.90030.sendpatchset@localhost>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754893Ab0ARRSZ@vger.kernel.org>
In-Reply-To: <20100118171349.14623.90030.sendpatchset@localhost>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] pata_via: fix address setup timings underlocking

Correct via_do_set_mode() documentation while at it.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ata/pata_via.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Index: b/drivers/ata/pata_via.c
===================================================================
--- a/drivers/ata/pata_via.c
+++ b/drivers/ata/pata_via.c
@@ -229,7 +229,7 @@ static int via_pre_reset(struct ata_link
 
 
 /**
- *	via_do_set_mode	-	set initial PIO mode data
+ *	via_do_set_mode	-	set transfer mode data
  *	@ap: ATA interface
  *	@adev: ATA device
  *	@mode: ATA mode being programmed
@@ -273,7 +273,7 @@ static void via_do_set_mode(struct ata_p
 
 		pci_read_config_byte(pdev, 0x4C, &setup);
 		setup &= ~(3 << shift);
-		setup |= clamp_val(t.setup, 1, 4) << shift;	/* 1,4 or 1,4 - 1  FIXME */
+		setup |= (clamp_val(t.setup, 1, 4) - 1) << shift;
 		pci_write_config_byte(pdev, 0x4C, setup);
 	}
 
