From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 02/22] ide: remove redundant init_hwif_default() call from ide_register_hw()
Date: Thu, 17 Jan 2008 00:26:10 +0100
Message-ID: <20080116232610.9166.8941.sendpatchset@localhost.localdomain>
References: <20080116232556.9166.13457.sendpatchset@localhost.localdomain>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.175]:10937 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753380AbYAPXNa (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 16 Jan 2008 18:13:30 -0500
Received: by ug-out-1314.google.com with SMTP id z38so275986ugc.16
        for <linux-ide@vger.kernel.org>; Wed, 16 Jan 2008 15:13:29 -0800 (PST)
In-Reply-To: <20080116232556.9166.13457.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org

ide_init_port_hw() call overrides setup done by init_hwif_default().

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

Index: b/drivers/ide/ide.c
===================================================================
--- a/drivers/ide/ide.c
+++ b/drivers/ide/ide.c
@@ -716,10 +716,8 @@ int ide_register_hw(hw_regs_t *hw, void 
 found:
 	if (hwif->present)
 		ide_unregister(index);
-	else if (!hwif->hold) {
+	else if (!hwif->hold)
 		ide_init_port_data(hwif, index);
-		init_hwif_default(hwif, index);
-	}
 
 	ide_init_port_hw(hwif, hw);
 	hwif->quirkproc = quirkproc;
