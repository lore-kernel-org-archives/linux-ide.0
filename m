From: "Fco. Javier" =?ISO-8859-1?Q?F=E9lix?= <sshinf@ono.com>
Subject: Path to Add support for primise FastTrack TX2200 2Ports
Date: Fri, 06 May 2005 12:32:38 +0200
Message-ID: <1115375558.14573.6.camel@ffelix>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-RoVtu1qE1Fc5iwRcB/iG"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp.ono.com ([62.42.230.12]:12161 "EHLO resmta04.ono.com")
	by vger.kernel.org with ESMTP id S261203AbVEFKbH (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 6 May 2005 06:31:07 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: linux-ide@vger.kernel.org


--=-RoVtu1qE1Fc5iwRcB/iG
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

I test with Kernel 2.6.11-ck4 and this patch in a machine two weeks and
it run ok



--=-RoVtu1qE1Fc5iwRcB/iG
Content-Disposition: attachment; filename=sata_promise.c.diff
Content-Type: text/x-patch; name=sata_promise.c.diff; charset=us-ascii
Content-Transfer-Encoding: 7bit

--- sata_promise.c	2005-05-06 12:18:51.866666336 +0200
+++ sata_promise.c.new	2005-04-21 18:19:04.000000000 +0200
@@ -150,6 +150,8 @@
 static struct pci_device_id pdc_ata_pci_tbl[] = {
 	{ PCI_VENDOR_ID_PROMISE, 0x3371, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
 	  board_2037x },
+	{ PCI_VENDOR_ID_PROMISE, 0x3571, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+	  board_2037x },
 	{ PCI_VENDOR_ID_PROMISE, 0x3373, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
 	  board_2037x },
 	{ PCI_VENDOR_ID_PROMISE, 0x3375, PCI_ANY_ID, PCI_ANY_ID, 0, 0,

--=-RoVtu1qE1Fc5iwRcB/iG--

