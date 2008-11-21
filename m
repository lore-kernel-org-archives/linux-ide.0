From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] ide: New libata driver for OCTEON SOC Compact Flash
 interface.
Date: Fri, 21 Nov 2008 17:49:44 +0000
Message-ID: <20081121174944.23a4a7d9@lxorguk.ukuu.org.uk>
References: <49261BE5.2010406@caviumnetworks.com>
	<20081121102137.634616c5@lxorguk.ukuu.org.uk>
	<4926EA6A.7040704@caviumnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:40455 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751205AbYKURtv (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 21 Nov 2008 12:49:51 -0500
In-Reply-To: <4926EA6A.7040704@caviumnetworks.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: David Daney <ddaney@caviumnetworks.com>
Cc: linux-ide@vger.kernel.org, linux-mips <linux-mips@linux-mips.org>

> > Even if you wanted to do it this way you could just use arrays and lookup
> > tables as many other drivers do - ie
> > 
> > 	pio = dev->pio_mode - XFER_PIO_0;
> > 	t1 = data[pio];
> > 
> 
> The timing calculations are based on the CPU clock rate, It is difficult 
> to encapsulate that in a table.

The lookup part of the switch you can however. If you can use the
ata_timing interface then it will also do the clock adjusting for you and
has a FIT() macro that can be quite handy for clipping.

> It appears to be broken.  One would expect ioread16 and ioread16_rep to 
> do endian swapping in the same manner.  On MIPS they do not.  Perhaps it 
> would be better to fix the problem at the source.

I think the MIPS tree needs fixing then.


Alan
