From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 8/8] ide: make CONFIG_IDEPCI_PCIBUS_ORDER visible and deprecate it
Date: Thu, 29 Nov 2007 01:10:49 +0100
Message-ID: <200711290110.49753.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.174]:43911 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758116AbXK2ACw (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 28 Nov 2007 19:02:52 -0500
Received: by ug-out-1314.google.com with SMTP id z38so1659770ugc
        for <linux-ide@vger.kernel.org>; Wed, 28 Nov 2007 16:02:51 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/Kconfig |   14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

Index: b/drivers/ide/Kconfig
===================================================================
--- a/drivers/ide/Kconfig
+++ b/drivers/ide/Kconfig
@@ -374,7 +374,19 @@ config BLK_DEV_IDEPCI
 	bool
 
 config IDEPCI_PCIBUS_ORDER
-	def_bool BLK_DEV_IDE=y && BLK_DEV_IDEPCI
+	bool "Probe IDE PCI devices in the PCI bus order (DEPRECATED)"
+	depends on BLK_DEV_IDE=y && BLK_DEV_IDEPCI
+	default y
+	help
+	  Probe IDE PCI devices in the order in which they appear on the
+	  PCI bus (i.e. 00:1f.1 PCI device before 02:01.0 PCI device)
+	  instead of the order in which IDE PCI host drivers are loaded.
+
+	  Please note that this method of assuring stable naming of
+	  IDE devices is unreliable and use other means for achieving
+	  it (i.e. udev).
+
+	  If in doubt, say N.
 
 # TODO: split it on per host driver config options (or module parameters)
 config BLK_DEV_OFFBOARD
