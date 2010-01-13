From: Seth Heasley <seth.heasley@intel.com>
Subject: [PATCH 2.6.32.3] ahci: AHCI and RAID mode SATA patch for Intel Cougar Point DeviceIDs
Date: Tue, 12 Jan 2010 17:00:18 -0800
Message-ID: <201001121700.18234.seth.heasley@intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:57786 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750946Ab0AMBEs (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 12 Jan 2010 20:04:48 -0500
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: seth.heasley@intel.com

This patch adds the Intel Cougar Point (PCH) SATA AHCI and RAID Controller DeviceIDs.

Signed-off-by: Seth Heasley <seth.heasley@intel.com>

--- linux-2.6.32.3/drivers/ata/ahci.c.orig	2010-01-06 15:07:45.000000000 -0800
+++ linux-2.6.32.3/drivers/ata/ahci.c	2010-01-07 13:55:23.000000000 -0800
@@ -560,6 +560,12 @@
 	{ PCI_VDEVICE(INTEL, 0x3b2b), board_ahci }, /* PCH RAID */
 	{ PCI_VDEVICE(INTEL, 0x3b2c), board_ahci }, /* PCH RAID */
 	{ PCI_VDEVICE(INTEL, 0x3b2f), board_ahci }, /* PCH AHCI */
+	{ PCI_VDEVICE(INTEL, 0x1c02), board_ahci }, /* CPT AHCI */
+	{ PCI_VDEVICE(INTEL, 0x1c03), board_ahci }, /* CPT AHCI */
+	{ PCI_VDEVICE(INTEL, 0x1c04), board_ahci }, /* CPT RAID */
+	{ PCI_VDEVICE(INTEL, 0x1c05), board_ahci }, /* CPT RAID */
+	{ PCI_VDEVICE(INTEL, 0x1c06), board_ahci }, /* CPT RAID */
+	{ PCI_VDEVICE(INTEL, 0x1c07), board_ahci }, /* CPT RAID */
 
 	/* JMicron 360/1/3/5/6, match class to avoid IDE function */
 	{ PCI_VENDOR_ID_JMICRON, PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID,
