From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 1/1] - sgiioc4: fixup use of mmio ops
Date: Thu, 13 Jul 2006 10:45:40 -0400
Message-ID: <44B65C94.6040100@garzik.org>
References: <200607131354.k6DDsaqe064559@fcbayern.americas.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:4235 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751558AbWGMOpn (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 13 Jul 2006 10:45:43 -0400
In-Reply-To: <200607131354.k6DDsaqe064559@fcbayern.americas.sgi.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: John Keller <jpk@sgi.com>
Cc: Jeremy Higdon <jeremy@sgi.com>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

John Keller wrote:
>>>> -	if (!request_region(base, IOC4_CMD_CTL_BLK_SIZE, hwif->name)) {
>>>> +	cmd_phys_base = bar0 + IOC4_CMD_OFFSET;
>>>> +	if (!request_mem_region(cmd_phys_base, IOC4_CMD_CTL_BLK_SIZE,
>>>> +	    hwif->name)) {
>>>>  		printk(KERN_ERR
>>>> -			"%s : %s -- ERROR, Port Addresses "
>>>> +			"%s : %s -- ERROR, Addresses "
>>>>  			"0x%p to 0x%p ALREADY in use\n",
>>>> -		       __FUNCTION__, hwif->name, (void *) base,
>>>> -		       (void *) base + IOC4_CMD_CTL_BLK_SIZE);
>>>> +		       __FUNCTION__, hwif->name, (void *) cmd_phys_base,
>>>> +		       (void *) cmd_phys_base + IOC4_CMD_CTL_BLK_SIZE);
>> If 'void __iomem *' were used, no casts would be needed here
> 
> So, 'void __iomem *' should also be used for physical (non-mapped)
> addresses, as in this case?


Ooops, no, just cookies returned from ioremap() and ioremap_nocache().

	Jeff


