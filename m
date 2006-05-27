From: Mark Lord <liml@rtr.ca>
Subject: Re: [PATCH alt4 v2] libata resume fixes
Date: Sat, 27 May 2006 16:41:21 -0400
Message-ID: <4478B971.3060409@rtr.ca>
References: <20060527195847.GA28334@havoc.gtf.org> <20060527201024.GA29015@havoc.gtf.org> <4478B312.5040901@garzik.org> <4478B611.2030201@rtr.ca> <4478B743.2050006@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([64.26.128.89]:52142 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S964938AbWE0UlU (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 27 May 2006 16:41:20 -0400
In-Reply-To: <4478B743.2050006@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: torvalds@osdl.org, linux-ide@vger.kernel.org

Jeff Garzik wrote:
> Mark Lord wrote:
..
> Yay!  I'm familiar with the 0xD0 status on ata_piix, so this is really 
> good progress.
> 
> 
>> Other than that, it's still dead -- disk I/O not working.
>>
>> Can this patch be combined with Linus's one-liner
>> and still work on your machine?
> 
> Does alt4v2 plus Linus's patch work on your machine?  (I'm guessing "no")

I haven't tried it here yet.

One other thing:  you patches keep adding a "pata" pci_device_resume handler.

My disk is SATA, or at least libata thinks it is SATA.
Just in case that makes any difference here.

(it really is PATA, but seems to have a SATA bridge
between it and the ICH6M SATA port).

Cheers
