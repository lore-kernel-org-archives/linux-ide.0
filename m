From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Subject: Re: [PATCH] remove ide_dma_{good,bad}_drive from ide_hwif_t
Date: Mon, 9 Feb 2004 20:11:29 +0100
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <200402092011.29742.bzolnier@elka.pw.edu.pl>
References: <200402091551.44365.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
In-Reply-To: <200402091551.44365.bzolnier@elka.pw.edu.pl>
Content-Disposition: inline
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Monday 09 of February 2004 15:51, Bartlomiej Zolnierkiewicz wrote:
> Use __ide_dma_{good,bad}_drive() directly and remove these wrappers.

I somehow managed to miss cs5530.c, sc1200.c and triflex.c, trivial fix below.

diff -puN drivers/ide/pci/cs5530.c~ide_dma_good_bad_cleanup drivers/ide/pci/cs5530.c
--- linux-2.6.3-rc1-bk1/drivers/ide/pci/cs5530.c~ide_dma_good_bad_cleanup	2004-02-09 20:01:50.699759520 +0100
+++ linux-2.6.3-rc1-bk1-root/drivers/ide/pci/cs5530.c	2004-02-09 20:02:14.319168824 +0100
@@ -180,7 +180,7 @@ static int cs5530_config_dma (ide_drive_
 	if (mate->present) {
 		struct hd_driveid *mateid = mate->id;
 		if (mateid && (mateid->capability & 1) &&
-		    !hwif->ide_dma_bad_drive(mate)) {
+		    !__ide_dma_bad_drive(mate)) {
 			if ((mateid->field_valid & 4) &&
 			    (mateid->dma_ultra & 7))
 				udma_ok = 1;
@@ -197,7 +197,7 @@ static int cs5530_config_dma (ide_drive_
 	 * selecting UDMA only if the mate said it was ok.
 	 */
 	if (id && (id->capability & 1) && drive->autodma &&
-	    !hwif->ide_dma_bad_drive(drive)) {
+	    !__ide_dma_bad_drive(drive)) {
 		if (udma_ok && (id->field_valid & 4) && (id->dma_ultra & 7)) {
 			if      (id->dma_ultra & 4)
 				mode = XFER_UDMA_2;
diff -puN drivers/ide/pci/sc1200.c~ide_dma_good_bad_cleanup drivers/ide/pci/sc1200.c
--- linux-2.6.3-rc1-bk1/drivers/ide/pci/sc1200.c~ide_dma_good_bad_cleanup	2004-02-09 20:01:47.018319184 +0100
+++ linux-2.6.3-rc1-bk1-root/drivers/ide/pci/sc1200.c	2004-02-09 20:02:38.985418984 +0100
@@ -164,7 +164,7 @@ static int sc1200_autoselect_dma_mode (i
 	 */
 	if (mate->present) {
 		struct hd_driveid *mateid = mate->id;
-		if (mateid && (mateid->capability & 1) && !hwif->ide_dma_bad_drive(mate)) {
+		if (mateid && (mateid->capability & 1) && !__ide_dma_bad_drive(mate)) {
 			if ((mateid->field_valid & 4) && (mateid->dma_ultra & 7))
 				udma_ok = 1;
 			else if ((mateid->field_valid & 2) && (mateid->dma_mword & 7))
@@ -177,7 +177,7 @@ static int sc1200_autoselect_dma_mode (i
 	 * Now see what the current drive is capable of,
 	 * selecting UDMA only if the mate said it was ok.
 	 */
-	if (id && (id->capability & 1) && hwif->autodma && !hwif->ide_dma_bad_drive(drive)) {
+	if (id && (id->capability & 1) && hwif->autodma && !__ide_dma_bad_drive(drive)) {
 		if (udma_ok && (id->field_valid & 4) && (id->dma_ultra & 7)) {
 			if      (id->dma_ultra & 4)
 				mode = XFER_UDMA_2;
@@ -493,7 +493,7 @@ printk("%s: SC1200: resume\n", hwif->nam
 		//
 		for (d = 0; d < MAX_DRIVES; ++d) {
 			ide_drive_t *drive = &(hwif->drives[d]);
-			if (drive->present && !hwif->ide_dma_bad_drive(drive)) {
+			if (drive->present && !__ide_dma_bad_drive(drive)) {
 				int was_using_dma = drive->using_dma;
 				hwif->ide_dma_off_quietly(drive);
 				sc1200_config_dma(drive);
diff -puN drivers/ide/pci/triflex.c~ide_dma_good_bad_cleanup drivers/ide/pci/triflex.c
--- linux-2.6.3-rc1-bk1/drivers/ide/pci/triflex.c~ide_dma_good_bad_cleanup	2004-02-09 20:01:26.641416944 +0100
+++ linux-2.6.3-rc1-bk1-root/drivers/ide/pci/triflex.c	2004-02-09 20:01:38.007689008 +0100
@@ -173,7 +173,7 @@ static int triflex_config_drive_xfer_rat
 	struct hd_driveid *id	= drive->id;
 	
 	if (id && (id->capability & 1) && drive->autodma) {
-		if (hwif->ide_dma_bad_drive(drive))
+		if (__ide_dma_bad_drive(drive))
 			goto tune_pio;
 		if (id->field_valid & 2) {
 			if ((id->dma_mword & hwif->mwdma_mask) ||
