From: Randy Dunlap <randy_d_dunlap@linux.intel.com>
Subject: [PATCH 1/13] ATA ACPI: Makefile/Kconfig/doc.
Date: Wed, 22 Feb 2006 13:40:54 -0800
Message-ID: <20060222134054.69373431.randy_d_dunlap@linux.intel.com>
References: <20060222133241.595a8509.randy_d_dunlap@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1161141AbWBVWQ2@vger.kernel.org>
In-Reply-To: <20060222133241.595a8509.randy_d_dunlap@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: lkml <linux-kernel@vger.kernel.org>
Cc: linux-ide@vger.kernel.org, akpm@osdl.org, jgarzik@pobox.com
List-Id: linux-ide@vger.kernel.org

From: Randy Dunlap <randy_d_dunlap@linux.intel.com>

Add ata_acpi in Makefile and Kconfig.
Add ACPI obj_handle.
Add ata_acpi.c to libata kernel-doc template file.

Signed-off-by: Randy Dunlap <randy_d_dunlap@linux.intel.com>
---
 Documentation/DocBook/libata.tmpl |    6 ++++++
 drivers/scsi/Kconfig              |    5 +++++
 drivers/scsi/Makefile             |    3 +++
 include/linux/libata.h            |    6 ++++++
 4 files changed, 20 insertions(+)

--- linux-2616-rc4-ata.orig/drivers/scsi/Makefile
+++ linux-2616-rc4-ata/drivers/scsi/Makefile
@@ -164,6 +164,9 @@ CFLAGS_ncr53c8xx.o	:= $(ncr53c8xx-flags-
 zalon7xx-objs	:= zalon.o ncr53c8xx.o
 NCR_Q720_mod-objs	:= NCR_Q720.o ncr53c8xx.o
 libata-objs	:= libata-core.o libata-scsi.o
+ifeq ($(CONFIG_SCSI_SATA_ACPI),y)
+  libata-objs	+= libata-acpi.o
+endif
 oktagon_esp_mod-objs	:= oktagon_esp.o oktagon_io.o
 
 # Files generated that shall be removed upon make clean
--- linux-2616-rc4-ata.orig/drivers/scsi/Kconfig
+++ linux-2616-rc4-ata/drivers/scsi/Kconfig
@@ -599,6 +599,11 @@ config SCSI_SATA_INTEL_COMBINED
 	depends on IDE=y && !BLK_DEV_IDE_SATA && (SCSI_SATA_AHCI || SCSI_ATA_PIIX)
 	default y
 
+config SCSI_SATA_ACPI
+	bool
+	depends on SCSI_SATA && ACPI
+	default y
+
 config SCSI_BUSLOGIC
 	tristate "BusLogic SCSI support"
 	depends on (PCI || ISA || MCA) && SCSI && ISA_DMA_API
--- linux-2616-rc4-ata.orig/include/linux/libata.h
+++ linux-2616-rc4-ata/include/linux/libata.h
@@ -33,6 +33,7 @@
 #include <asm/io.h>
 #include <linux/ata.h>
 #include <linux/workqueue.h>
+#include <acpi/acpi.h>
 
 /*
  * compile-time options
@@ -318,6 +319,11 @@ struct ata_device {
 	u16			cylinders;	/* Number of cylinders */
 	u16			heads;		/* Number of heads */
 	u16			sectors;	/* Number of sectors per track */
+
+#ifdef CONFIG_SCSI_SATA_ACPI
+	/* ACPI objects info */
+	acpi_handle		obj_handle;
+#endif
 };
 
 struct ata_port {
--- linux-2616-rc4-ata.orig/Documentation/DocBook/libata.tmpl
+++ linux-2616-rc4-ata/Documentation/DocBook/libata.tmpl
@@ -787,6 +787,12 @@ and other resources, etc.
 !Idrivers/scsi/libata-scsi.c
   </chapter>
 
+  <chapter id="libataAcpi">
+     <title>libata ACPI interfaces/methods</title>
+!Edrivers/scsi/ata_acpi.c
+!Idrivers/scsi/ata_acpi.c
+  </chapter>
+
   <chapter id="ataExceptions">
      <title>ATA errors &amp; exceptions</title>
 
