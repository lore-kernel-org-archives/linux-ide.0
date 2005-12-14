From: Randy Dunlap <randy_d_dunlap@linux.intel.com>
Subject: [PATCH 3/7] SATA ACPI linux/libata.h update
Date: Tue, 13 Dec 2005 16:05:30 -0800
Message-ID: <20051213160530.1fcadda0.randy_d_dunlap@linux.intel.com>
References: <20051213160110.193e3f61.randy_d_dunlap@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fmr18.intel.com ([134.134.136.17]:32421 "EHLO
	orsfmr003.jf.intel.com") by vger.kernel.org with ESMTP
	id S1030365AbVLNAHy (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 13 Dec 2005 19:07:54 -0500
In-Reply-To: <20051213160110.193e3f61.randy_d_dunlap@linux.intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: ide <linux-ide@vger.kernel.org>
Cc: axboe@suse.de, jgarzik@pobox.com

From: Randy Dunlap <randy_d_dunlap@linux.intel.com>

Add ACPI data pointer/length holders.

Signed-off-by: Randy Dunlap <randy_d_dunlap@linux.intel.com>
---
 include/linux/libata.h |    8 ++++++++
 1 files changed, 8 insertions(+)

--- linux-2615-rc5g3.orig/include/linux/libata.h
+++ linux-2615-rc5g3/include/linux/libata.h
@@ -33,6 +33,7 @@
 #include <asm/io.h>
 #include <linux/ata.h>
 #include <linux/workqueue.h>
+#include <acpi/acpi.h>
 
 /*
  * compile-time options
@@ -311,6 +312,13 @@ struct ata_device {
 	u16			cylinders;	/* Number of cylinders */
 	u16			heads;		/* Number of heads */
 	u16			sectors;	/* Number of sectors per track */
+
+#ifdef CONFIG_SCSI_SATA_ACPI
+	/* ACPI objects info */
+	acpi_handle		obj_handle;
+	acpi_size		gtf_length;
+	u8			*gtf_address;
+#endif
 };
 
 struct ata_port {


---
