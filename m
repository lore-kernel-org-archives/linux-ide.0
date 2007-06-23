From: Jeff Garzik <jeff@garzik.org>
Subject: Re: how to handle pata_via when controller not in fully-pci-native
 mode (two irqs?)
Date: Sat, 23 Jun 2007 00:23:25 -0400
Message-ID: <467CA03D.9060908@garzik.org>
References: <467C689E.3050800@genesi-usa.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:35558 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751032AbXFWEX1 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 23 Jun 2007 00:23:27 -0400
In-Reply-To: <467C689E.3050800@genesi-usa.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Matt Sealey <matt@genesi-usa.com>
Cc: linux-ide@vger.kernel.org

Matt Sealey wrote:
> Just bringing this up again as it's about that time of year.
> 
> There's an issue with some Via southbridges (the only notable and confirmed
> example I have being the VT8231 on the PegasosPPC) which can be configured
> such that they report that they are in "PCI Native Mode", but in fact handle
> (and report) legacy ATA interrupts through the ISA Bridge configuration.

pata_via calls ata_pci_init_one(), which supports the two-interrupt 
legacy configuration just fine.  The two-interrupt configuration is 
normal for a majority of pata_* drivers (and a few others), and has been 
working for years.

It sounds like you need to upgrade your BIOS to fix the requisite PCI 
config register, or need to add a PCI quirk for your platform, so that 
libata two-irq code will automagically start working for you.

	Jeff


