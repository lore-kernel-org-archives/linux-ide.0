From: Tejun Heo <tj@kernel.org>
Subject: [PATCH 02/23] sata_inic162x: inic162x is not dependent on CONFIG_ATA_SFF
Date: Mon, 10 May 2010 21:41:26 +0200
Message-ID: <1273520507-32459-3-git-send-email-tj@kernel.org>
References: <1273520507-32459-1-git-send-email-tj@kernel.org>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:44909 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755938Ab0EJTmC (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 10 May 2010 15:42:02 -0400
In-Reply-To: <1273520507-32459-1-git-send-email-tj@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, linux-ide@vger.kernel.org, sshtylyov@mvista.com
Cc: Tejun Heo <tj@kernel.org>

sata_inic162x no longer uses SFF interface.  Move it out of
CONFIG_ATA_SFF.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 drivers/ata/Kconfig |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
index cbadb9f..e68541f 100644
--- a/drivers/ata/Kconfig
+++ b/drivers/ata/Kconfig
@@ -81,6 +81,12 @@ config SATA_SIL24
 
 	  If unsure, say N.
 
+config SATA_INIC162X
+	tristate "Initio 162x SATA support"
+	depends on PCI
+	help
+	  This option enables support for Initio 162x Serial ATA.
+
 config SATA_FSL
 	tristate "Freescale 3.0Gbps SATA support"
 	depends on FSL_SOC
@@ -221,12 +227,6 @@ config SATA_VITESSE
 
 	  If unsure, say N.
 
-config SATA_INIC162X
-	tristate "Initio 162x SATA support"
-	depends on PCI
-	help
-	  This option enables support for Initio 162x Serial ATA.
-
 config PATA_ACPI
 	tristate "ACPI firmware driver for PATA"
 	depends on ATA_ACPI
-- 
1.6.4.2

