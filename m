From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 01/22] ide: remove redundant hwif->present check from ide_register_hw()
Date: Thu, 17 Jan 2008 00:26:03 +0100
Message-ID: <20080116232603.9166.96455.sendpatchset@localhost.localdomain>
References: <20080116232556.9166.13457.sendpatchset@localhost.localdomain>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.174]:10411 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750898AbYAPXNX (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 16 Jan 2008 18:13:23 -0500
Received: by ug-out-1314.google.com with SMTP id z38so275985ugc.16
        for <linux-ide@vger.kernel.org>; Wed, 16 Jan 2008 15:13:22 -0800 (PST)
In-Reply-To: <20080116232556.9166.13457.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org

We check earlier for hwif->present and call ide_unregister() if necessary
(after ide_unregister() hwif->present will be always cleared).

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide.c |    2 --
 1 file changed, 2 deletions(-)

Index: b/drivers/ide/ide.c
===================================================================
--- a/drivers/ide/ide.c
+++ b/drivers/ide/ide.c
@@ -720,8 +720,6 @@ found:
 		ide_init_port_data(hwif, index);
 		init_hwif_default(hwif, index);
 	}
-	if (hwif->present)
-		return -1;
 
 	ide_init_port_hw(hwif, hw);
 	hwif->quirkproc = quirkproc;
