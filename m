From: Mark Lord <liml@rtr.ca>
Subject: Re: [PATCH 1/8] sata_mv more cosmetics
Date: Fri, 25 Apr 2008 13:31:54 -0400
Message-ID: <4812158A.2010400@rtr.ca>
References: <480A3D2E.4040503@rtr.ca> <480A3D5E.8090206@rtr.ca>	 <481168E7.50402@pobox.com> <4811E0B7.2060508@rtr.ca> <da824cf30804250940o4f0e0396k1696348f8d86cb77@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:3849 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759703AbYDYRbz (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 25 Apr 2008 13:31:55 -0400
In-Reply-To: <da824cf30804250940o4f0e0396k1696348f8d86cb77@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Grant Grundler <grundler@google.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, Tejun Heo <htejun@gmail.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

Grant Grundler wrote:
> On Fri, Apr 25, 2008 at 6:46 AM, Mark Lord <liml@rtr.ca> wrote:
> ...
>>  But there are just *so many* irq cause / mask registers in these chips,
>>  (one for PCI, one for the host function, and one per-port for EDMA,
>>  plus the SATA SError + mask, ..), that even I was getting confused
>>  while working on the code.
> 
> Yeah, it's confusing because most of the bits from one "interrupt"
> (quotes explained in the next paragraph) register are rolled up into one bit
> and available in another register. It seems like someone thought it
> would be more efficient to read one register for all possible "causes"
> and then have evidence a second register read is really necessary
> (because a bit was set). Unfortunately, the result was the default
> programming model as suggested by Marvell asks for at least two
> MMIO reads just to find out if any IO completions are pending. 'Nuf said.
> Kudos to Mark for figuring out how to reduce that to one MMIO read.
..

Readers may note that the interrupt path (for a real mv interrupt)
currently reads three registers (or four if more than one hc interrupts).

Grant was refering to a plan we have formulated to reduce that to
a single read for the non-error cases.  Not currently implemented
in the driver (though there are comments marking where to change it).

I'm leaving those optimizations for after the rest of the EH fixes are completed.
Hopefully within a week or less.

Cheers
