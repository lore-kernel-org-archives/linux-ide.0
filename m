From: Adrian Bunk <bunk@stusta.de>
Subject: [2.6 patch] SCSI_SATA has to be a tristate
Date: Fri, 15 Jul 2005 23:35:05 +0200
Message-ID: <20050715213505.GG18059@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mailout.stusta.mhn.de ([141.84.69.5]:15370 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261213AbVGOVfI (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 15 Jul 2005 17:35:08 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrew Morton <akpm@osdl.org>
Cc: jgarzik@pobox.com, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

SCSI=m must disallow static drivers.

The problem is that all the SATA drivers depend on SCSI_SATA.

With SCSI=m and SCSI_SATA=y this allows the static enabling of the SATA
drivers with unwanted effects, e.g.:
- SCSI=m, SCSI_SATA=y, SCSI_ATA_ADMA=y
  -> SCSI_ATA_ADMA is built statically but scsi/built-in.o is not linked
     into the kernel
- SCSI=m, SCSI_SATA=y, SCSI_ATA_ADMA=y, SCSI_SATA_AHCI=m
  -> SCSI_ATA_ADMA and libata are built statically but
     scsi/built-in.o is not linked into the kernel,
     SCSI_SATA_AHCI is built modular (unresolved symbols due to missing
                                      libata)

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was already sent on:
- 8 Jul 2005
- 2 Jul 2005

--- linux-2.6.13-rc1-mm1/drivers/scsi/Kconfig.old	2005-07-02 21:57:40.000000000 +0200
+++ linux-2.6.13-rc1-mm1/drivers/scsi/Kconfig	2005-07-02 21:58:06.000000000 +0200
@@ -447,7 +447,7 @@
 source "drivers/scsi/megaraid/Kconfig.megaraid"
 
 config SCSI_SATA
-	bool "Serial ATA (SATA) support"
+	tristate "Serial ATA (SATA) support"
 	depends on SCSI
 	help
 	  This driver family supports Serial ATA host controllers
k
