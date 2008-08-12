From: Seth Heasley <seth.heasley@intel.com>
Subject: [PATCH 2.6.26.2][RESEND] ata_piix: IDE Mode SATA patch for Intel Ibex Peak DeviceIDs
Date: Mon, 11 Aug 2008 17:03:18 -0700
Message-ID: <200808111703.18252.seth.heasley@intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:25775 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755953AbYHKX6J (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 11 Aug 2008 19:58:09 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, htejun@gmail.com
Cc: seth.heasley@intel.com

Resend with proper whitespace.

This patch adds the Intel Ibex Peak (PCH) IDE mode SATA Controller DeviceIDs.

Signed-off-by: Seth Heasley <seth.heasley@intel.com>

--- linux-2.6.26.2/drivers/ata/ata_piix.c.orig	2008-08-08 11:34:56.000000000 -0700
+++ linux-2.6.26.2/drivers/ata/ata_piix.c	2008-08-08 14:30:02.000000000 -0700
@@ -274,6 +274,14 @@
 	{ 0x8086, 0x3a20, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich8_sata },
 	/* SATA Controller IDE (ICH10) */
 	{ 0x8086, 0x3a26, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich8_2port_sata },
+	/* SATA Controller IDE (PCH) */
+	{ 0x8086, 0x3b20, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich8_sata },
+	/* SATA Controller IDE (PCH) */
+	{ 0x8086, 0x3b26, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich8_2port_sata },
+	/* SATA Controller IDE (PCH) */
+	{ 0x8086, 0x3b2d, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich8_2port_sata },
+	/* SATA Controller IDE (PCH) */
+	{ 0x8086, 0x3b2e, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich8_sata },
 
 	{ }	/* terminate list */
 };
