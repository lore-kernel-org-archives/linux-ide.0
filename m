From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] de: drivers/ide/ide-atapi.c needs <linux/scatterlist.h>
Date: Sun, 29 Mar 2009 22:33:03 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0903292229400.23398@anakin>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1757455AbZC2Ud1@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, Linux Kernel Development <linux-kernel@vger.kernel.org>
List-Id: linux-ide@vger.kernel.org

On m68k:
| drivers/ide/ide-atapi.c: In function 'ide_io_buffers':
| drivers/ide/ide-atapi.c:87: error: implicit declaration of function 'sg_page'
| drivers/ide/ide-atapi.c:87: warning: passing argument 1 of 'PageHighMem' makes pointer from integer without a cast
| drivers/ide/ide-atapi.c:91: warning: passing argument 1 of 'kmap_atomic' makes pointer from integer without a cast
| drivers/ide/ide-atapi.c:96: error: implicit declaration of function 'sg_virt'
| drivers/ide/ide-atapi.c:96: warning: assignment makes pointer from integer without a cast
| drivers/ide/ide-atapi.c:107: error: implicit declaration of function 'sg_next'
| drivers/ide/ide-atapi.c:107: warning: assignment makes pointer from integer without a cast

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
No idea where it got introduced. 2.6.29 was fine.

 drivers/ide/ide-atapi.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/ide/ide-atapi.c b/drivers/ide/ide-atapi.c
index 6adc5b4..445d157 100644
--- a/drivers/ide/ide-atapi.c
+++ b/drivers/ide/ide-atapi.c
@@ -6,6 +6,8 @@
 #include <linux/cdrom.h>
 #include <linux/delay.h>
 #include <linux/ide.h>
+#include <linux/scatterlist.h>
+
 #include <scsi/scsi.h>
 
 #ifdef DEBUG
-- 
1.6.2.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
