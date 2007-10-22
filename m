From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] libata-sff: Correct use of check_status()
Date: Mon, 22 Oct 2007 14:36:25 -0400
Message-ID: <471CEDA9.30001@garzik.org>
References: <20071015192529.2365b636@the-village.bc.nu>	<4716AFCA.4080509@garzik.org> <20071022114056.78bafbf1@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:38558 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751408AbXJVSga (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 22 Oct 2007 14:36:30 -0400
In-Reply-To: <20071022114056.78bafbf1@the-village.bc.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-ide@vger.kernel.org, akpm@osdl.org

Alan Cox wrote:
>>> +	tf->command = ata_chk_status(ap);
>>>  	tf->feature = ioread8(ioaddr->error_addr);
>>>  	tf->nsect = ioread8(ioaddr->nsect_addr);
>>>  	tf->lbal = ioread8(ioaddr->lbal_addr);
>> applied, with a sigh:  it's in SFF, so I saw nothing wrong with 
>> ata_check_status().  I checked -- no SFF driver overrides it according 
>> to my audit, therefore the previous version was faster while still correct.
> 
> I hit it with the NS87415 where ata_check_status() doesn't do the right
> thing. Later on it turned out that there were enough other bugs when
> enabling DMA that it needed its own tf read method anyway.
> 
> Alternative is to go through and clear up chk_atatus v check_status
> (rename one sff_ to be clear), and explicitly document the assumption in
> tf_read. That way it'll be obvious to whoever hits it in future and they
> can supply their own tf_read method.
> 
> Preferences ?

That was my general preference -- use your own ->tf_read()

	Jeff



