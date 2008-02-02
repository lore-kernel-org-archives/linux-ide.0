From: Ben Dooks <ben-linux@fluff.org>
Subject: [PATCH 1/3 2.6.24-git] LIBATA: Add HAVE_PATA_PLATFORM to select PATA_PLATFORM driver
Date: Sat, 02 Feb 2008 16:21:34 +0000
Message-ID: <20080202162231.863337543@fluff.org.uk>
References: <20080202162133.678366209@fluff.org.uk>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from 87-194-8-8.bethere.co.uk ([87.194.8.8]:60246 "EHLO
	kira.home.fluff.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751173AbYBBQes (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 2 Feb 2008 11:34:48 -0500
Content-Disposition: inline; filename=libata-pata-kconfig.patch
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org, jeff@garzik.org, htejun@gmail.com
Cc: Ben Dooks <ben-linux@fluff.org>

Add HAVE_PATA_PLATFORM to select the pata platform driver
to ensure that we do not end up with a long 'depends on' list
when other users of this driver turn up.

Signed-off-by: Ben Dooks <ben-linux@fluff.org>

Index: linux-2.6.24-git12-pata/drivers/ata/Kconfig
===================================================================
--- linux-2.6.24-git12-pata.orig/drivers/ata/Kconfig
+++ linux-2.6.24-git12-pata/drivers/ata/Kconfig
@@ -614,9 +614,17 @@ config PATA_WINBOND_VLB
 	  Support for the Winbond W83759A controller on Vesa Local Bus
 	  systems.
 
+config HAVE_PATA_PLATFORM
+	bool
+	help
+	  This is an internal configuration node for any machine that
+	  uses pata-platform driver to enable the relevant driver in the
+	  configuration structure without having to submit endless patches
+	  to update the PATA_PLATFORM entry.
+
 config PATA_PLATFORM
 	tristate "Generic platform device PATA support"
-	depends on EMBEDDED || ARCH_RPC || PPC
+	depends on EMBEDDED || ARCH_RPC || PPC || HAVE_PATA_PLATFORM
 	help
 	  This option enables support for generic directly connected ATA
 	  devices commonly found on embedded systems.

-- 
Ben (ben@fluff.org, http://www.fluff.org/)

  'a smiley only costs 4 bytes'
