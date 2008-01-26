From: Mark Lord <liml@rtr.ca>
Subject: [PATCH 13/13] sata_mv ncq Comments and version bump
Date: Sat, 26 Jan 2008 18:33:59 -0500
Message-ID: <479BC367.8070402@rtr.ca>
References: <479BC217.60709@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:1692 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752901AbYAZXeA (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 26 Jan 2008 18:34:00 -0500
In-Reply-To: <479BC217.60709@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

Remove some obsolete comments, and bump up the driver version number.

Signed-off-by: Mark Lord <mlord@pobox.com>

--- old/drivers/ata/sata_mv.c	2008-01-26 11:05:54.000000000 -0500
+++ new/drivers/ata/sata_mv.c	2008-01-26 11:12:32.000000000 -0500
@@ -29,7 +29,13 @@
   I distinctly remember a couple workarounds (one related to PCI-X)
   are still needed.
 
-  4) Add NCQ support (easy to intermediate, once new-EH support appears)
+  2) Improve/fix IRQ and error handling sequences.
+
+  3) ATAPI support (Marvell claims the 60xx/70xx chips can do it).
+
+  4) Think about TCQ support here, and for libata in general
+  with controllers that suppport it via host-queuing hardware
+  (a software-only implementation could be a nightmare).
 
   5) Investigate problems with PCI Message Signalled Interrupts (MSI).
 
@@ -53,8 +59,6 @@
   Target mode, for those without docs, is the ability to directly
   connect two SATA controllers.
 
-  13) Verify that 7042 is fully supported.  I only have a 6042.
-
 */
 
 
@@ -73,7 +77,7 @@
 #include <linux/libata.h>
 
 #define DRV_NAME	"sata_mv"
-#define DRV_VERSION	"1.01"
+#define DRV_VERSION	"1.20"
 
 enum {
 	/* BAR's are enumerated in terms of pci_resource_start() terms */
