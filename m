Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EDD7C07E99
	for <linux-ide@archiver.kernel.org>; Fri,  9 Jul 2021 13:03:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA9456023E
	for <linux-ide@archiver.kernel.org>; Fri,  9 Jul 2021 13:03:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231455AbhGINFm (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 9 Jul 2021 09:05:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231285AbhGINFm (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 9 Jul 2021 09:05:42 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A09AC0613DD
        for <linux-ide@vger.kernel.org>; Fri,  9 Jul 2021 06:02:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=GI1I5jHdt3UOe70cgWxZkHEypM3B1skzMDDEquI28sU=; b=et1FJMoU6hSqHOBiJUV5tUxPfd
        YKowuIhn1qbODXUbiSSNIwwFP9R2hEsPkgTzpCKjBNeccb7DK0p8AIBB05/eESFqYG8PWyX+IC8cr
        /X07nTU5n/T+Pnump+TB7bWdwyyuqVoY+ddCeMuGkuA3y/KpPe+3Gvi2BPg+efh3CyC4fj7cuAr/E
        fSciKLlbD4cxtNjqhRwjkaGcwq5qTN0JwKt3m34DNuwhqUUAeqILzA5lj8XFp43S9czvhmIT7vHzU
        UdPek/YmD4Ovx7WM2T64Do6idAd2K/F48xgQvGnGtVO7MijVIw5/zft8WKqK1ZXSB49CIyOAsyc4g
        JraUpChw==;
Received: from p4fdb05cb.dip0.t-ipconnect.de ([79.219.5.203] helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m1q9R-00EWEM-BT; Fri, 09 Jul 2021 13:02:44 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     torvalds@linux-foundation.org, linux-ide@vger.kernel.org,
        kernel test robot <oliver.sang@intel.com>
Subject: [PATCH] libata: fix ata_pio_sector for CONFIG_HIGHMEM
Date:   Fri,  9 Jul 2021 15:02:37 +0200
Message-Id: <20210709130237.3730959-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Data transfers are not required to be block aligned in memory, so they
span two pages.  Fix this by splitting the call to >sff_data_xfer into
two for that case.

This has been broken since the initial libata import before the damn
of git, but was uncovered by the legacy ide driver removal.

Reported-by: kernel test robot <oliver.sang@intel.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/ata/libata-sff.c | 35 +++++++++++++++++++++++++++--------
 1 file changed, 27 insertions(+), 8 deletions(-)

diff --git a/drivers/ata/libata-sff.c b/drivers/ata/libata-sff.c
index ae7189d1a568..b71ea4a680b0 100644
--- a/drivers/ata/libata-sff.c
+++ b/drivers/ata/libata-sff.c
@@ -637,6 +637,20 @@ unsigned int ata_sff_data_xfer32(struct ata_queued_cmd *qc, unsigned char *buf,
 }
 EXPORT_SYMBOL_GPL(ata_sff_data_xfer32);
 
+static void ata_pio_xfer(struct ata_queued_cmd *qc, struct page *page,
+		unsigned int offset, size_t xfer_size)
+{
+	bool do_write = (qc->tf.flags & ATA_TFLAG_WRITE);
+	unsigned char *buf;
+
+	buf = kmap_atomic(page);
+	qc->ap->ops->sff_data_xfer(qc, buf + offset, xfer_size, do_write);
+	kunmap_atomic(buf);
+
+	if (!do_write && !PageSlab(page))
+		flush_dcache_page(page);
+}
+
 /**
  *	ata_pio_sector - Transfer a sector of data.
  *	@qc: Command on going
@@ -648,11 +662,9 @@ EXPORT_SYMBOL_GPL(ata_sff_data_xfer32);
  */
 static void ata_pio_sector(struct ata_queued_cmd *qc)
 {
-	int do_write = (qc->tf.flags & ATA_TFLAG_WRITE);
 	struct ata_port *ap = qc->ap;
 	struct page *page;
 	unsigned int offset;
-	unsigned char *buf;
 
 	if (!qc->cursg) {
 		qc->curbytes = qc->nbytes;
@@ -670,13 +682,20 @@ static void ata_pio_sector(struct ata_queued_cmd *qc)
 
 	DPRINTK("data %s\n", qc->tf.flags & ATA_TFLAG_WRITE ? "write" : "read");
 
-	/* do the actual data transfer */
-	buf = kmap_atomic(page);
-	ap->ops->sff_data_xfer(qc, buf + offset, qc->sect_size, do_write);
-	kunmap_atomic(buf);
+	/*
+	 * Split the transfer when it splits a page boundary.  Note that the
+	 * split still has to be dword aligned like all ATA data transfers.
+	 */
+	WARN_ON_ONCE(offset % 4);
+	if (offset + qc->sect_size > PAGE_SIZE) {
+		unsigned int split_len = PAGE_SIZE - offset;
 
-	if (!do_write && !PageSlab(page))
-		flush_dcache_page(page);
+		ata_pio_xfer(qc, page, offset, split_len);
+		ata_pio_xfer(qc, nth_page(page, 1), 0,
+			     qc->sect_size - split_len);
+	} else {
+		ata_pio_xfer(qc, page, offset, qc->sect_size);
+	}
 
 	qc->curbytes += qc->sect_size;
 	qc->cursg_ofs += qc->sect_size;
-- 
2.30.2

