From: Jose Alberto Reguero <jareguero@telefonica.net>
Subject: Marvel 6121 ahci
Date: Thu, 17 Apr 2008 02:14:41 +0200
Message-ID: <200804170214.42384.jareguero@telefonica.net>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_yZpBItXXya01+Df"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outmailhost.telefonica.net ([213.4.149.242]:2949 "EHLO
	ctsmtpout3.frontal.correo" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750778AbYDQAOs (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 16 Apr 2008 20:14:48 -0400
Received: from jar.dominio (80.25.230.35) by ctsmtpout3.frontal.correo (7.3.135) (authenticated as jareguero$telefonica.net)
        id 4805C8DF00056BCB for linux-ide@vger.kernel.org; Thu, 17 Apr 2008 02:14:43 +0200
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

--Boundary-00=_yZpBItXXya01+Df
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I am using Marvel 6121 with this patch without any problems. The flags:
ATA_FLAG_SATA
ATA_FLAG_NO_LEGACY
ATA_FLAG_MMIO
ATA_FLAG_PIO_DMA
was the default ahci flags when board_ahci_mv was aded to ahci, and the 
AHCI_HFLAG_NO_NCQ was aded before the NCQ fix.

Jose Alberto

--Boundary-00=_yZpBItXXya01+Df
Content-Type: text/x-diff;
  charset="us-ascii";
  name="ahci-25.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="ahci-25.patch"

--- linux-2.6.25-rc9/drivers/ata/ahci.c	2008-04-11 22:32:29.000000000 +0200
+++ linux-2.6.25-rc9.new/drivers/ata/ahci.c	2008-04-12 02:11:38.000000000 +0200
@@ -443,10 +443,9 @@
 	},
 	/* board_ahci_mv */
 	{
-		AHCI_HFLAGS	(AHCI_HFLAG_NO_NCQ | AHCI_HFLAG_NO_MSI |
+		AHCI_HFLAGS	(AHCI_HFLAG_NO_MSI |
 				 AHCI_HFLAG_MV_PATA),
-		.flags		= ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
-				  ATA_FLAG_MMIO | ATA_FLAG_PIO_DMA,
+		.flags		= AHCI_FLAG_COMMON,
 		.link_flags	= AHCI_LFLAG_COMMON,
 		.pio_mask	= 0x1f, /* pio0-4 */
 		.udma_mask	= ATA_UDMA6,

--Boundary-00=_yZpBItXXya01+Df--
