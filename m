From: Seth Heasley <seth.heasley@intel.com>
Subject: [PATCH 2.6.26.2] ata_piix: IDE mode SATA patch for Intel Ibex Peak DeviceIDs
Date: Fri, 8 Aug 2008 15:47:50 -0700
Message-ID: <200808081547.50790.seth.heasley@intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:47590 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756185AbYHHWmo (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 8 Aug 2008 18:42:44 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, htejun@gmail.com
Cc: seth.heasley@intel.com

This patch adds the Intel Ibex Peak (PCH) IDE mode SATA Controller DeviceIDs.

Signed-off by: Seth Heasley <seth.heasley@intel.com>

--- linux-2.6.26.2/drivers/ata/ata_piix.c.orig  2008-08-08 11:34:56.000000000 -0700
+++ linux-2.6.26.2/drivers/ata/ata_piix.c       2008-08-08 14:30:02.000000000 -0700
@@ -274,6 +274,14 @@
        { 0x8086, 0x3a20, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich8_sata },
        /* SATA Controller IDE (ICH10) */
        { 0x8086, 0x3a26, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich8_2port_sata },
+       /* SATA Controller IDE (PCH) */
+       { 0x8086, 0x3b20, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich8_sata },
+       /* SATA Controller IDE (PCH) */
+       { 0x8086, 0x3b26, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich8_2port_sata },
+       /* SATA Controller IDE (PCH) */
+       { 0x8086, 0x3b2d, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich8_2port_sata },
+       /* SATA Controller IDE (PCH) */
+       { 0x8086, 0x3b2e, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich8_sata },

        { }     /* terminate list */
 };
