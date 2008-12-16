From: Julia Lawall <julia@diku.dk>
Subject: [PATCH 1/11] drivers/ide: Move a dereference below a NULL test
Date: Tue, 16 Dec 2008 16:11:53 +0100 (CET)
Message-ID: <Pine.LNX.4.64.0812161611280.20444@pc-004.diku.dk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mgw2.diku.dk ([130.225.96.92]:37159 "EHLO mgw2.diku.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754592AbYLPPL5 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 16 Dec 2008 10:11:57 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org

From: Julia Lawall <julia@diku.dk>

In each case, if the NULL test is necessary, then the dereference should be
moved below the NULL test.

The semantic patch that makes this change is as follows:
(http://www.emn.fr/x-info/coccinelle/)

// <smpl>
@@
type T;
expression E;
identifier i,fld;
statement S;
@@

- T i = E->fld;
+ T i;
  ... when != E
      when != i
  if (E == NULL) S
+ i = E->fld;
// </smpl>

Signed-off-by: Julia Lawall <julia@diku.dk>

---
 drivers/ide/cs5530.c |    3 ++-
 drivers/ide/sc1200.c |    3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/ide/cs5530.c b/drivers/ide/cs5530.c
index 53f079c..d8ede85 100644
--- a/drivers/ide/cs5530.c
+++ b/drivers/ide/cs5530.c
@@ -81,11 +81,12 @@ static u8 cs5530_udma_filter(ide_drive_t *drive)
 {
 	ide_hwif_t *hwif = drive->hwif;
 	ide_drive_t *mate = ide_get_pair_dev(drive);
-	u16 *mateid = mate->id;
+	u16 *mateid;
 	u8 mask = hwif->ultra_mask;
 
 	if (mate == NULL)
 		goto out;
+	mateid = mate->id;
 
 	if (ata_id_has_dma(mateid) && __ide_dma_bad_drive(mate) == 0) {
 		if ((mateid[ATA_ID_FIELD_VALID] & 4) &&
diff --git a/drivers/ide/sc1200.c b/drivers/ide/sc1200.c
index f1a8758..ec7f766 100644
--- a/drivers/ide/sc1200.c
+++ b/drivers/ide/sc1200.c
@@ -104,11 +104,12 @@ static u8 sc1200_udma_filter(ide_drive_t *drive)
 {
 	ide_hwif_t *hwif = drive->hwif;
 	ide_drive_t *mate = ide_get_pair_dev(drive);
-	u16 *mateid = mate->id;
+	u16 *mateid;
 	u8 mask = hwif->ultra_mask;
 
 	if (mate == NULL)
 		goto out;
+	mateid = mate->id;
 
 	if (ata_id_has_dma(mateid) && __ide_dma_bad_drive(mate) == 0) {
 		if ((mateid[ATA_ID_FIELD_VALID] & 4) &&
