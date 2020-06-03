Return-Path: <SRS0=RB9J=7Q=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5175CC433DF
	for <linux-ide@archiver.kernel.org>; Wed,  3 Jun 2020 05:15:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2CFC620678
	for <linux-ide@archiver.kernel.org>; Wed,  3 Jun 2020 05:15:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hlcbbSYH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725807AbgFCFPn (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 3 Jun 2020 01:15:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725792AbgFCFPn (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 3 Jun 2020 01:15:43 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76C39C05BD43;
        Tue,  2 Jun 2020 22:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=q/5VpgkyFO00N1VKSSfFPcjSDFVe49KfMOFz+/wJqtg=; b=hlcbbSYHXeyR/GEgn2M2XhV/JK
        9uIwLkjlajSgB2wo3R1EVEiSaC7qlD20OPQOQj3hKOYJGNmniquqEo9fpVU6BgMJMOSu6KbGffwpY
        YLn51RgdX7HB10AZAWIfwbQtn7W6vzY6ac3C5LEWtPN25P4iVhLmHDdHP7i/Zs4atIysUt9yiFNh3
        MiolCQwWerpohlFoaZPfc9eBMrWfQHsRA9hffsOi6mhQhj1/Pnxcg9cSx4UjhHn5qlJWy/pt5wMiR
        QbWxSOZZXENLnqpO4zVHSdhjLqugSSA+xWnyPYSQuAeGx89w8Us2P7ujFzu4Tkgf3AsDT6RvVyhe6
        J3cxqwGg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jgLkb-0006oH-Ig; Wed, 03 Jun 2020 05:15:41 +0000
Date:   Tue, 2 Jun 2020 22:15:41 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Piotr Stankiewicz <piotr.stankiewicz@intel.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/15] ahci: use PCI_IRQ_MSI_TYPES where appropriate
Message-ID: <20200603051541.GA15520@infradead.org>
References: <20200602092012.31831-1-piotr.stankiewicz@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200602092012.31831-1-piotr.stankiewicz@intel.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On Tue, Jun 02, 2020 at 11:20:12AM +0200, Piotr Stankiewicz wrote:
> Seeing as there is shorthand available to use when asking for any type
> of interrupt, or any type of message signalled interrupt, leverage it.
> 
> Signed-off-by: Piotr Stankiewicz <piotr.stankiewicz@intel.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

Im not sure where PCI_IRQ_MSI_TYPES appeared (I can't find it in
mainline), but I think replacing the supported list of types with this
weird group is no in any way a good idea.
