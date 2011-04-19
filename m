From: Seth Heasley <seth.heasley@intel.com>
Subject: [PATCH 2.6.39-rc3] ata_piix: IDE-mode SATA patch for Intel Panther Point DeviceIDs
Date: Tue, 19 Apr 2011 16:45:17 -0700
Message-ID: <201104191645.17789.seth.heasley@intel.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:47010 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753253Ab1DSXxA (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 19 Apr 2011 19:53:00 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, seth.heasley@intel.com

This patch adds the IDE-mode SATA DeviceIDs for the Intel Panther 
Point PCH.

Signed-off-by: Seth Heasley <seth.heasley@intel.com>

--- linux-2.6.39-rc3/drivers/ata/ata_piix.c.orig	2011-04-11 
17:21:51.000000000 -0700
+++ linux-2.6.39-rc3/drivers/ata/ata_piix.c	2011-04-14 
11:38:04.000000000 -0700
@@ -309,6 +309,14 @@
 	{ 0x8086, 0x1d00, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich8_sata },
 	/* SATA Controller IDE (PBG) */
 	{ 0x8086, 0x1d08, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 
ich8_2port_sata },
+	/* SATA Controller IDE (Panther Point) */
+	{ 0x8086, 0x1e00, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich8_sata },
+	/* SATA Controller IDE (Panther Point) */
+	{ 0x8086, 0x1e01, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich8_sata },
+	/* SATA Controller IDE (Panther Point) */
+	{ 0x8086, 0x1e08, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 
ich8_2port_sata },
+	/* SATA Controller IDE (Panther Point) */
+	{ 0x8086, 0x1e09, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 
ich8_2port_sata },
 	{ }	/* terminate list */
 };
 
