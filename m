From: Olaf Hering <olh@suse.de>
Subject: Re: [PATCH] add missing space to printk in ide_allocate_dma_engine
Date: Thu, 3 Feb 2005 00:36:03 +0100
Message-ID: <20050202233603.GA15890@suse.de>
References: <20050202203652.GA14615@suse.de> <58cb370e0502021527529bcfe2@mail.gmail.com> <58cb370e0502021529666adec2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Received: from news.suse.de ([195.135.220.2]:18665 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262734AbVBBXgH (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 2 Feb 2005 18:36:07 -0500
Content-Disposition: inline
In-Reply-To: <58cb370e0502021529666adec2@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org

 On Thu, Feb 03, Bartlomiej Zolnierkiewicz wrote:

> On Thu, 3 Feb 2005 00:27:34 +0100, Bartlomiej Zolnierkiewicz
> <bzolnier@gmail.com> wrote:
> > applied
>  
> and reversed, missing space is here: " CPU"

This was my oops:

Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2   
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
W82C105: IDE controller at PCI slot 0000:00:03.1
W82C105: chipset revision 5
W82C105: 100% native mode on irq 102
    ide0: BM-DMA at 0xf040-0xf047<3> CPU: -- Error, unable to allocateW82C105 DMA table(s).
    ide1: BM-DMA at 0xf048-0xf04f<3> CPU: -- Error, unable to allocateW82C105 DMA table(s).
hda: HL-DT-ST CD-ROM GCR-8480B, ATAPI CD/DVD-ROM drive
Oops: Kernel access of bad area, sig: 11 [#1]
SMP NR_CPUS=128 NUMA PSERIES

