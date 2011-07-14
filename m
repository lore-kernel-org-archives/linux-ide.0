From: Seth Heasley <seth.heasley@intel.com>
Subject: [PATCH 3.0-rc7] ahci: RAID-mode SATA patch for Intel Panther Point DeviceIDs
Date: Thu, 14 Jul 2011 16:50:49 -0700
Message-ID: <201107141650.49929.seth.heasley@intel.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:38235 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932152Ab1GNXt7 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 14 Jul 2011 19:49:59 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: seth.heasley@gmail.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

This patch adds an additional SATA RAID controller DeviceID for the Intel Panther Point PCH.

Signed-off-by: Seth Heasley <seth.heasley@intel.com>
---

--- linux-3.0-rc7/drivers/ata/ahci.c.orig	2011-07-14 16:07:21.000000000 -0700
+++ linux-3.0-rc7/drivers/ata/ahci.c	2011-07-14 16:35:06.000000000 -0700
@@ -267,6 +267,7 @@
 	{ PCI_VDEVICE(INTEL, 0x1e05), board_ahci }, /* Panther Point RAID */
 	{ PCI_VDEVICE(INTEL, 0x1e06), board_ahci }, /* Panther Point RAID */
 	{ PCI_VDEVICE(INTEL, 0x1e07), board_ahci }, /* Panther Point RAID */
+	{ PCI_VDEVICE(INTEL, 0x1e0e), board_ahci }, /* Panther Point RAID */
 
 	/* JMicron 360/1/3/5/6, match class to avoid IDE function */
 	{ PCI_VENDOR_ID_JMICRON, PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID,
