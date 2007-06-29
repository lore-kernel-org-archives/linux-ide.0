From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: [PATCH] hpt366: blacklist MAXTOR STM3320620A for UltraDMA/66
Date: Fri, 29 Jun 2007 23:57:17 +0400
Message-ID: <200706292357.17374.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtsoft2.corbina.net ([85.21.88.2]:40064 "HELO
	mail.dev.rtsoft.ru" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
	with SMTP id S1752352AbXF2T73 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 29 Jun 2007 15:59:29 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com, linas@austin.ibm.com
Cc: linux-ide@vger.kernel.org

Add the MAXTOR STM3320620A drive into the UltraDMA/66 mode blacklist
for the HPT36x chips.

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

---
Linas, here's the patch at last -- it should apply atop 2.6.21.5.
Please, make sure it works for you.

 drivers/ide/pci/hpt366.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletion(-)

Index: linux-2.6/drivers/ide/pci/hpt366.c
===================================================================
--- linux-2.6.orig/drivers/ide/pci/hpt366.c
+++ linux-2.6/drivers/ide/pci/hpt366.c
@@ -1,5 +1,5 @@
 /*
- * linux/drivers/ide/pci/hpt366.c		Version 1.04	Jun 4, 2007
+ * linux/drivers/ide/pci/hpt366.c		Version 1.05	Jun 26, 2007
  *
  * Copyright (C) 1999-2003		Andre Hedrick <andre@linux-ide.org>
  * Portions Copyright (C) 2001	        Sun Microsystems, Inc.
@@ -182,6 +182,7 @@ static const char *bad_ata66_4[] = {
 	"IC35L040AVER07-0",
 	"IC35L060AVER07-0",
 	"WDC AC310200R",
+	"MAXTOR STM3320620A",
 	NULL
 };
 

