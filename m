From: Andrew Morton <akpm@osdl.org>
Subject: Re: [git patches] libata fixes
Date: Wed, 1 Nov 2006 16:02:07 -0800
Message-ID: <20061101160207.6b5e4c29.akpm@osdl.org>
References: <20061101021301.GA21568@havoc.gtf.org>
	<17736.43507.649685.484648@smtp.charter.net>
	<1162391435.11965.128.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.4]:48101 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750885AbWKBADR (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 1 Nov 2006 19:03:17 -0500
In-Reply-To: <1162391435.11965.128.camel@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: John Stoffel <john@stoffel.org>, Jeff Garzik <jeff@garzik.org>, Linus Torvalds <torvalds@osdl.org>, linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

On Wed, 01 Nov 2006 14:30:35 +0000
Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:

> Ar Mer, 2006-11-01 am 09:06 -0500, ysgrifennodd John Stoffel:
> > Jeff> +	{ 0x8086, 0x7110, PCI_ANY_ID, PCI_ANY_ID, 0, 0, piix_pata_33 },
> > Jeff>  	{ 0x8086, 0x7111, PCI_ANY_ID, PCI_ANY_ID, 0, 0, piix_pata_33 },
> > 
> > Umm, according to lspci -nn on my 440GX box, isn't the 0x8086/0x7110
> > an ISA bridge, not a PIIX? controller?  
> 
> Correct - the 7110 doesn't belong on that list.

So should it be moved elsewhere, or simply removed?
