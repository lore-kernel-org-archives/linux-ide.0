Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F162C433C1
	for <linux-ide@archiver.kernel.org>; Fri, 19 Mar 2021 16:32:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 10C4061980
	for <linux-ide@archiver.kernel.org>; Fri, 19 Mar 2021 16:32:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229875AbhCSQcE (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 19 Mar 2021 12:32:04 -0400
Received: from depni-mx.sinp.msu.ru ([213.131.7.21]:25 "EHLO
        depni-mx.sinp.msu.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229925AbhCSQcD (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 19 Mar 2021 12:32:03 -0400
X-Greylist: delayed 523 seconds by postgrey-1.27 at vger.kernel.org; Fri, 19 Mar 2021 12:32:02 EDT
Received: from spider (ip-95-220-117-58.bb.netbynet.ru [95.220.117.58])
        by depni-mx.sinp.msu.ru (Postfix) with ESMTPSA id 16F391BF496;
        Fri, 19 Mar 2021 19:24:04 +0300 (MSK)
From:   Serge Belyshev <belyshev@depni.sinp.msu.ru>
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
Subject: Re: [PATCH 01/10] alpha: use libata instead of the legacy ide driver
In-Reply-To: <YFLrLwjZubWUvA2J@zeniv-ca.linux.org.uk> (Al Viro's message of
        "Thu, 18 Mar 2021 05:54:55 +0000")
References: <20210318045706.200458-1-hch@lst.de>
        <20210318045706.200458-2-hch@lst.de>
        <YFLrLwjZubWUvA2J@zeniv-ca.linux.org.uk>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
Date:   Fri, 19 Mar 2021 19:23:17 +0300
Message-ID: <87lfajun7u.fsf@depni.sinp.msu.ru>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Al Viro <viro@zeniv.linux.org.uk> writes:

> ...
>
> Do you have reports of libata variants of drivers actually tested on
> those?

PATA_CMD64X works fine on my 164LX for many years, last tested with 5.12-rc3.

(with a caveat: in my setup with CF card DMA is broken, but it is broken
with BLK_DEV_CMD64X as well).
