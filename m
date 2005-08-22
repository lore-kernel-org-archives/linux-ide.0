From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [patch] libata passthrough - return register data from HDIO_*
 commands
Date: Mon, 22 Aug 2005 00:43:36 -0400
Message-ID: <430957F8.9070507@pobox.com>
References: <42FE2FBA.3000605@dresco.co.uk> <430112F6.3090906@dresco.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zeus1.kernel.org ([204.152.191.4]:15502 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1751432AbVHVW4g (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 22 Aug 2005 18:56:36 -0400
In-Reply-To: <430112F6.3090906@dresco.co.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jon Escombe <lists@dresco.co.uk>
Cc: linux-kernel@vger.kernel.org, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

Jon Escombe wrote:
> 
>> Here is a first attempt at a patch to return register data from the 
>> libata passthrough HDIO ioctl handlers, I needed this as the ATA 
>> 'unload immediate' command returns the success in the lbal register. 
>> This patch applies on top of 2.6.12 and Jeffs 
>> 2.6.12-git4-passthru1.patch. (Apologies, but Thunderbird appears to 
>> have replaced the tabs with spaces).
>>
>> One oddity is that the sr_result field is correctly being set in 
>> ata_gen_ata_desc_sense(), however the high word is different when 
>> we're back in the ioctl hander. I've coded round this for now by only 
>> checking the low word, but this needs more investigation.
>>
>> Jeff, could this functionality be incorporated into the pasthrough 
>> patch when complete?
> 
> 
> 
> I'd failed to realise that scsi_finish_command() sets the high byte of 
> the result field to DRIVER_SENSE when there is sense data. Patch updated 
> to reflect this...
> 
> Haven't had any feedback on the patch itself - but this now does what I 
> wanted it do to.  (I can't find a way to make Thunderbird retain tabs in 
> the message body, so sending as an attachment).

Patch seems sane at first glance.  I'll look over it in depth this week.

	Jeff


