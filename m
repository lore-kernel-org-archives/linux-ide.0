From: Arjan van de Ven <arjan@infradead.org>
Subject: [patch 2/2] fastboot: use a DMI match table to set defaults for
 port-disable
Date: Mon, 11 Aug 2008 15:37:30 -0700
Message-ID: <20080811153730.74599410@infradead.org>
References: <20080811153542.61095e5c@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:35798 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752318AbYHKWh0 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 11 Aug 2008 18:37:26 -0400
In-Reply-To: <20080811153542.61095e5c@infradead.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Arjan van de Ven <arjan@infradead.org>, linux-ide@vger.kernel.org


From: Arjan van de Ven <arjan@linux.intel.com>
Subject: [PATCH] libata: use a DMI match table to set defaults for port-disable

As suggested by Jeff:
This patch adds a DMI table that is used for setting defaults for
the new dont-probe-port parameter boot time optimization feature.

Initially, the table only contains the Asus EeePC 901 as this is the
device I have for testing.

Signed-off-by: Arjan van de Ven <arjan@linux.intel.com>
---
 drivers/ata/libata-core.c |   33 +++++++++++++++++++++++++++++++++
 1 files changed, 33 insertions(+), 0 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 831a8ca..a6b0540 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -56,6 +56,7 @@
 #include <linux/workqueue.h>
 #include <linux/scatterlist.h>
 #include <linux/io.h>
+#include <linux/dmi.h>
 #include <scsi/scsi.h>
 #include <scsi/scsi_cmnd.h>
 #include <scsi/scsi_host.h>
@@ -166,6 +167,37 @@ MODULE_LICENSE("GPL");
 MODULE_VERSION(DRV_VERSION);
 
 
+static int __init dmi_disable_ports(const struct dmi_system_id *d)
+{
+	int value = (unsigned long)d->driver_data;
+
+	printk(KERN_INFO "libata: DMI match used to disable probing\n");
+	libata_disable_ports |= value;
+	return 0;
+}
+
+#define DMI_PORT_ATA1 (void *)0x1
+#define DMI_PORT_ATA2 (void *)0x2
+#define DMI_PORT_ATA3 (void *)0x4
+#define DMI_PORT_ATA4 (void *)0x8
+
+static struct dmi_system_id libata_dmi_table[] __initdata = {
+	/*
+	 * The Asus EeePC901 has its devices attached to ATA2 only
+	 */
+	{
+	.callback = dmi_disable_ports,
+	.driver_data = DMI_PORT_ATA1,
+	.ident = "Asus EeePC 901",
+	.matches = {
+		     DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK Computer INC."),
+		     DMI_MATCH(DMI_PRODUCT_NAME, "901"),
+		},
+	},
+	{}
+};
+
+
 /**
  *	ata_force_cbl - force cable type according to libata.force
  *	@ap: ATA port of interest
@@ -6126,6 +6158,7 @@ static void __init ata_parse_force_param(void)
 static int __init ata_init(void)
 {
 	ata_parse_force_param();
+	dmi_check_system(libata_dmi_table);
 
 	ata_wq = create_workqueue("ata");
 	if (!ata_wq)
-- 
1.5.5.1

