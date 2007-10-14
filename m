From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [git patches] IDE updates (part 2)
Date: Sun, 14 Oct 2007 10:08:09 +1000
Message-ID: <1192320489.22054.40.camel@pasglop>
References: <200710131825.24768.bzolnier@gmail.com>
	 <200710140009.06260.bzolnier@gmail.com>
	 <20071013232922.3ff6a464@the-village.bc.nu>
	 <200710140041.25152.bzolnier@gmail.com>
Reply-To: benh@kernel.crashing.org
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1763285AbXJNAIe@vger.kernel.org>
In-Reply-To: <200710140041.25152.bzolnier@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Linus Torvalds <torvalds@linux-foundation.org>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org


On Sun, 2007-10-14 at 00:41 +0200, Bartlomiej Zolnierkiewicz wrote:
> On Sunday 14 October 2007, Alan Cox wrote:
> > > > > 		/* Probably a PCI interface... */
> > > > > 		for (i = IDE_DATA_OFFSET; i <= IDE_STATUS_OFFSET; ++i)
> > > > > 			hw->io_ports[i] = data_port + i - IDE_DATA_OFFSET;
> > > > > 		hw->io_ports[IDE_CONTROL_OFFSET] = ctrl_port;
> > 
> > Ok so in actual fact
> > 
> > - The piece of code above can't be executed anyway
> > - The ctrl_port argument is not needed ?
> 
> pmac_ide_init_hwif_ports() is also called by ide_init_hwif_ports()
> through ppc_ide_md.init_hwif.

In which case it should be called with a ctrl_port right ?

Ben.
