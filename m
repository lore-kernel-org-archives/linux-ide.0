From: Jason Gaston <jason.d.gaston@intel.com>
Subject: [PATCH 2.6.24] ahci: RAID mode SATA patch for Intel ICH10 DeviceID's
Date: Mon, 28 Jan 2008 17:34:14 -0800
Message-ID: <200801281734.14535.jason.d.gaston@intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:34024 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752126AbYA2Abi (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 28 Jan 2008 19:31:38 -0500
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, jason.d.gaston@intel.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

This patch adds the Intel ICH10 SATA RAID Controllers DeviceID's.

Signed-off-by:  Jason Gaston <jason.d.gaston@intel.com>

--- linux-2.6.24/drivers/ata/ahci.c.orig	2008-01-24 14:58:37.000000000 -0800
+++ linux-2.6.24/drivers/ata/ahci.c	2008-01-28 14:58:22.000000000 -0800
@@ -475,6 +475,8 @@
 	{ PCI_VDEVICE(INTEL, 0x294e), board_ahci }, /* ICH9M */
 	{ PCI_VDEVICE(INTEL, 0x502a), board_ahci }, /* Tolapai */
 	{ PCI_VDEVICE(INTEL, 0x502b), board_ahci }, /* Tolapai */
+	{ PCI_VDEVICE(INTEL, 0x3a05), board_ahci }, /* ICH10 */
+	{ PCI_VDEVICE(INTEL, 0x3a25), board_ahci }, /* ICH10 */
 
 	/* JMicron 360/1/3/5/6, match class to avoid IDE function */
 	{ PCI_VENDOR_ID_JMICRON, PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID,
