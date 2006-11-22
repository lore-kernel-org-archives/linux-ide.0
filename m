From: Jason Gaston <jason.d.gaston@intel.com>
Subject: [PATCH 2.6.19-rc6][RESEND] ahci: AHCI mode SATA patch for Intel ICH9
Date: Tue, 21 Nov 2006 16:55:58 -0800
Message-ID: <200611211655.58451.jason.d.gaston@intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:11898 "EHLO mga02.intel.com")
	by vger.kernel.org with ESMTP id S966970AbWKVA4G (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 21 Nov 2006 19:56:06 -0500
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, linux-ide@vger.kernel.org, jason.d.gaston@intel.com, linux-kernel@vger.kernel.org

This patch adds the Intel ICH9 AHCI controller DID's for SATA support.

Signed-off-by:  Jason Gaston <jason.d.gaston@intel.com>

--- linux-2.6.19-rc6/drivers/ata/ahci.c.orig	2006-11-20 04:56:51.000000000 -0800
+++ linux-2.6.19-rc6/drivers/ata/ahci.c	2006-11-20 04:58:30.000000000 -0800
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
