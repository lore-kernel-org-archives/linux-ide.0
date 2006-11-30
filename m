From: Olaf Hering <olaf@aepfle.de>
Subject: [PATCH] winbond IDE depends on IDEDMA
Date: Thu, 30 Nov 2006 19:52:08 +0100 (MET)
Message-ID: <20061130185209.GB24071@aepfle.de>
References: <20061130143803.GA22451@aepfle.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mo-p07-ob.rzone.de ([81.169.146.188]:33218 "EHLO
	mo-p07-ob.rzone.de") by vger.kernel.org with ESMTP id S1031212AbWK3SwY
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 30 Nov 2006 13:52:24 -0500
Content-Disposition: inline
In-Reply-To: <20061130143803.GA22451@aepfle.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrew Morton <akpm@osdl.org>, linux-ide@vger.kernel.org


winbond ide depends on idedma.
Move the option into the IDEDMA section.


drivers/built-in.o: In function `.sl82c105_ide_dma_timeout':
sl82c105.c:(.text+0x624d0): undefined reference to `.__ide_dma_timeout'
drivers/built-in.o: In function `.sl82c105_ide_dma_off_quietly':
sl82c105.c:(.text+0x6274c): undefined reference to `.__ide_dma_off_quietly'
drivers/built-in.o: In function `.sl82c105_ide_dma_on':
sl82c105.c:(.text+0x6284c): undefined reference to `.__ide_dma_on'
drivers/built-in.o: In function `.sl82c105_check_drive':
sl82c105.c:(.text+0x628ec): undefined reference to `.__ide_dma_bad_drive'
sl82c105.c:(.text+0x62934): undefined reference to `.__ide_dma_good_drive'
drivers/built-in.o: In function `.sl82c105_ide_dma_start':
sl82c105.c:(.text+0x62c24): undefined reference to `.ide_dma_start'
make[1]: *** [.tmp_vmlinux1] Error 1

Signed-off-by: Olaf Hering <olaf@aepfle.de>

---
 drivers/ide/Kconfig |   16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

Index: linux-2.6/drivers/ide/Kconfig
===================================================================
--- linux-2.6.orig/drivers/ide/Kconfig
+++ linux-2.6/drivers/ide/Kconfig
@@ -389,14 +389,6 @@ config BLK_DEV_RZ1000
 	  Linux. This may slow disk throughput by a few percent, but at least
 	  things will operate 100% reliably.
 
-config BLK_DEV_SL82C105
-	tristate "Winbond SL82c105 support"
-	depends on PCI && (PPC || ARM) && BLK_DEV_IDEPCI
-	help
-	  If you have a Winbond SL82c105 IDE controller, say Y here to enable
-	  special configuration for this chip. This is common on various CHRP
-	  motherboards, but could be used elsewhere. If in doubt, say Y.
-
 config BLK_DEV_IDEDMA_PCI
 	bool "Generic PCI bus-master DMA support"
 	depends on PCI && BLK_DEV_IDEPCI
@@ -712,6 +704,14 @@ config BLK_DEV_SIS5513
 
 	  Please read the comments at the top of <file:drivers/ide/pci/sis5513.c>.
 
+config BLK_DEV_SL82C105
+	tristate "Winbond SL82c105 support"
+	depends on (PPC || ARM)
+	help
+	  If you have a Winbond SL82c105 IDE controller, say Y here to enable
+	  special configuration for this chip. This is common on various CHRP
+	  motherboards, but could be used elsewhere. If in doubt, say Y.
+
 config BLK_DEV_SLC90E66
 	tristate "SLC90E66 chipset support"
 	help
