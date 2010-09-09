From: Seth Heasley <seth.heasley@intel.com>
Subject: [PATCH 2.6.35.4] ata_piix: IDE Mode SATA patch for Intel Patsburg DeviceIDs
Date: Thu, 9 Sep 2010 09:42:40 -0700
Message-ID: <201009090942.40760.seth.heasley@intel.com>
References: <201001121701.28589.seth.heasley@intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:51959 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751609Ab0IIQus (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 9 Sep 2010 12:50:48 -0400
In-Reply-To: <201001121701.28589.seth.heasley@intel.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
Cc: linux-ide@vger.kernel.org, jgarzik@pobox.com, seth.heasley@intel.com

This patch adds the Intel Patsburg (PCH) IDE mode SATA Controller DeviceIDs.

Signed-off-by: Seth Heasley <seth.heasley@intel.com>

--- linux-2.6.35.4/drivers/ata/ata_piix.c.orig	2010-08-26 16:47:12.000000000 -0700
+++ linux-2.6.35.4/drivers/ata/ata_piix.c	2010-08-31 17:29:43.697162374 -0700
@@ -302,6 +302,10 @@
 	{ 0x8086, 0x1c08, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich8_2port_sata },
 	/* SATA Controller IDE (CPT) */
 	{ 0x8086, 0x1c09, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich8_2port_sata },
+	/* SATA Controller IDE (PBG) */
+	{ 0x8086, 0x1d00, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich8_sata },
+	/* SATA Controller IDE (PBG) */
+	{ 0x8086, 0x1d08, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich8_2port_sata },
 	{ }	/* terminate list */
 };
 

