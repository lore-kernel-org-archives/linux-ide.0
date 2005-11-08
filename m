From: Rahul Siddharthan <rsidd@online.fr>
Subject: Re: Buggy IDE / ATA drive on 2.6? DMA timeouts, 2.4 is fine
Date: Tue, 08 Nov 2005 15:26:04 +0100
Message-ID: <1131459964.4370b57cdfbc5@imp1-g19.free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp3-g19.free.fr ([212.27.42.29]:9348 "EHLO smtp3-g19.free.fr")
	by vger.kernel.org with ESMTP id S964839AbVKHO0F (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 8 Nov 2005 09:26:05 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org

Bartlomiej Zolnierkiewicz said on Nov  8, 2005 at 14:17:13:
> On 11/8/05, Rahul Siddharthan <rsidd@online.fr> wrote:
> > I have a HP Pavilion ze5385us laptop bought in 2003, which has a
> > ALi15X3 IDE controller and a Toshiba MK6021GAS ATA disk.  For about
> > two months, since an upgrade to kernel 2.6.10+, I'd been noticing
> > occasional sluggishness with the laptop, and occasionally "DMA timeout"
> > errors.  But until a week ago they were rather rare, and never occurred
> > with the other kernel/OS's I have on the machine: Linux 2.4.27, Windows XP,
> > DragonFly BSD.    The exact error is:
> >
> > hda: dma_timer_expiry: dma status == 0x21
> > hda: DMA timeout error
> > hda: dma timeout error: status=0xd0 (busy)
> >
> > ide: failed opcode was: unknown
> > hda: DMA disabled
> > ide0: reset: success

[snip]
> > Now I have been running the laptop on DragonFly and Linux 2.4 for about
> > 3 hours each and there have been no problems whatever.  I even successfully
> > burned a CD in dummy mode and then in real mode.
> >
> > I have no clue what's going on but I am convinced that the 2.6 IDE driver is
> > somehow bad for my laptop.
> >
> > Any ideas?
>
> http://smartmontools.sf.net

OK, smartctl -a says
SMART overall-health self-assessment test result: PASSED
and reports 14 errors, the most recent 2 at 7287 hours, (303 days + 15
hrs) so the DMA timeout errors aren't here.  Do you need the full
output?

Rahul
