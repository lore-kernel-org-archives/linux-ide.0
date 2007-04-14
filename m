From: Mark Lord <liml@rtr.ca>
Subject: PATCH: ide/pci/delkin_cb.c   add new PCI ID
Date: Sat, 14 Apr 2007 18:22:49 -0400
Message-ID: <46215439.2060301@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ottawa-hs-64-26-128-89.s-ip.magma.ca ([64.26.128.89]:2767 "EHLO
	mail.rtr.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752076AbXDNWWv (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 14 Apr 2007 18:22:51 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

Add PCI ID for a newer variant of cardbus CF/IDE adapter card.
Patch is against 2.6.21-rc*.

Signed-off-by: Mark Lord <mlord@pobox.com>
---
--- old/drivers/ide/pci/delkin_cb.c	2007-04-11 00:18:51.000000000 -0400
+++ new/drivers/ide/pci/delkin_cb.c	2007-04-13 16:23:53.000000000 -0400
@@ -108,6 +108,7 @@
 
 static struct pci_device_id delkin_cb_pci_tbl[] __devinitdata = {
 	{ 0x1145, 0xf021, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
+	{ 0x1145, 0xf024, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
 	{ 0, },
 };
 MODULE_DEVICE_TABLE(pci, delkin_cb_pci_tbl);
