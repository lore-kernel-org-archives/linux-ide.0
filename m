From: "Asai Thambi Samymuthu Pattrayasamy (asamymuthupa) [CONTRACTOR]"
	<asamymuthupa@micron.com>
Subject: [PATCH 1/3] New driver mtipx2xx submission
Date: Tue, 3 May 2011 14:14:42 -0600
Message-ID: <22A973199D2C2F46933448F6E7990A300204FB87@ntxboimbx31.micron.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from masquerade.micron.com ([137.201.242.130]:30741 "EHLO
	masquerade.micron.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754324Ab1ECUOp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 3 May 2011 16:14:45 -0400
Received: from ntxboimbx31.micron.com (ntxboimbx31.micron.com [137.201.91.17])
	by masquerade.micron.com (8.13.6/8.13.6) with SMTP id p43KEhG1001275
	for <linux-ide@vger.kernel.org>; Tue, 3 May 2011 14:14:44 -0600
Content-class: urn:content-classes:message
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Part 1

diff -uNr a/drivers/block/Kconfig b/drivers/block/Kconfig
--- a/drivers/block/Kconfig	2011-04-15 13:53:48.000000000 -0600
+++ b/drivers/block/Kconfig	2011-05-03 13:00:40.000000000 -0600
@@ -116,6 +116,8 @@
 
 source "drivers/block/paride/Kconfig"
 
+source "drivers/block/mtipx2xx/Kconfig"
+
 config BLK_CPQ_DA
 	tristate "Compaq SMART2 support"
 	depends on PCI && VIRT_TO_BUS
diff -uNr a/drivers/block/mtipx2xx/Kconfig
b/drivers/block/mtipx2xx/Kconfig
--- a/drivers/block/mtipx2xx/Kconfig	1969-12-31 17:00:00.000000000
-0700
+++ b/drivers/block/mtipx2xx/Kconfig	2011-05-03 12:57:34.000000000
-0600
@@ -0,0 +1,13 @@
+#
+# mtipx2xx device driver configuration
+#
+
+config BLK_DEV_PCIE_SSD
+        tristate "Block Device Driver for Micron PCIe SSDs"
+        depends on  HOTPLUG_PCI_PCIE
+        default n
+        help
+
+          This option enables block device driver for Micron PCIe SSDs.
This
+          driver depends on pciehp module to support surprise insertion
+          surprise removal (SRSI) of the device.
diff -uNr a/drivers/block/mtipx2xx/Makefile
b/drivers/block/mtipx2xx/Makefile
--- a/drivers/block/mtipx2xx/Makefile	1969-12-31 17:00:00.000000000
-0700
+++ b/drivers/block/mtipx2xx/Makefile	2011-05-03 12:57:34.000000000
-0600
@@ -0,0 +1,7 @@
+#
+# Makefile for  Block device driver for Micron PCIe SSD
+#
+
+obj-$(CONFIG_BLK_DEV_PCIE_SSD) += mtipx2xx.o
+
+mtipx2xx-y := module.o pci.o block.o ahci.o
