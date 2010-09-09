From: Seth Heasley <seth.heasley@intel.com>
Subject: [PATCH 2.6.35.4] ahci: AHCI and RAID mode SATA patch for Intel Patsburg DeviceIDs
Date: Thu, 9 Sep 2010 09:44:56 -0700
Message-ID: <201009090944.56546.seth.heasley@intel.com>
References: <201001121700.18234.seth.heasley@intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:25042 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751609Ab0IIQxE (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 9 Sep 2010 12:53:04 -0400
In-Reply-To: <201001121700.18234.seth.heasley@intel.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: linux-ide@vger.kernel.org, seth.heasley@intel.com

This patch adds the Intel Patsburg (PCH) SATA AHCI and RAID Controller DeviceIDs.

Signed-off-by: Seth Heasley <seth.heasley@intel.com>

--- linux-2.6.35.4/drivers/ata/ahci.c.orig	2010-08-26 16:47:12.000000000 -0700
+++ linux-2.6.35.4/drivers/ata/ahci.c	2010-08-31 17:29:43.698135766 -0700
@@ -244,6 +244,9 @@
 	{ PCI_VDEVICE(INTEL, 0x1c05), board_ahci }, /* CPT RAID */
 	{ PCI_VDEVICE(INTEL, 0x1c06), board_ahci }, /* CPT RAID */
 	{ PCI_VDEVICE(INTEL, 0x1c07), board_ahci }, /* CPT RAID */
+	{ PCI_VDEVICE(INTEL, 0x1d02), board_ahci }, /* PBG AHCI */
+	{ PCI_VDEVICE(INTEL, 0x1d04), board_ahci }, /* PBG RAID */
+	{ PCI_VDEVICE(INTEL, 0x1d06), board_ahci }, /* PBG RAID */
 
 	/* JMicron 360/1/3/5/6, match class to avoid IDE function */
 	{ PCI_VENDOR_ID_JMICRON, PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID,
