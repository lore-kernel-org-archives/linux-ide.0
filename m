From: Randy Dunlap <randy_d_dunlap@linux.intel.com>
Subject: [PATCH 2/7] SATA ACPI make/config
Date: Tue, 13 Dec 2005 16:04:07 -0800
Message-ID: <20051213160407.7edfde9e.randy_d_dunlap@linux.intel.com>
References: <20051213160110.193e3f61.randy_d_dunlap@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fmr17.intel.com ([134.134.136.16]:37561 "EHLO
	orsfmr002.jf.intel.com") by vger.kernel.org with ESMTP
	id S1030364AbVLNAHv (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 13 Dec 2005 19:07:51 -0500
In-Reply-To: <20051213160110.193e3f61.randy_d_dunlap@linux.intel.com>
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

--- linux-2615-rc5g3.orig/drivers/scsi/Makefile
+++ linux-2615-rc5g3/drivers/scsi/Makefile
@@ -138,6 +138,7 @@ obj-$(CONFIG_SCSI_SATA_NV)	+= libata.o s
 obj-$(CONFIG_SCSI_SATA_ULI)	+= libata.o sata_uli.o
 obj-$(CONFIG_SCSI_SATA_MV)	+= libata.o sata_mv.o
 obj-$(CONFIG_SCSI_PDC_ADMA)	+= libata.o pdc_adma.o
+obj-$(CONFIG_SCSI_SATA_ACPI)	+= libata.o ata_acpi.o
 
 obj-$(CONFIG_ARM)		+= arm/
 
--- linux-2615-rc5g3.orig/drivers/scsi/Kconfig
+++ linux-2615-rc5g3/drivers/scsi/Kconfig
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
