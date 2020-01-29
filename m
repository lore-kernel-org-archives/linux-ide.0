Return-Path: <SRS0=TxtD=3S=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFEDFC2D0DB
	for <linux-ide@archiver.kernel.org>; Wed, 29 Jan 2020 17:18:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C66F6206F0
	for <linux-ide@archiver.kernel.org>; Wed, 29 Jan 2020 17:18:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TcFaQyli"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727259AbgA2RSv (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 29 Jan 2020 12:18:51 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:50732 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727241AbgA2RSv (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 29 Jan 2020 12:18:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=xn0S8KRH1jS8YVCTq8Af8bK8be4jymLEEWTnenXGXxw=; b=TcFaQyliwW87jlf6pu6/emL0v
        I0OJn/VJWNjhGw/vIEJhLN0cmOe2VRmrep3Xl79QRG0IZv9H0dyyt20thOZIl8vrjidoDaLJ3kqiJ
        VLebR2Ozm1zGebDRikmX23rymkYJ4aI4DAAuGmvIiItq21r9axpgrSsG/V/CeL9r0tIEWKcwRKPP3
        hQowRuN8y+04Sud7hqGz8U1O3ktCQBSAvdxygFS2GgD//+2YJl68/gJS7IA08eR0sQ/pKN9wAQPoM
        YIrdN0Mtgqs4Y7q/jzkVkE+Vg9dttG+IGIP31CyQFdOjtR7lrGbQ9Vam5/ThpO9WtDUNPkN+73r/o
        1nZvYKZzQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iwqzI-0004pL-5E; Wed, 29 Jan 2020 17:18:48 +0000
Date:   Wed, 29 Jan 2020 09:18:48 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Michael Schmitz <schmitzmic@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/28] ata: move EXPORT_SYMBOL_GPL()s close to exported
 code
Message-ID: <20200129171848.GC12616@infradead.org>
References: <20200128133343.29905-1-b.zolnierkie@samsung.com>
 <CGME20200128133413eucas1p195d291f69413cbb3bb86da9571942259@eucas1p1.samsung.com>
 <20200128133343.29905-9-b.zolnierkie@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200128133343.29905-9-b.zolnierkie@samsung.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On Tue, Jan 28, 2020 at 02:33:23PM +0100, Bartlomiej Zolnierkiewicz wrote:
> Move EXPORT_SYMBOL_GPL()s close to exported code like it is
> done in other kernel subsystems. As a nice side effect this
> results in the removal of few ifdefs.
> 
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
