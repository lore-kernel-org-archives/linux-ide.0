From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [git patches] IDE update
Date: Mon, 4 Jul 2005 22:47:39 +0200
Message-ID: <58cb370e05070413472629dd58@mail.gmail.com>
References: <58cb370e0507041251dd5a@mail.gmail.com>
	 <200507042033.XAA19724@raad.intranet>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nproxy.gmail.com ([64.233.182.206]:48454 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261658AbVGDUrm convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 4 Jul 2005 16:47:42 -0400
Received: by nproxy.gmail.com with SMTP id o25so183965nfa
        for <linux-ide@vger.kernel.org>; Mon, 04 Jul 2005 13:47:39 -0700 (PDT)
In-Reply-To: <200507042033.XAA19724@raad.intranet>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Al Boldi <a1426z@gawab.com>
Cc: Ondrej Zary <linux@rainbow-software.org>, Linus Torvalds <torvalds@osdl.org>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On 7/4/05, Al Boldi <a1426z@gawab.com> wrote:
> Bartlomiej Zolnierkiewicz wrote: {
> > >
> > >>On 7/4/05, Al Boldi <a1426z@gawab.com> wrote:
> > >>Hdparm -tT gives 38mb/s in 2.4.31
> > >>Cat /dev/hda > /dev/null gives 2% user 33% sys 65% idle
> > >>
> > >>Hdparm -tT gives 28mb/s in 2.6.12
> > >>Cat /dev/hda > /dev/null gives 2% user 25% sys 0% idle 73% IOWAIT
> > >>
> > >>It feels like DMA is not being applied properly in 2.6.12.
> > >
> > > Same on 2.6.10,11,12.
> > > No errors though, only sluggish system.
> 
> What about earlier kernels?
> Please try to narrow down the problem to a specific kernel version.
> }
> 
> Don't know about 2.6.0-2.6.9, but 2.4.31 is ok.

2.4 -> 2.6 means zillions of changes.
 
> Bartlomiej,
> When you compare 2.4.31 with 2.6.12 don't you see this problem on your
> machine?

Unfortunately I've never encountered this problem on any machine.

> If you have a fast system the slowdown won't show, but your IOWAIT will be
> higher anyway!

AFAIK high iowait is a known block layer problem

> It feels like running on PIO instead of DMA.
