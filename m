From: Tejun Heo <tj@kernel.org>
Subject: [PATCH #upstream-fixes] ahci: add another PCI ID for marvell
Date: Mon, 29 Nov 2010 15:57:14 +0100
Message-ID: <4CF3BF4A.4080009@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:46793 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752696Ab0K2O5k (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 29 Nov 2010 09:57:40 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Borislav Petkov <bp@alien8.de>, Alessandro Tagliapietra <tagliapietra.alessandro@gmail.com>

1b4b:91a3 seems to be another PCI ID for marvell ahci.  Add it.
Reported and tested in the following thread.

 http://thread.gmane.org/gmane.linux.kernel/1068354

Signed-off-by: Tejun Heo <tj@kernel.org>
Reported-by: Borislav Petkov <bp@alien8.de>
Reported-by: Alessandro Tagliapietra <tagliapietra.alessandro@gmail.com>
---
 drivers/ata/ahci.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 3288263..0c39fbb 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -380,6 +380,8 @@ static const struct pci_device_id ahci_pci_tbl[] = {
 	{ PCI_VDEVICE(MARVELL, 0x6121), board_ahci_mv },	/* 6121 */
 	{ PCI_DEVICE(0x1b4b, 0x9123),
 	  .driver_data = board_ahci_yes_fbs },			/* 88se9128 */
+	{ PCI_DEVICE(0x1b4b, 0x91a3),
+	  .driver_data = board_ahci_yes_fbs },

 	/* Promise */
 	{ PCI_VDEVICE(PROMISE, 0x3f20), board_ahci },	/* PDC42819 */
