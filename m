From: Ben Dooks <ben-linux@fluff.org>
Subject: [PATCH 3/3 2.6.24-git] PPC/LIBATA: Select HAVE_PATA_PLATFORM for ARCH_PPC
Date: Sat, 02 Feb 2008 16:21:36 +0000
Message-ID: <20080202162232.212855590@fluff.org.uk>
References: <20080202162133.678366209@fluff.org.uk>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from 87-194-8-8.bethere.co.uk ([87.194.8.8]:60251 "EHLO
	kira.home.fluff.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751229AbYBBQe6 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 2 Feb 2008 11:34:58 -0500
Content-Disposition: inline; filename=libata-ppc-use-have-kconfig.patch
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org, jeff@garzik.org, htejun@gmail.com
Cc: linuxppc-dev@ozlabs.org, Ben Dooks <ben-linux@fluff.org>

Use the new HAVE_PATA_PLATFORM to select PATA_PLATFORM
driver.

CC: linuxppc-dev@ozlabs.org
Signed-off-by: Ben Dooks <ben-linux@fluff.org>

Index: linux-2.6.24-git12-pata2/arch/ppc/Kconfig
===================================================================
--- linux-2.6.24-git12-pata2.orig/arch/ppc/Kconfig
+++ linux-2.6.24-git12-pata2/arch/ppc/Kconfig
@@ -41,6 +41,7 @@ config GENERIC_CALIBRATE_DELAY
 
 config PPC
 	bool
+	select HAVE_PATA_PLATFORM
 	default y
 
 config PPC32
Index: linux-2.6.24-git12-pata2/drivers/ata/Kconfig
===================================================================
--- linux-2.6.24-git12-pata2.orig/drivers/ata/Kconfig
+++ linux-2.6.24-git12-pata2/drivers/ata/Kconfig
@@ -624,7 +624,7 @@ config HAVE_PATA_PLATFORM
 
 config PATA_PLATFORM
 	tristate "Generic platform device PATA support"
-	depends on EMBEDDED || PPC || HAVE_PATA_PLATFORM
+	depends on EMBEDDED || HAVE_PATA_PLATFORM
 	help
 	  This option enables support for generic directly connected ATA
 	  devices commonly found on embedded systems.

-- 
Ben (ben@fluff.org, http://www.fluff.org/)

  'a smiley only costs 4 bytes'
