From: Mark Lord <liml@rtr.ca>
Subject: [PATCH 05/05] sata_mv: no longer experimental (v2)
Date: Wed, 21 Jan 2009 10:34:17 -0500
Message-ID: <49774079.1040902@rtr.ca>
References: <49750705.7010709@rtr.ca> <49750746.3010709@rtr.ca> <49750774.1070005@rtr.ca> <49773FD1.3040101@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:38582 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754752AbZAUPeS (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 21 Jan 2009 10:34:18 -0500
In-Reply-To: <49773FD1.3040101@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, IDE/ATA development list <linux-ide@vger.kernel.org>, Tejun Heo <htejun@gmail.com>

Update Kconfig for sata_mv with full list of chips supported,
and (finally!) remove the "EXPERIMENTAL" designations.

Signed-off-by: Mark Lord <mlord@pobox.com>
---

This replaces the patch "[PATCH 06/06] sata_mv: remove experimental".

--- old/drivers/ata/Kconfig	2009-01-21 10:16:16.000000000 -0500
+++ linux/drivers/ata/Kconfig	2009-01-21 10:25:35.000000000 -0500
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
+	  as well as the newer [67]042 PCI-X/PCIe and SOC devices.
 
 	  If unsure, say N.
 
