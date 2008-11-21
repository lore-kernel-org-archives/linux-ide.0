From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] ide: New libata driver for OCTEON SOC Compact Flash
 interface.
Date: Fri, 21 Nov 2008 17:46:42 +0000
Message-ID: <20081121174642.2fdaac4f@lxorguk.ukuu.org.uk>
References: <49261BE5.2010406@caviumnetworks.com>
	<4926E467.9020305@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-mips-bounce@linux-mips.org>
In-Reply-To: <4926E467.9020305@ru.mvista.com>
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: David Daney <ddaney@caviumnetworks.com>, linux-ide@vger.kernel.org, linux-mips <linux-mips@linux-mips.org>
List-Id: linux-ide@vger.kernel.org

> > +                iowrite16(*(uint16_t *)buffer, data_addr);
> 
>     Not seeing the reason to use iowrite16() and not writew() as registers are 
> always memory mapped...

iomap uses iowrite/ioread, writew is for the older ioremap stuff. Mixing
them up is not guaranteed to work for all ports.

> > + * Get the status of the DMA engine. The results of this function
> > + * must emulate the BMDMA engine expected by libata.
> 
>     Ugh... At least the IDE core is not so retarded.

Nor is libata, but he is piggybacking on the SFF code hence this.

Alan
