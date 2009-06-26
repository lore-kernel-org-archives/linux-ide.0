From: David Milburn <dmilburn@redhat.com>
Subject: [PATCH] ahci: add device ID for 82801JI sata controller
Date: Fri, 26 Jun 2009 10:44:11 -0500
Message-ID: <20090626154411.GB6433@dhcp-210.hsv.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx2.redhat.com ([66.187.237.31]:33725 "EHLO mx2.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750757AbZFZPp4 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 26 Jun 2009 11:45:56 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org
Cc: linux-ide@vger.kernel.org

From: Mark Goodwin <mgoodwin@redhat.com>

Add device ID for Intel 82801JI SATA AHCI controller.

Signed-off-by: David Milburn <dmilburn@redhat.com>
---
 drivers/ata/ahci.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 15a2303..336eb1e 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -513,6 +513,7 @@ static const struct pci_device_id ahci_pci_tbl[] = {
 	{ PCI_VDEVICE(INTEL, 0x502a), board_ahci }, /* Tolapai */
 	{ PCI_VDEVICE(INTEL, 0x502b), board_ahci }, /* Tolapai */
 	{ PCI_VDEVICE(INTEL, 0x3a05), board_ahci }, /* ICH10 */
+	{ PCI_VDEVICE(INTEL, 0x3a22), board_ahci }, /* ICH10 */
 	{ PCI_VDEVICE(INTEL, 0x3a25), board_ahci }, /* ICH10 */
 	{ PCI_VDEVICE(INTEL, 0x3b24), board_ahci }, /* PCH RAID */
 	{ PCI_VDEVICE(INTEL, 0x3b25), board_ahci }, /* PCH RAID */
