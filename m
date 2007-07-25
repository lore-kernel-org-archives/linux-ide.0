From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: Time Problems with 2.6.23-rc1-gf695baf2
Date: Wed, 25 Jul 2007 03:14:18 +0200
Message-ID: <200707250314.19232.bzolnier@gmail.com>
References: <20070723221630.GA28951@alice> <6bffcb0e0707241614s7b563b5bu114d2ecb227b1557@mail.gmail.com> <200707250240.49867.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.170]:59021 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759065AbXGYBQQ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 24 Jul 2007 21:16:16 -0400
Received: by ug-out-1314.google.com with SMTP id j3so258927ugf
        for <linux-ide@vger.kernel.org>; Tue, 24 Jul 2007 18:16:14 -0700 (PDT)
In-Reply-To: <200707250240.49867.bzolnier@gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
Cc: Eric Sesterhenn / Snakebyte <snakebyte@gmx.de>, linux-kernel@vger.kernel.org, IDE/ATA development list <linux-ide@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>

On Wednesday 25 July 2007, Bartlomiej Zolnierkiewicz wrote:
> 
> Hi,
> 
> On Wednesday 25 July 2007, Michal Piotrowski wrote:
> > Hi,
> > 
> > On 24/07/07, Eric Sesterhenn / Snakebyte <snakebyte@gmx.de> wrote:
> > > hi,
> > >
> > > seems like the clock got screwed or something similar. During bootup the
> > > computer hangs (no response on keyboard leds when pressing caps lock),
> > > the only way to make sure it resumes booting is by repeatedly pressing
> > > the power switch,
> > 
> > :)
> > 
> > > see second 13 to 510, after pressing it about ten
> > > times, it continues booting.
> > 
> > Probing IDE interface...
> > 
> > [   13.867939] VP_IDE: VIA vt82c686a (rev 22) IDE UDMA66 controller on
> > pci0000:00:04.1
> > [   13.868062]     ide0: BM-DMA at 0xd800-0xd807, BIOS settings:
> > hda:DMA, hdb:pio
> > [   13.868268]     ide1: BM-DMA at 0xd808-0xd80f, BIOS settings:
> > hdc:DMA, hdd:DMA
> > [   13.868574] Probing IDE interface ide0...
> > [  387.279576] Clocksource tsc unstable (delta = 370195339890 ns)
> > [  496.200082] hda: ST340823A, ATA DISK drive
> > [  510.264511] hda: selected mode 0x44
> > [  510.264826] ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
> > 
> > Could you please try to revert these commits
> 
> It doesn't seem like a IDE bug et all, rather seems to be some issue
> related to the recent "lack of the proper clocksource fallback" bug...

or ACPI

> > > [   13.506890] ACPI Exception (processor_throttling-0084): AE_NOT_FOUND, Evaluating _PTC [20070126]
> > > [   13.507101] ACPI Exception (processor_throttling-0147): AE_NOT_FOUND, Evaluating _TSS [20070126]

Bart
