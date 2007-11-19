From: Ben Dooks <ben-linux@fluff.org>
Subject: [PATCH] pata_platfrom: add MACH_HAS_PATA_PLATFORM configuration
Date: Mon, 19 Nov 2007 12:36:58 +0000
Message-ID: <20071119123658.GI26444@trinity.fluff.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from trinity.fluff.org ([89.145.97.151]:39890 "EHLO
	trinity.fluff.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752271AbXKSMhA (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 19 Nov 2007 07:37:00 -0500
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org
Cc: Vincent Sanders <vince@simtec.co.uk>

Add a configuration entry (MACH_HAS_PATA_PLATFORM) so that any machine
impelementing a pata_platform driver can add this to their own Kconfig
to enable the PATA_PLATFORM driver.

This will avoid multiple patches to the drivers/ata/Kconfig when new
machine support is added.

Signed-off-by: Ben Dooks <ben-linux@fluff.org>

diff -urpN -X linux-2.6.24-rc3/Documentation/dontdiff linux-2.6.24-rc3/drivers/ata/Kconfig linux-2.6.24-rc3-pata1/drivers/ata/Kconfig
--- linux-2.6.24-rc3/drivers/ata/Kconfig	2007-10-09 21:31:38.000000000 +0100
+++ linux-2.6.24-rc3-pata1/drivers/ata/Kconfig	2007-11-19 12:25:03.000000000 +0000
@@ -560,9 +560,17 @@ config PATA_WINBOND_VLB
 	  Support for the Winbond W83759A controller on Vesa Local Bus
 	  systems.
 
+config MACH_HAS_PATA_PLATFORM
+	bool
+	help
+	  This is an internal configuration node for any machine that
+	  uses pata-platform driver to enable the relevant driver in the
+	  configuration structure without having to submit endless patches
+	  to update the PATA_PLATFORM entry.
+
 config PATA_PLATFORM
 	tristate "Generic platform device PATA support"
-	depends on EMBEDDED || ARCH_RPC
+	depends on EMBEDDED || ARCH_RPC || MACH_HAS_PATA_PLATFORM
 	help
 	  This option enables support for generic directly connected ATA
 	  devices commonly found on embedded systems.
