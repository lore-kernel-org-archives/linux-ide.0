From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 03/11] libata: add probeinit component operation to ata_drive_probe_reset()
Date: Thu, 09 Feb 2006 04:42:51 -0500
Message-ID: <43EB0E9B.5030602@pobox.com>
References: <11388720002859-git-send-email-htejun@gmail.com> <43EAE8F3.7000505@pobox.com> <43EB0DEE.7030202@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:64417 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S965218AbWBIJm4 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 9 Feb 2006 04:42:56 -0500
In-Reply-To: <43EB0DEE.7030202@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun <htejun@gmail.com>
Cc: albertcc@tw.ibm.com, linux-ide@vger.kernel.org

Tejun wrote:
> Jeff Garzik wrote:
> 
>> Tejun Heo wrote:
>>
>>> This patch adds probeinit component operation to
>>> ata_drive_probe_reset().  If present, this new operation is called
>>> before performing any reset.  The operations's roll is to prepare @ap
>>> for following probe-reset operations.
>>>
>>> Signed-off-by: Tejun Heo <htejun@gmail.com>
>>
>>
>> [...]
>>
>>>  extern int ata_drive_probe_reset(struct ata_port *ap,
>>> +            ata_probeinit_fn_t probeinit,
>>>              ata_reset_fn_t softreset, ata_reset_fn_t hardreset,
>>>              ata_postreset_fn_t postreset, unsigned int *classes);
>>
>>
>>
>> Applied patches 3-4, although I dislike that ata_drive_probe_reset() 
>> is growing a ton of function pointer arguments.  Please consider a 
>> better approach when you have some free time.  Perhaps these need to 
>> be added to ata_port_operations?  Perhaps another ata_reset_operations 
>> struct? What do you think?
>>
> 
> I thought about adding the component operations to ata_port_operations, 
> but those callbacks would only be used if ->probe_reset uses 
> ata_drive_probe_reset() and layering ends up weird.  BTW, the same thing 
> is true for ->bmdma_* callbacks and a few more, I think.
> 
> So, I'm a little bit unconformatble with clamming multi levels of 
> operations into ata_port_operations or adding ata_reset_operations to 
> ata_port.  So, the wrap-with-drive-function thing was my compromise, 
> which isn't very pretty but keeps the functionality.

Fair enough.


> A problem with clamming multi-level callbacks into one structure is that 
> it's not clear which callbacks should be implemented and with core code 
> constantly changing, the requirements also changes along.  Changing API 
> is actually good thing but in this case it's difficult to know what end 
> effects changes have on low-level drivers.  (remember ->dev_select 
> breakage last year?)
> 
> So, IMHO we should not add more layered operations to top-level.  It 
> would be nice if we can come up with some simple way to separate out 
> layered callbacks.  Do you agree with this line of thought?

Indeed, one thought I had was having a cleaner upper-level qc_issue API, 
and separating the BMDMA hooks out somehow into a separate layer, 
outside ata_port_operations.

	Jeff



