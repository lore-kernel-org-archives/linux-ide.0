From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 4/8] ide: deprecate CONFIG_BLK_DEV_OFFBOARD
Date: Thu, 29 Nov 2007 01:05:47 +0100
Message-ID: <200711290105.47257.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.171]:44019 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757756AbXK2ACs (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 28 Nov 2007 19:02:48 -0500
Received: by ug-out-1314.google.com with SMTP id z38so1659756ugc
        for <linux-ide@vger.kernel.org>; Wed, 28 Nov 2007 16:02:47 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/Kconfig |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

Index: b/drivers/ide/Kconfig
===================================================================
--- a/drivers/ide/Kconfig
+++ b/drivers/ide/Kconfig
@@ -378,7 +378,7 @@ config IDEPCI_PCIBUS_ORDER
 
 # TODO: split it on per host driver config options (or module parameters)
 config BLK_DEV_OFFBOARD
-	bool "Boot off-board chipsets first support"
+	bool "Boot off-board chipsets first support (DEPRECATED)"
 	depends on BLK_DEV_IDEPCI && (BLK_DEV_AEC62XX || BLK_DEV_GENERIC || BLK_DEV_HPT34X || 
BLK_DEV_HPT366 || BLK_DEV_PDC202XX_NEW || BLK_DEV_PDC202XX_OLD || BLK_DEV_TC86C001)
 	help
 	  Normally, IDE controllers built into the motherboard (on-board
@@ -398,6 +398,10 @@ config BLK_DEV_OFFBOARD
 	  Note that, if you do this, the order of the hd* devices will be
 	  rearranged which may require modification of fstab and other files.
 
+	  Please also note that this method of assuring stable naming of
+	  IDE devices is unreliable and use other means for achieving it
+	  (i.e. udev).
+
 	  If in doubt, say N.
 
 config BLK_DEV_GENERIC
