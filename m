From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 10/10] sata_inic162x: update intro comment, up the version and drop EXPERIMENTAL
Date: Wed, 30 Apr 2008 16:35:17 +0900
Message-ID: <1209540919119-git-send-email-htejun@gmail.com>
References: <12095409172824-git-send-email-htejun@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0708.google.com ([209.85.198.240]:30073 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755853AbYD3Hfa (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 30 Apr 2008 03:35:30 -0400
Received: by rv-out-0506.google.com with SMTP id k29so211428rvb.1
        for <linux-ide@vger.kernel.org>; Wed, 30 Apr 2008 00:35:30 -0700 (PDT)
In-Reply-To: <12095409172824-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

sata_inic162x is now ready for production use.  Bump the version,
explain what's working and what's not and drop EXPERIMENTAL.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/Kconfig         |    4 ++--
 drivers/ata/sata_inic162x.c |   36 ++++++++++++++++++++++++++++--------
 2 files changed, 30 insertions(+), 10 deletions(-)

diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
index 1c11df9..908738a 100644
--- a/drivers/ata/Kconfig
+++ b/drivers/ata/Kconfig
@@ -205,8 +205,8 @@ config SATA_VITESSE
 	  If unsure, say N.
 
 config SATA_INIC162X
-	tristate "Initio 162x SATA support (HIGHLY EXPERIMENTAL)"
-	depends on PCI && EXPERIMENTAL
+	tristate "Initio 162x SATA support"
+	depends on PCI
 	help
 	  This option enables support for Initio 162x Serial ATA.
 
diff --git a/drivers/ata/sata_inic162x.c b/drivers/ata/sata_inic162x.c
index bfbd34b..2f8f1df 100644
--- a/drivers/ata/sata_inic162x.c
+++ b/drivers/ata/sata_inic162x.c
@@ -10,13 +10,33 @@
  * right.  Documentation is available at initio's website but it only
  * documents registers (not programming model).
  *
- * - ATA disks work.
- * - Hotplug works.
- * - ATAPI read works but burning doesn't.  This thing is really
- *   peculiar about ATAPI and I couldn't figure out how ATAPI PIO and
- *   ATAPI DMA WRITE should be programmed.  If you've got a clue, be
- *   my guest.
- * - Both STR and STD work.
+ * This driver has interesting history.  The first version was written
+ * from the documentation and a 2.4 IDE driver posted on a Taiwan
+ * company, which didn't use any IDMA features and couldn't handle
+ * LBA48.  The resulting driver couldn't handle LBA48 devices either
+ * making it pretty useless.
+ *
+ * After a while, initio picked the driver up, renamed it to
+ * sata_initio162x, updated it to use IDMA for ATA DMA commands and
+ * posted it on their website.  It only used ATA_PROT_DMA for IDMA and
+ * attaching both devices and issuing IDMA and !IDMA commands
+ * simultaneously broke it due to PIRQ masking interaction but it did
+ * show how to use the IDMA (ADMA + some initio specific twists)
+ * engine.
+ *
+ * Then, I picked up their changes again and here's the usable driver
+ * which uses IDMA for everything.  Everything works now including
+ * LBA48, CD/DVD burning, suspend/resume and hotplug.  There are some
+ * issues tho.  Result Tf is not resported properly, NCQ isn't
+ * supported yet and CD/DVD writing works with DMA assisted PIO
+ * protocol (which, for native SATA devices, shouldn't cause any
+ * noticeable difference).
+ *
+ * Anyways, so, here's finally a working driver for inic162x.  Enjoy!
+ *
+ * initio: If you guys wanna improve the driver regarding result TF
+ * access and other stuff, please feel free to contact me.  I'll be
+ * happy to assist.
  */
 
 #include <linux/kernel.h>
@@ -28,7 +48,7 @@
 #include <scsi/scsi_device.h>
 
 #define DRV_NAME	"sata_inic162x"
-#define DRV_VERSION	"0.3"
+#define DRV_VERSION	"0.4"
 
 enum {
 	MMIO_BAR_PCI		= 5,
-- 
1.5.2.4

