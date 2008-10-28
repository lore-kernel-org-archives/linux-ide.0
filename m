From: "Mark Nelson" <mdnelson8@gmail.com>
Subject: [PATCH v2] ahci: Add support for Promise PDC42819 (T3 controller)
Date: Tue, 28 Oct 2008 16:48:26 +1100
Message-ID: <65a6ef750810272248w6aa4881cv2d2b8dec08692472@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-gx0-f18.google.com ([209.85.217.18]:45019 "EHLO
	mail-gx0-f18.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752253AbYJ1Fs1 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 28 Oct 2008 01:48:27 -0400
Received: by gxk11 with SMTP id 11so1111103gxk.13
        for <linux-ide@vger.kernel.org>; Mon, 27 Oct 2008 22:48:26 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-ide@vger.kernel.org, mdnelson8@gmail.com

Add appropriate entries for the Promise PDC42819 controller. It has an
AHCI programming interface and so far works perfectly fine with board_ahci.

This chip is found on Promise's FastTrak TX2650 (2 port) and TX4650 (4 port)
software-based RAID cards and can be found on some motherboards, for example
the MSI K9A2 Platinum (v1), which calls the chip a Promise T3 controller.

This controller also supports SAS devices and Promise's proprietary software
RAID (via a different programming interface); but seeing as no documentation
is provided by Promise this patch at least allows the chip to be useful to
people as a SATA controller without resorting to the (not very up-to-date)
binary driver (t3sas).

Promise's PDC42819 appears on boards with PCI device IDs of 0x3f20 and
0x3f19. The only difference seems to be that the 0x3f19 is on boards that
are sold as SATA controllers (and probably have firmware that makes them act
as such). This makes no difference to us for the purposes of this patch
because we're only using the ACHI interface right now.

This patch has been tested on a system with a SAS disk connected to the
Promise PDC42819 controller and no problems were seen - during boot probing
of the port that has the SAS disk connected just timed out with "link online
but device misclassified" after which it continued on and correctly found
the connected SATA disk.

Signed-off-by: Mark Nelson <mdnelson8@gmail.com>
---
 drivers/ata/ahci.c |    4 ++++
 1 file changed, 4 insertions(+)

Index: upstream/drivers/ata/ahci.c
===================================================================
--- upstream.orig/drivers/ata/ahci.c
+++ upstream/drivers/ata/ahci.c
@@ -588,6 +588,10 @@ static const struct pci_device_id ahci_p
 	{ PCI_VDEVICE(MARVELL, 0x6145), board_ahci_mv },	/* 6145 */
 	{ PCI_VDEVICE(MARVELL, 0x6121), board_ahci_mv },	/* 6121 */

+	/* Promise */
+	{ PCI_VDEVICE(PROMISE, 0x3f20), board_ahci },	/* PDC42819 */
+	{ PCI_VDEVICE(PROMISE, 0x3f19), board_ahci },	/* PDC42819 */
+
 	/* Generic, PCI class code for AHCI */
 	{ PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID,
 	  PCI_CLASS_STORAGE_SATA_AHCI, 0xffffff, board_ahci },
