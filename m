From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 05/14] libata: make ->data_xfer return the number of consumed
 bytes
Date: Fri, 30 Nov 2007 03:00:56 +0900
Message-ID: <474EFE58.701@gmail.com>
References: <1196346817387-git-send-email-htejun@gmail.com>	<11963468181417-git-send-email-htejun@gmail.com>	<20071129155546.694c6c45@the-village.bc.nu>	<474EE394.6020604@gmail.com> <20071129174259.6a1edc88@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.184]:56573 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763607AbXK2SBE (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 29 Nov 2007 13:01:04 -0500
Received: by rv-out-0910.google.com with SMTP id k20so1624567rvb
        for <linux-ide@vger.kernel.org>; Thu, 29 Nov 2007 10:01:03 -0800 (PST)
In-Reply-To: <20071129174259.6a1edc88@the-village.bc.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: jeff@garzik.org, linux-ide@vger.kernel.org, liml@rtr.ca, albertl@mail.com, jens.axboe@oracle.com

Alan Cox wrote:
>> It's for draining.  Let's say drive says it wanna transfer 18 bytes but
>> the buffer is only 13 bytes long.  If the transfer method consumes 2
>> bytes per read, it would consume 14 bytes.  If the transfer method
>> consumes 4 bytes per read, it would consume 16 bytes.  If we drain too
>> much, we risk hanging the machine.
> 
> Do we have any actual cases where trying to drain beyond the controller
> granuality is a problem ?
> 
> Might be cleaner to sort this (and the DMA assumption of 2 byte
> alignment, and possibly 16 byte for some devices/controllers) with 
> 
> 	dev->pio_io_size;
> 	dev->dma_io_size;
> 

That could be cleaner although slightly less flexible.  For example, a
driver may do 32bit IOs normally but choose to do smaller size IO at the
end for whatever reason.

DMA alignment is host restriction so I think it belongs to ata_host if
we ever need it.  Do you know of any controller which require such
thing?  No need to add complexity when it's not necessary.

Thanks.

-- 
tejun
