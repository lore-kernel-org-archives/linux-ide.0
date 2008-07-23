From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 7/7] include/linux/hdreg.h: cover WIN_* and friends with #ifndef/#endif __KERNEL__
Date: Wed, 23 Jul 2008 20:46:08 +0200
Message-ID: <200807232046.08991.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.153]:1624 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754646AbYGWSu1 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 23 Jul 2008 14:50:27 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1201286fgg.17
        for <linux-ide@vger.kernel.org>; Wed, 23 Jul 2008 11:50:26 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 include/linux/hdreg.h |    2 ++
 1 file changed, 2 insertions(+)

Index: b/include/linux/hdreg.h
===================================================================
--- a/include/linux/hdreg.h
+++ b/include/linux/hdreg.h
@@ -191,6 +191,7 @@ typedef struct hd_drive_hob_hdr {
 #define TASKFILE_INVALID		0x7fff
 #endif
 
+#ifndef __KERNEL__
 /* ATA/ATAPI Commands pre T13 Spec */
 #define WIN_NOP				0x00
 /*
@@ -379,6 +380,7 @@ typedef struct hd_drive_hob_hdr {
 #define SECURITY_ERASE_UNIT		0xBD
 #define SECURITY_FREEZE_LOCK		0xBE
 #define SECURITY_DISABLE_PASSWORD	0xBF
+#endif /* __KERNEL__ */
 
 struct hd_geometry {
       unsigned char heads;
