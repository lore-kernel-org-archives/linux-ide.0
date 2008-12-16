From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 8/9] ide: unexport ide_wait_not_busy()
Date: Tue, 16 Dec 2008 20:32:23 +0100
Message-ID: <20081216193223.3959.31780.sendpatchset@localhost.localdomain>
References: <20081216193137.3959.70339.sendpatchset@localhost.localdomain>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bw0-f21.google.com ([209.85.218.21]:33945 "EHLO
	mail-bw0-f21.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758019AbYLPTcc (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 16 Dec 2008 14:32:32 -0500
Received: by mail-bw0-f21.google.com with SMTP id 14so4417970bwz.13
        for <linux-ide@vger.kernel.org>; Tue, 16 Dec 2008 11:32:31 -0800 (PST)
In-Reply-To: <20081216193137.3959.70339.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] ide: unexport ide_wait_not_busy()

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-iops.c |    3 ---
 1 file changed, 3 deletions(-)

Index: b/drivers/ide/ide-iops.c
===================================================================
--- a/drivers/ide/ide-iops.c
+++ b/drivers/ide/ide-iops.c
@@ -1216,6 +1216,3 @@ int ide_wait_not_busy(ide_hwif_t *hwif, 
 	}
 	return -EBUSY;
 }
-
-EXPORT_SYMBOL_GPL(ide_wait_not_busy);
-
