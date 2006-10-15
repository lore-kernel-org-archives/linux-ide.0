From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 2/3] [PATCH] ahci: update softreset and kill AHCI_FLAG_RESET_NEEDS_CLO
Date: Mon, 16 Oct 2006 07:43:23 +0900
Message-ID: <11609522033451-git-send-email-htejun@gmail.com>
References: <11609522031228-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zeus1.kernel.org ([204.152.191.4]:48608 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S932144AbWJOWos (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 15 Oct 2006 18:44:48 -0400
Received: from py-out-1112.google.com (py-out-1112.google.com [64.233.166.178])
	by zeus1.kernel.org (8.13.7/8.13.1) with ESMTP id k9FMiXvx008731
	for <linux-ide@vger.kernel.org>; Sun, 15 Oct 2006 22:44:47 GMT
Received: by py-out-1112.google.com with SMTP id n25so2069531pyg
        for <linux-ide@vger.kernel.org>; Sun, 15 Oct 2006 15:43:30 -0700 (PDT)
In-Reply-To: <11609522031228-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, aalderd.boac@wanadoo.nl, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

CLO is supposed to be automatically performed by ahci_softreset() if
BSY is set (AHCI rev1.1 10.4.1).  Although the code was there, it
didn't work because Status value in D2H Reg area, which is zeroed on
initialization, was used to determine whether BSY is set.

This patch updates ahci_softreset() to use TFDATA area to determine
Status and kill now unnecessary AHCI_FLAG_RESET_NEEDS_CLO.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/ahci.c |   22 ++++------------------
 1 files changed, 4 insertions(+), 18 deletions(-)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index d95d99b..f103799 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -166,8 +166,7 @@ enum {
 	AHCI_FLAG_MSI		= (1 << 0),
 
 	/* ap->flags bits */
-	AHCI_FLAG_RESET_NEEDS_CLO	= (1 << 24),
-	AHCI_FLAG_NO_NCQ		= (1 << 25),
+	AHCI_FLAG_NO_NCQ		= (1 << 24),
 };
 
 struct ahci_cmd_hdr {
@@ -291,8 +290,7 @@ static const struct ata_port_info ahci_p
 		.sht		= &ahci_sht,
 		.flags		= ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
 				  ATA_FLAG_MMIO | ATA_FLAG_PIO_DMA |
-				  ATA_FLAG_SKIP_D2H_BSY |
-				  AHCI_FLAG_RESET_NEEDS_CLO | AHCI_FLAG_NO_NCQ,
+				  ATA_FLAG_SKIP_D2H_BSY | AHCI_FLAG_NO_NCQ,
 		.pio_mask	= 0x1f, /* pio0-4 */
 		.udma_mask	= 0x7f, /* udma0-6 ; FIXME */
 		.port_ops	= &ahci_ops,
@@ -699,17 +697,6 @@ static int ahci_clo(struct ata_port *ap)
 	return 0;
 }
 
-static int ahci_prereset(struct ata_port *ap)
-{
-	if ((ap->flags & AHCI_FLAG_RESET_NEEDS_CLO) &&
-	    (ata_busy_wait(ap, ATA_BUSY, 1000) & ATA_BUSY)) {
-		/* ATA_BUSY hasn't cleared, so send a CLO */
-		ahci_clo(ap);
-	}
-
-	return ata_std_prereset(ap);
-}
-
 static int ahci_softreset(struct ata_port *ap, unsigned int *class)
 {
 	struct ahci_port_priv *pp = ap->private_data;
@@ -738,8 +725,7 @@ static int ahci_softreset(struct ata_por
 	}
 
 	/* check BUSY/DRQ, perform Command List Override if necessary */
-	ahci_tf_read(ap, &tf);
-	if (tf.command & (ATA_BUSY | ATA_DRQ)) {
+	if (ahci_check_status(ap) & (ATA_BUSY | ATA_DRQ)) {
 		rc = ahci_clo(ap);
 
 		if (rc == -EOPNOTSUPP) {
@@ -1163,7 +1149,7 @@ static void ahci_error_handler(struct at
 	}
 
 	/* perform recovery */
-	ata_do_eh(ap, ahci_prereset, ahci_softreset, ahci_hardreset,
+	ata_do_eh(ap, ata_std_prereset, ahci_softreset, ahci_hardreset,
 		  ahci_postreset);
 }
 
-- 
1.4.2.3


