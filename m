From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: data_xfer too fast? - SATA PIO
Date: Wed, 02 Mar 2005 12:44:43 +1100
Message-ID: <1109727883.5680.73.camel@gaston>
References: <00dc01c51dee$c2cf13a0$3805040a@internal.synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Received: from gate.crashing.org ([63.228.1.57]:42436 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261993AbVCBBrD (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 1 Mar 2005 20:47:03 -0500
In-Reply-To: <00dc01c51dee$c2cf13a0$3805040a@internal.synopsys.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mat.Loikkanen@synopsys.com
Cc: 'Jeff Garzik' <jgarzik@pobox.com>, list linux-ide <linux-ide@vger.kernel.org>

On Mon, 2005-02-28 at 15:39 -0800, Mat Loikkanen wrote:
> We've run into the issue of ata_mmio_data_xfer() reading our host
> controller's data fifo too fast -- requesting a data word when the fifo was
> empty, before the device had sent PIO data (in our observed case somewhere
> in the middle of a 512 byte IDENTIFY DEVICE PIO data transfer).  I can't see
> any provision in Libata for a case like ours where the processor and bus are
> "too fast".  Has anyone run into this issue before?  Any ideas on what we
> should do about it?  We can make our host controller to wait-state the bus
> ... but for how long, what if data never arrives ...  Thanks for any help.
> 

You should waitstate the bus, with eventually some sanity limit built
into the HW.

Ben.


