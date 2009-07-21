From: David Milburn <dmilburn@redhat.com>
Subject: [PATCH #upstream-fixes] ahci add device ID for Ibex Peak ahci controller
Date: Tue, 21 Jul 2009 12:57:59 -0500
Message-ID: <20090721175759.GA5929@dhcp-210.hsv.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx2.redhat.com ([66.187.237.31]:41506 "EHLO mx2.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755548AbZGUTco (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 21 Jul 2009 15:32:44 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org
Cc: linux-ide@vger.kernel.org

From: Jaroslav Kysela <jkysela@redhat.com>

Add device ID for Ibex Peak 6 port SATA AHCI Controller

Signed-off-by: David Milburn <dmilburn@redhat.com>
---
 drivers/ata/ahci.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 336eb1e..c342551 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -515,6 +515,7 @@ static const struct pci_device_id ahci_pci_tbl[] = {
 	{ PCI_VDEVICE(INTEL, 0x3a05), board_ahci }, /* ICH10 */
 	{ PCI_VDEVICE(INTEL, 0x3a22), board_ahci }, /* ICH10 */
 	{ PCI_VDEVICE(INTEL, 0x3a25), board_ahci }, /* ICH10 */
+	{ PCI_VDEVICE(INTEL, 0x3b22), board_ahci }, /* PCH AHCI */
 	{ PCI_VDEVICE(INTEL, 0x3b24), board_ahci }, /* PCH RAID */
 	{ PCI_VDEVICE(INTEL, 0x3b25), board_ahci }, /* PCH RAID */
 	{ PCI_VDEVICE(INTEL, 0x3b2b), board_ahci }, /* PCH RAID */
