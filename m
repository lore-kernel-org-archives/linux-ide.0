Return-Path: <SRS0=AWLX=CU=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DFCBC43461
	for <linux-ide@archiver.kernel.org>; Fri, 11 Sep 2020 06:29:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD048221EB
	for <linux-ide@archiver.kernel.org>; Fri, 11 Sep 2020 06:29:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725468AbgIKG27 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 11 Sep 2020 02:28:59 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:33962 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725782AbgIKG25 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 11 Sep 2020 02:28:57 -0400
Received: by mail-oi1-f194.google.com with SMTP id n2so8473430oij.1;
        Thu, 10 Sep 2020 23:28:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XFz8rKiULsWlS4B3yTs1ahls2aSZLYJA1vMCjs+Zp4o=;
        b=CDlnVg9im/AKCsNJZhVz6oRLyvmBDANp4/nZUYJXznMx9EAHOW12z5GeO7cTfF7QNs
         3Z4tCCDzuTL2Wil1JNezI/wwPWdR5eLrlmP9qTjAVgO0+R8YQVHdZoFhQtNihFFp7VHY
         E499kWnRmrG4t130VE/tpkw7JzVcr7/Z77N1OCc4cK1omhF5khzbrVRx2qHGjyJiooY+
         8xtycnZUqL0mnVCoX74jiG70HuL2kvUYBNdwR1PAmegIBjL87P2gkUTFHbqihigDvKHi
         KuHQFENlk7QvXsVaKDnIMRfrJ6uzOWlMNpGe9umCsza0sMYIiowq6S+bSvkl7dZ+MlYS
         m9pg==
X-Gm-Message-State: AOAM532fgqLkB/sUaSK3NJXdyxO282vw3oWibMPWvBXymSb2LC1YO9Cw
        AUwuzkR7qQH7pahsFR58bSPIJqzyk9q0aVKxmJM=
X-Google-Smtp-Source: ABdhPJw4JFMjBLi5cZRkWa/xy3dwylhvGC/mUTcSrnF54YZM6KzEZYCTEmevPskj7NvMNHTwBVh24XWLF9sDZBMg4Gc=
X-Received: by 2002:aca:b742:: with SMTP id h63mr398999oif.148.1599805736227;
 Thu, 10 Sep 2020 23:28:56 -0700 (PDT)
MIME-Version: 1.0
References: <00ee44fe6ecdce1c783c3cc3b1b9a62b498dcdb2.1597736545.git.fthain@telegraphics.com.au>
 <CAMuHMdWAi6+75Mq0U8x7Ut6viHvF7XEZAcYnxq=jJmtJyAX8pw@mail.gmail.com>
 <alpine.LNX.2.23.453.2009100920001.8@nippy.intranet> <CAMuHMdVMvhJRHOwJapi+LAdPbPuoT73ST_Nj0qeCqQd3XWvoSQ@mail.gmail.com>
 <alpine.LNX.2.23.453.2009110847480.8@nippy.intranet>
In-Reply-To: <alpine.LNX.2.23.453.2009110847480.8@nippy.intranet>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 11 Sep 2020 08:28:45 +0200
Message-ID: <CAMuHMdU9vEUasHMeS=OiHX+16dgQGPdmjEtCi+-YLcXvw4BM7g@mail.gmail.com>
Subject: Re: [PATCH] ide/macide: Convert Mac IDE driver to platform driver
To:     Finn Thain <fthain@telegraphics.com.au>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Joshua Thompson <funaho@jurai.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-ide@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Hi Finn,

On Fri, Sep 11, 2020 at 1:05 AM Finn Thain <fthain@telegraphics.com.au> wrote:
> On Thu, 10 Sep 2020, Geert Uytterhoeven wrote:
> > On Thu, Sep 10, 2020 at 2:23 AM Finn Thain <fthain@telegraphics.com.au> wrote:
> > > > How does the driver know not to use the special port_ops after
> > > > this change?
> > > >
> > >
> > > The driver always uses the special port_ops after this change because it
> > > no longer handles the MAC_IDE_BABOON case. That case is handled by either
> >
> > non-MAC_IDE_BABOON case?
> >
> > > drivers/ata/pata_platform.c or drivers/ide/ide_platform.c, depending on
> > > .config.
> >
> > Ideally, we do need to differentiate, right?
> >
>
> Sorry, I'm lost.
>
> The commit log explains that the macide driver is only intended to support
> two of the three variants, because the generic drivers are already able to
> support the third variant (Baboon). Stan confirmed this on his PB 190.
>
> But, IIUC, you seem to want macide to continue to support all three
> variants (?) The existing code to implement that has an old bug that
> reassigns d.port_ops when it is const. IMO, the const is correct because
> macide should concern itself with mac hardware quirks and should not try
> to mimic a generic driver by setting d.port_ops = NULL. Does that make
> sense?

Sorry, I completely missed that the Baboon case registers a "pata_platform"
device instead of a "macide" device.  Hence please ignore my comments
related to that.  Sorry for the noise.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
