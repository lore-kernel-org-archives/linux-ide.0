Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9E89C48BCD
	for <linux-ide@archiver.kernel.org>; Thu, 10 Jun 2021 07:57:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C14E3613CB
	for <linux-ide@archiver.kernel.org>; Thu, 10 Jun 2021 07:57:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230120AbhFJH7j (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 10 Jun 2021 03:59:39 -0400
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:59644 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230137AbhFJH7d (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 10 Jun 2021 03:59:33 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by kvm5.telegraphics.com.au (Postfix) with ESMTP id 2493B2BB40;
        Thu, 10 Jun 2021 03:57:30 -0400 (EDT)
Date:   Thu, 10 Jun 2021 17:57:48 +1000 (AEST)
From:   Finn Thain <fthain@linux-m68k.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
cc:     Jens Axboe <axboe@kernel.dk>,
        "David S. Miller" <davem@davemloft.net>,
        Joshua Thompson <funaho@jurai.org>, linux-ide@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Richard Zidlicky <rz@linux-m68k.org>,
        Michael Schmitz <schmitzmic@gmail.com>
Subject: Re: [PATCH v3 0/2] Use libata platform drivers to replace deprecated
 m68k IDE drivers
In-Reply-To: <CAMuHMdWLJWBH5uz=PLL7pt2uEHz9uSO2Gh7twCDUTz3NDfhdEQ@mail.gmail.com>
Message-ID: <417a2d12-6085-e796-a8a5-605a58f131f@linux-m68k.org>
References: <cover.1623287706.git.fthain@linux-m68k.org> <CAMuHMdWLJWBH5uz=PLL7pt2uEHz9uSO2Gh7twCDUTz3NDfhdEQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On Thu, 10 Jun 2021, Geert Uytterhoeven wrote:

> On Thu, Jun 10, 2021 at 3:34 AM Finn Thain <fthain@linux-m68k.org> wrote:
> > This patch series allows m68k platforms to switch from deprecated IDE
> > drivers to libata drivers.
> >
> > Changed since v1:
> >  - Added reviewed-by and tested-by tags.
> >  - Improved commit log.
> >
> > Changed since v2:
> >  - Added #ifdef guards to prevent build failure when CONFIG_ATARI=n.
> 
> Thanks for the update!
> 
> Note that Jens has already applied v2 to block/for-next.
> https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git/commit/?h=for-next&id=9658506fbf8c1b629ca8a660862bc1ee57400506
> 

Thanks for the tip. I gather that Jens' tree can't be rebased, so I'll 
have to send another patch...
