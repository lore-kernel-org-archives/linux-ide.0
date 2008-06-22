From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 1/4] ide-generic: probing fix
Date: Sun, 22 Jun 2008 21:35:37 +0200
Message-ID: <20080622193537.5325.43764.sendpatchset@localhost.localdomain>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.237]:40226 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757359AbYFVTdl (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 22 Jun 2008 15:33:41 -0400
Received: by rv-out-0506.google.com with SMTP id k40so6648229rvb.1
        for <linux-ide@vger.kernel.org>; Sun, 22 Jun 2008 12:33:41 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org

* Don't skip probing IDE port if the corresponding ide_hwifs[] slot
  is already occupied.

* Remove duplicate idx[i] assignment.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-generic.c |    8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

Index: b/drivers/ide/ide-generic.c
===================================================================
--- a/drivers/ide/ide-generic.c
+++ b/drivers/ide/ide-generic.c
@@ -118,15 +118,9 @@ static int __init ide_generic_init(void)
 				continue;
 			}
 
-			/*
-			 * Skip probing if the corresponding
-			 * slot is already occupied.
-			 */
 			hwif = ide_find_port();
-			if (hwif == NULL || hwif->index != i) {
-				idx[i] = 0xff;
+			if (hwif == NULL)
 				continue;
-			}
 
 			hwif->chipset = ide_generic;
 
