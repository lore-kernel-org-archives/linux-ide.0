From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: readXs on pci*iomap-ped regions [Was: [PATCH] /drivers/char
 sx.c ioremap -> pci_ioremap api]
Date: Sat, 25 Aug 2007 11:17:58 +0100
Message-ID: <20070825111758.47500f39@the-village.bc.nu>
References: <46CF2849.2090008@gmail.com>
	<4af2d03a0708241159v56b46299h46df9777a98590e5@mail.gmail.com>
	<20070824201530.5d741b37@the-village.bc.nu>
	<46CF399E.3010808@gmail.com>
	<20070824213439.0007e653@the-village.bc.nu>
	<46CFEC40.7060006@gmail.com>
	<46CFEEB3.6000802@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:39320 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751735AbXHYKJ4 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 25 Aug 2007 06:09:56 -0400
In-Reply-To: <46CFEEB3.6000802@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Jiri Slaby <jirislaby@gmail.com>, linux-kernel@vger.kernel.org, Greg KH <gregkh@suse.de>, linux-ide@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz

On Sat, 25 Aug 2007 04:56:19 -0400
Jeff Garzik <jgarzik@pobox.com> wrote:

> If the driver knows its MMIO, using readX/writeX after pci_iomap() is 
> just fine, for all current implementations, and it makes sense that way.

There is nothing that guarantees this is permitted, any more than there
is anything saying not to use outb/outl. Some of the implementations do
quite strange things. It may happen to work but its not in the
documentation or the comments.

If you want to change this then you need to check the existing usages and
update all the docs if its safe, oh and tell the sparc64 pcmcia people to
take a hike, which is probably not a big problem.

Alan
