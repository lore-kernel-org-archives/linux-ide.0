From: Mark Lord <liml@rtr.ca>
Subject: Re: [PATCH 13/13] libata: use PIO for misc ATAPI commands
Date: Tue, 27 Nov 2007 18:31:41 -0500
Message-ID: <474CA8DD.3040004@rtr.ca>
References: <11961764391983-git-send-email-htejun@gmail.com>	<11961764413291-git-send-email-htejun@gmail.com> <20071127165600.39b8c383@the-village.bc.nu> <474CA1E2.1060008@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:4364 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757491AbXK0Xbm (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 27 Nov 2007 18:31:42 -0500
In-Reply-To: <474CA1E2.1060008@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, jeff@garzik.org, linux-ide@vger.kernel.org, albertl@mail.com, jens.axboe@oracle.com

Tejun Heo wrote:
> Alan Cox wrote:
..
> Because we can't use DMA uniformly, I went the other way and tried to
> use PIO uniformly.  Another important point is that the other OS which
> is probably the only platform most ATAPI device vendors test against use
> PIO for these commands.
> 
>> - Control over the DMA/PIO strategy belongs with the driver. If we mess
>> that up it will cost us dearly later.
> 
> And I don't get what we'll lose.  Care to deliberate?
..

Mmmm.. so what happens with the various controllers that can do PIO
using host-DMA and host-queuing ?   Dropping to *real* PIO mode can
be quite expensive on those, especially when the channel is shared
with a hard disk.

Curious.
