From: Mark Lord <liml@rtr.ca>
Subject: Re: [PATCH 2/4] libata: Drain data on errors
Date: Mon, 27 Oct 2008 15:14:51 -0400
Message-ID: <4906132B.1000502@rtr.ca>
References: <20081017180655.7781.15021.stgit@localhost.localdomain> <20081017180837.7781.26372.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:37378 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753686AbYJ0TOV (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 27 Oct 2008 15:14:21 -0400
In-Reply-To: <20081017180837.7781.26372.stgit@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: jeff@garzik.org, linux-ide@vger.kernel.org

Alan Cox wrote:
> From: Alan Cox <alan@redhat.com>
> 
> If the device is signalling that there is data to drain after an error we
> should read the bytes out and throw them away. Without this some devices
> and controllers get wedged and don't recover.
> 
> Based on earlier work by Mark Lord
> 
> Signed-off-by: Alan Cox <alan@redhat.com>
..
> +	/* Drain up to 64K of data before we give up this recovery method */
> +	for (count = 0; (ap->ops->sff_check_status(ap) & ATA_DRQ)
> +							&& count < 65536;)
> +		ioread8(ap->ioaddr.data_addr);
..

I'm just catching up on a few things here now that holiday season is over.
In the above loop, I wonder if it might be better to only check status
every NN iterations, where NN > 1 (say, 16), to speed things up a fair amount (?).

Sure it's rare, but when it happens the entire system is probably stopped
waiting for us to recover, so speed might matter some.

Cheers
