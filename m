From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: linux 2.6.9 controller order reordered. was: [Re: linux 2.6.9 still having network code problems]
Date: Wed, 3 Nov 2004 18:01:45 +0100
Message-ID: <58cb370e04110309011ca7489a@mail.gmail.com>
References: <418741EB.3080701@outblaze.com>
	 <20041102014119.1a6096cc.akpm@osdl.org>
	 <41874D93.9000008@outblaze.com>
	 <20041102020712.18218d47.akpm@osdl.org>
	 <418751B3.8090003@outblaze.com>
	 <20041102022604.262058c4.akpm@osdl.org>
	 <1099413643.24934.1.camel@localhost.localdomain>
	 <41888160.5080502@outblaze.com>
	 <58cb370e041103050016acc419@mail.gmail.com>
	 <4188FE81.1030109@outblaze.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rproxy.gmail.com ([64.233.170.198]:47495 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261668AbUKCRBv (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 3 Nov 2004 12:01:51 -0500
Received: by rproxy.gmail.com with SMTP id y7so137901rne
        for <linux-ide@vger.kernel.org>; Wed, 03 Nov 2004 09:01:46 -0800 (PST)
In-Reply-To: <4188FE81.1030109@outblaze.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Christopher Chan <cchan@outblaze.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@osdl.org>, linux-ide@vger.kernel.org

On Wed, 03 Nov 2004 23:51:29 +0800, Christopher Chan <cchan@outblaze.com> wrote:
> Bartlomiej Zolnierkiewicz wrote:
> > Do you have CONFIG_BLK_DEV_OFFBOARD=y in your config?
> 
> Yes....

This explains the issue...

> > On Wed, 03 Nov 2004 14:57:36 +0800, Christopher Chan <cchan@outblaze.com> wrote:
> >
> >>>What are you on about ? The problem is that in the two traces his
> >>>serverworks has moved from ide0 to ide2.
> >
> >
> 
>
