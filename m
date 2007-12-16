From: Adrian McMenamin <adrian@newgolddream.dyndns.info>
Subject: Re: [PATCH 0/3] Add GD-Rom support to the SEGA Dreamcast
Date: Sun, 16 Dec 2007 17:06:46 +0000
Message-ID: <1197824806.6254.5.camel@localhost.localdomain>
References: <8b67d60712151620s331281f4s7e150aacacff4400@mail.gmail.com>
	 <20071216041348.GB11113@linux-sh.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <20071216041348.GB11113@linux-sh.org>
Sender: linux-sh-owner@vger.kernel.org
To: Paul Mundt <lethal@linux-sh.org>
Cc: Adrian McMenamin <lkmladrian@gmail.com>, linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org, axboe@kernel.dk, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org


On Sun, 2007-12-16 at 13:13 +0900, Paul Mundt wrote:
> On Sun, Dec 16, 2007 at 12:20:54AM +0000, Adrian McMenamin wrote:
> > This device is electrically compatible with ATA-3 IDE CD drives but
> > implements a proprietary packet interface. There have been previous
> > Dreamcast CD drivers around but this is new code and uses DMA as
> > opposed to PIO for reads.
> > 
> > It also supports reading the proprietary GD Rom format disks.
> > 
> > The driver will live as drivers/sh/gdrom/gdrom.c
> > 
> No, the driver will live in drivers/cdrom if that's the API that you
> depend on. The only things in drivers/sh are SH-specific bus support
> code, it is not a dumping ground for unrelated drivers.


Well, the other cd drives exist in mainline outside that directory eg
drivers/block/paride/pcd.c  drivers/ide/ide-cd.c drivers/scsi/sr.c 

As far as I can see if this joins mainline it will be the only
proprietary CD device - there were six others which were
in /drivers/cdrom but they were purged recently.

I'm not bothered where it goes, though.

