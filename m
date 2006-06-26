From: Auke Kok <sofar@foo-projects.org>
Subject: [PATCH] ata_piix: add ICH6/7/8 to Kconfig
Date: Mon, 26 Jun 2006 07:51:28 -0700
Message-ID: <449FF470.8080605@foo-projects.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------090105050308030302080404"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.89]:40350 "EHLO
	fmsmga101.fm.intel.com") by vger.kernel.org with ESMTP
	id S1750728AbWFZOwN (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 26 Jun 2006 10:52:13 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: linux-ide@vger.kernel.org

This is a multi-part message in MIME format.
--------------090105050308030302080404
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit



Ata_piix's Kconfig entry still refers only to ICH5, while it supports ICH6
through 8. This creates confusion with people who are looking to see
if their newer SATA enabled motherboards are supported. The
following patch makes this clear.

Signed-off-by: Auke Kok <auke-jan.h.kok@intel.com>


---
This patch is against:
      linus-2.6.git/d384ea691fe4ea8c2dd5b9b8d9042eb181776f18

---
  drivers/scsi/Kconfig |    2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)


--------------090105050308030302080404
Content-Type: text/x-patch;
 name="ata_piix_kconfig_help.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ata_piix_kconfig_help.patch"

diff --git a/drivers/scsi/Kconfig b/drivers/scsi/Kconfig
index a480a37..98b1da8 100644
--- a/drivers/scsi/Kconfig
+++ b/drivers/scsi/Kconfig
@@ -501,7 +501,7 @@ config SCSI_ATA_PIIX
 	tristate "Intel PIIX/ICH SATA support"
 	depends on SCSI_SATA && PCI
 	help
-	  This option enables support for ICH5 Serial ATA.
+	  This option enables support for ICH5/6/7/8 Serial ATA.
 	  If PATA support was enabled previously, this enables
 	  support for select Intel PIIX/ICH PATA host controllers.
 

--------------090105050308030302080404--
