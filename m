From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 05/13] libata-acpi: s/CONFIG_SATA_ACPI/CONFIG_ATA_ACPI/
Date: Mon, 23 Apr 2007 02:41:06 +0900
Message-ID: <11772636664152-git-send-email-htejun@gmail.com>
References: <11772636651400-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <11772636651400-git-send-email-htejun@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
To: jeff@garzik.org, mjg59@srcf.ucam.org, rdunlap@xenotime.net, trenn@suse.de, alan@lxorguk.ukuu.org.uk, forrest.zhao@gmail.com, kristen.c.accardi@intel.com, lenb@kernel.org, linux-acpi@vger.kernel.org, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>
List-Id: linux-ide@vger.kernel.org

ACPI applies to both SATA and PATA.  Drop the 'S' from the config
variable.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/Kconfig    |   26 +++++++++++++-------------
 drivers/ata/Makefile   |    2 +-
 drivers/ata/libata.h   |    2 +-
 include/linux/libata.h |    2 +-
 4 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
index 365c306..6ee8f42 100644
--- a/drivers/ata/Kconfig
+++ b/drivers/ata/Kconfig
@@ -23,6 +23,19 @@ config ATA_NONSTANDARD
        bool
        default n
 
+config ATA_ACPI
+	bool
+	depends on ACPI && PCI
+	default y
+	help
+	  This option adds support for ATA-related ACPI objects.
+	  These ACPI objects add the ability to retrieve taskfiles
+	  from the ACPI BIOS and write them to the disk controller.
+	  These objects may be related to performance, security,
+	  power management, or other areas.
+	  You can disable this at kernel boot time by using the
+	  option libata.noacpi=1
+
 config SATA_AHCI
 	tristate "AHCI SATA support"
 	depends on PCI
@@ -156,19 +169,6 @@ config SATA_INIC162X
 	help
 	  This option enables support for Initio 162x Serial ATA.
 
-config SATA_ACPI
-	bool
-	depends on ACPI && PCI
-	default y
-	help
-	  This option adds support for SATA-related ACPI objects.
-	  These ACPI objects add the ability to retrieve taskfiles
-	  from the ACPI BIOS and write them to the disk controller.
-	  These objects may be related to performance, security,
-	  power management, or other areas.
-	  You can disable this at kernel boot time by using the
-	  option libata.noacpi=1
-
 config PATA_ALI
 	tristate "ALi PATA support (Experimental)"
 	depends on PCI && EXPERIMENTAL
diff --git a/drivers/ata/Makefile b/drivers/ata/Makefile
index b7055e3..f9e53c1 100644
--- a/drivers/ata/Makefile
+++ b/drivers/ata/Makefile
@@ -68,4 +68,4 @@ obj-$(CONFIG_ATA_GENERIC)	+= ata_generic.o
 obj-$(CONFIG_PATA_LEGACY)	+= pata_legacy.o
 
 libata-objs	:= libata-core.o libata-scsi.o libata-sff.o libata-eh.o
-libata-$(CONFIG_SATA_ACPI) += libata-acpi.o
+libata-$(CONFIG_ATA_ACPI)	+= libata-acpi.o
diff --git a/drivers/ata/libata.h b/drivers/ata/libata.h
index c40665a..122bc16 100644
--- a/drivers/ata/libata.h
+++ b/drivers/ata/libata.h
@@ -97,7 +97,7 @@ extern int ata_cmd_ioctl(struct scsi_device *scsidev, void __user *arg);
 extern struct ata_port *ata_port_alloc(struct ata_host *host);
 
 /* libata-acpi.c */
-#ifdef CONFIG_SATA_ACPI
+#ifdef CONFIG_ATA_ACPI
 extern int ata_acpi_exec_tfs(struct ata_port *ap);
 extern int ata_acpi_push_id(struct ata_port *ap, unsigned int ix);
 #else
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 3cffbf6..8a577c2 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -474,7 +474,7 @@ struct ata_device {
 	struct ata_ering	ering;
 	int			spdn_cnt;
 	unsigned int		horkage;	/* List of broken features */
-#ifdef CONFIG_SATA_ACPI
+#ifdef CONFIG_ATA_ACPI
 	/* ACPI objects info */
 	acpi_handle obj_handle;
 #endif
-- 
1.5.0.3


