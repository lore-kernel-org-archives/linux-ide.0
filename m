From: Alan Cox <alan@linux.intel.com>
Subject: [PATCH] libata: Allow pata_legacy to be built on non-ISA but PCI
	systems
Date: Mon, 08 Feb 2010 10:04:54 +0000
Message-ID: <20100208100429.2679.52367.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:48792 "EHLO
	bob.linux.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755066Ab0BHK3d (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 8 Feb 2010 05:29:33 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, linux-ide@vger.kernel.org

This is needed for some unsupported hardware setups on strange 64bit
mainboards where crazy stuff has been done like putting flash ata adapters
on the LPC bus, or where the real hardware is hidden/confused.

Signed-off-by: Alan Cox <alan@linux.intel.com>
---

 drivers/ata/Kconfig |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)


diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
index 56c6374..01c52c4 100644
--- a/drivers/ata/Kconfig
+++ b/drivers/ata/Kconfig
@@ -446,9 +446,9 @@ config PATA_JMICRON
 
 config PATA_LEGACY
 	tristate "Legacy ISA PATA support (Experimental)"
-	depends on ISA && EXPERIMENTAL
+	depends on (ISA || PCI)  && EXPERIMENTAL
 	help
-	  This option enables support for ISA/VLB bus legacy PATA
+	  This option enables support for ISA/VLB/PCI bus legacy PATA
 	  ports and allows them to be accessed via the new ATA layer.
 
 	  If unsure, say N.

