From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [git-patch] hotplug fix patches added
Date: Mon, 12 Jun 2006 09:41:29 -0400
Message-ID: <448D6F09.3080609@pobox.com>
References: <448B7FFD.9050507@gmail.com> <448C1C1E.7080109@pobox.com> <448C1FA7.6030305@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:5523 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751973AbWFLNlb (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 12 Jun 2006 09:41:31 -0400
In-Reply-To: <448C1FA7.6030305@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

Tejun Heo wrote:
> Jeff Garzik wrote:
>> Tejun Heo wrote:
>>> Hello,
>>>
>>> Two hotplug fix patches have been added to libata-tj #for-jeff.
>>>
>>> * libata: add missing finish_wait() call in ata_port_wait_eh()
>>> * libata: cosmetic change in struct ata_port
>>>
>>> The following two patches have been dropped as it hasn't been acked yet.
>>>
>>> * ata_piix: fix ghost device probing by honoring PCS present bits[1]
>>
>> Seems vaguely OK to me...
>>
>>
>>> * libata: add ata_port->private_flags[2]
>>
>> What's the justification for this?  Running out of room in flags?
> 
> Yeap, ran out of bits while implementing power management.
> 
>> If we are going to do this, I would move any such flags to the 
>> LLDD-allocated hpriv structure completely.  I wouldn't add hpriv_flags 
>> to struct ata_port.
> 
> Several drivers only need flags.  IMHO, having to allocate hpriv just 
> for flags is a bit annoying.  I also thought about separating capability 
> flags and dynamic flags but couldn't think of proper field name. 
> ap->dyn_flags?  Also, it would be easy to screw up and test the wrong 
> field.  Another sucky option was using u64 for flags.

I tend to think that most drivers fall into two categories:

* bmdma (PCI IDE-like) drivers
* drivers which already do their own hpriv allocation and management

Therefore, I would be OK with adding a bmdma_flags member, to be used 
only by bmdma drivers [and eventually separated from the high level 
libata API, as discussed].  Otherwise, I would go ahead and add code to 
allocate an hpriv structure in the driver.

	Jeff



