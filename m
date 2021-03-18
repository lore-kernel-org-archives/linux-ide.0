Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29304C433E6
	for <linux-ide@archiver.kernel.org>; Thu, 18 Mar 2021 15:59:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC02964E37
	for <linux-ide@archiver.kernel.org>; Thu, 18 Mar 2021 15:59:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231805AbhCRP6s (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 18 Mar 2021 11:58:48 -0400
Received: from elvis.franken.de ([193.175.24.41]:40627 "EHLO elvis.franken.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230338AbhCRP6d (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Thu, 18 Mar 2021 11:58:33 -0400
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1lMv2a-0002Um-00; Thu, 18 Mar 2021 16:58:28 +0100
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 6EC6BC0CFA; Thu, 18 Mar 2021 15:19:00 +0100 (CET)
Date:   Thu, 18 Mar 2021 15:19:00 +0100
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Christoph Hellwig <hch@lst.de>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Jens Axboe <axboe@kernel.dk>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-ide@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 08/10] MIPS: disable CONFIG_IDE in malta*_defconfig
Message-ID: <20210318141900.GA10554@alpha.franken.de>
References: <20210318045706.200458-1-hch@lst.de>
 <20210318045706.200458-9-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210318045706.200458-9-hch@lst.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On Thu, Mar 18, 2021 at 05:57:04AM +0100, Christoph Hellwig wrote:
>  arch/mips/configs/malta_kvm_guest_defconfig | 3 ---

that file is gone in mips-next.

I could take all MIPS patches into mips-next, if you want...

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
