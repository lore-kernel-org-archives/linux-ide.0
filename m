From: "Adam J. Richter" <adam@yggdrasil.com>
Subject: [Trivial patch] include <asm/types.h> in <linux/ata.h>
Date: Sun, 7 Nov 2004 13:30:27 -0800
Message-ID: <200411072130.iA7LURb27362@freya.yggdrasil.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from [61.48.52.243] ([61.48.52.243]:20967 "EHLO freya.yggdrasil.com")
	by vger.kernel.org with ESMTP id S261538AbUKGFgA (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 7 Nov 2004 00:36:00 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: linux-ide@vger.kernel.org

	linux-2.6.10-rc1-bk16 has a new compilation error not
present in -bk15.  The problem comes from include/linux/ata.h
using u8, u32, etc. without #include'ing <asm/types.h> to
define all types.

	I believe that having almost all #include files pull in
their own dependencies minimizes changes that are needed to
other files as those dependencies change, making more efficient
use of developers' time when they use these header files and
allowing #include lists in source files to include just what
is referenced directly.  I think the trade-off of some getting
away with not #include'ing some headers that they directly use
(because they are pulled in by other headers) worth it, in that,
at least this way, the header lists are shorter, making problems
easier to spot.

	Also, is there some reason that ata_taskfile.flags
is unsigned long, instead of u32?

                    __     ______________ 
Adam J. Richter        \ /
adam@yggdrasil.com      | g g d r a s i l

--- linux-2.6.10-rc1-bk16/include/linux/ata.h	2004-11-07 10:58:00.000000000 -0800
+++ linux/include/linux/ata.h	2004-11-07 13:16:41.000000000 -0800
@@ -24,6 +24,8 @@
 #ifndef __LINUX_ATA_H__
 #define __LINUX_ATA_H__
 
+#include <asm/types.h>
+
 /* defines only for the constants which don't work well as enums */
 #define ATA_DMA_BOUNDARY	0xffffUL
 #define ATA_DMA_MASK		0xffffffffULL
