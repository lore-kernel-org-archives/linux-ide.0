From: Ben Hutchings <ben@decadent.org.uk>
Subject: [PATCH] ata_piix: Add device ID for ICH4-L
Date: Sun, 10 Oct 2010 22:42:21 +0100
Message-ID: <1286746941.2955.255.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:35965 "EHLO
	shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751250Ab0JJVm3 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 10 Oct 2010 17:42:29 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Alan Cox <alan@linux.intel.com>, linux-ide@vger.kernel.org

ICH4-L is a variant of ICH4 lacking USB2 functionality and with some
different device IDs.

It is documented in Intel specification update 290745-025, currently
at <http://www.intel.com/assets/pdf/specupdate/290745.pdf>, and is
included in the device ID table for piix.

Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
This is untested; I don't have this device but just compared the device
ID tables.

Ben.

 drivers/ata/ata_piix.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/ata/ata_piix.c b/drivers/ata/ata_piix.c
index 2cfc1ae..6cb14ca 100644
--- a/drivers/ata/ata_piix.c
+++ b/drivers/ata/ata_piix.c
@@ -210,6 +210,8 @@ static const struct pci_device_id piix_pci_tbl[] = {
 	{ 0x8086, 0x248A, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich_pata_100 },
 	/* Intel ICH3 (E7500/1) UDMA 100 */
 	{ 0x8086, 0x248B, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich_pata_100 },
+	/* Intel ICH4-L */
+	{ 0x8086, 0x24C1, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich_pata_100 },
 	/* Intel ICH4 (i845GV, i845E, i852, i855) UDMA 100 */
 	{ 0x8086, 0x24CA, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich_pata_100 },
 	{ 0x8086, 0x24CB, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich_pata_100 },
-- 
1.7.1


