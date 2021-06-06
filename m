Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C6D8C4743E
	for <linux-ide@archiver.kernel.org>; Sun,  6 Jun 2021 23:51:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 349806142C
	for <linux-ide@archiver.kernel.org>; Sun,  6 Jun 2021 23:51:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229884AbhFFXxA (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sun, 6 Jun 2021 19:53:00 -0400
Received: from cynthia.allandria.com ([50.242.82.17]:49540 "EHLO
        cynthia.allandria.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229813AbhFFXxA (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sun, 6 Jun 2021 19:53:00 -0400
Received: from flar by cynthia.allandria.com with local (Exim 4.84_2)
        (envelope-from <flar@allandria.com>)
        id 1lq2Xq-0003CW-Ir; Sun, 06 Jun 2021 16:51:06 -0700
Date:   Sun, 6 Jun 2021 16:51:06 -0700
From:   Brad Boyer <flar@allandria.com>
To:     Michael Schmitz <schmitzmic@gmail.com>
Cc:     Finn Thain <fthain@linux-m68k.org>, linux-m68k@vger.kernel.org,
        geert@linux-m68k.org, linux-ide@vger.kernel.org,
        ALeX Kazik <alex@kazik.de>
Subject: Re: [PATCH RFC 1/2] m68k: io_mm.h: conditionalize ISA address
 translation on Atari
Message-ID: <20210606235106.GA10846@allandria.com>
References: <25ab336d-e0e0-41a8-d468-ecbf8d83d2b@linux-m68k.org>
 <143313da-d294-f89b-d285-235230514c5a@gmail.com>
 <d7165fdd-9269-7bd2-185-c6193f864722@linux-m68k.org>
 <535b7829-f16f-4ddc-a676-dbb10c7a4a35@gmail.com>
 <20210604224955.GA12141@allandria.com>
 <eefa79e9-01d3-9179-9ca6-57500b9ab7c2@gmail.com>
 <20210605060447.GA18461@allandria.com>
 <5bed9868-2cb6-6604-abb9-faa9361fa3e3@gmail.com>
 <bfce51f-a393-7c3e-77f0-a99595a0d037@linux-m68k.org>
 <460124e6-6ac3-4b94-43de-ebff5cb50cf8@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <460124e6-6ac3-4b94-43de-ebff5cb50cf8@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On Sun, Jun 06, 2021 at 05:42:30PM +1200, Michael Schmitz wrote:
> >Would (port & ~1) be faster than (port - 1) here?
> 
> Perhaps it would - I'd hope the compiler will pick the most efficient
> solution here.

I'm pretty sure the compiler couldn't do that optimization. Without
more context, those two statements are not equivalent. I don't see
how the compiler could know that.

Looking at the 68040 manual, the instruction timing of ANDI and SUBQ
is mostly the same (except for immediate addressing, where ANDI is
slower). The ANDI is also going to take up extra bytes in the code
to put the bitmask in an extension word. BCLR can be faster than
ANDI or SUBQ in some cases, but it's slower in others. It also needs
an extension word when using an immediate value for the bit number.
If you presume port is in a data register, then ANDI and SUBQ have
the same timing and BCLR is slower. At that point, the difference
between ANDI and SUBQ is the size of the instruction which would
favor using SUBQ. I haven't checked if other m68k chips have similar
timings.

Unless I missed something, I don't see a better way to do the
equivalent of the and with a constant bitmask.

	Brad Boyer
	flar@allandria.com

