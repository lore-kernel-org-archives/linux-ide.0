From: Davor <vordah@gmail.com>
Subject: Marvell SATA AHCI 0x6141
Date: Fri, 9 Mar 2007 23:02:00 +0100
Message-ID: <20070309220200.GA17323@emard>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.171]:13874 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933405AbXCIWCP (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 9 Mar 2007 17:02:15 -0500
Received: by ug-out-1314.google.com with SMTP id 44so1487603uga
        for <linux-ide@vger.kernel.org>; Fri, 09 Mar 2007 14:01:58 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, linux-ide@vger.kernel.org

HI

I have onboard 
02:00.0 SATA controller: Marvell Technology Group Ltd. Unknown device 6141 (rev 01)
02:00.0 0106: 11ab:6141 (rev 01)

and it's an AHCI compatible device so a simple patch makes it work 
(patch agains linux-2.6.20.2)

--- drivers/ata/ahci.c.orig	2007-03-09 21:58:26.000000000 +0100
+++ drivers/ata/ahci.c	2007-03-09 22:38:20.000000000 +0100
@@ -437,6 +437,9 @@ static const struct pci_device_id ahci_p
 	{ PCI_VDEVICE(SI, 0x1185), board_ahci }, /* SiS 966 */
 	{ PCI_VDEVICE(SI, 0x0186), board_ahci }, /* SiS 968 */
 
+	/* Marvell */
+	{ PCI_VDEVICE(MARVELL, 0x6141), board_ahci },	/* 6141 */
+
 	/* Generic, PCI class code for AHCI */
 	{ PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID,
 	  0x010601, 0xffffff, board_ahci },
