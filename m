Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DA55C4743D
	for <linux-ide@archiver.kernel.org>; Fri,  4 Jun 2021 23:09:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 70BDD613EC
	for <linux-ide@archiver.kernel.org>; Fri,  4 Jun 2021 23:09:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229986AbhFDXLI (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 4 Jun 2021 19:11:08 -0400
Received: from cynthia.allandria.com ([50.242.82.17]:48651 "EHLO
        cynthia.allandria.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229929AbhFDXLI (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 4 Jun 2021 19:11:08 -0400
X-Greylist: delayed 1163 seconds by postgrey-1.27 at vger.kernel.org; Fri, 04 Jun 2021 19:11:08 EDT
Received: from flar by cynthia.allandria.com with local (Exim 4.84_2)
        (envelope-from <flar@allandria.com>)
        id 1lpIdX-0003Gd-V6; Fri, 04 Jun 2021 15:49:56 -0700
Date:   Fri, 4 Jun 2021 15:49:55 -0700
From:   Brad Boyer <flar@allandria.com>
To:     Michael Schmitz <schmitzmic@gmail.com>
Cc:     Finn Thain <fthain@linux-m68k.org>, linux-m68k@vger.kernel.org,
        geert@linux-m68k.org, linux-ide@vger.kernel.org
Subject: Re: [PATCH RFC 1/2] m68k: io_mm.h: conditionalize ISA address
 translation on Atari
Message-ID: <20210604224955.GA12141@allandria.com>
References: <CAMuHMdUskb3oicq8Kbf6MY_4mn4-Y1pJ-om4fny7k48gndscgg@mail.gmail.com>
 <1622611267-15825-1-git-send-email-schmitzmic@gmail.com>
 <1622611267-15825-2-git-send-email-schmitzmic@gmail.com>
 <25ab336d-e0e0-41a8-d468-ecbf8d83d2b@linux-m68k.org>
 <143313da-d294-f89b-d285-235230514c5a@gmail.com>
 <d7165fdd-9269-7bd2-185-c6193f864722@linux-m68k.org>
 <535b7829-f16f-4ddc-a676-dbb10c7a4a35@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <535b7829-f16f-4ddc-a676-dbb10c7a4a35@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On Fri, Jun 04, 2021 at 07:30:00PM +1200, Michael Schmitz wrote:
> >>I'm still unsure whether changing the default branch for the sake of
> >>fixing Atari behaviour is a sane idea - I was hoping for comments either
> >>way.
> >>
> >
> >You mean, what happens if a random m68k platform (other than amiga, atari
> >and q40) were to adopt CONFIG_ISA? I guess it would be nice if that would
> >'just work' but it's probably never going to be needed.
> 
> The NULL default was meant to catch incorrect use of config options related
> to CONFIG_ISA. My repurposing the default branch for Atari's needs (no
> translation for IDE) defeats that. But the chance that we run into such
> incorrect use in the future are pretty slim indeed.

Well, we could in theory add a trex socket driver to get PCMCIA support
for the PowerBook 190 hardware. There was a driver for that in ppc for
the PowerBook 5300 which uses the same chipset. I believe the PCMCIA
drivers use these same macros in spite of not being considered ISA.
I don't see anything in drivers/pcmcia that is obviously an m68k
system even though I'm pretty sure I remember discussions of supporting
such hardware in the past.

Is PCMCIA support something we should also consider in all of this?

	Brad Boyer
	flar@allandria.com

