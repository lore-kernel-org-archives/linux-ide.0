From: Randy Dunlap <randy_d_dunlap@linux.intel.com>
Subject: [RFC 2/5] ata_acpi: libata.h fields
Date: Wed, 23 Nov 2005 15:51:03 -0800
Message-ID: <20051123155103.7e58140c.randy_d_dunlap@linux.intel.com>
References: <20051123154055.6ab5cab2.randy_d_dunlap@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fmr17.intel.com ([134.134.136.16]:38055 "EHLO
	orsfmr002.jf.intel.com") by vger.kernel.org with ESMTP
	id S1751323AbVKWX7u (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 23 Nov 2005 18:59:50 -0500
In-Reply-To: <20051123154055.6ab5cab2.randy_d_dunlap@linux.intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org

From: Randy Dunlap <randy_d_dunlap@linux.intel.com>

Add ACPI data pointer/length holders.

Signed-off-by: Randy Dunlap <randy_d_dunlap@linux.intel.com>
 include/linux/libata.h |    6 ++++++
 1 files changed, 6 insertions(+)

--- linux-2615-rc2c.orig/include/linux/libata.h
+++ linux-2615-rc2c/include/linux/libata.h
@@ -33,6 +33,7 @@
 #include <asm/io.h>
 #include <linux/ata.h>
 #include <linux/workqueue.h>
+#include <acpi/acpi.h>
 
 /*
  * compile-time options
@@ -310,6 +311,11 @@ struct ata_device {
 	u16			cylinders;	/* Number of cylinders */
 	u16			heads;		/* Number of heads */
 	u16			sectors;	/* Number of sectors per track */
+
+	/* ACPI objects info */
+	acpi_handle		obj_handle;
+	acpi_size		gtf_length;
+	u8			*gtf_address;
 };
 
 struct ata_port {


---
