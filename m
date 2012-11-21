From: Aaron Lu <aaron.lu@intel.com>
Subject: [PATCH v10 02/10] libata: Add CONFIG_SATA_ZPODD
Date: Wed, 21 Nov 2012 19:50:31 +0800
Message-ID: <1353498639-27631-3-git-send-email-aaron.lu@intel.com>
References: <1353498639-27631-1-git-send-email-aaron.lu@intel.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:9387 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753877Ab2KULua (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 21 Nov 2012 06:50:30 -0500
In-Reply-To: <1353498639-27631-1-git-send-email-aaron.lu@intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, Tejun Heo <tj@kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, Alan Stern <stern@rowland.harvard.edu>
Cc: James Bottomley <James.Bottomley@hansenpartnership.com>, Jeff Wu <jeff.wu@amd.com>, Aaron Lu <aaron.lwe@gmail.com>, linux-ide@vger.kernel.org, linux-linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org

Added a new config CONFIG_SATA_ZPODD, which is used to support
SATA based zero power ODD, and depends on ATA_ACPI.

Signed-off-by: Aaron Lu <aaron.lu@intel.com>
---
 drivers/ata/Kconfig  | 13 +++++++++++++
 drivers/ata/Makefile |  1 +
 2 files changed, 14 insertions(+)

diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
index e08d322..996d16c 100644
--- a/drivers/ata/Kconfig
+++ b/drivers/ata/Kconfig
@@ -58,6 +58,19 @@ config ATA_ACPI
 	  You can disable this at kernel boot time by using the
 	  option libata.noacpi=1
 
+config SATA_ZPODD
+	bool "SATA Zero Power ODD Support"
+	depends on ATA_ACPI
+	default n
+	help
+	  This option adds support for SATA ZPODD. It requires both
+	  ODD and the platform support, and if enabled, will automatically
+	  power on/off the ODD when certain condition is satisfied. This
+	  does not impact user's experience of the ODD, only power is saved
+	  when ODD is not in use(i.e. no disc inside).
+
+	  If unsure, say N.
+
 config SATA_PMP
 	bool "SATA Port Multiplier support"
 	default y
diff --git a/drivers/ata/Makefile b/drivers/ata/Makefile
index 9329daf..85e3de4 100644
--- a/drivers/ata/Makefile
+++ b/drivers/ata/Makefile
@@ -107,3 +107,4 @@ libata-y	:= libata-core.o libata-scsi.o libata-eh.o libata-transport.o
 libata-$(CONFIG_ATA_SFF)	+= libata-sff.o
 libata-$(CONFIG_SATA_PMP)	+= libata-pmp.o
 libata-$(CONFIG_ATA_ACPI)	+= libata-acpi.o
+libata-$(CONFIG_SATA_ZPODD)	+= libata-zpodd.o
-- 
1.7.12.4

