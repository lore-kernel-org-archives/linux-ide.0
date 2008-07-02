From: Tejun Heo <tj@kernel.org>
Subject: [PATCH #upstream-fixes] sata_sil24: add DIDs for adaptec flavors
Date: Wed, 02 Jul 2008 11:52:09 +0900
Message-ID: <486AED59.7020606@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:58497 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758759AbYGBCwk (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 1 Jul 2008 22:52:40 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>, Travis Read <ics@dark.net.au>

Adaptec uses different DIDs for 3132.  Add them.

Reported by Travis Read.

Signed-off-by: Tejun Heo <tj@kernel.org>
Cc: Travis Read <ics@dark.net.au>
---
 drivers/ata/sata_sil24.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/ata/sata_sil24.c b/drivers/ata/sata_sil24.c
index 8ee6b5b..5633a31 100644
--- a/drivers/ata/sata_sil24.c
+++ b/drivers/ata/sata_sil24.c
@@ -372,6 +372,8 @@ static const struct pci_device_id sil24_pci_tbl[] = {
 	{ PCI_VDEVICE(CMD, 0x0242), BID_SIL3132 },
 	{ PCI_VDEVICE(CMD, 0x3131), BID_SIL3131 },
 	{ PCI_VDEVICE(CMD, 0x3531), BID_SIL3131 },
+	{ PCI_VDEVICE(CMD, 0x0242), BID_SIL3132 },
+	{ PCI_VDEVICE(CMD, 0x0244), BID_SIL3132 },
 
 	{ } /* terminate list */
 };
