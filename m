From: Randy Dunlap <randy_d_dunlap@linux.intel.com>
Subject: [PATCH 2/5] SATA/ACPI Make/Kconfig/docs
Date: Tue, 27 Dec 2005 15:29:41 -0800
Message-ID: <20051227152941.44652c9d.randy_d_dunlap@linux.intel.com>
References: <20051227152613.25d580ff.randy_d_dunlap@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fmr19.intel.com ([134.134.136.18]:50633 "EHLO
	orsfmr004.jf.intel.com") by vger.kernel.org with ESMTP
	id S932393AbVL0XeV (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 27 Dec 2005 18:34:21 -0500
In-Reply-To: <20051227152613.25d580ff.randy_d_dunlap@linux.intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Randy Dunlap <randy_d_dunlap@linux.intel.com>
Cc: linux-ide@vger.kernel.org, jgarzik@pobox.com, axboe <axboe@suse.de>

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

--- linux-2615-rc7-sat.orig/drivers/scsi/Makefile
+++ linux-2615-rc7-sat/drivers/scsi/Makefile
@@ -164,6 +164,9 @@ CFLAGS_ncr53c8xx.o	:= $(ncr53c8xx-flags-
 zalon7xx-objs	:= zalon.o ncr53c8xx.o
 NCR_Q720_mod-objs	:= NCR_Q720.o ncr53c8xx.o
 libata-objs	:= libata-core.o libata-scsi.o
+ifeq ($(CONFIG_SCSI_SATA_ACPI),y)
+  libata-objs	+= libata-acpi.o
+endif
 
 # Files generated that shall be removed upon make clean
 clean-files :=	53c7xx_d.h 53c700_d.h	\
--- linux-2615-rc7-sat.orig/drivers/scsi/Kconfig
+++ linux-2615-rc7-sat/drivers/scsi/Kconfig
@@ -598,6 +598,11 @@ config SCSI_SATA_INTEL_COMBINED
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
--- linux-2615-rc7-sat.orig/include/linux/libata.h
+++ linux-2615-rc7-sat/include/linux/libata.h
@@ -33,6 +33,7 @@
 #include <asm/io.h>
 #include <linux/ata.h>
 #include <linux/workqueue.h>
+#include <acpi/acpi.h>
 
 /*
  * compile-time options
@@ -312,6 +313,11 @@ struct ata_device {
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
--- linux-2615-rc7-sat.orig/Documentation/DocBook/libata.tmpl
+++ linux-2615-rc7-sat/Documentation/DocBook/libata.tmpl
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
 

---

