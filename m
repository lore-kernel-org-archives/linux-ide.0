From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] ide: remove stale comment from ide-lib.c
Date: Mon, 11 Feb 2008 00:24:26 +0100
Message-ID: <200802110024.27229.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.158]:21461 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756289AbYBJXRM (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 10 Feb 2008 18:17:12 -0500
Received: by fg-out-1718.google.com with SMTP id e21so3601133fga.17
        for <linux-ide@vger.kernel.org>; Sun, 10 Feb 2008 15:17:12 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-ide@vger.kernel.org


Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-lib.c |    9 ---------
 1 file changed, 9 deletions(-)

Index: b/drivers/ide/ide-lib.c
===================================================================
--- a/drivers/ide/ide-lib.c
+++ b/drivers/ide/ide-lib.c
@@ -21,15 +21,6 @@
 #include <asm/uaccess.h>
 #include <asm/io.h>
 
-/*
- *	IDE library routines. These are plug in code that most 
- *	drivers can use but occasionally may be weird enough
- *	to want to do their own thing with
- *
- *	Add common non I/O op stuff here. Make sure it has proper
- *	kernel-doc function headers or your patch will be rejected
- */
-
 static const char *udma_str[] =
 	 { "UDMA/16", "UDMA/25",  "UDMA/33",  "UDMA/44",
 	   "UDMA/66", "UDMA/100", "UDMA/133", "UDMA7" };
