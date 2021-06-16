Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F06A7C48BE8
	for <linux-ide@archiver.kernel.org>; Wed, 16 Jun 2021 13:48:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D840461356
	for <linux-ide@archiver.kernel.org>; Wed, 16 Jun 2021 13:48:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233589AbhFPNuM (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 16 Jun 2021 09:50:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233570AbhFPNuF (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 16 Jun 2021 09:50:05 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D28BC061574;
        Wed, 16 Jun 2021 06:47:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=hz+UUrM8ElLAj/iJo+DmppsdBvwZ+F/R3vYoPMFC1v0=; b=HIXR7KJRvzBTx1oAaTOhFmEuQe
        7CrxkQC18XDjnkjby7ybaNzflCoG6u6dQhmFAZo0KG7x2b39Uuv+A32AODZB2lArcUjcu+qbWHefe
        n81gkVEX4j8vD6cP+WCo3Y76nSvHTwJlVPORP90hsMlal4lckKPFG1aJpU5uw1LKUWLsEEaKymzxW
        5SF3TSiQnWUILvnEhwlbu7/aKNZ7ukSi+paqcn2zBgJ03rW+AbDWf+Y09zkefOPw9sIP5kIlJycer
        GeLGcS0yRcv5hzlgsxqhLHTk4eroIDW0ZMQneIeIyZF5e3pNUT20Cy+7/oP+m/xsKs2KR3goQdRow
        br23u7wQ==;
Received: from [2001:4bb8:19b:fdce:84d:447:81f0:ca60] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ltVt4-0085ue-Gh; Wed, 16 Jun 2021 13:47:26 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     "David S. Miller" <davem@davemloft.net>,
        Jens Axboe <axboe@kernel.dk>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-ide@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-m68k@lists.linux-m68k.org
Subject: [PATCH 1/6] pata_cypress: add a module option to disable BM-DMA
Date:   Wed, 16 Jun 2021 15:46:53 +0200
Message-Id: <20210616134658.1471835-2-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210616134658.1471835-1-hch@lst.de>
References: <20210616134658.1471835-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Multiple users report that they need to disable DMA on this driver,
so provide an option to do so without affecting all of libata.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/ata/pata_cypress.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/pata_cypress.c b/drivers/ata/pata_cypress.c
index e1486fe298ae..5b3a7a8ebef6 100644
--- a/drivers/ata/pata_cypress.c
+++ b/drivers/ata/pata_cypress.c
@@ -41,6 +41,10 @@ enum {
 	CY82_INDEX_TIMEOUT	= 0x32
 };
 
+static bool enable_dma = true;
+module_param(enable_dma, bool, 0);
+MODULE_PARM_DESC(enable_dma, "Enable bus master DMA operations");
+
 /**
  *	cy82c693_set_piomode	-	set initial PIO mode data
  *	@ap: ATA interface
@@ -124,14 +128,16 @@ static struct ata_port_operations cy82c693_port_ops = {
 
 static int cy82c693_init_one(struct pci_dev *pdev, const struct pci_device_id *id)
 {
-	static const struct ata_port_info info = {
+	static struct ata_port_info info = {
 		.flags = ATA_FLAG_SLAVE_POSS,
 		.pio_mask = ATA_PIO4,
-		.mwdma_mask = ATA_MWDMA2,
 		.port_ops = &cy82c693_port_ops
 	};
 	const struct ata_port_info *ppi[] = { &info, &ata_dummy_port_info };
 
+	if (enable_dma)
+		info.mwdma_mask = ATA_MWDMA2;
+
 	/* Devfn 1 is the ATA primary. The secondary is magic and on devfn2.
 	   For the moment we don't handle the secondary. FIXME */
 
-- 
2.30.2

