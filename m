From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 09/22] ide: remove incorrect init_gendisk() comment
Date: Thu, 17 Jan 2008 00:27:09 +0100
Message-ID: <20080116232709.9166.21924.sendpatchset@localhost.localdomain>
References: <20080116232556.9166.13457.sendpatchset@localhost.localdomain>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.175]:10937 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752833AbYAPXO3 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 16 Jan 2008 18:14:29 -0500
Received: by ug-out-1314.google.com with SMTP id z38so275986ugc.16
        for <linux-ide@vger.kernel.org>; Wed, 16 Jan 2008 15:14:28 -0800 (PST)
In-Reply-To: <20080116232556.9166.13457.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-probe.c |    6 ------
 1 file changed, 6 deletions(-)

Index: b/drivers/ide/ide-probe.c
===================================================================
--- a/drivers/ide/ide-probe.c
+++ b/drivers/ide/ide-probe.c
@@ -1182,12 +1182,6 @@ static void drive_release_dev (struct de
 	complete(&drive->gendev_rel_comp);
 }
 
-/*
- * init_gendisk() (as opposed to ide_geninit) is called for each major device,
- * after probing for drives, to allocate partition tables and other data
- * structures needed for the routines in genhd.c.  ide_geninit() gets called
- * somewhat later, during the partition check.
- */
 static void init_gendisk (ide_hwif_t *hwif)
 {
 	unsigned int unit;
