From: Mark Lord <liml@rtr.ca>
Subject: Re: data_xfer too fast? - SATA PIO
Date: Mon, 28 Feb 2005 22:06:45 -0500
Message-ID: <4223DC45.9000204@rtr.ca>
References: <00dc01c51dee$c2cf13a0$3805040a@internal.synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Received: from cpu1185.adsl.bellglobal.com ([207.236.110.166]:19349 "EHLO
	mail.rtr.ca") by vger.kernel.org with ESMTP id S261226AbVCADIH
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 28 Feb 2005 22:08:07 -0500
In-Reply-To: <00dc01c51dee$c2cf13a0$3805040a@internal.synopsys.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mat.Loikkanen@synopsys.com
Cc: 'Jeff Garzik' <jgarzik@pobox.com>, linux-ide@vger.kernel.org

Err.. PIO data transfer within a sector (or multiple sector block)
is supposed to be synchronous in hardware.  This means the chip/board
should be using IORDY to stretch the cycle until data can be supplied
within each 256-word interrupt group.

Right?

Mat Loikkanen wrote:
> We've run into the issue of ata_mmio_data_xfer() reading our host
> controller's data fifo too fast -- requesting a data word when the fifo was
> empty, before the device had sent PIO data (in our observed case somewhere
> in the middle of a 512 byte IDENTIFY DEVICE PIO data transfer).  I can't see
> any provision in Libata for a case like ours where the processor and bus are
> "too fast".  Has anyone run into this issue before?  Any ideas on what we
> should do about it?  We can make our host controller to wait-state the bus
> ... but for how long, what if data never arrives ...  Thanks for any help.
> 
> -mat
>  
> Mat Loikkanen
> Synopsys, Inc.
