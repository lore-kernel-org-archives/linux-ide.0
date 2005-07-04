From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [git patches] IDE update
Date: Mon, 4 Jul 2005 21:51:45 +0200
Message-ID: <58cb370e0507041251dd5a@mail.gmail.com>
References: <200507041706.UAA11178@raad.intranet>
	 <42C9742E.8000204@rainbow-software.org>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nproxy.gmail.com ([64.233.182.200]:56164 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261613AbVGDTvy convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 4 Jul 2005 15:51:54 -0400
Received: by nproxy.gmail.com with SMTP id n15so179677nfc
        for <linux-ide@vger.kernel.org>; Mon, 04 Jul 2005 12:51:46 -0700 (PDT)
In-Reply-To: <42C9742E.8000204@rainbow-software.org>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Ondrej Zary <linux@rainbow-software.org>
Cc: Al Boldi <a1426z@gawab.com>, Linus Torvalds <torvalds@osdl.org>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On 7/4/05, Ondrej Zary <linux@rainbow-software.org> wrote:
> Al Boldi wrote:
> > Bartlomiej Zolnierkiewicz wrote: {
> >
> >>On 7/4/05, Al Boldi <a1426z@gawab.com> wrote:
> >>Hdparm -tT gives 38mb/s in 2.4.31
> >>Cat /dev/hda > /dev/null gives 2% user 33% sys 65% idle
> >>
> >>Hdparm -tT gives 28mb/s in 2.6.12
> >>Cat /dev/hda > /dev/null gives 2% user 25% sys 0% idle 73% IOWAIT
> >>
> >>It feels like DMA is not being applied properly in 2.6.12.
> >
> >
> > Are earlier 2.6.x kernels okay?
> >
> > dmesg output?
> > }
> >
> > Same on 2.6.10,11,12.
> > No errors though, only sluggish system.

What about earlier kernels?

Please try to narrow down the problem to a specific kernel version.

> Something like this http://lkml.org/lkml/2005/6/13/1 ?

It doesn't seem like IDE regression but...

Bartlomiej
