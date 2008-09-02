From: "Mark Nelson" <mdnelson8@gmail.com>
Subject: [RFC][PATCH] ahci: Add support for Promise PDC42819
Date: Tue, 2 Sep 2008 21:03:54 +1000
Message-ID: <65a6ef750809020403i52228319u9e3197e4062941bc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-gx0-f29.google.com ([209.85.217.29]:54019 "EHLO
	mail-gx0-f29.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751255AbYIBLD4 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 2 Sep 2008 07:03:56 -0400
Received: by gxk10 with SMTP id 10so2440478gxk.13
        for <linux-ide@vger.kernel.org>; Tue, 02 Sep 2008 04:03:54 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-ide@vger.kernel.org, Mikael Pettersson <mikpe@it.uu.se>

Add an appropriate entry for the Promise PDC42819 controller. It has an
AHCI mode and seems to work correctly with board_ahci.

This chip is found on Promise's FastTrak TX2650 (2 port) and TX4650 (4 port)
software-based RAID cards (for which there is a binary driver, t3sas) and
can be found on some motherboards, for example the MSI K9A2 Platinum,
which calls the chip a Promise T3 controller.

Signed-off-by: Mark Nelson <mdnelson8@gmail.com>
---
Apparently this chip also supports SAS disks, will these work with the
ahci driver (I've only tested with normal desktop SATA disks)?

 drivers/ata/ahci.c |    3 +++
 1 file changed, 3 insertions(+)

Index: upstream/drivers/ata/ahci.c
===================================================================
--- upstream.orig/drivers/ata/ahci.c
+++ upstream/drivers/ata/ahci.c
@@ -585,6 +585,9 @@ static const struct pci_device_id ahci_p
 	{ PCI_VDEVICE(MARVELL, 0x6145), board_ahci_mv },	/* 6145 */
 	{ PCI_VDEVICE(MARVELL, 0x6121), board_ahci_mv },	/* 6121 */

+	/* Promise */
+	{ PCI_VDEVICE(PROMISE, 0x3f20), board_ahci },	/* PDC42819 */
+
 	/* Generic, PCI class code for AHCI */
 	{ PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID,
 	  PCI_CLASS_STORAGE_SATA_AHCI, 0xffffff, board_ahci },
