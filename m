From: "Al Boldi" <a1426z@gawab.com>
Subject: RE: [git patches] IDE update
Date: Mon, 4 Jul 2005 23:32:50 +0300
Message-ID: <200507042033.XAA19724@raad.intranet>
References: <58cb370e0507041251dd5a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from [212.76.87.97] ([212.76.87.97]:20485 "EHLO raad.intranet")
	by vger.kernel.org with ESMTP id S261635AbVGDUeA (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 4 Jul 2005 16:34:00 -0400
In-Reply-To: <58cb370e0507041251dd5a@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: 'Bartlomiej Zolnierkiewicz' <bzolnier@gmail.com>, 'Ondrej Zary' <linux@rainbow-software.org>
Cc: 'Linus Torvalds' <torvalds@osdl.org>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote: {
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
> > Same on 2.6.10,11,12.
> > No errors though, only sluggish system.

What about earlier kernels?
Please try to narrow down the problem to a specific kernel version.
}

Don't know about 2.6.0-2.6.9, but 2.4.31 is ok.

Bartlomiej,
When you compare 2.4.31 with 2.6.12 don't you see this problem on your
machine?
If you have a fast system the slowdown won't show, but your IOWAIT will be
higher anyway!
It feels like running on PIO instead of DMA.

