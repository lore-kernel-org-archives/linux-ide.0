From: "Adrian McMenamin" <lkmladrian@gmail.com>
Subject: [PATCH 1/3] Add GD-Rom support to the SEGA Dreamcast
Date: Sun, 16 Dec 2007 00:21:05 +0000
Message-ID: <8b67d60712151621i5134eb7co9bab02cfe9e4fb81@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-sh-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, Paul Mundt <lethal@linux-sh.org>, linux-sh@vger.kernel.org, linux-ide@vger.kernel.org, axboe@kernel.dk
List-Id: linux-ide@vger.kernel.org

diff -ruN ./linux-2.6-orig/drivers/block/Kconfig
./linux-2.6/drivers/block/Kconfig
--- ./linux-2.6-orig/drivers/block/Kconfig	2007-12-15 22:23:47.000000000 +0000
+++ ./linux-2.6/drivers/block/Kconfig	2007-12-15 22:18:28.000000000 +0000
@@ -105,6 +105,18 @@
 	  "MicroSolutions backpack protocol", "DataStor Commuter protocol"
 	  etc.).

+config	GDROM
+	tristate "SEGA Dreamcast GD-ROM drive"
+	depends on SH_DREAMCAST
+	help
+	  A standard SEGA Dreamcast comes with a modified CD ROM drive called a
+	  "GD-ROM" by SEGA to signify it is capable of reading special disks
+	  with up to 1 GB of data. This drive will also read standard CD ROM
+	  disks. Select this option to access any disks in you GD ROM drive.
+         Most users will want to say "Y" here.
+	  You can also build this as a module - which will be called gdrom.ko
+
+
 source "drivers/block/paride/Kconfig"

 config BLK_CPQ_DA
diff -ruN ./linux-2.6-orig/drivers/cdrom/Makefile
./linux-2.6/drivers/cdrom/Makefile
--- ./linux-2.6-orig/drivers/cdrom/Makefile	2007-12-15 22:23:47.000000000 +0000
+++ ./linux-2.6/drivers/cdrom/Makefile	2007-12-15 22:18:29.000000000 +0000
@@ -11,3 +11,4 @@
 obj-$(CONFIG_CDROM_PKTCDVD)	+=		cdrom.o

 obj-$(CONFIG_VIOCD)		+= viocd.o      cdrom.o
+obj-$(CONFIG_GDROM)		+=		cdrom.o
