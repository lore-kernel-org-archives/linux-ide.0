From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH] ata_piix: rename PIIX_FLAG_IGN_PRESENT to PIIX_FLAG_IGNORE_PCS
Date: Sun, 5 Mar 2006 14:28:51 +0900
Message-ID: <20060305052851.GA13188@htj.dyndns.org>
References: <11411439393863-git-send-email-htejun@gmail.com> <4408A829.6090805@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.202]:11363 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751696AbWCEF24 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 5 Mar 2006 00:28:56 -0500
Received: by zproxy.gmail.com with SMTP id j2so1007370nzf
        for <linux-ide@vger.kernel.org>; Sat, 04 Mar 2006 21:28:55 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4408A829.6090805@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: jfs@keytradebank.com, 0602@eq.cz, linux-ide@vger.kernel.org

Rename PIIX_FLAG_IGN_PRESENT to PIIX_FLAG_IGNORE_PCS as Jeff
requested.

Signed-off-by: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jgarzik@pobox.com>

diff --git a/drivers/scsi/ata_piix.c b/drivers/scsi/ata_piix.c
index 72e38e6..9327b62 100644
--- a/drivers/scsi/ata_piix.c
+++ b/drivers/scsi/ata_piix.c
@@ -101,7 +101,7 @@ enum {
 	ICH5_PCS		= 0x92,	/* port control and status */
 	PIIX_SCC		= 0x0A, /* sub-class code register */
 
-	PIIX_FLAG_IGN_PRESENT	= (1 << 25), /* ignore PCS present bits */
+	PIIX_FLAG_IGNORE_PCS	= (1 << 25), /* ignore PCS present bits */
 	PIIX_FLAG_SCR		= (1 << 26), /* SCR available */
 	PIIX_FLAG_AHCI		= (1 << 27), /* AHCI possible */
 	PIIX_FLAG_CHECKINTR	= (1 << 28), /* make sure PCI INTx enabled */
@@ -365,7 +365,7 @@ static struct ata_port_info piix_port_in
 	{
 		.sht		= &piix_sht,
 		.host_flags	= ATA_FLAG_SATA | PIIX_FLAG_COMBINED |
-				  PIIX_FLAG_CHECKINTR | PIIX_FLAG_IGN_PRESENT,
+				  PIIX_FLAG_CHECKINTR | PIIX_FLAG_IGNORE_PCS,
 		.pio_mask	= 0x1f,	/* pio0-4 */
 		.mwdma_mask	= 0x07, /* mwdma0-2 */
 		.udma_mask	= 0x7f,	/* udma0-6 */
@@ -538,7 +538,7 @@ static unsigned int piix_sata_probe (str
 		port = map[base + i];
 		if (port < 0)
 			continue;
-		if (ap->flags & PIIX_FLAG_IGN_PRESENT || pcs & 1 << (4 + port))
+		if (ap->flags & PIIX_FLAG_IGNORE_PCS || pcs & 1 << (4 + port))
 			present_mask |= 1 << i;
 		else
 			pcs &= ~(1 << port);
