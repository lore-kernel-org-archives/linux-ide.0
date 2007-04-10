From: Jan Engelhardt <jengelh@linux01.gwdg.de>
Subject: [PATCH 03/30] Use menuconfig objects - libata
Date: Tue, 10 Apr 2007 21:50:30 +0200 (MEST)
Message-ID: <Pine.LNX.4.61.0704102149220.32056@yvahk01.tjqt.qr>
References: <Pine.LNX.4.61.0704102046520.32056@yvahk01.tjqt.qr>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753833AbXDJTwS@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.61.0704102046520.32056@yvahk01.tjqt.qr>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-ide@vger.kernel.org


Use menuconfigs instead of menus, so the whole menu can be disabled at        
once instead of going through all options.

Signed-off-by: Jan Engelhardt <jengelh@gmx.de>

Index: linux-2.6.21-rc5/drivers/ata/Kconfig
===================================================================
--- linux-2.6.21-rc5.orig/drivers/ata/Kconfig
+++ linux-2.6.21-rc5/drivers/ata/Kconfig
@@ -2,10 +2,8 @@
 # SATA/PATA driver configuration
 #
 
-menu "Serial ATA (prod) and Parallel ATA (experimental) drivers"
-
-config ATA
-	tristate "ATA device support"
+menuconfig ATA
+	tristate "Serial ATA (prod) and Parallel ATA (experimental) drivers"
 	depends on BLOCK
 	depends on !(M32R || M68K) || BROKEN
 	depends on !SUN4 || BROKEN
@@ -571,6 +569,4 @@ config PATA_SCC
 
 	  If unsure, say N.
 
-endif
-endmenu
-
+endif # ATA
#<EOF>
