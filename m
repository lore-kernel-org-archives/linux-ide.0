From: Randy Dunlap <randy_d_dunlap@linux.intel.com>
Subject: [PATCH 2/6] SATA ACPI: make/config changes
Date: Fri, 2 Dec 2005 10:04:52 -0800
Message-ID: <20051202100452.1e740baf.randy_d_dunlap@linux.intel.com>
References: <20051202100119.032b242e.randy_d_dunlap@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fmr17.intel.com ([134.134.136.16]:45457 "EHLO
	orsfmr002.jf.intel.com") by vger.kernel.org with ESMTP
	id S1750899AbVLBSOG (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 2 Dec 2005 13:14:06 -0500
In-Reply-To: <20051202100119.032b242e.randy_d_dunlap@linux.intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: ide <linux-ide@vger.kernel.org>
Cc: axboe@suse.de, jgarzik@pobox.com

From: Randy Dunlap <randy_d_dunlap@linux.intel.com>

Add ata_acpi in Makefile and Kconfig.

Signed-off-by: Randy Dunlap <randy_d_dunlap@linux.intel.com>
---
 drivers/scsi/Kconfig  |    5 +++++
 drivers/scsi/Makefile |    1 +
 2 files changed, 6 insertions(+)

--- linux-2615-rc4.orig/drivers/scsi/Makefile
+++ linux-2615-rc4/drivers/scsi/Makefile
@@ -138,6 +138,7 @@ obj-$(CONFIG_SCSI_SATA_NV)	+= libata.o s
 obj-$(CONFIG_SCSI_SATA_ULI)	+= libata.o sata_uli.o
 obj-$(CONFIG_SCSI_SATA_MV)	+= libata.o sata_mv.o
 obj-$(CONFIG_SCSI_PDC_ADMA)	+= libata.o pdc_adma.o
+obj-$(CONFIG_SCSI_SATA_ACPI)	+= libata.o ata_acpi.o
 
 obj-$(CONFIG_ARM)		+= arm/
 
--- linux-2615-rc4.orig/drivers/scsi/Kconfig
+++ linux-2615-rc4/drivers/scsi/Kconfig
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


---
