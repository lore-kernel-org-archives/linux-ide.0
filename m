From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: PATA_ARTOP reads byte from PCI IO port without mapping it to the right address.
Date: Wed, 30 Mar 2011 22:00:46 +0200
Message-ID: <201103302200.47052.arnd@arndb.de>
References: <4D937FDC.4090607@danielpalmer.co.uk> <20110330202628.5dc8db5f@lxorguk.ukuu.org.uk> <4D93890A.60307@danielpalmer.co.uk>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4D93890A.60307@danielpalmer.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Palmer <me@danielpalmer.co.uk>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Wednesday 30 March 2011 21:48:26 Daniel Palmer wrote:
> >  That is the PCI port address.
> 
> I don't pretend to understand most of this fully.
> On the board the PCI address space/PCI controller is apparently at 
> 0xfe240000
> So I guess that when that byte is read it should read from 0xfe240000 + 
> 0x1400?
> That doesn't happen and a read happens at 0x1400 and an oops results.
> I don't know enough to point the finger really.
> 
> There are probably only 2 people using this board still too. So I doubt 
> it really matters. :)

Is this an ARM machine? The platform specific mach/io.h header file
in that case defines an __io() macro that is responsible for mapping
port numbers to virtual addresses.

You have to ioremap() the physical address 0xfe240000 to a virtual
address, and then add the base address to the number inside of the
__io macro, e.g.

/* in mach/io.h: */
extern void __iomem *this_board_pci_iospace;
#define __io(x) ((x & 0xffff) + this_board_pci_iospace)

/* in pci controller setup code: */
this_board_pci_iospace = ioremap(0xfe240000, 0x10000);

	Arnd
