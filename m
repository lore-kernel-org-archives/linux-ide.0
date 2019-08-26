Return-Path: <SRS0=SK3w=WW=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55859C3A59F
	for <linux-ide@archiver.kernel.org>; Mon, 26 Aug 2019 10:57:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EC5220874
	for <linux-ide@archiver.kernel.org>; Mon, 26 Aug 2019 10:57:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FnJ66lkN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730557AbfHZK5n (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 26 Aug 2019 06:57:43 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:45560 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730199AbfHZK5n (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 26 Aug 2019 06:57:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=rY8ZYFKAHWICyKXrzF2Goxn/VRONDtfY6gf6hJO6jvA=; b=FnJ66lkNWmrV9beLh28V52EqBQ
        B+MK5bBTvKBhh5zkx0l/REgkuLT1d0+1CvlbHcFY8nyiTUAnVbiKJwrvL6Ei1vGsgcjcNg76wUn1K
        1n1E8/9o9Kx7KO09hcto3j2q4yUKgaQvasBS1rDCC2egOtreqHHRHqQFu4Wq4Wxm8WUJLwLt9k1bO
        bqE6ZHzWRnv4J79MOnFTKjrsCeaj3lfA59oHfdvjq2Wzh7MqUiENYL75WCNsI+hTw4xhvS/5PxGDp
        0ayaz0ua/zlpei9cBwR9wOL0pJe/Qlw8R3IBbNhpa5W3GAzgaxxWTotljDQBsoQDLsOp3pvoJ+Iuu
        qvfyC6YA==;
Received: from clnet-p19-102.ikbnet.co.at ([83.175.77.102] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1i2Cgw-0007h0-5q; Mon, 26 Aug 2019 10:57:42 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Mikael Pettersson <mikpelinux@gmail.com>
Cc:     linux-ide@vger.kernel.org
Subject: [PATCH 5/8] sata_nv: use dma_set_mask_and_coherent
Date:   Mon, 26 Aug 2019 12:57:22 +0200
Message-Id: <20190826105725.19405-6-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190826105725.19405-1-hch@lst.de>
References: <20190826105725.19405-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Use the dma_set_mask_and_coherent helper to set the DMA mask.  Rely
on the relatively recent change that setting a larger than required
mask will never fail to avoid the need for the boilerplate 32-bit
fallback code.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/ata/sata_nv.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/ata/sata_nv.c b/drivers/ata/sata_nv.c
index b44b4b64354c..56946012d113 100644
--- a/drivers/ata/sata_nv.c
+++ b/drivers/ata/sata_nv.c
@@ -1122,14 +1122,10 @@ static int nv_adma_port_start(struct ata_port *ap)
 
 	/*
 	 * Now that the legacy PRD and padding buffer are allocated we can
-	 * try to raise the DMA mask to allocate the CPB/APRD table.
+	 * raise the DMA mask to allocate the CPB/APRD table.
 	 */
-	rc = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));
-	if (rc) {
-		rc = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32));
-		if (rc)
-			return rc;
-	}
+	dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));
+
 	pp->adma_dma_mask = *dev->dma_mask;
 
 	mem = dmam_alloc_coherent(dev, NV_ADMA_PORT_PRIV_DMA_SZ,
-- 
2.20.1

