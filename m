Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1313BC64E69
	for <linux-ide@archiver.kernel.org>; Thu, 19 Nov 2020 16:50:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A62762222A
	for <linux-ide@archiver.kernel.org>; Thu, 19 Nov 2020 16:50:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Mb4xvl1t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729153AbgKSQuZ (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 19 Nov 2020 11:50:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728499AbgKSQuZ (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 19 Nov 2020 11:50:25 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DBF2C0613CF
        for <linux-ide@vger.kernel.org>; Thu, 19 Nov 2020 08:50:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=UPCE6Oz4X7VDqgnGXn3XwYzAd/mQGUqe6qsS38RJ93s=; b=Mb4xvl1tcJsyd+f+zWYhpeLGU5
        hSNx+aFILcH/foNZlsfkwFJ0+WTAbedufrqkqSM5ci9EhSd1wqDXxN1MiJJiTtmVGPcqOPNX4WSRf
        Ws18t0ErlTn3r5mK3YR+wkieWCtz9n/f82fmnhY2in1hrxgYi3jtj3cdmC/WKEZHvyiNhmJJog0f1
        AEe1C3P2+yNM6MpOeCg3pFUv8KNbFi7nqbLjTsO2Q990mjOfOWsENLMYsLvCEOs0zZaYv5brXwzw2
        lIcvvE/zrUDCPYq7bnvcmuaZnS+1QotR9DKQWMBtsoOZQgZWDCkw1nSdng9YKgn5SzwCNWYKrcxwu
        V5LzLGPw==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kfn8Y-00015u-8d; Thu, 19 Nov 2020 16:50:22 +0000
Date:   Thu, 19 Nov 2020 16:50:22 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-ide@vger.kernel.org
Subject: Re: [PATCH] ahci: Add Intel Emmitsburg PCH RAID PCI IDs
Message-ID: <20201119165022.GA3582@infradead.org>
References: <20201119104318.79297-1-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201119104318.79297-1-mika.westerberg@linux.intel.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On Thu, Nov 19, 2020 at 01:43:18PM +0300, Mika Westerberg wrote:
> Add Intel Emmitsburg PCH RAID PCI IDs to the list of supported
> controllers.

Stupid question: what would it to get Intel to finally report the
correct classcode after all the time?  The amount of IDs we need to list
is getting ridiculous.
