From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 02/15] libata-ncq: add NCQ related libata flags
Date: Tue, 11 Apr 2006 22:53:36 +0900
Message-ID: <11447636161257-git-send-email-htejun@gmail.com>
References: <1144763616819-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.234]:56740 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750975AbWDKNxk (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 11 Apr 2006 09:53:40 -0400
Received: by wproxy.gmail.com with SMTP id i11so927605wra
        for <linux-ide@vger.kernel.org>; Tue, 11 Apr 2006 06:53:39 -0700 (PDT)
In-Reply-To: <1144763616819-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, albertcc@tw.ibm.com, lkosewsk@gmail.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Add two NCQ related libata flags - ATA_DFLAG_NCQ and ATA_FLAG_NCQ..

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 include/linux/libata.h |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

b54166188991cd72df9e174b31692081237ba72c
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 603d800..c9dfc7d 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -123,6 +123,7 @@ enum {
 	/* struct ata_device stuff */
 	ATA_DFLAG_LBA		= (1 << 0), /* device supports LBA */
 	ATA_DFLAG_LBA48		= (1 << 1), /* device supports LBA48 */
+	ATA_DFLAG_NCQ		= (1 << 2), /* device supports NCQ */
 	ATA_DFLAG_CFG_MASK	= (1 << 8) - 1,
 
 	ATA_DFLAG_PIO		= (1 << 8), /* device currently in PIO mode */
@@ -149,6 +150,7 @@ enum {
 	ATA_FLAG_PIO_DMA	= (1 << 7), /* PIO cmds via DMA */
 	ATA_FLAG_PIO_LBA48	= (1 << 8), /* Host DMA engine is LBA28 only */
 	ATA_FLAG_IRQ_MASK	= (1 << 9), /* Mask IRQ in PIO xfers */
+	ATA_FLAG_NCQ		= (1 << 10), /* host supports NCQ */
 
 	ATA_FLAG_NOINTR		= (1 << 16), /* FIXME: Remove this once
 					      * proper HSM is in place. */
-- 
1.2.4


