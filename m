From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 05/20] ide-cd: remove dead code from cdrom_decode_status()
Date: Mon, 16 Feb 2009 01:13:42 +0100
Message-ID: <20090216001342.27491.2921.sendpatchset@localhost.localdomain>
References: <20090216001309.27491.59759.sendpatchset@localhost.localdomain>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f20.google.com ([209.85.220.20]:51372 "EHLO
	mail-fx0-f20.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755938AbZBPAMQ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 15 Feb 2009 19:12:16 -0500
In-Reply-To: <20090216001309.27491.59759.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Borislav Petkov <petkovbb@gmail.com>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] ide-cd: remove dead code from cdrom_decode_status()

There should be no functional changes caused by this patch.

Cc: Borislav Petkov <petkovbb@gmail.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-cd.c |    6 ------
 1 file changed, 6 deletions(-)

Index: b/drivers/ide/ide-cd.c
===================================================================
--- a/drivers/ide/ide-cd.c
+++ b/drivers/ide/ide-cd.c
@@ -316,12 +316,6 @@ static int cdrom_decode_status(ide_drive
 	err = ide_read_error(drive);
 	sense_key = err >> 4;
 
-	if (rq == NULL) {
-		printk(KERN_ERR PFX "%s: missing rq in %s\n",
-				drive->name, __func__);
-		return 1;
-	}
-
 	ide_debug_log(IDE_DBG_RQ, "stat: 0x%x, good_stat: 0x%x, cmd[0]: 0x%x, "
 				  "rq->cmd_type: 0x%x, err: 0x%x",
 				  stat, good_stat, rq->cmd[0], rq->cmd_type,
