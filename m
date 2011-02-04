From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: [PATCH 4/4] libata: remove ATA_FLAG_LPM
Date: Fri, 4 Feb 2011 22:08:22 +0300
Message-ID: <201102042208.22409.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dev.rtsoft.ru ([213.79.90.226]:40419 "HELO
	mail.dev.rtsoft.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751778Ab1BDTJp (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 4 Feb 2011 14:09:45 -0500
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org, jgarzik@pobox.com

Commit 6b7ae9545ad9875a289f4191c0216b473e313cb9 (libata: reimplement link power
management) removed the check of ATA_FLAG_LPM but neglected to remove the flag
itself.  Do it now...

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

---
The patch is against the recent Linus' tree.

 drivers/ata/ahci.h     |    3 +--
 include/linux/libata.h |    1 -
 2 files changed, 1 insertion(+), 3 deletions(-)

Index: linux-2.6/drivers/ata/ahci.h
===================================================================
--- linux-2.6.orig/drivers/ata/ahci.h
+++ linux-2.6/drivers/ata/ahci.h
@@ -214,8 +214,7 @@ enum {
 	/* ap->flags bits */
 
 	AHCI_FLAG_COMMON		= ATA_FLAG_SATA | ATA_FLAG_PIO_DMA |
-					  ATA_FLAG_ACPI_SATA | ATA_FLAG_AN |
-					  ATA_FLAG_LPM,
+					  ATA_FLAG_ACPI_SATA | ATA_FLAG_AN,
 
 	ICH_MAP				= 0x90, /* ICH MAP register */
 
Index: linux-2.6/include/linux/libata.h
===================================================================
--- linux-2.6.orig/include/linux/libata.h
+++ linux-2.6/include/linux/libata.h
@@ -194,7 +194,6 @@ enum {
 	ATA_FLAG_ACPI_SATA	= (1 << 17), /* need native SATA ACPI layout */
 	ATA_FLAG_AN		= (1 << 18), /* controller supports AN */
 	ATA_FLAG_PMP		= (1 << 19), /* controller supports PMP */
-	ATA_FLAG_LPM		= (1 << 20), /* driver can handle LPM */
 	ATA_FLAG_EM		= (1 << 21), /* driver supports enclosure
 					      * management */
 	ATA_FLAG_SW_ACTIVITY	= (1 << 22), /* driver supports sw activity
