Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65568C8301D
	for <linux-ide@archiver.kernel.org>; Mon, 23 Nov 2020 13:04:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C0C820782
	for <linux-ide@archiver.kernel.org>; Mon, 23 Nov 2020 13:04:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="iSoNo6kW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388345AbgKWNEU (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 23 Nov 2020 08:04:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733296AbgKWMvR (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 23 Nov 2020 07:51:17 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD667C061A4E
        for <linux-ide@vger.kernel.org>; Mon, 23 Nov 2020 04:51:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=hGwFFxZDkfTKMpVUin8IwCyLR1ox8ZPJ5jRaHO73hOQ=; b=iSoNo6kWPZojll+FQV7dP7Wa+u
        8ttxGdC1m8/nivfbbenIuaQdQNCecojUwkypaLqaZU4AEmgF6YqkK2omqBMcdbacqQZ01Wr7y01SZ
        eEv0Rb+vGtgM9i52mj/JcFs6R3P+QWwK3Lv1l2DIZHcZj6X/M5yeIrBdNDJJ41f/Jr4lXjFcPsjoE
        d5aRJ/pD2a025qydKZQIFFTxT1inDDTN62mxU3xXDRzYlVM362ESUtK2y3gV6Y+BdUNcgul37Wmsl
        2oJOVlUlkdCDyVE6iw54pQRNo6ZTTKKGQd9mw2KbKxM/9HCvfp+58XFFCIpI1UMzt04V/gXv/QNpV
        k2A66cow==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1khBJK-00017g-Nq; Mon, 23 Nov 2020 12:51:14 +0000
Date:   Mon, 23 Nov 2020 12:51:14 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, linux-ide@vger.kernel.org
Subject: Re: [PATCH] ahci: Add Intel Emmitsburg PCH RAID PCI IDs
Message-ID: <20201123125114.GA4264@infradead.org>
References: <20201119104318.79297-1-mika.westerberg@linux.intel.com>
 <20201119165022.GA3582@infradead.org>
 <20201120105309.GR2495@lahna.fi.intel.com>
 <20201123100917.GA26718@infradead.org>
 <20201123112622.GB2495@lahna.fi.intel.com>
 <20201123113801.GA15759@infradead.org>
 <20201123122820.GD2495@lahna.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201123122820.GD2495@lahna.fi.intel.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On Mon, Nov 23, 2020 at 02:28:20PM +0200, Mika Westerberg wrote:
> On Mon, Nov 23, 2020 at 11:38:01AM +0000, Christoph Hellwig wrote:
> > The point is: these AHCI controllers do not support RAID in form
> > despite the confusing naming.
> 
> Are you sure?
> 
> I looked at the Emmitsburg data sheet and it actually seems to support
> some sort of RAID but it requires some special Rapid Storage Technology
> [1] drivers from Intel. Probably the idea is that when in "RAID mode"
> the thing, as AHCI spec says, does not announce itself to be AHCI
> compliant which makes Windows inbox AHCI driver to not to load, and this
> allows the Intel propriatery driver to load that then takes advantage of
> this somehow.

Yes, and that is purely (badly implemented) software RAID.
