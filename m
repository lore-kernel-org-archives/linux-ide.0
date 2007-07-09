From: Ben Dooks <ben@trinity.fluff.org>
Subject: [PATCH,RFC] Add configuration for availability of pata_platform
Date: Tue, 10 Jul 2007 00:31:29 +0100
Message-ID: <20070709233129.GA31114@trinity.fluff.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from trinity.fluff.org ([217.147.94.151]:2154 "EHLO
	trinity.fluff.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756701AbXGIXbb (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 9 Jul 2007 19:31:31 -0400
Received: from ben by trinity.fluff.org with local (Exim 4.50)
	id 1I82hW-00086h-0A
	for linux-ide@vger.kernel.org; Tue, 10 Jul 2007 00:31:30 +0100
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Repost of http://marc.info/?l=linux-ide&m=118106594419762&w=2

Could someone comment on the following please:

Add a hidden configuration for an architecture or machine to
select to show that the pata_platform driver should be show
in the configuration.

This method is used to allow each individual machine/arch to
specify this, instead of creating large "depends on" on the
driver's Kconfig menu.

If this patch is acceptable, I will submit a patch to
move ARCH_RPC to select ARCH_HAS_PATA_PLATFORM.

Signed-off-by: Ben Dooks <ben-linux@fluff.org>
 
Index: linux-2.6.22-rc4-simtec/drivers/ata/Kconfig
===================================================================
--- linux-2.6.22-rc4-simtec.orig/drivers/ata/Kconfig	2007-06-05 18:27:08.000000000 +0100
+++ linux-2.6.22-rc4-simtec/drivers/ata/Kconfig	2007-06-05 18:35:44.000000000 +0100
@@ -548,9 +548,15 @@ config PATA_WINBOND_VLB
 	  Support for the Winbond W83759A controller on Vesa Local Bus
 	  systems.
 
+config ARCH_HAS_PLATFORM_ATA
+	bool
+	help
+	  Embedded option to show the architecture has at least one
+	  machine which can use the platform device ata support.
+
 config PATA_PLATFORM
 	tristate "Generic platform device PATA support"
-	depends on EMBEDDED || ARCH_RPC
+	depends on EMBEDDED || ARCH_RPC || ARCH_HAS_PLATFORM_ATA
 	help
 	  This option enables support for generic directly connected ATA
 	  devices commonly found on embedded systems.

-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.

