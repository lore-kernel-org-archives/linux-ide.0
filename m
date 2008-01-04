From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 8/15] ide: I/O resources are released too early in ide_unregister()
Date: Fri, 04 Jan 2008 22:25:24 +0100
Message-ID: <20080104212524.6978.64718.sendpatchset@localhost.localdomain>
References: <20080104212424.6978.93646.sendpatchset@localhost.localdomain>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.170]:38027 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754970AbYADVNr (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 4 Jan 2008 16:13:47 -0500
Received: by ug-out-1314.google.com with SMTP id z38so2833654ugc.16
        for <linux-ide@vger.kernel.org>; Fri, 04 Jan 2008 13:13:46 -0800 (PST)
In-Reply-To: <20080104212424.6978.93646.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org

Release I/O resources after releasing DMA.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide.c |   14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

Index: b/drivers/ide/ide.c
===================================================================
--- a/drivers/ide/ide.c
+++ b/drivers/ide/ide.c
@@ -529,13 +529,6 @@ void ide_unregister(unsigned int index)
 
 	spin_lock_irq(&ide_lock);
 	/*
-	 * Note that we only release the standard ports,
-	 * and do not even try to handle any extra ports
-	 * allocated for weird IDE interface chipsets.
-	 */
-	ide_hwif_release_regions(hwif);
-
-	/*
 	 * Remove us from the hwgroup, and free
 	 * the hwgroup if we were the only member
 	 */
@@ -589,6 +582,13 @@ void ide_unregister(unsigned int index)
 		hwif->extra_ports = 0;
 	}
 
+	/*
+	 * Note that we only release the standard ports,
+	 * and do not even try to handle any extra ports
+	 * allocated for weird IDE interface chipsets.
+	 */
+	ide_hwif_release_regions(hwif);
+
 	/* copy original settings */
 	tmp_hwif = *hwif;
 
