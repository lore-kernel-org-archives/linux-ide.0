Return-Path: <SRS0=lv1h=CY=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27549C433E2
	for <linux-ide@archiver.kernel.org>; Tue, 15 Sep 2020 22:57:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E9F6C20872
	for <linux-ide@archiver.kernel.org>; Tue, 15 Sep 2020 22:57:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727461AbgIOW5E (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 15 Sep 2020 18:57:04 -0400
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:46572 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727419AbgIOW5E (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 15 Sep 2020 18:57:04 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by kvm5.telegraphics.com.au (Postfix) with ESMTP id 9B1CF272F2;
        Tue, 15 Sep 2020 18:56:57 -0400 (EDT)
Date:   Wed, 16 Sep 2020 08:56:58 +1000 (AEST)
From:   Finn Thain <fthain@telegraphics.com.au>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
cc:     "David S. Miller" <davem@davemloft.net>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Joshua Thompson <funaho@jurai.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-ide@vger.kernel.org
Subject: Re: [PATCH v2] ide/macide: Convert Mac IDE driver to platform
 driver
In-Reply-To: <CAMuHMdX1GXMGg1mviE_msM1vx0ZLEKEPT4AacSBjYDzN6sZVmw@mail.gmail.com>
Message-ID: <alpine.LNX.2.23.453.2009160758350.6@nippy.intranet>
References: <3cf40b9df80a99a3eee6d3af79437016038f0a44.1600051331.git.fthain@telegraphics.com.au> <CAMuHMdUOdOkBE72ouk0W_bXnoSTFqLsLKag+2LSRz+Qox6MoxQ@mail.gmail.com> <alpine.LNX.2.23.453.2009150945480.6@nippy.intranet>
 <CAMuHMdX1GXMGg1mviE_msM1vx0ZLEKEPT4AacSBjYDzN6sZVmw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On Tue, 15 Sep 2020, Geert Uytterhoeven wrote:

> > > > --- a/drivers/ide/macide.c
> > > > +++ b/drivers/ide/macide.c
> > >
> > > > @@ -109,42 +110,61 @@ static const char *mac_ide_name[] =
> > > >   * Probe for a Macintosh IDE interface
> > > >   */
> > > >
> > > > -static int __init macide_init(void)
> > > > +static int mac_ide_probe(struct platform_device *pdev)
> > > >  {
> > >
> > > >         printk(KERN_INFO "ide: Macintosh %s IDE controller\n",
> > > >                          mac_ide_name[macintosh_config->ide_type - 1]);
> > > >
> > > > -       macide_setup_ports(&hw, base, irq);
> > > > +       macide_setup_ports(&hw, mem->start, irq->start);
> > > >
> > > > -       return ide_host_add(&d, hws, 1, NULL);
> > > > +       rc = ide_host_add(&d, hws, 1, &host);
> > > > +       if (rc)
> > > > +               return rc;
> > > > +
> > > > +       platform_set_drvdata(pdev, host);
> > >
> > > Move one up, to play it safe?
> > >
> >
> > You mean, before calling ide_host_add? The 'host' pointer is uninitialized
> > prior to that call.
> 
> Oh right, so the IDE subsystem doesn't let you use the drvdata inside 
> your driver (besides in remove()) in a safe way :-(
> 

The IDE subsystem does allow other patterns here. I could have changed 
ide_host_alloc() into ide_host_register() followed by ide_host_add() but I 
could not see any benefit from that change.

A quick search for "platform_device" shows that the driver does not use 
any uninitialized driver_data pointer (because ide_ifr is a global). In 
your message of September 9th you readily reached the same conclusion when 
you reviewed v1.

If mac_ide_probe() followed the usual pattern it might make review easier 
(as reviewers may not wish to consider the entire driver) but does that 
really make the code more "safe"?
