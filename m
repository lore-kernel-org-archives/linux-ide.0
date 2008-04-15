From: Ben Dooks <ben-linux@fluff.org>
Subject: [patch 1/2] LIBATA: Add HAVE_PATA_PLATFORM to select PATA_PLATFORM driver
Date: Tue, 15 Apr 2008 15:43:26 +0100
Message-ID: <20080415144511.835003836@fluff.org.uk>
References: <20080415144325.363175912@fluff.org.uk>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from 87-194-8-8.bethere.co.uk ([87.194.8.8]:60489 "EHLO
	kira.home.fluff.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750834AbYDOP3K (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 15 Apr 2008 11:29:10 -0400
Content-Disposition: inline; filename=libata-pata-kconfig.patch
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Linux IDE List <linux-ide@vger.kernel.org>
Cc: Ben Dooks <ben-linux@fluff.org>

Add HAVE_PATA_PLATFORM to select the pata platform driver
to ensure that we do not end up with a long 'depends on' list
when other users of this driver turn up.

Signed-off-by: Ben Dooks <ben-linux@fluff.org>

Index: linux-2.6.25-rc9-ata1/drivers/ata/Kconfig
===================================================================
--- linux-2.6.25-rc9-ata1.orig/drivers/ata/Kconfig	2008-04-14 23:46:46.000000000 +0100
+++ linux-2.6.25-rc9-ata1/drivers/ata/Kconfig	2008-04-15 15:27:48.000000000 +0100
@@ -624,9 +624,17 @@ config PATA_WINBOND_VLB
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
