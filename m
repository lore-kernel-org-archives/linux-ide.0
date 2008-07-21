From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] ide: remove stale comments from drivers/ide/Makefile
Date: Mon, 21 Jul 2008 21:09:53 +0200
Message-ID: <200807212109.53577.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.171]:33275 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755058AbYGUTNi (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 21 Jul 2008 15:13:38 -0400
Received: by ug-out-1314.google.com with SMTP id h2so297351ugf.16
        for <linux-ide@vger.kernel.org>; Mon, 21 Jul 2008 12:13:36 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/Makefile |    9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

Index: b/drivers/ide/Makefile
===================================================================
--- a/drivers/ide/Makefile
+++ b/drivers/ide/Makefile
@@ -1,13 +1,6 @@
 #
-# Makefile for the kernel ata, atapi, and ide block device drivers.
-#
-# 12 September 2000, Bartlomiej Zolnierkiewicz <bkz@linux-ide.org>
-# Rewritten to use lists instead of if-statements.
-#
-# Note : at this point, these files are compiled on all systems.
-# In the future, some of these should be built conditionally.
-#
 # link order is important here
+#
 
 EXTRA_CFLAGS				+= -Idrivers/ide
 
