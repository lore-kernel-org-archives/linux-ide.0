From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 4/6] ide: struct ide_atapi_pc - remove unused fields and update documentation
Date: Mon, 29 Dec 2008 20:04:35 +0100
Message-ID: <20081229190435.1020.45092.sendpatchset@localhost.localdomain>
References: <20081229190415.1020.43119.sendpatchset@localhost.localdomain>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bw0-f21.google.com ([209.85.218.21]:54079 "EHLO
	mail-bw0-f21.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753155AbYL2TEP (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 29 Dec 2008 14:04:15 -0500
In-Reply-To: <20081229190415.1020.43119.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] ide: struct ide_atapi_pc - remove unused fields and update documentation

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 include/linux/ide.h |    4 ----
 1 file changed, 4 deletions(-)

Index: b/include/linux/ide.h
===================================================================
--- a/include/linux/ide.h
+++ b/include/linux/ide.h
@@ -426,13 +426,9 @@ struct ide_atapi_pc {
 	struct idetape_bh *bh;
 	char *b_data;
 
-	/* idescsi only for now */
 	struct scatterlist *sg;
 	unsigned int sg_cnt;
 
-	struct scsi_cmnd *scsi_cmd;
-	void (*done) (struct scsi_cmnd *);
-
 	unsigned long timeout;
 };
 
