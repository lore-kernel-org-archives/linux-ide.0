From: Ben Dooks <ben-linux@fluff.org>
Subject: [PATCH] Add configuration to specify availability of pata_platform
Date: Tue, 5 Jun 2007 18:50:20 +0100
Message-ID: <20070605175020.GD13353@trinity.fluff.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from trinity.fluff.org ([217.147.94.151]:2002 "EHLO
	trinity.fluff.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755511AbXFERuV (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 5 Jun 2007 13:50:21 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

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
+++ linux-2.6.22-rc4-simtec/drivers/ata/Kconfig	2007-06-05 18:41:58.000000000 +0100
@@ -548,9 +548,15 @@ config PATA_WINBOND_VLB
 	  Support for the Winbond W83759A controller on Vesa Local Bus
 	  systems.
 
+config ARCH_HAS_PATA_PLATFORM
+	bool
+	help
+	  Internal config to show the architecture has at least one
+	  machine which can use the pata_platform device support.
+
 config PATA_PLATFORM
 	tristate "Generic platform device PATA support"
-	depends on EMBEDDED || ARCH_RPC
+	depends on EMBEDDED || ARCH_RPC || ARCH_HAS_PATA_PLATFORM
 	help
 	  This option enables support for generic directly connected ATA
 	  devices commonly found on embedded systems.
