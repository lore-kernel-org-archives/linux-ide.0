From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: [PATCH 4/4] sata_dwc_460ex: add debugging options
Date: Fri, 28 Jan 2011 22:02:09 +0300
Message-ID: <201101282202.09770.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dev.rtsoft.ru ([213.79.90.226]:59165 "HELO
	mail.dev.rtsoft.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1755057Ab1A1TDb (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 28 Jan 2011 14:03:31 -0500
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, linux-ide@vger.kernel.org

The driver makes use of the two options (CONFIG_SATA_DWC_[V]DEBUG) to enable
the debug output but they both are absent in drivers/ata/Kconfig...

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

---
The patch is against the recent Linus' tree.

 drivers/ata/Kconfig |   12 ++++++++++++
 1 file changed, 12 insertions(+)

Index: linux-2.6/drivers/ata/Kconfig
===================================================================
--- linux-2.6.orig/drivers/ata/Kconfig
+++ linux-2.6/drivers/ata/Kconfig
@@ -202,6 +202,18 @@ config SATA_DWC
 
 	  If unsure, say N.
 
+config SATA_DWC_DEBUG
+	bool "Debugging driver version"
+	depends on SATA_DWC
+	help
+	  This option enables debugging output in the driver.
+
+config SATA_DWC_VDEBUG
+	bool "Verbose debug output"
+	depends on SATA_DWC_DEBUG
+	help
+	  This option enables the taskfile dumping and NCQ debugging.
+
 config SATA_MV
 	tristate "Marvell SATA support"
 	help
