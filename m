From: Seth Heasley <seth.heasley@intel.com>
Subject: [PATCH 2.6.27-rc4] ahci: RAID mode SATA patch for Intel Ibex Peak DeviceIDs
Date: Wed, 27 Aug 2008 16:47:22 -0700
Message-ID: <200808271647.22782.seth.heasley@intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:31355 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755144AbYH0XmH (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 27 Aug 2008 19:42:07 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: seth.heasley@intel.com

This patch adds the Intel Ibex Peak (PCH) SATA RAID Controller DeviceIDs.

Signed-off-by: Seth Heasley <seth.heasley@intel.com>

--- linux-2.6/drivers/ata/ahci.c.orig	2008-08-27 11:48:10.000000000 -0700
+++ linux-2.6/drivers/ata/ahci.c	2008-08-27 11:49:23.000000000 -0700
@@ -487,7 +487,9 @@
 	{ PCI_VDEVICE(INTEL, 0x3a05), board_ahci }, /* ICH10 */
 	{ PCI_VDEVICE(INTEL, 0x3a25), board_ahci }, /* ICH10 */
 	{ PCI_VDEVICE(INTEL, 0x3b24), board_ahci }, /* PCH RAID */
+	{ PCI_VDEVICE(INTEL, 0x3b25), board_ahci }, /* PCH RAID */
 	{ PCI_VDEVICE(INTEL, 0x3b2b), board_ahci }, /* PCH RAID */
+	{ PCI_VDEVICE(INTEL, 0x3b2c), board_ahci }, /* PCH RAID */
 
 	/* JMicron 360/1/3/5/6, match class to avoid IDE function */
 	{ PCI_VENDOR_ID_JMICRON, PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID,
