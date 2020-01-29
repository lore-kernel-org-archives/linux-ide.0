Return-Path: <SRS0=TxtD=3S=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECD75C2D0DB
	for <linux-ide@archiver.kernel.org>; Wed, 29 Jan 2020 17:19:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2A03206F0
	for <linux-ide@archiver.kernel.org>; Wed, 29 Jan 2020 17:19:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UY+ErSmJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727303AbgA2RTY (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 29 Jan 2020 12:19:24 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:52108 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727160AbgA2RTY (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 29 Jan 2020 12:19:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=l2WBiCb5duYJRA9nKpihqrJOH1Qjg6utSrFiu8qAdtc=; b=UY+ErSmJvUlzLwk06mqfdmT+P
        WxjROfsOWY/BPRju4fUVBaWQ0LAafnkUm2CoOTlzlECsrXZqbUmI42R9qcD5bEVff4yrHlOL0Z6jL
        SqJoN9MjHzWRLZyS8z1cBBDn+2iTwWM67xNxe5IA+EEJCZGOEZhx90FQk5qPo9iKzudcZNhgnmoKF
        6PPFGAfRaCVEUdi30MYH03Gf26V8/lFSYYXUOGSaTqThlcC7QMkR1Nzr0M4ZfjVd2OZVq7jZQAnbi
        gZ2wD/L6F3ynhMfX23VuqnN+bQ013+/sZd+Nm5QdAzsES/9ycy0LOpEIXg1hKtDht0BwC/+aemjhQ
        uv+WWv1Xw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iwqzp-000577-JY; Wed, 29 Jan 2020 17:19:21 +0000
Date:   Wed, 29 Jan 2020 09:19:21 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Michael Schmitz <schmitzmic@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 09/28] ata: remove EXPORT_SYMBOL_GPL()s not used by
 modules
Message-ID: <20200129171921.GE12616@infradead.org>
References: <20200128133343.29905-1-b.zolnierkie@samsung.com>
 <CGME20200128133413eucas1p1725ccae03fb5aba49f0e0cef798da9d6@eucas1p1.samsung.com>
 <20200128133343.29905-10-b.zolnierkie@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200128133343.29905-10-b.zolnierkie@samsung.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
