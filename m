From: Mark Lord <liml@rtr.ca>
Subject: [PATCH 8/8] sata_mv re-enable hotplug, update TODO list
Date: Sat, 19 Apr 2008 14:54:41 -0400
Message-ID: <480A3FF1.4030305@rtr.ca>
References: <480A3D2E.4040503@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:3920 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755791AbYDSSyi (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 19 Apr 2008 14:54:38 -0400
In-Reply-To: <480A3D2E.4040503@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, Tejun Heo <htejun@gmail.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

Re-enable hotplug, now that the interrupt/error handling are mostly sane.
Also update the TODO list at the top.

Signed-off-by: Mark Lord <mlord@pobox.com>

--- old/drivers/ata/sata_mv.c	2008-04-19 13:53:33.000000000 -0400
+++ linux/drivers/ata/sata_mv.c	2008-04-19 13:56:32.000000000 -0400
@@ -23,46 +23,34 @@
  */
 
 /*
-  sata_mv TODO list:
-
-  1) Needs a full errata audit for all chipsets.  I implemented most
-  of the errata workarounds found in the Marvell vendor driver, but
-  I distinctly remember a couple workarounds (one related to PCI-X)
-  are still needed.
-
-  2) Improve/fix IRQ and error handling sequences.
-
-  3) ATAPI support (Marvell claims the 60xx/70xx chips can do it).
-
-  4) Think about TCQ support here, and for libata in general
-  with controllers that suppport it via host-queuing hardware
-  (a software-only implementation could be a nightmare).
-
-  5) Investigate problems with PCI Message Signalled Interrupts (MSI).
-
-  6) Cache frequently-accessed registers in mv_port_priv to reduce overhead.
-
-  7) Fix/reenable hot plug/unplug (should happen as a side-effect of (2) above).
-
-  8) Develop a low-power-consumption strategy, and implement it.
-
-  9) [Experiment, low priority] See if ATAPI can be supported using
-  "unknown FIS" or "vendor-specific FIS" support, or something creative
-  like that.
-
-  10) [Experiment, low priority] Investigate interrupt coalescing.
-  Quite often, especially with PCI Message Signalled Interrupts (MSI),
-  the overhead reduced by interrupt mitigation is quite often not
-  worth the latency cost.
-
-  11) [Experiment, Marvell value added] Is it possible to use target
-  mode to cross-connect two Linux boxes with Marvell cards?  If so,
-  creating LibATA target mode support would be very interesting.
-
-  Target mode, for those without docs, is the ability to directly
-  connect two SATA controllers.
-
-*/
+ * sata_mv TODO list:
+ *
+ * --> Errata workaround for NCQ device errors.
+ *
+ * --> More errata workarounds for PCI-X.
+ *
+ * --> Complete a full errata audit for all chipsets to identify others.
+ *
+ * --> ATAPI support (Marvell claims the 60xx/70xx chips can do it).
+ *
+ * --> Investigate problems with PCI Message Signalled Interrupts (MSI).
+ *
+ * --> Cache frequently-accessed registers in mv_port_priv to reduce overhead.
+ *
+ * --> Develop a low-power-consumption strategy, and implement it.
+ *
+ * --> [Experiment, low priority] Investigate interrupt coalescing.
+ *       Quite often, especially with PCI Message Signalled Interrupts (MSI),
+ *       the overhead reduced by interrupt mitigation is quite often not
+ *       worth the latency cost.
+ *
+ * --> [Experiment, Marvell value added] Is it possible to use target
+ *       mode to cross-connect two Linux boxes with Marvell cards?  If so,
+ *       creating LibATA target mode support would be very interesting.
+ *
+ *       Target mode, for those without docs, is the ability to directly
+ *       connect two SATA ports.
+ */
 
 #include <linux/kernel.h>
 #include <linux/module.h>
@@ -299,9 +287,7 @@
 	EDMA_ERR_IRQ_TRANSIENT  = EDMA_ERR_LNK_CTRL_RX_0 |
 				  EDMA_ERR_LNK_CTRL_RX_1 |
 				  EDMA_ERR_LNK_CTRL_RX_3 |
-				  EDMA_ERR_LNK_CTRL_TX |
-				 /* temporary, until we fix hotplug: */
-				 (EDMA_ERR_DEV_DCON | EDMA_ERR_DEV_CON),
+				  EDMA_ERR_LNK_CTRL_TX,
 
 	EDMA_EH_FREEZE		= EDMA_ERR_D_PAR |
 				  EDMA_ERR_PRD_PAR |
@@ -2120,13 +2106,6 @@
 		printk(KERN_ERR DRV_NAME ": can't clear global reset\n");
 		rc = 1;
 	}
-	/*
-	 * Temporary: wait 3 seconds before port-probing can happen,
-	 * so that we don't miss finding sleepy SilXXXX port-multipliers.
-	 * This can go away once hotplug is fully/correctly implemented.
-	 */
-	if (rc == 0)
-		msleep(3000);
 done:
 	return rc;
 }
