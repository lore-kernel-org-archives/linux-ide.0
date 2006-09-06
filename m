From: Adrian Bunk <bunk@stusta.de>
Subject: [-mm patch] ATA_JMICRON: remove the superfluous ATA dependency
Date: Thu, 7 Sep 2006 01:06:55 +0200
Message-ID: <20060906230655.GD12157@stusta.de>
References: <20060901015818.42767813.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mailout.stusta.mhn.de ([141.84.69.5]:36612 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S965079AbWIFXG5 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 6 Sep 2006 19:06:57 -0400
Content-Disposition: inline
In-Reply-To: <20060901015818.42767813.akpm@osdl.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrew Morton <akpm@osdl.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org, jgarzik@pobox.com, linux-ide@vger.kernel.org

The dependency on ATA is no longer required since this option is now 
inside an "if ATA" block.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.18-rc5-mm1/drivers/ata/Kconfig.old	2006-09-07 00:39:33.000000000 +0200
+++ linux-2.6.18-rc5-mm1/drivers/ata/Kconfig	2006-09-07 00:39:55.000000000 +0200
@@ -309,7 +309,7 @@
 
 config ATA_JMICRON
 	tristate "JMicron non-AHCI support (Experimental)"
-	depends on ATA && PCI && EXPERIMENTAL
+	depends on PCI && EXPERIMENTAL
 	help
 	  This option enables support for Jmicron ATA controllers
 	  ports running in non-AHCI mode. Where possible you should

