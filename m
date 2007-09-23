From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 10/10] ahci: implement AHCI_HFLAG_NO_PMP
Date: Sun, 23 Sep 2007 13:19:55 +0900
Message-ID: <1190521195729-git-send-email-htejun@gmail.com>
References: <1190521193410-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.191]:56412 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752745AbXIWEUJ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 23 Sep 2007 00:20:09 -0400
Received: by rv-out-0910.google.com with SMTP id k20so1141425rvb
        for <linux-ide@vger.kernel.org>; Sat, 22 Sep 2007 21:20:08 -0700 (PDT)
In-Reply-To: <1190521193410-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Of course some controllers lie about PMP support.  Black list them.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/ahci.c |   11 +++++++++--
 1 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 1111dc2..ad3ff29 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -176,6 +176,7 @@ enum {
 	AHCI_HFLAG_32BIT_ONLY		= (1 << 3), /* force 32bit */
 	AHCI_HFLAG_MV_PATA		= (1 << 4), /* PATA port */
 	AHCI_HFLAG_NO_MSI		= (1 << 5), /* no PCI MSI */
+	AHCI_HFLAG_NO_PMP		= (1 << 6), /* no PMP */
 
 	/* ap->flags bits */
 	AHCI_FLAG_NO_HOTPLUG		= (1 << 24), /* ignore PxSERR.DIAG.N */
@@ -357,7 +358,7 @@ static const struct ata_port_info ahci_port_info[] = {
 	},
 	/* board_ahci_vt8251 */
 	{
-		AHCI_HFLAGS	(AHCI_HFLAG_NO_NCQ),
+		AHCI_HFLAGS	(AHCI_HFLAG_NO_NCQ | AHCI_HFLAG_NO_PMP),
 		.flags		= AHCI_FLAG_COMMON,
 		.link_flags	= AHCI_LFLAG_COMMON | ATA_LFLAG_HRST_TO_RESUME,
 		.pio_mask	= 0x1f, /* pio0-4 */
@@ -376,7 +377,7 @@ static const struct ata_port_info ahci_port_info[] = {
 	/* board_ahci_sb600 */
 	{
 		AHCI_HFLAGS	(AHCI_HFLAG_IGN_SERR_INTERNAL |
-				 AHCI_HFLAG_32BIT_ONLY),
+				 AHCI_HFLAG_32BIT_ONLY | AHCI_HFLAG_NO_PMP),
 		.flags		= AHCI_FLAG_COMMON,
 		.link_flags	= AHCI_LFLAG_COMMON,
 		.pio_mask	= 0x1f, /* pio0-4 */
@@ -578,6 +579,12 @@ static void ahci_save_initial_config(struct pci_dev *pdev,
 		cap &= ~HOST_CAP_NCQ;
 	}
 
+	if ((cap && HOST_CAP_PMP) && (hpriv->flags & AHCI_HFLAG_NO_PMP)) {
+		dev_printk(KERN_INFO, &pdev->dev,
+			   "controller can't do PMP, turning off CAP_PMP\n");
+		cap &= ~HOST_CAP_PMP;
+	}
+
 	/*
 	 * Temporary Marvell 6145 hack: PATA port presence
 	 * is asserted through the standard AHCI port
-- 
1.5.0.3


