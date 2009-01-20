From: Mark Lord <liml@rtr.ca>
Subject: [PATCH 06/06] sata_mv: remove experimental designation
Date: Tue, 20 Jan 2009 13:49:37 -0500
Message-ID: <49761CC1.2070804@rtr.ca>
References: <49750705.7010709@rtr.ca> <49750746.3010709@rtr.ca> <49750774.1070005@rtr.ca> <497507BF.3090608@rtr.ca> <49761596.3010000@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:39563 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753704AbZATStj (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 20 Jan 2009 13:49:39 -0500
In-Reply-To: <49761596.3010000@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

Bump version number on sata_mv, update list of chips supported,
and (finally!) remove the "EXPERIMENTAL" designation.

Signed-off-by: Mark Lord <mlord@pobox.com>

--- old/drivers/ata/sata_mv.c	2009-01-20 13:06:06.000000000 -0500
+++ linux/drivers/ata/sata_mv.c	2009-01-20 13:42:32.000000000 -0500
@@ -68,7 +68,7 @@
 #include <linux/libata.h>
 
 #define DRV_NAME	"sata_mv"
-#define DRV_VERSION	"1.24"
+#define DRV_VERSION	"1.25"
 
 enum {
 	/* BAR's are enumerated in terms of pci_resource_start() terms */
--- old/drivers/ata/Kconfig	2009-01-20 13:44:28.000000000 -0500
+++ linux/drivers/ata/Kconfig	2009-01-20 13:44:33.000000000 -0500
@@ -112,11 +112,11 @@
 	  If unsure, say N.
 
 config SATA_MV
-	tristate "Marvell SATA support (HIGHLY EXPERIMENTAL)"
-	depends on EXPERIMENTAL
+	tristate "Marvell SATA support"
 	help
 	  This option enables support for the Marvell Serial ATA family.
-	  Currently supports 88SX[56]0[48][01] chips.
+	  Currently supports 88SX[56]0[48][01] PCI(-X) chips,
+	  as well as the newer [67]042 PCI/PCIe and SOC devices.
 
 	  If unsure, say N.
 
