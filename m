From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 4/18] ide: move ide_fixstring() documentation to ide-iops.c from ide.h
Date: Mon, 5 Nov 2007 00:18:56 +0100
Message-ID: <200711050018.56731.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.187]:52113 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754127AbXKDX3f (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 4 Nov 2007 18:29:35 -0500
Received: by nf-out-0910.google.com with SMTP id g13so1219894nfb
        for <linux-ide@vger.kernel.org>; Sun, 04 Nov 2007 15:29:34 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-iops.c |    7 +++++++
 include/linux/ide.h    |    9 +--------
 2 files changed, 8 insertions(+), 8 deletions(-)

Index: b/drivers/ide/ide-iops.c
===================================================================
--- a/drivers/ide/ide-iops.c
+++ b/drivers/ide/ide-iops.c
@@ -389,6 +389,13 @@ void ide_fix_driveid (struct hd_driveid 
 #endif
 }
 
+/*
+ * ide_fixstring() cleans up and (optionally) byte-swaps a text string,
+ * removing leading/trailing blanks and compressing internal blanks.
+ * It is primarily used to tidy up the model name/number fields as
+ * returned by the WIN_[P]IDENTIFY commands.
+ */
+
 void ide_fixstring (u8 *s, const int bytecount, const int byteswap)
 {
 	u8 *p = s, *end = &s[bytecount & ~1]; /* bytecount must be even */
Index: b/include/linux/ide.h
===================================================================
--- a/include/linux/ide.h
+++ b/include/linux/ide.h
@@ -851,14 +851,7 @@ ide_startstop_t __ide_abort(ide_drive_t 
 extern ide_startstop_t ide_abort(ide_drive_t *, const char *);
 
 extern void ide_fix_driveid(struct hd_driveid *);
-/*
- * ide_fixstring() cleans up and (optionally) byte-swaps a text string,
- * removing leading/trailing blanks and compressing internal blanks.
- * It is primarily used to tidy up the model name/number fields as
- * returned by the WIN_[P]IDENTIFY commands.
- *
- * (s, bytecount, byteswap)
- */
+
 extern void ide_fixstring(u8 *, const int, const int);
 
 int ide_wait_stat(ide_startstop_t *, ide_drive_t *, u8, u8, unsigned long);
