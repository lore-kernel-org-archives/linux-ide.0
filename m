Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91F4EC4743D
	for <linux-ide@archiver.kernel.org>; Sat,  5 Jun 2021 06:04:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6EB216140C
	for <linux-ide@archiver.kernel.org>; Sat,  5 Jun 2021 06:04:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229660AbhFEGGh (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sat, 5 Jun 2021 02:06:37 -0400
Received: from cynthia.allandria.com ([50.242.82.17]:48748 "EHLO
        cynthia.allandria.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229972AbhFEGGh (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sat, 5 Jun 2021 02:06:37 -0400
Received: from flar by cynthia.allandria.com with local (Exim 4.84_2)
        (envelope-from <flar@allandria.com>)
        id 1lpPQN-000516-7i; Fri, 04 Jun 2021 23:04:47 -0700
Date:   Fri, 4 Jun 2021 23:04:47 -0700
From:   Brad Boyer <flar@allandria.com>
To:     Michael Schmitz <schmitzmic@gmail.com>
Cc:     Finn Thain <fthain@linux-m68k.org>, linux-m68k@vger.kernel.org,
        geert@linux-m68k.org, linux-ide@vger.kernel.org
Subject: Re: [PATCH RFC 1/2] m68k: io_mm.h: conditionalize ISA address
 translation on Atari
Message-ID: <20210605060447.GA18461@allandria.com>
References: <CAMuHMdUskb3oicq8Kbf6MY_4mn4-Y1pJ-om4fny7k48gndscgg@mail.gmail.com>
 <1622611267-15825-1-git-send-email-schmitzmic@gmail.com>
 <1622611267-15825-2-git-send-email-schmitzmic@gmail.com>
 <25ab336d-e0e0-41a8-d468-ecbf8d83d2b@linux-m68k.org>
 <143313da-d294-f89b-d285-235230514c5a@gmail.com>
 <d7165fdd-9269-7bd2-185-c6193f864722@linux-m68k.org>
 <535b7829-f16f-4ddc-a676-dbb10c7a4a35@gmail.com>
 <20210604224955.GA12141@allandria.com>
 <eefa79e9-01d3-9179-9ca6-57500b9ab7c2@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eefa79e9-01d3-9179-9ca6-57500b9ab7c2@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On Sat, Jun 05, 2021 at 01:41:22PM +1200, Michael Schmitz wrote:
> Am 05.06.2021 um 10:49 schrieb Brad Boyer:
> >I don't see anything in drivers/pcmcia that is obviously an m68k
> >system even though I'm pretty sure I remember discussions of supporting
> >such hardware in the past.
> 
> There's the APNE driver (Amiga PCMCIA NE2000 clone), which is already
> catered for by the current code in io_mm.h. I remember seeing patches for
> that driver that would allow support of a variant of the APNE card that were
> hard to integrate in the current NE clone code framework. Didn't consider
> adding another isa_type for that card at the time - I'll revisit these
> patches if I can find them again.
> 
> Supporting PB190 PCMCIA hardware requires adding a new isa_type and the
> corresponding IO translation cases. Not much more, for all I can see.
> Existing chipset drivers from other architectures ought to work already.
> Maybe add a specific block_input() hook as for APNE (but I surmise that
> might just be code duplication from generic code in lib8390.c - didn't
> check).
> 
> Not sure what card socket code the APNE driver uses - must be one of the
> generic variants from drivers/pcmcia. If your PB190 needs something not
> already in there, we'd need to add that as well.

I had to look a bit, but I found it. The apne driver doesn't use the
normal PCMCIA infrastructure at all. There is a custom Amiga PCMCIA
thing found in arch/m68k/amiga/pcmcia.c. This could complicate things
if we are able to use the common PCMCIA code for trex and try to
build a kernel with both that and amiga/pcmcia + apne.

At least it does sound like the io macros won't be an issue.

	Brad Boyer
	flar@allandria.com

