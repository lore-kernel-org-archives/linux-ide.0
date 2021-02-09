Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA2AFC433DB
	for <linux-ide@archiver.kernel.org>; Tue,  9 Feb 2021 08:33:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E2B864EC4
	for <linux-ide@archiver.kernel.org>; Tue,  9 Feb 2021 08:33:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbhBIIdK (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 9 Feb 2021 03:33:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229752AbhBIIdI (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 9 Feb 2021 03:33:08 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94BADC061786
        for <linux-ide@vger.kernel.org>; Tue,  9 Feb 2021 00:32:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=EflpwnuCStfeDmxIDYvszEB1UgJrJwIxHa5V3CzMi0w=; b=e4Z7Jj/7pPVj9WLAkL7f3Fbtx7
        Kx9PUcvZx/sbZNCOLb93FxiOXPjePqJJwQgCbOfvbPgHcqTzwUn0QfkxqUZfNwxCQVNcdUxeh65cS
        0F2F5dwT8biqiauwHM0lyT4bhZFHRnYCLu3XtQiEOMTW9mh29Repuv4OT36alYhrbf/LPhao/2147
        Yv08KDpogNznkAL1FUoSxU4a17s/HM3LpmHmURqQJiXvbCeuofvTMf/YP1aKgHw8yVstq5JwY4PX7
        qswMPEfVcFGtN0ThaAMjSZWF04Rp3YYxd0KQ76PKruo8D5ctjfxW6TwxFoFzKYiRcPiE85IUmdyGj
        2o6WLb8g==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1l9ORY-007APg-SD; Tue, 09 Feb 2021 08:32:21 +0000
Date:   Tue, 9 Feb 2021 08:32:20 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Jeffle Xu <jefflexu@linux.alibaba.com>
Cc:     davem@davemloft.net, linux-ide@vger.kernel.org,
        joseph.qi@linux.alibaba.com
Subject: Re: [PATCH] ide: set missing QUEUE_FLAG_ADD_RANDOM
Message-ID: <20210209083220.GA1708073@infradead.org>
References: <20210209081013.38979-1-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210209081013.38979-1-jefflexu@linux.alibaba.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On Tue, Feb 09, 2021 at 04:10:13PM +0800, Jeffle Xu wrote:
> While the whole block layer has migrated to mq framework,
> QUEUE_FLAG_ADD_RANDOM is not included in QUEUE_FLAG_MQ_DEFAULT as the
> default flags.

If you are using the legacy ide code anywhere please switch to libata
ASAP as it is about to go away.
