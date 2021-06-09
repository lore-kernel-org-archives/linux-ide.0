Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93816C48BCF
	for <linux-ide@archiver.kernel.org>; Wed,  9 Jun 2021 03:53:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 733A861181
	for <linux-ide@archiver.kernel.org>; Wed,  9 Jun 2021 03:53:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233234AbhFIDzG (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 8 Jun 2021 23:55:06 -0400
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:34192 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233144AbhFIDzG (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 8 Jun 2021 23:55:06 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by kvm5.telegraphics.com.au (Postfix) with ESMTP id 56E4029DD2;
        Tue,  8 Jun 2021 23:53:10 -0400 (EDT)
Date:   Wed, 9 Jun 2021 13:53:27 +1000 (AEST)
From:   Finn Thain <fthain@linux-m68k.org>
To:     Michael Schmitz <schmitzmic@gmail.com>
cc:     Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        "David S. Miller" <davem@davemloft.net>,
        Joshua Thompson <funaho@jurai.org>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        Richard Zidlicky <rz@linux-m68k.org>
Subject: Re: [PATCH v2 0/2] Use libata platform drivers to replace deprecated
 m68k IDE drivers
In-Reply-To: <36f7519d-698f-1284-551a-0dbd82e2a0d8@gmail.com>
Message-ID: <1016d48a-a276-f7b0-49a8-4571f4f75a61@linux-m68k.org>
References: <cover.1623131194.git.fthain@linux-m68k.org> <YL+AqIEPjMgG519L@infradead.org> <d3c70f7a-368a-ad9a-6575-8289234b0ce0@kernel.dk> <36f7519d-698f-1284-551a-0dbd82e2a0d8@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On Wed, 9 Jun 2021, Michael Schmitz wrote:

> please note that Finn's patch depends on one of mine currently under review.
> Without that one, Q40 support may break in certain cases.
> 

AFAIK, that's only true for a configuration that enables both CONFIG_Q40 
and CONFIG_ATARI. In my tests with stock v5.12, such a configuration 
presently doesn't work correctly on Atari.

This patch series doesn't make this issue any worse.

Besides, I think it is a non-issue because the problem is so rare that 
no-one noticed it before I did, and the workaround for CONFIG_Q40 users is 
trivial anyway (disable CONFIG_ATARI).

Is there really some benefit in holding up this patch series?
