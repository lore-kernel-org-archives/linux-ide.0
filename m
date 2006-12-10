From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: [PATCH] (2.6.19-rc6-mm2) pdc202xx_*: remove check_in_drive_lists() abomination
Date: Sun, 10 Dec 2006 20:48:48 +0300
Message-ID: <200612102048.48247.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:52123 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1762288AbWLJRrP (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 10 Dec 2006 12:47:15 -0500
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: akpm@osdl.org, bzolnier@gmail.com
Cc: linux-ide@vger.kernel.org, alan@lxorguk.ukuu.org.uk

Fold check_in_drive_lists() into quirkproc() handler in both PDC202xx drivers--
this function was never called with a list other than pdc_quirk_drives and was
a bad example of code overall...

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

 drivers/ide/pci/pdc202xx_new.c |   27 ++++++---------------------
 drivers/ide/pci/pdc202xx_old.c |   27 ++++++---------------------
 2 files changed, 12 insertions(+), 42 deletions(-)

Index: linux-2.6/drivers/ide/pci/pdc202xx_new.c
===================================================================
--- linux-2.6.orig/drivers/ide/pci/pdc202xx_new.c
+++ linux-2.6/drivers/ide/pci/pdc202xx_new.c
@@ -92,26 +92,6 @@ static u8 pdcnew_ratemask(ide_drive_t *d
 	return	mode;
 }
 
-static int check_in_drive_lists(ide_drive_t *drive, const char **list)
-{
-	struct hd_driveid *id = drive->id;
-
-	if (pdc_quirk_drives == list) {
-		while (*list) {
-			if (strstr(id->model, *list++)) {
-				return 2;
-			}
-		}
-	} else {
-		while (*list) {
-			if (!strcmp(*list++,id->model)) {
-				return 1;
-			}
-		}
-	}
-	return 0;
-}
-
 /**
  * get_indexed_reg - Get indexed register
  * @hwif: for the port address
@@ -324,7 +304,12 @@ fast_ata_pio:
 
 static int pdcnew_quirkproc(ide_drive_t *drive)
 {
-	return check_in_drive_lists(drive, pdc_quirk_drives);
+	const char **list, *model = drive->id->model;
+
+	for (list = pdc_quirk_drives; *list != NULL; list++)
+		if (strstr(model, *list) != NULL)
+			return 2;
+	return 0;
 }
 
 static void pdcnew_reset(ide_drive_t *drive)
Index: linux-2.6/drivers/ide/pci/pdc202xx_old.c
===================================================================
--- linux-2.6.orig/drivers/ide/pci/pdc202xx_old.c
+++ linux-2.6/drivers/ide/pci/pdc202xx_old.c
@@ -123,26 +123,6 @@ static u8 pdc202xx_ratemask (ide_drive_t
 	return mode;
 }
 
-static int check_in_drive_lists (ide_drive_t *drive, const char **list)
-{
-	struct hd_driveid *id = drive->id;
-
-	if (pdc_quirk_drives == list) {
-		while (*list) {
-			if (strstr(id->model, *list++)) {
-				return 2;
-			}
-		}
-	} else {
-		while (*list) {
-			if (!strcmp(*list++,id->model)) {
-				return 1;
-			}
-		}
-	}
-	return 0;
-}
-
 static int pdc202xx_tune_chipset (ide_drive_t *drive, u8 xferspeed)
 {
 	ide_hwif_t *hwif	= HWIF(drive);
@@ -377,7 +357,12 @@ fast_ata_pio:
 
 static int pdc202xx_quirkproc (ide_drive_t *drive)
 {
-	return ((int) check_in_drive_lists(drive, pdc_quirk_drives));
+	const char **list, *model = drive->id->model;
+
+	for (list = pdc_quirk_drives; *list != NULL; list++)
+		if (strstr(model, *list) != NULL)
+			return 2;
+	return 0;
 }
 
 static void pdc202xx_old_ide_dma_start(ide_drive_t *drive)

