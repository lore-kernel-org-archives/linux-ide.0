From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] add missing space to printk in ide_allocate_dma_engine
Date: Thu, 3 Feb 2005 16:00:32 +0100
Message-ID: <58cb370e05020307007ef4e70a@mail.gmail.com>
References: <20050202203652.GA14615@suse.de>
	 <58cb370e0502021527529bcfe2@mail.gmail.com>
	 <58cb370e0502021529666adec2@mail.gmail.com>
	 <20050202233603.GA15890@suse.de>
	 <58cb370e050202154128e397fc@mail.gmail.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.196]:17521 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S263544AbVBCPAh (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 3 Feb 2005 10:00:37 -0500
Received: by wproxy.gmail.com with SMTP id 67so267250wri
        for <linux-ide@vger.kernel.org>; Thu, 03 Feb 2005 07:00:33 -0800 (PST)
In-Reply-To: <58cb370e050202154128e397fc@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Olaf Hering <olh@suse.de>
Cc: linux-ide@vger.kernel.org

On Thu, 3 Feb 2005 00:41:38 +0100, Bartlomiej Zolnierkiewicz
<bzolnier@gmail.com> wrote:
> On Thu, 3 Feb 2005 00:36:03 +0100, Olaf Hering <olh@suse.de> wrote:
> >  On Thu, Feb 03, Bartlomiej Zolnierkiewicz wrote:
> >
> > > On Thu, 3 Feb 2005 00:27:34 +0100, Bartlomiej Zolnierkiewicz
> > > <bzolnier@gmail.com> wrote:
> > > > applied
> > >
> > > and reversed, missing space is here: " CPU"
> >
> > This was my oops:
> >
> > Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
> > ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
> > W82C105: IDE controller at PCI slot 0000:00:03.1
> > W82C105: chipset revision 5
> > W82C105: 100% native mode on irq 102
> >     ide0: BM-DMA at 0xf040-0xf047<3> CPU: -- Error, unable to allocateW82C105 DMA table(s).
> >     ide1: BM-DMA at 0xf048-0xf04f<3> CPU: -- Error, unable to allocateW82C105 DMA table(s).
> > hda: HL-DT-ST CD-ROM GCR-8480B, ATAPI CD/DVD-ROM drive
> > Oops: Kernel access of bad area, sig: 11 [#1]
> > SMP NR_CPUS=128 NUMA PSERIES
> 
> Indeed there is a bug but a different one:
> printk() parameters are interchanged.

Fix will be in the next ide-2.6 update (today).

Thanks.
