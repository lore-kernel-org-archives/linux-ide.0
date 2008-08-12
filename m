From: Seth Heasley <seth.heasley@intel.com>
Subject: [PATCH 2.6.26.2][RESEND] ahci: RAID mode SATA patch for Intel Ibex Peak DeviceIDs
Date: Mon, 11 Aug 2008 17:03:09 -0700
Message-ID: <200808111703.09743.seth.heasley@intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:53025 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758172AbYHKX6A (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 11 Aug 2008 19:58:00 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: seth.heasley@intel.com

Resend with proper whitespace.

This patch adds the Intel Ibex Peak (PCH) SATA RAID Controller DeviceIDs.

Signed-off-by: Seth Heasley <seth.heasley@intel.com>

--- linux-2.6.26.2/drivers/ata/ahci.c.orig	2008-08-08 11:34:48.000000000 -0700
+++ linux-2.6.26.2/drivers/ata/ahci.c	2008-08-08 11:36:06.000000000 -0700
@@ -445,6 +445,8 @@
 	{ PCI_VDEVICE(INTEL, 0x502b), board_ahci }, /* Tolapai */
 	{ PCI_VDEVICE(INTEL, 0x3a05), board_ahci }, /* ICH10 */
 	{ PCI_VDEVICE(INTEL, 0x3a25), board_ahci }, /* ICH10 */
+	{ PCI_VDEVICE(INTEL, 0x3b24), board_ahci }, /* PCH RAID */
+	{ PCI_VDEVICE(INTEL, 0x3b2b), board_ahci }, /* PCH RAID */
 
 	/* JMicron 360/1/3/5/6, match class to avoid IDE function */
 	{ PCI_VENDOR_ID_JMICRON, PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID,

