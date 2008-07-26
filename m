From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 04/10] ide: remove no longer needed BUG_ON()-s from init_irq()
Date: Sat, 26 Jul 2008 15:40:30 +0200
Message-ID: <20080726134030.10589.69015.sendpatchset@localhost.localdomain>
References: <20080726134010.10589.51679.sendpatchset@localhost.localdomain>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.184]:42093 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755503AbYGZNmf (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 26 Jul 2008 09:42:35 -0400
Received: by fk-out-0910.google.com with SMTP id 18so2728698fkq.5
        for <linux-ide@vger.kernel.org>; Sat, 26 Jul 2008 06:42:34 -0700 (PDT)
In-Reply-To: <20080726134010.10589.51679.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org

init_irq() is now called only during initial host registration
so these BUG_ON()-s are no loner needed (+ the last one was done
too late anyway).

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-probe.c |    5 -----
 1 file changed, 5 deletions(-)

Index: b/drivers/ide/ide-probe.c
===================================================================
--- a/drivers/ide/ide-probe.c
+++ b/drivers/ide/ide-probe.c
@@ -1031,11 +1031,6 @@ static int init_irq (ide_hwif_t *hwif)
 	ide_hwgroup_t *hwgroup;
 	ide_hwif_t *match = NULL;
 
-
-	BUG_ON(in_interrupt());
-	BUG_ON(irqs_disabled());	
-	BUG_ON(hwif == NULL);
-
 	mutex_lock(&ide_cfg_mtx);
 	hwif->hwgroup = NULL;
 #if MAX_HWIFS > 1
