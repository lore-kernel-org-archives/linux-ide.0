From: "zhao, forrest" <forrest.zhao@intel.com>
Subject: [PATCH 1/3] Makefile/Kconfig/doc/definition of noacpi
Date: Fri, 23 Jun 2006 14:39:34 +0800
Message-ID: <1151044774.7132.154.camel@forrest26.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:34884 "EHLO
	fmsmga101-1.fm.intel.com") by vger.kernel.org with ESMTP
	id S932884AbWFWGwO (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 23 Jun 2006 02:52:14 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, rdunlap@xenotime.net, htejun@gmail.com
Cc: linux-ide@vger.kernel.org

This patch updated the Makefile, Kconfig, kernel-parameters.txt, and added
definition of noacpi.


Signed-off-by: Zhao Forrest <forrest.zhao@intel.com>

---

 Documentation/kernel-parameters.txt |    5 +++++
 drivers/scsi/Kconfig                |   13 +++++++++++++
 drivers/scsi/Makefile               |    1 +
 drivers/scsi/libata-core.c          |    4 ++++
 drivers/scsi/libata.h               |    1 +
 5 files changed, 24 insertions(+), 0 deletions(-)

aeb16f3e54806143a6a790a918b969ae60d2eeb1
diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
index b3a6187..770bc86 100644
--- a/Documentation/kernel-parameters.txt
+++ b/Documentation/kernel-parameters.txt
@@ -49,6 +49,7 @@ parameter is applicable:
 	ISAPNP	ISA PnP code is enabled.
 	ISDN	Appropriate ISDN support is enabled.
 	JOY	Appropriate joystick support is enabled.
+	LIBATA  Libata driver is enabled.
 	LP	Printer support is enabled.
 	LOOP	Loopback device support is enabled.
 	M68k	M68k architecture is enabled.
@@ -1001,6 +1002,10 @@ running once the system is up.
 			emulation library even if a 387 maths coprocessor
 			is present.
 
+	noacpi		[LIBATA] Disables use of ACPI in libata suspend/resume
+			when set.
+			Format: <int>
+
 	noalign		[KNL,ARM]
 
 	noapic		[SMP,APIC] Tells the kernel to not make use of any
diff --git a/drivers/scsi/Kconfig b/drivers/scsi/Kconfig
index a480a37..f71c4e3 100644
--- a/drivers/scsi/Kconfig
+++ b/drivers/scsi/Kconfig
@@ -609,6 +609,19 @@ config SCSI_SATA_INTEL_COMBINED
 	depends on IDE=y && !BLK_DEV_IDE_SATA && (SCSI_SATA_AHCI || SCSI_ATA_PIIX)
 	default y
 
+config SCSI_SATA_ACPI
+	bool
+	depends on SCSI_SATA && ACPI && PCI
+	default y
+	help
+	  This option adds support for SATA-related ACPI objects.
+	  These ACPI objects add the ability to retrieve taskfiles
+	  from the ACPI BIOS and write them to the disk controller.
+	  These objects may be related to performance, security,
+	  power management, or other areas.
+	  You can disable this at kernel boot time by using the
+	  option 'libata.noacpi'.
+
 config SCSI_BUSLOGIC
 	tristate "BusLogic SCSI support"
 	depends on (PCI || ISA || MCA) && SCSI && ISA_DMA_API
diff --git a/drivers/scsi/Makefile b/drivers/scsi/Makefile
index 669ff6b..c1a5f71 100644
--- a/drivers/scsi/Makefile
+++ b/drivers/scsi/Makefile
@@ -165,6 +165,7 @@ CFLAGS_ncr53c8xx.o	:= $(ncr53c8xx-flags-
 zalon7xx-objs	:= zalon.o ncr53c8xx.o
 NCR_Q720_mod-objs	:= NCR_Q720.o ncr53c8xx.o
 libata-objs	:= libata-core.o libata-scsi.o libata-bmdma.o libata-eh.o
+libata-$(CONFIG_SCSI_SATA_ACPI) += libata-acpi.o
 oktagon_esp_mod-objs	:= oktagon_esp.o oktagon_io.o
 
 # Files generated that shall be removed upon make clean
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index 89c3fbe..a11b674 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -88,6 +88,10 @@ int libata_fua = 0;
 module_param_named(fua, libata_fua, int, 0444);
 MODULE_PARM_DESC(fua, "FUA support (0=off, 1=on)");
 
+int noacpi = 0;
+module_param(noacpi, int, 0444);
+MODULE_PARM_DESC(noacpi, "Disables use of ACPI in suspend/resume when set");
+
 MODULE_AUTHOR("Jeff Garzik");
 MODULE_DESCRIPTION("Library module for ATA devices");
 MODULE_LICENSE("GPL");
diff --git a/drivers/scsi/libata.h b/drivers/scsi/libata.h
index bdd4888..ca31bcb 100644
--- a/drivers/scsi/libata.h
+++ b/drivers/scsi/libata.h
@@ -43,6 +43,7 @@ extern struct workqueue_struct *ata_aux_
 extern int atapi_enabled;
 extern int atapi_dmadir;
 extern int libata_fua;
+extern int noacpi;
 extern struct ata_queued_cmd *ata_qc_new_init(struct ata_device *dev);
 extern int ata_rwcmd_protocol(struct ata_queued_cmd *qc);
 extern void ata_dev_disable(struct ata_device *dev);
-- 
1.2.6
