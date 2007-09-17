From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [git patches] IDE fixes
Date: Mon, 17 Sep 2007 12:38:50 +0200
Message-ID: <200709171238.50304.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.191]:27223 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752633AbXIQLHB (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 17 Sep 2007 07:07:01 -0400
Received: by nf-out-0910.google.com with SMTP id g13so1117545nfb
        for <linux-ide@vger.kernel.org>; Mon, 17 Sep 2007 04:07:01 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org


Please pull from:

master.kernel.org:/pub/scm/linux/kernel/git/bart/ide-2.6.git/

to receive the following updates:

 drivers/ide/ide-disk.c |    1 +
 drivers/ide/ppc/pmac.c |    2 --
 2 files changed, 1 insertions(+), 2 deletions(-)


Jorge Juan Chico (1):
      ide: ST320413A has the same problem as ST340823A

Stephen Rothwell (1):
      ide: remove unused variables from drivers/ide/ppc/pmac.c


diff --git a/drivers/ide/ide-disk.c b/drivers/ide/ide-disk.c
index eba1adb..4754769 100644
--- a/drivers/ide/ide-disk.c
+++ b/drivers/ide/ide-disk.c
@@ -487,6 +487,7 @@ static inline int idedisk_supports_lba48(const struct hd_driveid *id)
  */
 static const struct drive_list_entry hpa_list[] = {
 	{ "ST340823A",	NULL },
+	{ "ST320413A",	NULL },
 	{ NULL,		NULL }
 };
 
diff --git a/drivers/ide/ppc/pmac.c b/drivers/ide/ppc/pmac.c
index 4b13cd9..f19eb6d 100644
--- a/drivers/ide/ppc/pmac.c
+++ b/drivers/ide/ppc/pmac.c
@@ -1802,9 +1802,7 @@ pmac_ide_dma_check(ide_drive_t *drive)
 {
 	struct hd_driveid *id = drive->id;
 	ide_hwif_t *hwif = HWIF(drive);
-	pmac_ide_hwif_t* pmif = (pmac_ide_hwif_t *)hwif->hwif_data;
 	int enable = 1;
-	int map;
 	drive->using_dma = 0;
 	
 	if (drive->media == ide_floppy)
