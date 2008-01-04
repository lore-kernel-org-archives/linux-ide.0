From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 1/2] ide: don't include <linux/hdsmart.h>
Date: Fri, 4 Jan 2008 21:52:11 +0100
Message-ID: <200801042152.11312.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.172]:2020 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752949AbYADUls (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 4 Jan 2008 15:41:48 -0500
Received: by ug-out-1314.google.com with SMTP id z38so2830996ugc.16
        for <linux-ide@vger.kernel.org>; Fri, 04 Jan 2008 12:41:45 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org


IDE doesn't need it.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 include/linux/ide.h |    1 -
 1 file changed, 1 deletion(-)

Index: b/include/linux/ide.h
===================================================================
--- a/include/linux/ide.h
+++ b/include/linux/ide.h
@@ -9,7 +9,6 @@
 #include <linux/init.h>
 #include <linux/ioport.h>
 #include <linux/hdreg.h>
-#include <linux/hdsmart.h>
 #include <linux/blkdev.h>
 #include <linux/proc_fs.h>
 #include <linux/interrupt.h>
