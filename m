From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Subject: [PATCH] obsolete asm/hdreg.h [1/5]
Date: Thu, 8 Apr 2004 00:22:04 +0200
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <200404080022.04693.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
Content-Disposition: inline
To: linux-kernel@vger.kernel.org
Cc: linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org


[IDE] asm-arm26/hdreg.h: use unsigned long for ide_ioreg_t

 linux-2.6.5-root/include/asm-arm26/hdreg.h |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -puN include/asm-arm26/hdreg.h~arm26_ide_ioreg_t include/asm-arm26/hdreg.h
--- linux-2.6.5/include/asm-arm26/hdreg.h~arm26_ide_ioreg_t	2004-04-06 00:23:04.039180016 +0200
+++ linux-2.6.5-root/include/asm-arm26/hdreg.h	2004-04-06 00:23:16.078349784 +0200
@@ -9,7 +9,7 @@
 #ifndef __ASMARM_HDREG_H
 #define __ASMARM_HDREG_H
 
-typedef unsigned int ide_ioreg_t;
+typedef unsigned long ide_ioreg_t;
 
 #endif /* __ASMARM_HDREG_H */
 

_
