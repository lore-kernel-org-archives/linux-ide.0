From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [git patches] IDE fixes
Date: Sun, 4 May 2008 17:05:52 +0200
Message-ID: <200805041705.53129.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1752809AbYEDOuo@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Stephen Rothwell <sfr@canb.auug.org.au>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org


Fix regression affecting SL82C105 host driver.


Linus, please pull from:

master.kernel.org:/pub/scm/linux/kernel/git/bart/ide-2.6.git/

to receive the following updates:

 drivers/ide/ide-probe.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)


Bartlomiej Zolnierkiewicz (1):
      ide: IDE_HFLAG_SERIALIZE_DMA bugfix


diff --git a/drivers/ide/ide-probe.c b/drivers/ide/ide-probe.c
index 591deda..34b0d4f 100644
--- a/drivers/ide/ide-probe.c
+++ b/drivers/ide/ide-probe.c
@@ -1355,12 +1355,6 @@ static void ide_init_port(ide_hwif_t *hwif, unsigned int port,
 	if (hwif->chipset != ide_dtc2278 || hwif->channel == 0)
 		hwif->port_ops = d->port_ops;
 
-	if ((d->host_flags & IDE_HFLAG_SERIALIZE) ||
-	    ((d->host_flags & IDE_HFLAG_SERIALIZE_DMA) && hwif->dma_base)) {
-		if (hwif->mate)
-			hwif->mate->serialized = hwif->serialized = 1;
-	}
-
 	hwif->swdma_mask = d->swdma_mask;
 	hwif->mwdma_mask = d->mwdma_mask;
 	hwif->ultra_mask = d->udma_mask;
@@ -1382,6 +1376,12 @@ static void ide_init_port(ide_hwif_t *hwif, unsigned int port,
 			hwif->dma_ops = d->dma_ops;
 	}
 
+	if ((d->host_flags & IDE_HFLAG_SERIALIZE) ||
+	    ((d->host_flags & IDE_HFLAG_SERIALIZE_DMA) && hwif->dma_base)) {
+		if (hwif->mate)
+			hwif->mate->serialized = hwif->serialized = 1;
+	}
+
 	if (d->host_flags & IDE_HFLAG_RQSIZE_256)
 		hwif->rqsize = 256;
 
