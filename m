From: Jeff Garzik <jgarzik@pobox.com>
Subject: [BK PATCHES] 2.6.x ATA build fix
Date: Sat, 6 Nov 2004 15:25:14 -0500
Message-ID: <20041106202514.GA5788@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from havoc.gtf.org ([69.28.190.101]:20411 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S261462AbUKFUZX (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 6 Nov 2004 15:25:23 -0500
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: linux-ide@vger.kernel.org


Mainly a build fix from Meelios(sp?).

Please do a

	bk pull bk://gkernel.bkbits.net/libata-2.6

This will update the following files:

 include/linux/ata.h |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

through these ChangeSets:

<jgarzik@pobox.com> (04/11/06 1.2473)
   Remove silly comment from linux/ata.h.
   
   XFER_xxx is not necessarily "legacy IDE 'stuff'"

<mroos@linux.ee> (04/11/06 1.2472)
   [PATCH] ata.h undefined types in USB
   
   This is todays BK on a x86:
   
     CC [M]  drivers/usb/storage/freecom.o
   In file included from include/linux/hdreg.h:4,
                    from drivers/usb/storage/freecom.c:32:
   include/linux/ata.h:197: error: parse error before "u32"
   ...
   and so on for tens of lines.
   
   Signed-off-by: Jeff Garzik <jgarzik@pobox.com>

diff -Nru a/include/linux/ata.h b/include/linux/ata.h
--- a/include/linux/ata.h	2004-11-06 14:17:52 -05:00
+++ b/include/linux/ata.h	2004-11-06 14:17:52 -05:00
@@ -24,6 +24,8 @@
 #ifndef __LINUX_ATA_H__
 #define __LINUX_ATA_H__
 
+#include <linux/types.h>
+
 /* defines only for the constants which don't work well as enums */
 #define ATA_DMA_BOUNDARY	0xffffUL
 #define ATA_DMA_MASK		0xffffffffULL
@@ -140,8 +142,6 @@
 	XFER_PIO_2		= 0x0A,
 	XFER_PIO_1		= 0x09,
 	XFER_PIO_0		= 0x08,
-
-	/* legacy IDE 'stuff' */
 	XFER_SW_DMA_2		= 0x12,
 	XFER_SW_DMA_1		= 0x11,
 	XFER_SW_DMA_0		= 0x10,
