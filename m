From: Mark Lord <liml@rtr.ca>
Subject: Re: what is hdparm doing?
Date: Tue, 28 Feb 2006 20:27:56 -0500
Message-ID: <4404F89C.8040008@rtr.ca>
References: <E1FED6T-0004a4-LN@highlab.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([64.26.128.89]:8686 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S932641AbWCAB2C (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 28 Feb 2006 20:28:02 -0500
In-Reply-To: <E1FED6T-0004a4-LN@highlab.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sebastian Kuzminsky <seb@highlab.com>
Cc: linux-ide@vger.kernel.org

Sebastian Kuzminsky wrote:
> Hi folks, hdparm's got me confused.
..
> "hdparm /dev/hda" says:
.
>             DMA: mdma0 mdma1 *mdma2
>                  Cycle time: min=120ns recommended=120ns
>             PIO: pio0 pio1 pio2 pio3 pio4
>                  Cycle time: no flow control=120ns  IORDY flow control=120ns
..

The *mdma2 means, that if you were to issue a READ_DMA (or WRITE_DMA)
command to the drive, the drive is expecting the host to use
the multiword-dma-2 protocol and timings for it.

Meanwhile, the host may, at its option, simply use PIO commands (READ, WRITE)
instead of DMA, any time it chooses.

Drives have both a DMA mode, and a PIO mode, each of which is selected
and used independently of the other.

Cheers
