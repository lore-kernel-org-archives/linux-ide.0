From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] falconide: locking bugfix
Date: Sun, 17 Feb 2008 17:22:05 +0100
Message-ID: <200802171722.05804.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.185]:24874 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752278AbYBQQ3d (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 17 Feb 2008 11:29:33 -0500
Received: by fk-out-0910.google.com with SMTP id z23so1389091fkz.5
        for <linux-ide@vger.kernel.org>; Sun, 17 Feb 2008 08:29:31 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-ide@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>, Michael Schmitz <schmitz@debian.org>


commit 8ac4ce742c66100931b6f2d7a36b0df08bc721fe ("ide: fix host drivers
depending on ide_generic to probe for interfaces (take 2)") moved probing
to falconide but forgot to take care of Atari specific locking - fix it.

Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Michael Schmitz <schmitz@debian.org>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-generic.c      |    6 ------
 drivers/ide/legacy/falconide.c |    2 ++
 2 files changed, 2 insertions(+), 6 deletions(-)

Index: b/drivers/ide/ide-generic.c
===================================================================
--- a/drivers/ide/ide-generic.c
+++ b/drivers/ide/ide-generic.c
@@ -17,9 +17,6 @@ static int __init ide_generic_init(void)
 	u8 idx[MAX_HWIFS];
 	int i;
 
-	if (ide_hwifs[0].io_ports[IDE_DATA_OFFSET])
-		ide_get_lock(NULL, NULL); /* for atari only */
-
 	for (i = 0; i < MAX_HWIFS; i++) {
 		ide_hwif_t *hwif = &ide_hwifs[i];
 
@@ -31,9 +28,6 @@ static int __init ide_generic_init(void)
 
 	ide_device_add_all(idx, NULL);
 
-	if (ide_hwifs[0].io_ports[IDE_DATA_OFFSET])
-		ide_release_lock();	/* for atari only */
-
 	return 0;
 }
 
Index: b/drivers/ide/legacy/falconide.c
===================================================================
--- a/drivers/ide/legacy/falconide.c
+++ b/drivers/ide/legacy/falconide.c
@@ -84,7 +84,9 @@ static int __init falconide_init(void)
 		ide_init_port_data(hwif, index);
 		ide_init_port_hw(hwif, &hw);
 
+		ide_get_lock(NULL, NULL);
 		ide_device_add(idx, NULL);
+		ide_release_lock();
 	}
 
 	return 0;
