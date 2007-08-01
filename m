From: Al Boldi <a1426z@gawab.com>
Subject: [PATCH] libata Kconfig: Allow libata to be selected from within the SCSI submenu
Date: Wed, 1 Aug 2007 07:22:11 +0300
Message-ID: <200708010722.11243.a1426z@gawab.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1759091AbXHAEWS@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org


Move libata Kconfig sourcing from the drivers Kconfig into the SCSI Kconfig.

This allows the user to quickly select additional disk/tape/cdrom support 
from within the same menu.

Signed-off-by: Al Boldi <a1426z@gawab.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
---
--- a/drivers/Kconfig	2007-05-02 17:25:30.000000000 +0300
+++ b/drivers/Kconfig	2007-08-01 06:33:13.000000000 +0300
@@ -22,8 +22,6 @@ source "drivers/ide/Kconfig"
 
 source "drivers/scsi/Kconfig"
 
-source "drivers/ata/Kconfig"
-
 source "drivers/cdrom/Kconfig"
 
 source "drivers/md/Kconfig"
--- a/drivers/scsi/Kconfig	2007-07-09 06:38:37.000000000 +0300
+++ b/drivers/scsi/Kconfig	2007-08-01 06:46:42.000000000 +0300
@@ -7,6 +7,8 @@ config RAID_ATTRS
 	---help---
 	  Provides RAID
 
+source "drivers/ata/Kconfig"
+
 config SCSI
 	tristate "SCSI device support"
 	depends on BLOCK
