From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: libata PATA support - work items?
Date: Wed, 5 Jan 2005 13:59:02 +0100
Message-ID: <58cb370e05010504594f6ab8d@mail.gmail.com>
References: <006301c4ee5c$49e6a230$95714109@tw.ibm.com>
	 <311601c9050101111929aef5ba@mail.gmail.com>
	 <41DB299C.3030405@pobox.com>
	 <1104886199.17176.115.camel@localhost.localdomain>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.196]:27095 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262354AbVAEM7D (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 5 Jan 2005 07:59:03 -0500
Received: by wproxy.gmail.com with SMTP id 69so129350wri
        for <linux-ide@vger.kernel.org>; Wed, 05 Jan 2005 04:59:02 -0800 (PST)
In-Reply-To: <1104886199.17176.115.camel@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jeff Garzik <jgarzik@pobox.com>, Eric Mudama <edmudama@gmail.com>, Albert Lee <albertcc@tw.ibm.com>, IDE Linux <linux-ide@vger.kernel.org>, Doug Maxey <dwm@maxeymade.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Jens Axboe <axboe@suse.de>

On Wed, 05 Jan 2005 00:50:05 +0000, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> On Maw, 2005-01-04 at 23:41, Jeff Garzik wrote:
> > So, that said, I think it is important for libata to fully support PATA,
> > if it is to support it at all.  That means handling the errata that Alan
> > always bugs me about, and that means handling C/H/S support as well.
> 
> I think so. If it supports all the features of the old IDE layer we get
> to have a party when we eliminate the need for drivers/ide once and for
> all.
> 
> That means
> - Hotplug (controller and disk)
> - CHS
> - "Not quite generic" IDE DMA (eg CS5520)
> - VDMA (eg CS5520)
> - IORDY timers (not handled well in drivers/ide but needed)
> - Funky Maxtor "LBA48.. maybe" oddments
> - Missing slave detection
> - Controller errata hooks (modes, drives, timings, "dont touch during an
> I/O" etc)
> - Drive nIEN bugs
> - No nIEN cases
> - Drives that don't do some DMA/modes right
> - Crazy shit "Don't DMA from the page below 640K" (not handled by
> drivers/ide but an AMD errata
>         fixed by using a PS/2 mouse)
> - Serialize (RZ1000, CMD640, some 469, etc)
> - Bandwidth arbiter (not in drivers/ide but needed)
> - Non PCI shared IRQ mess 8(
> 
> Hopefully most of this can be buried away in a pata-errata.c 8)

:-)

few more:
- Power Management for devices
- 32 bit I/O support
- Multiple Mode PIO support
- Host Protected Area support
  (can be done from user-space but "coldplug" is needed)
- ide-{cd,disk,floppy,tape}.c specific quirks
