From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH #upstream-fixes 2/3] pata_hpt366: fix cable detection
Date: Tue, 09 Dec 2008 10:17:41 +0900
Message-ID: <493DC735.1050703@kernel.org>
References: <493CED7A.2010505@kernel.org> <493CEE74.3060601@kernel.org> <493D03A4.1090409@ru.mvista.com> <493D296F.90901@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:44008 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752395AbYLIBSJ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 8 Dec 2008 20:18:09 -0500
In-Reply-To: <493D296F.90901@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Mark Lord <liml@rtr.ca>, rob.opensuse.linux@googlemail.com

Sergei Shtylyov wrote:
> Hello, I wrote:
> 
>>> hpt366 is strange in that its cable detection register uses the higher
>>> bit for master, so the testing should be 2 >> port_no instead of 1 <<
> 
>>   For primary -- the cable bits are per-channel, not per-device.
> 
>>> port_no.  Fix it.
> 
>>> Info provided by Alan Cox.
> 
>>> Signed-off-by: Tejun Heo <tj@kernel.org>
> 
>> Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>
> 
>    I have to NAK this. HPT366 design is just too brain damaged for both
> IDE and libata drivers to get it right so far.
> 
>>> Index: work/drivers/ata/pata_hpt366.c
>>> ===================================================================
>>> --- work.orig/drivers/ata/pata_hpt366.c
>>> +++ work/drivers/ata/pata_hpt366.c
>>> @@ -215,7 +215,7 @@ static int hpt36x_cable_detect(struct at
>>>      struct pci_dev *pdev = to_pci_dev(ap->host->dev);
>>>  
>>>      pci_read_config_byte(pdev, 0x5A, &ata66);
>>> -    if (ata66 & (1 << ap->port_no))
>>> +    if (ata66 & (2 >> ap->port_no))
>>>   
> 
>>   HPT36x are single channel per function, so the shift can be removed.
> 
>    It should be replaced by more sophisticated logic for function 1 in
> fact...

Ah... crap.  I don't know anything about this controller.  Care to
post the correct patch?  I'll be happy to test.

Thanks.

-- 
tejun
