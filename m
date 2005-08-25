From: "Tomita, Haruo" <haruo.tomita@toshiba.co.jp>
Subject: RE: libata-dev queue updated
Date: Thu, 25 Aug 2005 15:56:23 +0900
Message-ID: <BF571719A4041A478005EF3F08EA6DF001617907@pcsmail03.pcs.pc.ome.toshiba.co.jp>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-2022-jp"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S964861AbVHYG5Q@vger.kernel.org>
Content-class: urn:content-classes:message
Sender: linux-kernel-owner@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, "Tomita, Haruo" <haruo.tomita@toshiba.co.jp>
List-Id: linux-ide@vger.kernel.org

Hi Jeff,

2.6.13- rc7-libata1.patch.bz2 was used. 
A combined mode of ata_piix seems not to work. 
Is the following patches correct?

diff -urN linux-2.6.13-rc7.orig/drivers/scsi/Kconfig linux-2.6.13-rc7/drivers/scsi/Kconfig
--- linux-2.6.13-rc7.orig/drivers/scsi/Kconfig	2005-08-25 13:44:33.000000000 +0900
+++ linux-2.6.13-rc7/drivers/scsi/Kconfig	2005-08-25 14:33:38.000000000 +0900
@@ -424,7 +424,7 @@
 source "drivers/scsi/megaraid/Kconfig.megaraid"
 
 config SCSI_SATA
-	tristate "Serial ATA (SATA) support"
+	bool "Serial ATA (SATA) support"
 	depends on SCSI
 	help
 	  This driver family supports Serial ATA host controllers

--
Haruo
