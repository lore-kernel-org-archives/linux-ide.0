Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15907C47082
	for <linux-ide@archiver.kernel.org>; Mon,  7 Jun 2021 08:46:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE54A60E08
	for <linux-ide@archiver.kernel.org>; Mon,  7 Jun 2021 08:46:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230131AbhFGIsb (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 7 Jun 2021 04:48:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbhFGIsa (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 7 Jun 2021 04:48:30 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25415C061766
        for <linux-ide@vger.kernel.org>; Mon,  7 Jun 2021 01:46:23 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id dj8so19350590edb.6
        for <linux-ide@vger.kernel.org>; Mon, 07 Jun 2021 01:46:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kazik.de; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rbCJZ424Xbt1MnOfGZf2sF9LS+q4Pp70klcOnStjO08=;
        b=rVqM/N7ix6+OFOAqkzmX/3xR+VlPj49ipm/MCahSj2TeHef+NFYDEi6YmLyp/zvLo1
         yJOMfqUsR9VaRoZirf2O9halVqRXr9wqnGlav1+bXjIDu4/scqA7V4E+aIPH5RPdpj9s
         ak2db+be33WvInAZeRfH0cXVt1OmFxsJ8Uxnc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rbCJZ424Xbt1MnOfGZf2sF9LS+q4Pp70klcOnStjO08=;
        b=V4wMEo/tz003YKsrLWf0A2GOyqdRAj8sHGR8V7IlolE+NWaOql/WIvcXiqWBn3tk1z
         QEH3pPFlrl4gySIEw0G7b7M09eMxxC16mxMKMtuPLxK22LTHLnp0kwsD6RqOOxW6I7sA
         F1xz54CAIPazaQh686tGy464Iv/kmFN5JWIO42y78NiEUzscroOxs7G0JUcD4mggJZrv
         C4+DA6R8AS0l9VZzdJAklHu8bkl3/viZ66/F+5IEe+//87wAgEhQBBSLIJuGqPnNgING
         ZtJFXn78UgK8vioek8UgYbF9auy/gME+vfEf2riRK4CvPeJi6HSpOZZ/22pihigMW3qx
         u9OQ==
X-Gm-Message-State: AOAM532oxfaMHgKIYU5xXhnJX3bDKmcrq/yAbRjYvGPgGO6zwOGN7Mbf
        5ch5PvE790r08IA/mrE7h/2g+6PDMJLfKhm39ixZbg==
X-Google-Smtp-Source: ABdhPJyxVmF5qq2RnWEx36JlhrjEE//8AmCKLcPsyhdNc3vg9ieNuhslYCmsW8jAruky+WQ86nfRnSGCmnXvx/owm8Q=
X-Received: by 2002:a05:6402:5256:: with SMTP id t22mr5796547edd.54.1623055579647;
 Mon, 07 Jun 2021 01:46:19 -0700 (PDT)
MIME-Version: 1.0
References: <20210605060447.GA18461@allandria.com> <1622958877-2026-1-git-send-email-schmitzmic@gmail.com>
 <1622958877-2026-3-git-send-email-schmitzmic@gmail.com> <CAMuHMdXEs874y3nBjVNt8TQP-AMLTRMFgh+1wMt2xyJP3W_+Dg@mail.gmail.com>
 <d6268e39-295d-f9a4-862c-738803168f03@gmail.com>
In-Reply-To: <d6268e39-295d-f9a4-862c-738803168f03@gmail.com>
From:   ALeX Kazik <alex@kazik.de>
Date:   Mon, 7 Jun 2021 10:46:09 +0200
Message-ID: <CAFFuhJp5iu-2o4wYf3XSsCF3VV_T-q8gp08bkPpGBs8Ra_OnKw@mail.gmail.com>
Subject: Re: [PATCH RFC 2/2] net/8390: apne.c - add 100 Mbit support to apne.c driver
To:     Michael Schmitz <schmitzmic@gmail.com>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        "Linux/m68k" <linux-m68k@vger.kernel.org>,
        linux-ide@vger.kernel.org, Finn Thain <fthain@linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Hi all,

> It's been quite a while - can you still try and build/test this change, Alex?

I'm happy to test it again (assuming my Amiga still works, not used
for a while).
But I'm waiting until you guys have perfected the patch.

> >> +
> >>         pr_info("Looking for PCMCIA ethernet card : ");
> >>
> >>         /* check if a card is inserted */
> >> @@ -590,6 +597,16 @@ static int init_pcmcia(void)
> >>  #endif
> >>         u_long offset;
> >>
> >> +#ifdef CONFIG_APNE100MBIT
> >> +       /* reset card (idea taken from CardReset by Artur Pogoda) */
> >> +       {
> >> +               u_char  tmp = gayle.intreq;
> >> +
> >> +               gayle.intreq = 0xff;    mdelay(1);
> >> +               gayle.intreq = tmp;     mdelay(300);
> >> +       }
> >
> > Is this safe for all cards?
>
> I _think_ so, but this really is a question for Alex and others involved
> in developing the original patch. (The original patch had that
> conditionalized as well so I might be wrong ...)

My code is based on the patches here: http://www.g-mb.de/pcmcia_e.html

I'm not deep into it, just adapted the patch. And that's why I can't
tell if the other drivers will work with it always enabled, sorry.

Bye,
Alex.
