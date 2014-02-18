From: Tejun Heo <tj@kernel.org>
Subject: [PATCH libata/for-3.14-fixes] ahci: disable NCQ on Samsung pci-e
 SSDs on macbooks
Date: Tue, 18 Feb 2014 10:28:36 -0500
Message-ID: <20140218152836.GB30043@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qc0-f169.google.com ([209.85.216.169]:56841 "EHLO
	mail-qc0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755016AbaBRP2k (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 18 Feb 2014 10:28:40 -0500
Received: by mail-qc0-f169.google.com with SMTP id w7so26112558qcr.0
        for <linux-ide@vger.kernel.org>; Tue, 18 Feb 2014 07:28:39 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Levente Kurusa <levex@linux.com>

>From 67809f85d31eac600f6b28defa5386c9d2a13b1d Mon Sep 17 00:00:00 2001
From: Levente Kurusa <levex@linux.com>
Date: Tue, 18 Feb 2014 10:22:17 -0500

Samsung's pci-e SSDs with device ID 0x1600 which are found on some
macbooks time out on NCQ commands.  Blacklist NCQ on the device so
that the affected machines can at least boot.

Original-patch-by: Levente Kurusa <levex@linux.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=60731
Cc: stable@vger.kernel.org
---
 drivers/ata/ahci.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index dc2756f..7df81576 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -61,6 +61,7 @@ enum board_ids {
 	/* board IDs by feature in alphabetical order */
 	board_ahci,
 	board_ahci_ign_iferr,
+	board_ahci_noncq,
 	board_ahci_nosntf,
 	board_ahci_yes_fbs,
 
@@ -121,6 +122,13 @@ static const struct ata_port_info ahci_port_info[] = {
 		.udma_mask	= ATA_UDMA6,
 		.port_ops	= &ahci_ops,
 	},
+	[board_ahci_noncq] = {
+		AHCI_HFLAGS	(AHCI_HFLAG_NO_NCQ),
+		.flags		= AHCI_FLAG_COMMON,
+		.pio_mask	= ATA_PIO4,
+		.udma_mask	= ATA_UDMA6,
+		.port_ops	= &ahci_ops,
+	},
 	[board_ahci_nosntf] = {
 		AHCI_HFLAGS	(AHCI_HFLAG_NO_SNTF),
 		.flags		= AHCI_FLAG_COMMON,
@@ -452,6 +460,12 @@ static const struct pci_device_id ahci_pci_tbl[] = {
 	{ PCI_VDEVICE(ASMEDIA, 0x0611), board_ahci },	/* ASM1061 */
 	{ PCI_VDEVICE(ASMEDIA, 0x0612), board_ahci },	/* ASM1062 */
 
+	/*
+	 * Samsung SSDs found on some macbooks.  NCQ times out.
+	 * https://bugzilla.kernel.org/show_bug.cgi?id=60731
+	 */
+	{ PCI_VDEVICE(SAMSUNG, 0x1600), board_ahci_noncq },
+
 	/* Enmotus */
 	{ PCI_DEVICE(0x1c44, 0x8000), board_ahci },
 
-- 
1.8.5.3

