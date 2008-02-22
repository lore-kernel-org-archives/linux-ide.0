From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] ide: remove redundant comment from ide_unregister()
Date: Fri, 22 Feb 2008 23:57:07 +0100
Message-ID: <200802222357.07781.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.169]:49465 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758238AbYBVWpI (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 22 Feb 2008 17:45:08 -0500
Received: by ug-out-1314.google.com with SMTP id z38so8545ugc.16
        for <linux-ide@vger.kernel.org>; Fri, 22 Feb 2008 14:45:07 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

Identical comment is present in ide_hwif_release_regions() documentation.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
goes after "hpt366: fix section mismatch warnings" patch in IDE quilt tree

 drivers/ide/ide.c |    5 -----
 1 file changed, 5 deletions(-)

Index: b/drivers/ide/ide.c
===================================================================
--- a/drivers/ide/ide.c
+++ b/drivers/ide/ide.c
@@ -590,11 +590,6 @@ void ide_unregister(unsigned int index, 
 		hwif->extra_ports = 0;
 	}
 
-	/*
-	 * Note that we only release the standard ports,
-	 * and do not even try to handle any extra ports
-	 * allocated for weird IDE interface chipsets.
-	 */
 	ide_hwif_release_regions(hwif);
 
 	/* copy original settings */
