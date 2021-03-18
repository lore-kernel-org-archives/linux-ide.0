Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B73A6C433DB
	for <linux-ide@archiver.kernel.org>; Thu, 18 Mar 2021 17:22:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 83ABB64F1C
	for <linux-ide@archiver.kernel.org>; Thu, 18 Mar 2021 17:22:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbhCRRVq convert rfc822-to-8bit (ORCPT
        <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 18 Mar 2021 13:21:46 -0400
Received: from unicorn.mansr.com ([81.2.72.234]:42522 "EHLO unicorn.mansr.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229524AbhCRRVm (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Thu, 18 Mar 2021 13:21:42 -0400
X-Greylist: delayed 753 seconds by postgrey-1.27 at vger.kernel.org; Thu, 18 Mar 2021 13:21:41 EDT
Received: from raven.mansr.com (raven.mansr.com [81.2.72.235])
        by unicorn.mansr.com (Postfix) with ESMTPS id 194A215360;
        Thu, 18 Mar 2021 17:09:03 +0000 (GMT)
Received: by raven.mansr.com (Postfix, from userid 51770)
        id 952E4219C32; Thu, 18 Mar 2021 17:09:02 +0000 (GMT)
From:   =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Jens Axboe <axboe@kernel.dk>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-doc@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>, linux-ide@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        linux-arm-kernel@lists.infradead.org, linux-alpha@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Matt Turner <mattst88@gmail.com>, linux-mips@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Richard Henderson <rth@twiddle.net>
Subject: Re: [PATCH 01/10] alpha: use libata instead of the legacy ide driver
References: <20210318045706.200458-1-hch@lst.de>
        <20210318045706.200458-2-hch@lst.de>
        <YFLrLwjZubWUvA2J@zeniv-ca.linux.org.uk>
        <20210318060724.GA29117@lst.de>
Date:   Thu, 18 Mar 2021 17:09:02 +0000
In-Reply-To: <20210318060724.GA29117@lst.de> (Christoph Hellwig's message of
        "Thu, 18 Mar 2021 07:07:24 +0100")
Message-ID: <yw1x1rccie35.fsf@mansr.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Christoph Hellwig <hch@lst.de> writes:

> On Thu, Mar 18, 2021 at 05:54:55AM +0000, Al Viro wrote:
>> On Thu, Mar 18, 2021 at 05:56:57AM +0100, Christoph Hellwig wrote:
>> > Switch the alpha defconfig from the legacy ide driver to libata.
>> 
>> Umm...  I don't have an IDE alpha box in a usable shape (fans on
>> CPU module shat themselves), and it would take a while to resurrect
>> it, but I remember the joy it used to cause in some versions.
>> 
>> Do you have reports of libata variants of drivers actually tested on
>> those?
>
> No, I haven't.  The whole point is that we're not going to keep 40000
> lines of code around despite notice for users that don't exist or
> care.  If there is a regression we'll fix it, but we're not going to
> make life miserable just because we can.

The pata_ali driver works fine on my UP1500 machine, unless something
broke recently.  I'll build the latest kernel and report back.

-- 
Måns Rullgård
