Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71A1DC2D0E4
	for <linux-ide@archiver.kernel.org>; Mon, 23 Nov 2020 11:38:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F2B7B206C0
	for <linux-ide@archiver.kernel.org>; Mon, 23 Nov 2020 11:38:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lHjY4Ery"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728696AbgKWLiE (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 23 Nov 2020 06:38:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728305AbgKWLiE (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 23 Nov 2020 06:38:04 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 585EFC0613CF
        for <linux-ide@vger.kernel.org>; Mon, 23 Nov 2020 03:38:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=jf4y1vN5lHGoArc9lJpu/JTgexGWEG8kjM0RZOTtf+E=; b=lHjY4EryTjRlElFaq7QVZp79ff
        vYQZbf8Zme5Wmvv6M1WUIbARRl9xJzyx/p+M8tuy4AtQcqWeYjYGHxjfC2huJqSf2bQidnowY/Iyu
        A+Gdncju3sg2vUFhNRiFpsWKxCv5H99coxoMPNGUIO+TNgg9zmEoc/8jB40vSVqcM0UfH5aNR27O4
        eXloEbCuqGE8/Jpud0IQyzmNGEGKMb40qodmc5YwvEz2+GjzT3hUtk4Fn2sDtctIpuGx1XJGsJE21
        VRZ/DcGVl7JqbNYOJmosF861iPa4h3M8rYifj6ZQTaJf6wfh2Q8wW0X7VSy4g5QC9NmcPeKBxvyN5
        tnfCB0Og==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1khAAU-00047E-15; Mon, 23 Nov 2020 11:38:02 +0000
Date:   Mon, 23 Nov 2020 11:38:01 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, linux-ide@vger.kernel.org
Subject: Re: [PATCH] ahci: Add Intel Emmitsburg PCH RAID PCI IDs
Message-ID: <20201123113801.GA15759@infradead.org>
References: <20201119104318.79297-1-mika.westerberg@linux.intel.com>
 <20201119165022.GA3582@infradead.org>
 <20201120105309.GR2495@lahna.fi.intel.com>
 <20201123100917.GA26718@infradead.org>
 <20201123112622.GB2495@lahna.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201123112622.GB2495@lahna.fi.intel.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On Mon, Nov 23, 2020 at 01:26:22PM +0200, Mika Westerberg wrote:
> On Mon, Nov 23, 2020 at 10:09:17AM +0000, Christoph Hellwig wrote:
> > On Fri, Nov 20, 2020 at 12:53:09PM +0200, Mika Westerberg wrote:
> > > On Thu, Nov 19, 2020 at 04:50:22PM +0000, Christoph Hellwig wrote:
> > > > On Thu, Nov 19, 2020 at 01:43:18PM +0300, Mika Westerberg wrote:
> > > > > Add Intel Emmitsburg PCH RAID PCI IDs to the list of supported
> > > > > controllers.
> > > > 
> > > > Stupid question: what would it to get Intel to finally report the
> > > > correct classcode after all the time?  The amount of IDs we need to list
> > > > is getting ridiculous.
> > > 
> > > What is the correct class code in this case that it works with the AHCI
> > > driver?
> > > 
> > > I think (not 100% sure) it reports standard AHCI class code when it is
> > > not in RAID mode but these PCI IDs are for the RAID mode.
> > 
> > The right class code is the AHCI one.  The so called RAID mode doesn't
> > change the operation of the device at all (except for sometimes hiding
> > NVMe devices that are a different PCIe function to start with).
> 
> Thanks. I looked at the AHCI spec (1.3.1) and it says this regarding the
> class code (CC) field:
> 
>   Informative Note: For HBAs that support RAID, the Sub Class Code reset
>   value should be 04h and the Programming Interface reset value should be
>   00h.
> 
> I think this is what the controller is doing when in "RAID mode".

The point is: these AHCI controllers do not support RAID in form
despite the confusing naming.
