From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 2/2] <linux/hdsmart.h> is not used by kernel code
Date: Fri, 4 Jan 2008 21:53:02 +0100
Message-ID: <200801042153.02889.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hs-out-0708.google.com ([64.233.178.251]:42300 "EHLO
	hs-out-2122.google.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752748AbYADUls (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 4 Jan 2008 15:41:48 -0500
Received: by hs-out-2122.google.com with SMTP id 54so4455992hsz.5
        for <linux-ide@vger.kernel.org>; Fri, 04 Jan 2008 12:41:47 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org


Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 include/linux/hdsmart.h |    2 ++
 1 file changed, 2 insertions(+)

Index: b/include/linux/hdsmart.h
===================================================================
--- a/include/linux/hdsmart.h
+++ b/include/linux/hdsmart.h
@@ -17,6 +17,7 @@
 #ifndef _LINUX_HDSMART_H
 #define _LINUX_HDSMART_H
 
+#ifndef __KERNEL
 #define OFFLINE_FULL_SCAN		0
 #define SHORT_SELF_TEST			1
 #define EXTEND_SELF_TEST		2
@@ -120,5 +121,6 @@ typedef struct ata_smart_selftestlog_s {
 	unsigned char			resevered[2];
 	unsigned char			chksum;
 } __attribute__ ((packed)) ata_smart_selftestlog_t;
+#endif /* __KERNEL__ *
 
 #endif	/* _LINUX_HDSMART_H */
