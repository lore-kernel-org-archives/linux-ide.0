From: Robert Hancock <hancockrwd@gmail.com>
Subject: [PATCH] ide: update Kconfig text to mark as deprecated
Date: Mon, 26 Oct 2009 19:41:32 -0600
Message-ID: <4AE64FCC.4030102@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yw0-f202.google.com ([209.85.211.202]:40891 "EHLO
	mail-yw0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755528AbZJ0Bln (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 26 Oct 2009 21:41:43 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-kernel <linux-kernel@vger.kernel.org>, ide <linux-ide@vger.kernel.org>, David Miller <davem@davemloft.net>

The current Kconfig text for CONFIG_IDE doesn't give a hint to users that this
subsystem is currently in maintenance mode and isn't actively developed.
Let's correct this by marking it as deprecated, and also get rid of a bunch of
unnecessary text that doesn't really have anything to do with what the option is
for.

Signed-off-by: Robert Hancock <hancockrwd@gmail.com>

diff --git a/drivers/ide/Kconfig b/drivers/ide/Kconfig
index 9a5d0aa..98ccfeb 100644
--- a/drivers/ide/Kconfig
+++ b/drivers/ide/Kconfig
@@ -7,50 +7,25 @@ config HAVE_IDE
 	bool
 
 menuconfig IDE
-	tristate "ATA/ATAPI/MFM/RLL support"
+	tristate "ATA/ATAPI/MFM/RLL support (DEPRECATED)"
 	depends on HAVE_IDE
 	depends on BLOCK
 	---help---
-	  If you say Y here, your kernel will be able to manage low cost mass
-	  storage units such as ATA/(E)IDE and ATAPI units. The most common
-	  cases are IDE hard drives and ATAPI CD-ROM drives.
-
-	  If your system is pure SCSI and doesn't use these interfaces, you
-	  can say N here.
-
-	  Integrated Disk Electronics (IDE aka ATA-1) is a connecting standard
-	  for mass storage units such as hard disks. It was designed by
-	  Western Digital and Compaq Computer in 1984. It was then named
-	  ST506. Quite a number of disks use the IDE interface.
-
-	  AT Attachment (ATA) is the superset of the IDE specifications.
-	  ST506 was also called ATA-1.
-
-	  Fast-IDE is ATA-2 (also named Fast ATA), Enhanced IDE (EIDE) is
-	  ATA-3. It provides support for larger disks (up to 8.4GB by means of
-	  the LBA standard), more disks (4 instead of 2) and for other mass
-	  storage units such as tapes and cdrom. UDMA/33 (aka UltraDMA/33) is
-	  ATA-4 and provides faster (and more CPU friendly) transfer modes
-	  than previous PIO (Programmed processor Input/Output) from previous
-	  ATA/IDE standards by means of fast DMA controllers.
-
-	  ATA Packet Interface (ATAPI) is a protocol used by EIDE tape and
-	  CD-ROM drives, similar in many respects to the SCSI protocol.
-
-	  SMART IDE (Self Monitoring, Analysis and Reporting Technology) was
-	  designed in order to prevent data corruption and disk crash by
-	  detecting pre hardware failure conditions (heat, access time, and
-	  the like...). Disks built since June 1995 may follow this standard.
-	  The kernel itself doesn't manage this; however there are quite a
-	  number of user programs such as smart that can query the status of
-	  SMART parameters from disk drives.
+	  If you say Y here, your kernel will be able to manage ATA/(E)IDE and
+	  ATAPI units. The most common cases are IDE hard drives and ATAPI
+	  CD-ROM drives.
+
+	  This subsystem is currently in maintenance mode with only bug fix
+	  changes applied. Users of ATA hardware are encouraged to migrate to
+	  the newer ATA subsystem ("Serial ATA (prod) and Parallel ATA
+	  (experimental) drivers") which is more actively maintained.
 
 	  To compile this driver as a module, choose M here: the
 	  module will be called ide-core.
 
 	  For further information, please read <file:Documentation/ide/ide.txt>.
 
-	  If unsure, say Y.
+	  If unsure, say N.
 
 if IDE
 
