Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E235C433DB
	for <linux-ide@archiver.kernel.org>; Sun, 28 Feb 2021 00:20:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3870D64E25
	for <linux-ide@archiver.kernel.org>; Sun, 28 Feb 2021 00:20:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230063AbhB1AUX (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sat, 27 Feb 2021 19:20:23 -0500
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:59690 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230010AbhB1AUW (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sat, 27 Feb 2021 19:20:22 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
        by kvm5.telegraphics.com.au (Postfix) with ESMTP id 96D2A23F62;
        Sat, 27 Feb 2021 19:19:35 -0500 (EST)
Date:   Sun, 28 Feb 2021 11:19:31 +1100 (AEDT)
From:   Finn Thain <fthain@telegraphics.com.au>
To:     Jens Axboe <axboe@kernel.dk>
cc:     "David S. Miller" <davem@davemloft.net>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Michael Schmitz <schmitzmic@gmail.com>,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND] ide/falconide: Fix module unload
In-Reply-To: <5d7fd7bb-1bb8-a21c-61d8-4d1046f92ca8@kernel.dk>
Message-ID: <d92db64-cfb8-9640-35a4-4f864dfc99a2@telegraphics.com.au>
References: <63369c9b96673442a4bd653fe92acda99172123a.1605847196.git.fthain@telegraphics.com.au> <alpine.LNX.2.23.453.2101031017290.12@nippy.intranet> <5d7fd7bb-1bb8-a21c-61d8-4d1046f92ca8@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On Sun, 3 Jan 2021, Jens Axboe wrote:

> > 
> > This patch was sent in September and subsequently resent in November. 
> > I've since learned that the maintainer has been ill. What's the best 
> > way forward for fixes like this?
> 
> I can queue it up.
> 

That would be great.
