Return-Path: <SRS0=MoT+=UX=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0A02C43613
	for <linux-ide@archiver.kernel.org>; Mon, 24 Jun 2019 07:12:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B62CD205F4
	for <linux-ide@archiver.kernel.org>; Mon, 24 Jun 2019 07:12:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZkBK7wty"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727438AbfFXHMb (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 24 Jun 2019 03:12:31 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:51568 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727426AbfFXHMb (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 24 Jun 2019 03:12:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Ypx8RhXpItwz9jQAB8bwDgkDsO6VkjqQjWyI/TIh84Q=; b=ZkBK7wty0C80DpH5mFnXya4Tx
        m/JN2XnhSFYE5q0GofgDNb1Iu/3u8j4xAugtGAZmz5XEgM6KTY3nlYOUn9TC97HsxD30ggTU2TSN1
        ZDsOD0786FMQ1yp1RvwkO9sNUsBufrg2P0TZC68zsb22c0CWsNTwfzNfAVs9HCHYSzXbpZHEHGK6t
        paZVg8rdmuJ/wJNXys/Gu+WW69n31ONZLJCTkzQGHzy/pQKgmk2vg6KuBMBQg42T1ltWMgisX/Mg8
        qc8m2ny45d1xoDZHJOs0rWCK3y4DCD7DITsvY+gqnKEEsED+p4OPuO9qnidhYxb9uSb5/znIlrvD5
        QKlWA/Lpw==;
Received: from 213-225-6-159.nat.highway.a1.net ([213.225.6.159] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hfJ9P-0002e0-0L; Mon, 24 Jun 2019 07:12:27 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Mikael Pettersson <mikpelinux@gmail.com>
Cc:     linux-ide@vger.kernel.org
Subject: libata dma_set_mask cleanups
Date:   Mon, 24 Jun 2019 09:12:16 +0200
Message-Id: <20190624071224.24019-1-hch@lst.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Hi all,

this series makes use of the fact that dma_set_mask now never fails
for a larger than necessary DMA mask, and cleans up various other bits
around dma mask setting.
