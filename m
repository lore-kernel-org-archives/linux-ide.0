From: Jason Gaston <jason.d.gaston@intel.com>
Subject: [PATCH 2.6.19-rc6] ahci: AHCI mode SATA patch for Intel ICH9
Date: Tue, 21 Nov 2006 14:51:38 -0800
Message-ID: <1164149498.27730.17.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:52303 "EHLO mga02.intel.com")
	by vger.kernel.org with ESMTP id S1031274AbWKUWv6 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 21 Nov 2006 17:51:58 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, jason.d.gaston@intel.com

This patch adds the Intel ICH9 AHCI controller DID's for SATA support.

Signed-off-by:  Jason Gaston <jason.d.gaston@intel.com>

--- linux-2.6.19-rc6/drivers/ata/ahci.c.orig	2006-11-20
04:56:51.000000000 -0800
+++ linux-2.6.19-rc6/drivers/ata/ahci.c	2006-11-20 04:58:30.000000000
-0800
@@ -314,6 +314,17 @@
 	{ PCI_VDEVICE(INTEL, 0x2824), board_ahci }, /* ICH8 */
 	{ PCI_VDEVICE(INTEL, 0x2829), board_ahci }, /* ICH8M */
 	{ PCI_VDEVICE(INTEL, 0x282a), board_ahci }, /* ICH8M */
+	{ PCI_VDEVICE(INTEL, 0x2922), board_ahci }, /* ICH9 */
+	{ PCI_VDEVICE(INTEL, 0x2923), board_ahci }, /* ICH9 */
+	{ PCI_VDEVICE(INTEL, 0x2924), board_ahci }, /* ICH9 */
+	{ PCI_VDEVICE(INTEL, 0x2925), board_ahci }, /* ICH9 */
+	{ PCI_VDEVICE(INTEL, 0x2927), board_ahci }, /* ICH9 */
+	{ PCI_VDEVICE(INTEL, 0x2929), board_ahci }, /* ICH9M */
+	{ PCI_VDEVICE(INTEL, 0x292a), board_ahci }, /* ICH9M */
+	{ PCI_VDEVICE(INTEL, 0x292b), board_ahci }, /* ICH9M */
+	{ PCI_VDEVICE(INTEL, 0x292f), board_ahci }, /* ICH9M */
+	{ PCI_VDEVICE(INTEL, 0x294d), board_ahci }, /* ICH9 */
+	{ PCI_VDEVICE(INTEL, 0x294e), board_ahci }, /* ICH9M */
 
 	/* JMicron */
 	{ PCI_VDEVICE(JMICRON, 0x2360), board_ahci }, /* JMicron JMB360 */


