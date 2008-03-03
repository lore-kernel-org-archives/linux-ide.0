From: Randy Dunlap <randy.dunlap@ORACLE.COM>
Subject: [PATCH 2/2 v2] ide: update references to Documentation/ide/ide.txt
Date: Mon, 3 Mar 2008 15:40:49 -0800
Message-ID: <20080303154049.b5c14fd4.randy.dunlap@oracle.com>
References: <20080303144820.460ce4ac.randy.dunlap@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from agminet01.oracle.com ([141.146.126.228]:16254 "EHLO
	agminet01.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751132AbYCCXk5 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 3 Mar 2008 18:40:57 -0500
In-Reply-To: <20080303144820.460ce4ac.randy.dunlap@oracle.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: ide <linux-ide@vger.kernel.org>
Cc: Bart <bzolnier@gmail.com>

From: Randy Dunlap <randy.dunlap@oracle.com>
cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

step 2 of 2:  Fix all references to Documentation/ide/ide.txt.
Add/update ide/00-INDEX file.

Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
---
 Documentation/00-INDEX              |    2 -
 Documentation/cdrom/ide-cd          |   18 +++++++--------
 Documentation/ide/00-INDEX          |   12 ++++++++++
 Documentation/kernel-parameters.txt |    8 +++---
 drivers/ide/Kconfig                 |   30 +++++++++++++-------------
 drivers/ide/ide.c                   |    2 -
 6 files changed, 41 insertions(+), 31 deletions(-)

--- linux-2.6.25-rc3-git4.orig/Documentation/cdrom/ide-cd
+++ linux-2.6.25-rc3-git4/Documentation/cdrom/ide-cd
@@ -45,7 +45,7 @@ This driver provides the following featu
 ---------------
 
 0. The ide-cd relies on the ide disk driver.  See
-   Documentation/ide.txt for up-to-date information on the ide
+   Documentation/ide/ide.txt for up-to-date information on the ide
    driver.
 
 1. Make sure that the ide and ide-cd drivers are compiled into the
@@ -64,7 +64,7 @@ This driver provides the following featu
 
    Depending on what type of IDE interface you have, you may need to
    specify additional configuration options.  See
-   Documentation/ide.txt.
+   Documentation/ide/ide.txt.
 
 2. You should also ensure that the iso9660 filesystem is either
    compiled into the kernel or available as a loadable module.  You
@@ -84,7 +84,7 @@ This driver provides the following featu
    on the primary IDE interface are called `hda' and `hdb',
    respectively.  The drives on the secondary interface are called
    `hdc' and `hdd'.  (Interfaces at other locations get other letters
-   in the third position; see Documentation/ide.txt.)
+   in the third position; see Documentation/ide/ide.txt.)
 
    If you want your CDROM drive to be found automatically by the
    driver, you should make sure your IDE interface uses either the
@@ -93,7 +93,7 @@ This driver provides the following featu
    be jumpered as `master'.  (If for some reason you cannot configure
    your system in this manner, you can probably still use the driver.
    You may have to pass extra configuration information to the kernel
-   when you boot, however.  See Documentation/ide.txt for more
+   when you boot, however.  See Documentation/ide/ide.txt for more
    information.)
 
 4. Boot the system.  If the drive is recognized, you should see a
@@ -201,7 +201,7 @@ TEST
 This section discusses some common problems encountered when trying to
 use the driver, and some possible solutions.  Note that if you are
 experiencing problems, you should probably also review
-Documentation/ide.txt for current information about the underlying
+Documentation/ide/ide.txt for current information about the underlying
 IDE support code.  Some of these items apply only to earlier versions
 of the driver, but are mentioned here for completeness.
 
@@ -211,7 +211,7 @@ from the driver.
 a. Drive is not detected during booting.
 
    - Review the configuration instructions above and in
-     Documentation/ide.txt, and check how your hardware is
+     Documentation/ide/ide.txt, and check how your hardware is
      configured.
 
    - If your drive is the only device on an IDE interface, it should
@@ -219,7 +219,7 @@ a. Drive is not detected during booting.
 
    - If your IDE interface is not at the standard addresses of 0x170
      or 0x1f0, you'll need to explicitly inform the driver using a
-     lilo option.  See Documentation/ide.txt.  (This feature was
+     lilo option.  See Documentation/ide/ide.txt.  (This feature was
      added around kernel version 1.3.30.)
 
    - If the autoprobing is not finding your drive, you can tell the
@@ -245,7 +245,7 @@ a. Drive is not detected during booting.
      Support for some interfaces needing extra initialization is
      provided in later 1.3.x kernels.  You may need to turn on
      additional kernel configuration options to get them to work;
-     see Documentation/ide.txt.
+     see Documentation/ide/ide.txt.
 
      Even if support is not available for your interface, you may be
      able to get it to work with the following procedure.  First boot
@@ -299,7 +299,7 @@ c. System hangups.
     be worked around by specifying the `serialize' option when
     booting.  Recent kernels should be able to detect the need for
     this automatically in most cases, but the detection is not
-    foolproof.  See Documentation/ide.txt for more information
+    foolproof.  See Documentation/ide/ide.txt for more information
     about the `serialize' option and the CMD640B.
 
   - Note that many MS-DOS CDROM drivers will work with such buggy
--- linux-2.6.25-rc3-git4.orig/Documentation/kernel-parameters.txt
+++ linux-2.6.25-rc3-git4/Documentation/kernel-parameters.txt
@@ -712,7 +712,7 @@ and is between 256 and 4096 characters. 
 			Format: <cyl>,<head>,<sect>
 
 	hd?=		[HW] (E)IDE subsystem
-	hd?lun=		See Documentation/ide.txt.
+	hd?lun=		See Documentation/ide/ide.txt.
 
 	highmem=nn[KMG]	[KNL,BOOT] forces the highmem zone to have an exact
 			size of <nn>. This works even on boxes that have no
@@ -766,14 +766,14 @@ and is between 256 and 4096 characters. 
 
 	ide=		[HW] (E)IDE subsystem
 			Format: ide=nodma or ide=doubler or ide=reverse
-			See Documentation/ide.txt.
+			See Documentation/ide/ide.txt.
 
 	ide?=		[HW] (E)IDE subsystem
 			Format: ide?=noprobe or chipset specific parameters.
-			See Documentation/ide.txt.
+			See Documentation/ide/ide.txt.
 
 	idebus=		[HW] (E)IDE subsystem - VLB/PCI bus speed
-			See Documentation/ide.txt.
+			See Documentation/ide/ide.txt.
 
 	idle=		[X86]
 			Format: idle=poll or idle=mwait
--- linux-2.6.25-rc3-git4.orig/drivers/ide/ide.c
+++ linux-2.6.25-rc3-git4/drivers/ide/ide.c
@@ -1180,7 +1180,7 @@ static int __initdata is_chipset_set[MAX
  * ide_setup() gets called VERY EARLY during initialization,
  * to handle kernel "command line" strings beginning with "hdx=" or "ide".
  *
- * Remember to update Documentation/ide.txt if you change something here.
+ * Remember to update Documentation/ide/ide.txt if you change something here.
  */
 static int __init ide_setup(char *s)
 {
--- linux-2.6.25-rc3-git4.orig/drivers/ide/Kconfig
+++ linux-2.6.25-rc3-git4/drivers/ide/Kconfig
@@ -50,7 +50,7 @@ menuconfig IDE
 	  To compile this driver as a module, choose M here: the
 	  module will be called ide.
 
-	  For further information, please read <file:Documentation/ide.txt>.
+	  For further information, please read <file:Documentation/ide/ide.txt>.
 
 	  If unsure, say Y.
 
@@ -77,7 +77,7 @@ config BLK_DEV_IDE
 	  Useful information about large (>540 MB) IDE disks, multiple
 	  interfaces, what to do if ATA/IDE devices are not automatically
 	  detected, sound card ATA/IDE ports, module support, and other
-	  topics, is contained in <file:Documentation/ide.txt>. For detailed
+	  topics, is contained in <file:Documentation/ide/ide.txt>. For detailed
 	  information about hard drives, consult the Disk-HOWTO and the
 	  Multi-Disk-HOWTO, available from
 	  <http://www.tldp.org/docs.html#howto>.
@@ -87,7 +87,7 @@ config BLK_DEV_IDE
 	  <ftp://ibiblio.org/pub/Linux/system/hardware/>.
 
 	  To compile this driver as a module, choose M here and read
-	  <file:Documentation/ide.txt>. The module will be called ide-mod.
+	  <file:Documentation/ide/ide.txt>. The module will be called ide-mod.
 	  Do not compile this driver as a module if your root file system (the
 	  one containing the directory /) is located on an IDE device.
 
@@ -98,7 +98,7 @@ config BLK_DEV_IDE
 
 if BLK_DEV_IDE
 
-comment "Please see Documentation/ide.txt for help/info on IDE drives"
+comment "Please see Documentation/ide/ide.txt for help/info on IDE drives"
 
 config BLK_DEV_IDE_SATA
 	bool "Support for SATA (deprecated; conflicts with libata SATA driver)"
@@ -235,8 +235,8 @@ config BLK_DEV_IDETAPE
 	  along with other IDE devices, as "hdb" or "hdc", or something
 	  similar, and will be mapped to a character device such as "ht0"
 	  (check the boot messages with dmesg).  Be sure to consult the
-	  <file:drivers/ide/ide-tape.c> and <file:Documentation/ide.txt> files
-	  for usage information.
+	  <file:drivers/ide/ide-tape.c> and <file:Documentation/ide/ide.txt>
+	  files for usage information.
 
 	  To compile this driver as a module, choose M here: the
 	  module will be called ide-tape.
@@ -358,7 +358,7 @@ config BLK_DEV_CMD640
 
 	  The CMD640 chip is also used on add-in cards by Acculogic, and on
 	  the "CSA-6400E PCI to IDE controller" that some people have. For
-	  details, read <file:Documentation/ide.txt>.
+	  details, read <file:Documentation/ide/ide.txt>.
 
 config BLK_DEV_CMD640_ENHANCED
 	bool "CMD640 enhanced support"
@@ -366,7 +366,7 @@ config BLK_DEV_CMD640_ENHANCED
 	help
 	  This option includes support for setting/autotuning PIO modes and
 	  prefetch on CMD640 IDE interfaces.  For details, read
-	  <file:Documentation/ide.txt>. If you have a CMD640 IDE interface
+	  <file:Documentation/ide/ide.txt>. If you have a CMD640 IDE interface
 	  and your BIOS does not already do this for you, then say Y here.
 	  Otherwise say N.
 
@@ -1069,9 +1069,9 @@ config BLK_DEV_ALI14XX
 	  This driver is enabled at runtime using the "ali14xx.probe" kernel
 	  boot parameter.  It enables support for the secondary IDE interface
 	  of the ALI M1439/1443/1445/1487/1489 chipsets, and permits faster
-	  I/O speeds to be set as well.  See the files
-	  <file:Documentation/ide.txt> and <file:drivers/ide/legacy/ali14xx.c>
-	  for more info.
+	  I/O speeds to be set as well.
+	  See the files <file:Documentation/ide/ide.txt> and
+	  <file:drivers/ide/legacy/ali14xx.c> for more info.
 
 config BLK_DEV_DTC2278
 	tristate "DTC-2278 support"
@@ -1079,7 +1079,7 @@ config BLK_DEV_DTC2278
 	  This driver is enabled at runtime using the "dtc2278.probe" kernel
 	  boot parameter. It enables support for the secondary IDE interface
 	  of the DTC-2278 card, and permits faster I/O speeds to be set as
-	  well. See the <file:Documentation/ide.txt> and
+	  well. See the <file:Documentation/ide/ide.txt> and
 	  <file:drivers/ide/legacy/dtc2278.c> files for more info.
 
 config BLK_DEV_HT6560B
@@ -1088,7 +1088,7 @@ config BLK_DEV_HT6560B
 	  This driver is enabled at runtime using the "ht6560b.probe" kernel
 	  boot parameter. It enables support for the secondary IDE interface
 	  of the Holtek card, and permits faster I/O speeds to be set as well.
-	  See the <file:Documentation/ide.txt> and
+	  See the <file:Documentation/ide/ide.txt> and
 	  <file:drivers/ide/legacy/ht6560b.c> files for more info.
 
 config BLK_DEV_QD65XX
@@ -1096,7 +1096,7 @@ config BLK_DEV_QD65XX
 	help
 	  This driver is enabled at runtime using the "qd65xx.probe" kernel
 	  boot parameter.  It permits faster I/O speeds to be set.  See the
-	  <file:Documentation/ide.txt> and <file:drivers/ide/legacy/qd65xx.c>
+	  <file:Documentation/ide/ide.txt> and <file:drivers/ide/legacy/qd65xx.c>
 	  for more info.
 
 config BLK_DEV_UMC8672
@@ -1105,7 +1105,7 @@ config BLK_DEV_UMC8672
 	  This driver is enabled at runtime using the "umc8672.probe" kernel
 	  boot parameter. It enables support for the secondary IDE interface
 	  of the UMC-8672, and permits faster I/O speeds to be set as well.
-	  See the files <file:Documentation/ide.txt> and
+	  See the files <file:Documentation/ide/ide.txt> and
 	  <file:drivers/ide/legacy/umc8672.c> for more info.
 
 endif
--- linux-2.6.25-rc3-git4.orig/Documentation/00-INDEX
+++ linux-2.6.25-rc3-git4/Documentation/00-INDEX
@@ -183,8 +183,6 @@ i386/
 	- directory with info about Linux on Intel 32 bit architecture.
 ia64/
 	- directory with info about Linux on Intel 64 bit architecture.
-ide.txt
-	- important info for users of ATA devices (IDE/EIDE disks and CD-ROMS).
 infiniband/
 	- directory with documents concerning Linux InfiniBand support.
 initrd.txt
--- /dev/null
+++ linux-2.6.25-rc3-git4/Documentation/ide/00-INDEX
@@ -0,0 +1,12 @@
+00-INDEX
+    	- this file
+ChangeLog.ide-cd.1994-2004
+	- ide-cd changelog
+ChangeLog.ide-floppy.1996-2002
+	- ide-floppy changelog
+ChangeLog.ide-tape.1995-2002
+	- ide-tape changelog
+ide-tape.txt
+	- info on the IDE ATAPI streaming tape driver
+ide.txt
+	- important info for users of ATA devices (IDE/EIDE disks and CD-ROMS).
