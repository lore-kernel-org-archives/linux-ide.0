From: David Milburn <dmilburn@redhat.com>
Subject: [PATCH #upstream-fixes v2] ahci: add device IDs for Ibex Peak ahci controllers
Date: Wed, 22 Jul 2009 15:15:56 -0500
Message-ID: <20090722201556.GB10049@dhcp-210.hsv.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx2.redhat.com ([66.187.237.31]:59495 "EHLO mx2.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751625AbZGVURm (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 22 Jul 2009 16:17:42 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org
Cc: linux-ide@vger.kernel.org

Add device IDS for Ibex Peak SATA AHCI Controllers

Signed-off-by: Jaroslav Kysela <jkysela@redhat.com>
Signed-off-by: David Milburn <dmilburn@redhat.com>
---
 drivers/ata/ahci.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 336eb1e..958c1fa 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -515,10 +515,14 @@ static const struct pci_device_id ahci_pci_tbl[] = {
 	{ PCI_VDEVICE(INTEL, 0x3a05), board_ahci }, /* ICH10 */
 	{ PCI_VDEVICE(INTEL, 0x3a22), board_ahci }, /* ICH10 */
 	{ PCI_VDEVICE(INTEL, 0x3a25), board_ahci }, /* ICH10 */
+	{ PCI_VDEVICE(INTEL, 0x3b22), board_ahci }, /* PCH AHCI */
+	{ PCI_VDEVICE(INTEL, 0x3b23), board_ahci }, /* PCH AHCI */
 	{ PCI_VDEVICE(INTEL, 0x3b24), board_ahci }, /* PCH RAID */
 	{ PCI_VDEVICE(INTEL, 0x3b25), board_ahci }, /* PCH RAID */
+	{ PCI_VDEVICE(INTEL, 0x3b29), board_ahci }, /* PCH AHCI */
 	{ PCI_VDEVICE(INTEL, 0x3b2b), board_ahci }, /* PCH RAID */
 	{ PCI_VDEVICE(INTEL, 0x3b2c), board_ahci }, /* PCH RAID */
+	{ PCI_VDEVICE(INTEL, 0x3b2f), board_ahci }, /* PCH AHCI */
 
 	/* JMicron 360/1/3/5/6, match class to avoid IDE function */
 	{ PCI_VENDOR_ID_JMICRON, PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID,
