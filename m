From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 7/10] ide-generic: remove broken PPC_PREP support
Date: Mon, 7 Jul 2008 23:55:27 +0200
Message-ID: <200807072355.27868.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from yw-out-2324.google.com ([74.125.46.31]:9170 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758659AbYGGWAz (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 7 Jul 2008 18:00:55 -0400
Received: by yw-out-2324.google.com with SMTP id 9so1051974ywe.1
        for <linux-ide@vger.kernel.org>; Mon, 07 Jul 2008 15:00:54 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>

PPC_PREP has been depending on BROKEN for some time now.

Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 include/asm-powerpc/ide.h |   18 ------------------
 1 file changed, 18 deletions(-)

Index: b/include/asm-powerpc/ide.h
===================================================================
--- a/include/asm-powerpc/ide.h
+++ b/include/asm-powerpc/ide.h
@@ -32,16 +32,6 @@ static __inline__ int ide_default_irq(un
 	case 0x170:	return 15;
 	}
 #endif
-#ifdef CONFIG_PPC_PREP
-	switch (base) {
-	case 0x1f0:	return 13;
-	case 0x170:	return 13;
-	case 0x1e8:	return 11;
-	case 0x168:	return 10;
-	case 0xfff0:	return 14;	/* MCP(N)750 ide0 */
-	case 0xffe0:	return 15;	/* MCP(N)750 ide1 */
-	}
-#endif
 	return 0;
 }
 
@@ -54,14 +44,6 @@ static __inline__ unsigned long ide_defa
 	case 1:		return 0x170;
 	}
 #endif
-#ifdef CONFIG_PPC_PREP
-	switch (index) {
-	case 0:		return 0x1f0;
-	case 1:		return 0x170;
-	case 2:		return 0x1e8;
-	case 3:		return 0x168;
-	}
-#endif
 	return 0;
 }
 
