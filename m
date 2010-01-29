From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 39/68] pata_cmd64x: documentation fix
Date: Fri, 29 Jan 2010 17:07:18 +0100
Message-ID: <20100129160718.21495.19709.sendpatchset@localhost>
References: <20100129160308.21495.14120.sendpatchset@localhost>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754970Ab0A2QHh@vger.kernel.org>
In-Reply-To: <20100129160308.21495.14120.sendpatchset@localhost>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] pata_cmd64x: documentation fix

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ata/pata_cmd64x.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: b/drivers/ata/pata_cmd64x.c
===================================================================
--- a/drivers/ata/pata_cmd64x.c
+++ b/drivers/ata/pata_cmd64x.c
@@ -113,7 +113,7 @@ out:
 }
 
 /**
- *	cmd64x_set_piomode	-	set PIO and MWDMA timing
+ *	cmd64x_set_timing	-	set PIO and MWDMA timing
  *	@ap: ATA interface
  *	@adev: ATA device
  *	@mode: mode
