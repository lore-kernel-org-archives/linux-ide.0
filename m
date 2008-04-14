From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: [PATCH] Au1200: IDE driver build fix
Date: Mon, 14 Apr 2008 23:03:04 +0400
Message-ID: <200804142303.04661.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mips-bounce@linux-mips.org>
Content-Disposition: inline
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
To: bzolnier@gmail.com
Cc: linux-ide@vger.kernel.org, linux-mips@linux-mips.org
List-Id: linux-ide@vger.kernel.org

The driver fails to compile with CONFIG_BLK_DEV_IDE_AU1XXX_MDMA2_DBDMA enabled:

drivers/ide/mips/au1xxx-ide.c: In function `auide_build_dmatable':
drivers/ide/mips/au1xxx-ide.c:256: error: implicit declaration of function
`sg_virt'
drivers/ide/mips/au1xxx-ide.c:275: error: implicit declaration of function
`sg_next'
drivers/ide/mips/au1xxx-ide.c:275: warning: assignment makes pointer from
integer without a cast

Fix this by including <linux/scatterlist.h>. While at it, remove the #include's
without which the driver happily builds.

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

 drivers/ide/mips/au1xxx-ide.c |    9 +--------
 1 files changed, 1 insertion(+), 8 deletions(-)

Index: linux-2.6/drivers/ide/mips/au1xxx-ide.c
===================================================================
--- linux-2.6.orig/drivers/ide/mips/au1xxx-ide.c
+++ linux-2.6/drivers/ide/mips/au1xxx-ide.c
@@ -32,19 +32,12 @@
 #include <linux/kernel.h>
 #include <linux/delay.h>
 #include <linux/platform_device.h>
-
 #include <linux/init.h>
 #include <linux/ide.h>
-#include <linux/sysdev.h>
-
-#include <linux/dma-mapping.h>
+#include <linux/scatterlist.h>
 
-#include "ide-timing.h"
-
-#include <asm/io.h>
 #include <asm/mach-au1x00/au1xxx.h>
 #include <asm/mach-au1x00/au1xxx_dbdma.h>
-
 #include <asm/mach-au1x00/au1xxx_ide.h>
 
 #define DRV_NAME	"au1200-ide"
