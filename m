From: Mark Lord <liml@rtr.ca>
Subject: Re: [PATCH] libata: Add pata_dma option so users can disable pata_dma
 as they can with old-ide
Date: Fri, 22 Jun 2007 12:53:03 -0400
Message-ID: <467BFE6F.7050300@rtr.ca>
References: <20070622144939.026ed6ac@the-village.bc.nu>	<467BE435.5000001@rtr.ca> <20070622165221.2ce648f6@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([64.26.128.89]:4106 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752676AbXFVQxH (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 22 Jun 2007 12:53:07 -0400
In-Reply-To: <20070622165221.2ce648f6@the-village.bc.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: jeff@garzik.org, davej@redhat.com, linux-ide@vger.kernel.org

Alan Cox wrote:
> On Fri, 22 Jun 2007 11:01:09 -0400
> Mark Lord <liml@rtr.ca> wrote:
> 
>> Alan Cox wrote:
>>> Allow
>>>
>>> 	libata.pata_dma=0
>>>
>>> to disable DMA (default is 1)
>>>
>>> SATA is unaffected as disabling DMA for SATA makes no sense at all.
>>>
>>> Signed-off-by: Alan Cox <alan@redhat.com>
>> Alan,
>>
>> Should we really be piling up like this on global boot/module options
>> rather than run-time flags on individual channels/devices ?
>>
>> I can imagine systems with internal notebook drives that want dma=1,
>> plus Cardbus CF devices that require dma=0.
>>
>> With a single global flag, how does one do that?
> 
> We need proper tuning as well but there is huge value (with distro hat
> on especially) in a single "try this to get it installed and then we can
> debug it" button. Same with the old IDE. Trying to guide users through
> selecting specific channels/devices is going to be painful. I want
> something that I can tell people to get them 'off the ground' and work
> with them to sort the rest.

Oh for sure.  I'm just thinking that some form of on-the-fly tunable
would be of even greater value here, in addition to the boot/load default flag.

I think a /sys/ "dma" attribute (pick a name) might be most appropriate,
or we just just implement HDIO_[GS]ET_DMA as a simpler/lazier mechanism.

Cheers

