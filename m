From: Alan <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] Kconfig: clarify ATA_PIIX description
Date: Mon, 5 Feb 2007 16:04:10 +0000
Message-ID: <20070205160410.2e573eaa@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:33363 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751392AbXBEPvY (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 5 Feb 2007 10:51:24 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: akpm@osdl.org, jgarzik@pobox.com, linux-ide@vger.kernel.org

People are getting confused about which drivers to enable for PATA PIIX
type devices. Change the ATA_PIIX line and help to make it clearer.

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.20-rc6-mm3/drivers/ata/Kconfig linux-2.6.20-rc6-mm3/drivers/ata/Kconfig
--- linux.vanilla-2.6.20-rc6-mm3/drivers/ata/Kconfig	2007-01-31 14:20:39.000000000 +0000
+++ linux-2.6.20-rc6-mm3/drivers/ata/Kconfig	2007-02-05 11:14:01.655016520 +0000
@@ -41,12 +41,12 @@
 	  If unsure, say N.
 
 config ATA_PIIX
-	tristate "Intel PIIX/ICH SATA support"
+	tristate "Intel ESB, ICH, PIIX3, PIIX4 PATA/SATA support"
 	depends on PCI
 	help
 	  This option enables support for ICH5/6/7/8 Serial ATA
-	  and support for PATA on the Intel PIIX3/PIIX4/ICH series
-	  PATA host controllers.
+	  and support for PATA on the Intel ESB/ICH/PIIX3/PIIX4 series
+	  host controllers.
 
 	  If unsure, say N.
 
