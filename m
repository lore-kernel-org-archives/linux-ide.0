From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 2/10] ide-generic: fix ide_default_io_base() for m32r
Date: Mon, 7 Jul 2008 23:52:59 +0200
Message-ID: <200807072352.59495.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from yw-out-2324.google.com ([74.125.46.31]:9169 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758205AbYGGWAv (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 7 Jul 2008 18:00:51 -0400
Received: by yw-out-2324.google.com with SMTP id 9so1051968ywe.1
        for <linux-ide@vger.kernel.org>; Mon, 07 Jul 2008 15:00:46 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Hirokazu Takata <takata@linux-m32r.org>

Fix ide_default_io_base() to match ide_default_irq().

Cc: Hirokazu Takata <takata@linux-m32r.org>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 include/asm-m32r/ide.h |    8 ++++++++
 1 file changed, 8 insertions(+)

Index: b/include/asm-m32r/ide.h
===================================================================
--- a/include/asm-m32r/ide.h
+++ b/include/asm-m32r/ide.h
@@ -52,12 +52,20 @@ static __inline__ int ide_default_irq(un
 static __inline__ unsigned long ide_default_io_base(int index)
 {
 	switch (index) {
+#if defined(CONFIG_PLAT_M32700UT) || defined(CONFIG_PLAT_MAPPI2) \
+	|| defined(CONFIG_PLAT_OPSPUT)
+		case 0:	return 0x1f0;
+#elif defined(CONFIG_PLAT_MAPPI3)
+		case 0:	return 0x1f0;
+		case 1:	return 0x170;
+#else
 		case 0:	return 0x1f0;
 		case 1:	return 0x170;
 		case 2: return 0x1e8;
 		case 3: return 0x168;
 		case 4: return 0x1e0;
 		case 5: return 0x160;
+#endif
 		default:
 			return 0;
 	}
