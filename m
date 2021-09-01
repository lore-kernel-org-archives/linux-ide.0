Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B842DC432BE
	for <linux-ide@archiver.kernel.org>; Wed,  1 Sep 2021 06:33:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 952F760FE6
	for <linux-ide@archiver.kernel.org>; Wed,  1 Sep 2021 06:33:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231658AbhIAGeU (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 1 Sep 2021 02:34:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231501AbhIAGeT (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 1 Sep 2021 02:34:19 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9AD0C061575;
        Tue, 31 Aug 2021 23:33:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=VuAFtE5tH+k/1J5m7DWoHGj8sWp6YOyq2WnD4vK38S8=; b=ad2Ir0FjPU5azc2pRQ2IBgWAQ0
        QFXAS1BH/DIBARUP+qd/I+WyngEAvozEnhT/oFrtzbutc4s6DQZltuK/cy2drYU1zMrdtDk6FnM7W
        4FxlbMwdkgR/LXY35IWCr06FJVmB3jZviCZCgJwhFOin7wI/4U0qT88W86paX+KaD4h9tV+wkT/Us
        5SyvagCbF7PQ/dfrA6exYL4tLayA0yMneoNPVRjsNq8EkmtmL1NLDef2BCjKzedNBghOpAUTnsloi
        5YMJtS5Digp6O77LnM8IRd3Z+6HtIDroL35Q42fes6nQ4vr8s0R/hMfFjLh21Mcyv5iqoypYCTh3E
        kLAaaHuQ==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mLJnV-001xAu-PC; Wed, 01 Sep 2021 06:32:45 +0000
Date:   Wed, 1 Sep 2021 07:32:33 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Kate Hsuan <hpa@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Hans de Goede <hdegoede@redhat.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] libata: Add ATA_HORKAGE_NO_NCQ_ON_AMD for Samsung 860
 and 870 SSD.
Message-ID: <YS8egQU7RVhc6Uwk@infradead.org>
References: <20210901045220.27746-1-hpa@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210901045220.27746-1-hpa@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On Wed, Sep 01, 2021 at 12:52:20PM +0800, Kate Hsuan wrote:
> Many users are reporting that the Samsung 860 and 870 SSD are having
> various issues when combined with AMD SATA controllers and only
> completely disabling NCQ helps to avoid these issues.
> 
> Always disabling NCQ for Samsung 860/870 SSDs regardless of the host
> SATA adapter vendor will cause I/O performance degradation with well
> behaved adapters. To limit the performance impact to AMD adapters,
> introduce the ATA_HORKAGE_NO_NCQ_ON_AMD flag to force disable NCQ
> only for these adapters.
> 
> BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=201693
> Signed-off-by: Kate Hsuan <hpa@redhat.com>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
