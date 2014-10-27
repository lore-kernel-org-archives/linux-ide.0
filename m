From: Tejun Heo <tj@kernel.org>
Subject: [PATCH libata/for-3.18-fixes] ahci: disable MSI instead of NCQ on
 Samsung pci-e SSDs on macbooks
Date: Mon, 27 Oct 2014 10:30:52 -0400
Message-ID: <20141027143052.GM4436@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qc0-f174.google.com ([209.85.216.174]:39945 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752920AbaJ0Oa4 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 27 Oct 2014 10:30:56 -0400
Received: by mail-qc0-f174.google.com with SMTP id r5so921684qcx.33
        for <linux-ide@vger.kernel.org>; Mon, 27 Oct 2014 07:30:56 -0700 (PDT)
Received: from htj.dyndns.org (207-38-238-8.c3-0.wsd-ubr1.qens-wsd.ny.cable.rcn.com. [207.38.238.8])
        by mx.google.com with ESMTPSA id w6sm11346911qas.26.2014.10.27.07.30.53
        for <linux-ide@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Oct 2014 07:30:54 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

>From 44aecdabc85087e7c299d7a28e095e2b91894a51 Mon Sep 17 00:00:00 2001
From: Tejun Heo <tj@kernel.org>
Date: Mon, 27 Oct 2014 10:22:56 -0400

Samsung pci-e SSDs on macbooks failed miserably on NCQ commands, so
67809f85d31e ("ahci: disable NCQ on Samsung pci-e SSDs on macbooks")
disabled NCQ on them.  It turns out that NCQ is fine as long as MSI is
not used, so let's turn off MSI and leave NCQ on.

Signed-off-by: Tejun Heo <tj@kernel.org>
Link: https://bugzilla.kernel.org/show_bug.cgi?id=60731
Tested-by: <dorin@i51.org>
Tested-by: Imre Kaloz <kaloz@openwrt.org>
Cc: stable@vger.kernel.org
Fixes: 67809f85d31e ("ahci: disable NCQ on Samsung pci-e SSDs on macbooks")
---
Applied to libata/for-3.18-fixes.

Thanks.

 drivers/ata/ahci.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 5f039f1..ef4b647 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -60,6 +60,7 @@ enum board_ids {
 	/* board IDs by feature in alphabetical order */
 	board_ahci,
 	board_ahci_ign_iferr,
+	board_ahci_nomsi,
 	board_ahci_noncq,
 	board_ahci_nosntf,
 	board_ahci_yes_fbs,
@@ -121,6 +122,13 @@ static const struct ata_port_info ahci_port_info[] = {
 		.udma_mask	= ATA_UDMA6,
 		.port_ops	= &ahci_ops,
 	},
+	[board_ahci_nomsi] = {
+		AHCI_HFLAGS	(AHCI_HFLAG_NO_MSI),
+		.flags		= AHCI_FLAG_COMMON,
+		.pio_mask	= ATA_PIO4,
+		.udma_mask	= ATA_UDMA6,
+		.port_ops	= &ahci_ops,
+	},
 	[board_ahci_noncq] = {
 		AHCI_HFLAGS	(AHCI_HFLAG_NO_NCQ),
 		.flags		= AHCI_FLAG_COMMON,
@@ -475,10 +483,10 @@ static const struct pci_device_id ahci_pci_tbl[] = {
 	{ PCI_VDEVICE(ASMEDIA, 0x0612), board_ahci },	/* ASM1062 */
 
 	/*
-	 * Samsung SSDs found on some macbooks.  NCQ times out.
-	 * https://bugzilla.kernel.org/show_bug.cgi?id=60731
+	 * Samsung SSDs found on some macbooks.  NCQ times out if MSI is
+	 * enabled.  https://bugzilla.kernel.org/show_bug.cgi?id=60731
 	 */
-	{ PCI_VDEVICE(SAMSUNG, 0x1600), board_ahci_noncq },
+	{ PCI_VDEVICE(SAMSUNG, 0x1600), board_ahci_nomsi },
 
 	/* Enmotus */
 	{ PCI_DEVICE(0x1c44, 0x8000), board_ahci },
-- 
1.9.3

