From: Ben Dooks <ben-linux@fluff.org>
Subject: PATA: RPC now selects HAVE_PATA_PLATFORM for pata platform driver
Date: Tue, 05 Aug 2008 10:36:15 +0100
Message-ID: <20080805093615.362685204@fluff.org.uk>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from aeryn.fluff.org.uk ([87.194.8.8]:51234 "EHLO
	kira.home.fluff.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753338AbYHEJgV (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 5 Aug 2008 05:36:21 -0400
Content-Disposition: inline; filename=simtec/libata-rpc-use-have-kconfig2.patch
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Russell King <rmk@arm.linux.org.uk>, Ben Dooks <ben-linux@fluff.org>

The RPC machine type now selects HAVE_PATA_PLATFORM so we can remove
the special case in the PATA_PLATFORM configuration code.

Acked-by: Russell King <rmk@arm.linux.org.uk>
Signed-off-by: Ben Dooks <ben-linux@fluff.org>

Index: linux-2.6.26-rc5-quilt1/drivers/ata/Kconfig
===================================================================
--- linux-2.6.26-rc5-quilt1.orig/drivers/ata/Kconfig	2008-06-10 12:38:03.000000000 +0100
+++ linux-2.6.26-rc5-quilt1/drivers/ata/Kconfig	2008-06-10 12:38:03.000000000 +0100
@@ -661,7 +661,7 @@ config HAVE_PATA_PLATFORM
 
 config PATA_PLATFORM
 	tristate "Generic platform device PATA support"
-	depends on EMBEDDED || ARCH_RPC || PPC || HAVE_PATA_PLATFORM
+	depends on EMBEDDED || PPC || HAVE_PATA_PLATFORM
 	help
 	  This option enables support for generic directly connected ATA
 	  devices commonly found on embedded systems.

-- 
Ben (ben@fluff.org, http://www.fluff.org/)

  'a smiley only costs 4 bytes'
