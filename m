From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 2/15] ide: CPU endianness doesn't matter for special_t
Date: Wed, 31 Oct 2007 00:24:24 +0100
Message-ID: <200710310024.24262.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.190]:45723 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752037AbXJ3XuT (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 30 Oct 2007 19:50:19 -0400
Received: by nf-out-0910.google.com with SMTP id g13so1788117nfb
        for <linux-ide@vger.kernel.org>; Tue, 30 Oct 2007 16:50:17 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


special_t is used only internally by the IDE subsystem (it isn't
related to hardware registers and isn't exported to the user-space).

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 include/linux/ide.h |   11 -----------
 1 file changed, 11 deletions(-)

Index: b/include/linux/ide.h
===================================================================
--- a/include/linux/ide.h
+++ b/include/linux/ide.h
@@ -306,23 +306,12 @@ static inline void ide_init_hwif_ports(h
 typedef union {
 	unsigned all			: 8;
 	struct {
-#if defined(__LITTLE_ENDIAN_BITFIELD)
 		unsigned set_geometry	: 1;
 		unsigned recalibrate	: 1;
 		unsigned set_multmode	: 1;
 		unsigned set_tune	: 1;
 		unsigned serviced	: 1;
 		unsigned reserved	: 3;
-#elif defined(__BIG_ENDIAN_BITFIELD)
-		unsigned reserved	: 3;
-		unsigned serviced	: 1;
-		unsigned set_tune	: 1;
-		unsigned set_multmode	: 1;
-		unsigned recalibrate	: 1;
-		unsigned set_geometry	: 1;
-#else
-#error "Please fix <asm/byteorder.h>"
-#endif
 	} b;
 } special_t;
 
