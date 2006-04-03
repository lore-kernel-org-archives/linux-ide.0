From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 02/14] libata: add NCQ related libata flags
Date: Mon, 3 Apr 2006 17:32:39 +0900
Message-ID: <11440531593791-git-send-email-htejun@gmail.com>
References: <1144053158183-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.234]:56548 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751544AbWDCIco (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 3 Apr 2006 04:32:44 -0400
Received: by wproxy.gmail.com with SMTP id 68so1223806wra
        for <linux-ide@vger.kernel.org>; Mon, 03 Apr 2006 01:32:44 -0700 (PDT)
In-Reply-To: <1144053158183-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, albertcc@tw.ibm.com, axboe@suse.de, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Add two NCQ related libata flags - ATA_DFLAG_NCQ and ATA_FLAG_NCQ..

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 include/linux/libata.h |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

190336a29c98e025ad0c9e76f8d6115d00a90918
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 43e5392..c3a3cc0 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -124,6 +124,7 @@ enum {
 	/* struct ata_device stuff */
 	ATA_DFLAG_LBA		= (1 << 0), /* device supports LBA */
 	ATA_DFLAG_LBA48		= (1 << 1), /* device supports LBA48 */
+	ATA_DFLAG_NCQ		= (1 << 2), /* device supports NCQ */
 	ATA_DFLAG_CFG_MASK	= (1 << 8) - 1,
 
 	ATA_DFLAG_PIO		= (1 << 8), /* device currently in PIO mode */
@@ -150,6 +151,7 @@ enum {
 	ATA_FLAG_PIO_DMA	= (1 << 7), /* PIO cmds via DMA */
 	ATA_FLAG_PIO_LBA48	= (1 << 8), /* Host DMA engine is LBA28 only */
 	ATA_FLAG_IRQ_MASK	= (1 << 9), /* Mask IRQ in PIO xfers */
+	ATA_FLAG_NCQ		= (1 << 10), /* host supports NCQ */
 
 	ATA_FLAG_NOINTR		= (1 << 16), /* FIXME: Remove this once
 					      * proper HSM is in place. */
-- 
1.2.4


