From: Kirill Smelkov <kirr@mns.spb.ru>
Subject: [PATCH] ide: fix revision comparison in ide_in_drive_list
Date: Tue, 20 Jun 2006 14:52:31 +0400
Message-ID: <200606201452.33925.kirr@mns.spb.ru>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.mnsspb.ru ([84.204.75.2]:47490 "EHLO mail.mnsspb.ru")
	by vger.kernel.org with ESMTP id S932574AbWFTKww (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 20 Jun 2006 06:52:52 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrew Morton <akpm@osdl.org>, B.Zolnierkiewicz@elka.pw.edu.pl
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

NB: bart/ide-2.6.git seems to be unmaintained,  so I'm sending this directly to -mm

Fix ide_in_drive_list:  drive_table->id_firmware should be searched *in* id->fw_rev,
not vise versa.

Signed-off-by: Kirill Smelkov <kirr@mns.spb.ru>

Index: linux-2.6.17/drivers/ide/ide-dma.c
===================================================================
--- linux-2.6.17.orig/drivers/ide/ide-dma.c	2006-06-20 13:51:49.000000000 +0400
+++ linux-2.6.17/drivers/ide/ide-dma.c	2006-06-20 13:52:14.000000000 +0400
@@ -147,7 +147,7 @@
 {
 	for ( ; drive_table->id_model ; drive_table++)
 		if ((!strcmp(drive_table->id_model, id->model)) &&
-		    ((strstr(drive_table->id_firmware, id->fw_rev)) ||
+		    ((strstr(id->fw_rev, drive_table->id_firmware)) ||
 		     (!strcmp(drive_table->id_firmware, "ALL"))))
 			return 1;
 	return 0;

