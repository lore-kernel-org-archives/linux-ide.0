From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] pata_pcmcia: another memory card support
Date: Tue, 11 Nov 2008 03:44:09 -0500
Message-ID: <491945D9.2080201@garzik.org>
References: <200811061144.35556.marc.pignat@hevs.ch> <49193C0F.5000908@garzik.org> <20081111084053.GA12965@isilmar.linta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:56758 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753334AbYKKIoM (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 11 Nov 2008 03:44:12 -0500
In-Reply-To: <20081111084053.GA12965@isilmar.linta.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, Marc Pignat <marc.pignat@hevs.ch>, linux-ide@vger.kernel.org, linux-pcmcia@lists.infradead.org

Dominik Brodowski wrote:
> Jeff,
> 
> On Tue, Nov 11, 2008 at 03:02:23AM -0500, Jeff Garzik wrote:
>> Marc Pignat wrote:
>>> Support for Apacer photo steno pro card.
>>>
>>> Signed-off-by: Marc Pignat <marc.pignat@hevs.ch>
>>> ---
>>>
>>> Hi all!
>>>
>>> Here is a new ID for ide-cs and pata_pcmcia. I tried all the card
>>> I can find in the labs, only this one was unknown.
>>>
>>> Best regards
>>>
>>> Marc
>>>
>>>
>>>
>>> diff --git a/drivers/ata/pata_pcmcia.c b/drivers/ata/pata_pcmcia.c
>>> index 271cb64..64b2e22 100644
>>> --- a/drivers/ata/pata_pcmcia.c
>>> +++ b/drivers/ata/pata_pcmcia.c
>>> @@ -416,6 +416,7 @@ static struct pcmcia_device_id pcmcia_devices[] = {
>>>  	PCMCIA_DEVICE_PROD_ID1("STI Flash", 0xe4a13209),
>>>  	PCMCIA_DEVICE_PROD_ID12("STI", "Flash 5.0", 0xbf2df18d, 0x8cb57a0e),
>>>  	PCMCIA_MFC_DEVICE_PROD_ID12(1, "SanDisk", "ConnectPlus", 0x7a954bd9, 0x74be00c6),
>>> +	PCMCIA_DEVICE_PROD_ID2("Flash Card", 0x5a362506),
>>>  	PCMCIA_DEVICE_NULL,
>>>  };
>>>  
>>> diff --git a/drivers/ide/ide-cs.c b/drivers/ide/ide-cs.c
>>> index cb199c8..f50210f 100644
>>> --- a/drivers/ide/ide-cs.c
>>> +++ b/drivers/ide/ide-cs.c
>>> @@ -444,6 +444,7 @@ static struct pcmcia_device_id ide_ids[] = {
>>>  	PCMCIA_DEVICE_PROD_ID1("STI Flash", 0xe4a13209),
>>>  	PCMCIA_DEVICE_PROD_ID12("STI", "Flash 5.0", 0xbf2df18d, 0x8cb57a0e),
>>>  	PCMCIA_MFC_DEVICE_PROD_ID12(1, "SanDisk", "ConnectPlus", 0x7a954bd9, 0x74be00c6),
>>> +	PCMCIA_DEVICE_PROD_ID2("Flash Card", 0x5a362506),
>>>  	PCMCIA_DEVICE_NULL,
>>>  };
>>>  MODULE_DEVICE_TABLE(pcmcia, ide_ids);
>>> --
>> applied pata_pcmcia bit
> 
> could we merge such stuff through pcmcia-git in future, please? (see
> http://git.kernel.org/?p=linux/kernel/git/brodo/pcmcia-2.6.git;a=commitdiff;h=980fc29f20f5cfb8cef29ddfccecb685f299ada4
> ) Else the device tables in ide-cs and pata_pcmcia will diverge again.

It is not normal practice to merge add-device-id patches through 
bus-specific trees.  We do not do such things with PCI IDs, for example.

I would be happy to apply the whole patch, or ACK it and let Bart apply 
the entire patch.  Either way is fine with me.

	Jeff




