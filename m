Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 076A7C2D0E4
	for <linux-ide@archiver.kernel.org>; Mon, 23 Nov 2020 10:09:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9836320888
	for <linux-ide@archiver.kernel.org>; Mon, 23 Nov 2020 10:09:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XjsALs1L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728254AbgKWKJU (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 23 Nov 2020 05:09:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727692AbgKWKJU (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 23 Nov 2020 05:09:20 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95D64C0613CF
        for <linux-ide@vger.kernel.org>; Mon, 23 Nov 2020 02:09:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=evJkac+S1Rl1w5PZanMemK1YSSB/dVbtS7WUti+8iFo=; b=XjsALs1LpBb8YlTzWwjFM48uXg
        d/atjtawBmhMminKi10mbss7ZQmTdP+l96uraDXac0gVr23IuR3SmhF+netUTvBfCH/j8VtFdZnMd
        asYK9rp7B87G4xWxnIlLxtC0H9rsCBj4rDW2Vb7kdwOQj8d4ONdNJaxA2bboFlyDuJZqL4HgXyRd4
        /1N/PDzvtBkRx3Coe/YLHzlfqZmZkNQsixZAfHrzhyos56NiYio763yCIXOAdS7lWQbNdFr2FEIQW
        pxk29BDESaKMDomPnF9Sph01qu/SrVJWJFxabM4mOylKNjxMvcqS1cxeJ04S8Kubv6QtItB0o2vMz
        AwF0lRDA==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kh8mb-0006yw-EX; Mon, 23 Nov 2020 10:09:17 +0000
Date:   Mon, 23 Nov 2020 10:09:17 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, linux-ide@vger.kernel.org
Subject: Re: [PATCH] ahci: Add Intel Emmitsburg PCH RAID PCI IDs
Message-ID: <20201123100917.GA26718@infradead.org>
References: <20201119104318.79297-1-mika.westerberg@linux.intel.com>
 <20201119165022.GA3582@infradead.org>
 <20201120105309.GR2495@lahna.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201120105309.GR2495@lahna.fi.intel.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On Fri, Nov 20, 2020 at 12:53:09PM +0200, Mika Westerberg wrote:
> On Thu, Nov 19, 2020 at 04:50:22PM +0000, Christoph Hellwig wrote:
> > On Thu, Nov 19, 2020 at 01:43:18PM +0300, Mika Westerberg wrote:
> > > Add Intel Emmitsburg PCH RAID PCI IDs to the list of supported
> > > controllers.
> > 
> > Stupid question: what would it to get Intel to finally report the
> > correct classcode after all the time?  The amount of IDs we need to list
> > is getting ridiculous.
> 
> What is the correct class code in this case that it works with the AHCI
> driver?
> 
> I think (not 100% sure) it reports standard AHCI class code when it is
> not in RAID mode but these PCI IDs are for the RAID mode.

The right class code is the AHCI one.  The so called RAID mode doesn't
change the operation of the device at all (except for sometimes hiding
NVMe devices that are a different PCIe function to start with).
