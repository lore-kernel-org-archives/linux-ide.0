Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 398D7C43381
	for <linux-ide@archiver.kernel.org>; Thu, 18 Mar 2021 06:08:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D78DC64F10
	for <linux-ide@archiver.kernel.org>; Thu, 18 Mar 2021 06:08:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbhCRGIA (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 18 Mar 2021 02:08:00 -0400
Received: from verein.lst.de ([213.95.11.211]:40153 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229559AbhCRGHa (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Thu, 18 Mar 2021 02:07:30 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 5735768C4E; Thu, 18 Mar 2021 07:07:25 +0100 (CET)
Date:   Thu, 18 Mar 2021 07:07:24 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Christoph Hellwig <hch@lst.de>,
        "David S. Miller" <davem@davemloft.net>,
        Jens Axboe <axboe@kernel.dk>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-ide@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 01/10] alpha: use libata instead of the legacy ide
 driver
Message-ID: <20210318060724.GA29117@lst.de>
References: <20210318045706.200458-1-hch@lst.de> <20210318045706.200458-2-hch@lst.de> <YFLrLwjZubWUvA2J@zeniv-ca.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YFLrLwjZubWUvA2J@zeniv-ca.linux.org.uk>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On Thu, Mar 18, 2021 at 05:54:55AM +0000, Al Viro wrote:
> On Thu, Mar 18, 2021 at 05:56:57AM +0100, Christoph Hellwig wrote:
> > Switch the alpha defconfig from the legacy ide driver to libata.
> 
> Umm...  I don't have an IDE alpha box in a usable shape (fans on
> CPU module shat themselves), and it would take a while to resurrect
> it, but I remember the joy it used to cause in some versions.
> 
> Do you have reports of libata variants of drivers actually tested on
> those?

No, I haven't.  The whole point is that we're not going to keep 40000
lines of code around despite notice for users that don't exist or
care.  If there is a regression we'll fix it, but we're not going to
make life miserable just because we can.
