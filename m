From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 03/18] ide-floppy: use alloc_disk_node()
Date: Mon, 08 Sep 2008 00:14:44 +0200
Message-ID: <20080907221444.24285.64157.sendpatchset@localhost.localdomain>
References: <20080907221424.24285.81137.sendpatchset@localhost.localdomain>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mu-out-0910.google.com ([209.85.134.187]:25685 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755287AbYIGWQw (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 7 Sep 2008 18:16:52 -0400
Received: by mu-out-0910.google.com with SMTP id g7so1100873muf.1
        for <linux-ide@vger.kernel.org>; Sun, 07 Sep 2008 15:16:51 -0700 (PDT)
In-Reply-To: <20080907221424.24285.81137.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Borislav Petkov <petkovbb@gmail.com>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org

Cc: Borislav Petkov <petkovbb@gmail.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-floppy.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: b/drivers/ide/ide-floppy.c
===================================================================
--- a/drivers/ide/ide-floppy.c
+++ b/drivers/ide/ide-floppy.c
@@ -788,7 +788,7 @@ static int ide_floppy_probe(ide_drive_t 
 		goto failed;
 	}
 
-	g = alloc_disk(1 << PARTN_BITS);
+	g = alloc_disk_node(1 << PARTN_BITS, hwif_to_node(drive->hwif));
 	if (!g)
 		goto out_free_floppy;
 
