From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: ide-io.c, ide_do_request -- race condition?
Date: Fri, 16 Jul 2004 03:06:30 -0400
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <40F77E76.70501@pobox.com>
References: <40F2CFDE.66D28904@verizon.net> <20040712183505.GE26789@bounceswoosh.org> <40F72B6A.6F12F454@verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:21179 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S266501AbUGPHGn
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 16 Jul 2004 03:06:43 -0400
In-Reply-To: <40F72B6A.6F12F454@verizon.net>
List-Id: linux-ide@vger.kernel.org
To: "Max T. Woodbury" <max.teneyck.woodbury@verizon.net>
Cc: "Eric D. Mudama" <edmudama@bounceswoosh.org>, linux-ide@vger.kernel.org

Max T. Woodbury wrote:
> "Eric D. Mudama" wrote:
> 
>>On Mon, Jul 12 at 13:52, Max T. Woodbury wrote:
>>
>>>Still, why would PIO mode be unsafe?  (I can see slower, but I don't
>>>expect speed from this beast.  Oh well.  Thanks for the pointer.)
>>
>>PIO has no data integrity check, so bogus cables that glitch the data
>>will not be detected.  Not sure if that is what he was talking about,
>>but is definitely a problem for PIO.
> 
> 
> Huh? Unless something major has changed since the last time I looked at
> DMA hardware (and it has been a few years), DMA uses the same transfer
> sequence from the devices point of view as PIO.  The fact that the 


Ultra DMA does CRC, PIO does not.  Thus will cable glitches be detected.

	Jeff


