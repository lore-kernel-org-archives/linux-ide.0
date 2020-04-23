Return-Path: <SRS0=1fB0=6H=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 935FBC2BA19
	for <linux-ide@archiver.kernel.org>; Thu, 23 Apr 2020 06:12:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 644E4214AF
	for <linux-ide@archiver.kernel.org>; Thu, 23 Apr 2020 06:12:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KV91X82h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725854AbgDWGMm (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 23 Apr 2020 02:12:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725562AbgDWGMl (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 23 Apr 2020 02:12:41 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6B4EC03C1AB;
        Wed, 22 Apr 2020 23:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=jfQK2PwAh2C3DIS291PKwmLlhxlhjUsgV0psLy3bMmM=; b=KV91X82hek96DEsT+pDcDJJIGj
        9GZPqbKo/WUN/60ih1bKKhXiFmYQ5uA1e2rePhyRNR5rybC3qz+UsJC/MPW4X0wEOLJXhmhqmlEN/
        u+V6l+t8nifGbbIIV2wdhg/BmUa/2Cltiyn4hw5SRuWsmi4KCOWiamn7DG8VdnLPySpoXHUKI2Hrm
        I06C1qIk6epjtEJYbdnSjmAIr0CJrO2NEgdH8bOxb+ITemuMnO5APHTKYNR1WjBzJhtsxxoUnJKOY
        UWILe+jOxHNh/rQrDkCazWVD7SglJ+x88Q2Ddmem1Jd2U69tKt6kh9Ua/36lo+zcGG7+FNVZfvU29
        SITh1RlA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jRV6C-0003IR-Sl; Thu, 23 Apr 2020 06:12:36 +0000
Date:   Wed, 22 Apr 2020 23:12:36 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     John Oldman <john.oldman@polehill.co.uk>
Cc:     axboe@kernel.dk, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Staging: ata: sata_inic162x fixed a spelling issue
Message-ID: <20200423061236.GA12577@infradead.org>
References: <20200422140332.22923-1-john.oldman@polehill.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200422140332.22923-1-john.oldman@polehill.co.uk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On Wed, Apr 22, 2020 at 03:03:32PM +0100, John Oldman wrote:
> Fixed a warning message spelling issue.

Why does this say Staging in the subject?
