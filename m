From: "Mat Loikkanen" <Mat.Loikkanen@synopsys.com>
Subject: RE: data_xfer too fast? - SATA PIO
Date: Tue, 1 Mar 2005 09:49:52 -0800
Message-ID: <00fa01c51e87$128a7810$3805040a@internal.synopsys.com>
References: <4223DC45.9000204@rtr.ca>
Reply-To: <Mat.Loikkanen@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Received: from us02smtp1.synopsys.com ([198.182.60.75]:36344 "EHLO
	vaxjo.synopsys.com") by vger.kernel.org with ESMTP id S262006AbVCARt4 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 1 Mar 2005 12:49:56 -0500
In-Reply-To: <4223DC45.9000204@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: 'Mark Lord' <liml@rtr.ca>
Cc: linux-ide@vger.kernel.org

Thanks, Mark.  I think the hardware designer plans to do this -- add wait
states on the bus (we sell soft IP, so our controller is on an FPGA on our
test platform).  I wasn't sure if there were any PCI/ISA-isms that were at
play here.  We are ARM AMBA/AHB bus based, targeting embedded applications.

-----Original Message-----
From: Mark Lord

Err.. PIO data transfer within a sector (or multiple sector block)
is supposed to be synchronous in hardware.  This means the chip/board
should be using IORDY to stretch the cycle until data can be supplied
within each 256-word interrupt group.

Right?

Mat Loikkanen wrote:
> We've run into the issue of ata_mmio_data_xfer() reading our host
> controller's data fifo too fast -- requesting a data word when the fifo
was
> empty, before the device had sent PIO data (in our observed case somewhere
> in the middle of a 512 byte IDENTIFY DEVICE PIO data transfer).  I can't
see
> any provision in Libata for a case like ours where the processor and bus
are
> "too fast".  Has anyone run into this issue before?  Any ideas on what we
> should do about it?  We can make our host controller to wait-state the bus
> ... but for how long, what if data never arrives ...  Thanks for any help.
> 
> -mat
>  
> Mat Loikkanen
> Synopsys, Inc.

