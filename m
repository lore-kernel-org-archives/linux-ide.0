From: Jason Gaston <jason.d.gaston@intel.com>
Subject: [PATCH 2.6.24] ata_piix:  IDE mode SATA patch for Intel ICH10 DeviceID's
Date: Mon, 28 Jan 2008 17:36:45 -0800
Message-ID: <200801281736.45574.jason.d.gaston@intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:10340 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1765021AbYA2Ada (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 28 Jan 2008 19:33:30 -0500
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, jason.d.gaston@intel.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, htejun@gmail.com

This patch adds the Intel ICH10 IDE mode SATA Controller DeviceID's.

Signed-off-by:  Jason Gaston <jason.d.gaston@intel.com>

--- linux-2.6.24/drivers/ata/ata_piix.c.orig	2008-01-24 14:58:37.000000000 -0800
+++ linux-2.6.24/drivers/ata/ata_piix.c	2008-01-28 14:58:22.000000000 -0800
@@ -263,6 +263,14 @@
 	{ 0x8086, 0x292e, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich8_sata_ahci },
 	/* SATA Controller IDE (Tolapai) */
 	{ 0x8086, 0x5028, PCI_ANY_ID, PCI_ANY_ID, 0, 0, tolapai_sata_ahci },
+	/* SATA Controller IDE (ICH10) */
+	{ 0x8086, 0x3a00, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich8_sata_ahci },
+	/* SATA Controller IDE (ICH10) */
+	{ 0x8086, 0x3a06, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich8_2port_sata },
+	/* SATA Controller IDE (ICH10) */
+	{ 0x8086, 0x3a20, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich8_sata_ahci },
+	/* SATA Controller IDE (ICH10) */
+	{ 0x8086, 0x3a26, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich8_2port_sata },
 
 	{ }	/* terminate list */
 };
