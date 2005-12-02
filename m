From: Randy Dunlap <randy_d_dunlap@linux.intel.com>
Subject: [PATCH 3/6] SATA ACPI: libata.h changes
Date: Fri, 2 Dec 2005 10:05:41 -0800
Message-ID: <20051202100541.1dfb3db4.randy_d_dunlap@linux.intel.com>
References: <20051202100119.032b242e.randy_d_dunlap@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fmr20.intel.com ([134.134.136.19]:51857 "EHLO
	orsfmr005.jf.intel.com") by vger.kernel.org with ESMTP
	id S1750897AbVLBSOD (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 2 Dec 2005 13:14:03 -0500
In-Reply-To: <20051202100119.032b242e.randy_d_dunlap@linux.intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: ide <linux-ide@vger.kernel.org>
Cc: axboe@suse.de, jgarzik@pobox.com

From: Randy Dunlap <randy_d_dunlap@linux.intel.com>

Add ACPI data pointer/length holders.

Signed-off-by: Randy Dunlap <randy_d_dunlap@linux.intel.com>
---
 include/linux/libata.h |    6 ++++++
 1 files changed, 6 insertions(+)

--- linux-2615-rc4.orig/include/linux/libata.h
+++ linux-2615-rc4/include/linux/libata.h
@@ -33,6 +33,7 @@
 #include <asm/io.h>
 #include <linux/ata.h>
 #include <linux/workqueue.h>
+#include <acpi/acpi.h>
 
 /*
  * compile-time options
@@ -311,6 +312,11 @@ struct ata_device {
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
