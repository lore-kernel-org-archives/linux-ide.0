From: Seth Heasley <seth.heasley@intel.com>
Subject: [PATCH 2.6.37.3] ahci: AHCI mode SATA patch for Intel Patsburg SATA RAID controller
Date: Fri, 11 Mar 2011 11:57:42 -0800
Message-ID: <201103111157.42656.seth.heasley@intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:18162 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752476Ab1CKUKd (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 11 Mar 2011 15:10:33 -0500
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, seth.heasley@intel.com

This patch adds an updated SATA RAID DeviceID for the Intel Patsburg PCH.

Signed-off-by: Seth Heasley <seth.heasley@intel.com>

--- linux-2.6.37.3/drivers/ata/ahci.c.orig	2011-03-09 10:30:44.000000000 -0800
+++ linux-2.6.37.3/drivers/ata/ahci.c	2011-03-09 10:31:08.000000000 -0800
@@ -260,6 +260,7 @@
 	{ PCI_VDEVICE(INTEL, 0x1d02), board_ahci }, /* PBG AHCI */
 	{ PCI_VDEVICE(INTEL, 0x1d04), board_ahci }, /* PBG RAID */
 	{ PCI_VDEVICE(INTEL, 0x1d06), board_ahci }, /* PBG RAID */
+	{ PCI_VDEVICE(INTEL, 0x2826), board_ahci }, /* PBG RAID */
 
 	/* JMicron 360/1/3/5/6, match class to avoid IDE function */
 	{ PCI_VENDOR_ID_JMICRON, PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID,
