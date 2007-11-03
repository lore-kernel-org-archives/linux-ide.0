From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 1/3] libata: implement dev->acpi_init_gtm
Date: Sat, 03 Nov 2007 08:33:04 -0400
Message-ID: <472C6A80.3030206@garzik.org>
References: <472B402A.4030009@gmail.com> <472B43E6.2020402@garzik.org> <472BA0D6.3050607@gmail.com> <472C1ED0.5080407@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:59462 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752279AbXKCMdJ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 3 Nov 2007 08:33:09 -0400
In-Reply-To: <472C1ED0.5080407@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>

Tejun Heo wrote:
> Tejun Heo wrote:
>> Jeff Garzik wrote:
>>> Tejun Heo wrote:
>>>> Add dev->acpi_init_gtm and store initial GTM values on host
>>>> initialization.  If the field is valid, ATA_PFLAG_INIT_GTM_VALID flag
>>>> is set.  This is to remember BIOS/firmware programmed initial timing
>>>> for later use before reset and mode configuration modify it.
>>>>
>>>> Signed-off-by: Tejun Heo <htejun@gmail.com>
>>> It sounds like pata_via and pata_amd need a foo_save_initial_config()
>>> much like AHCI, during which they would fill ppriv->init_gtm rather than
>>> ap->init_gtm.  Thoughts?  Both drivers are calling ata_acpi_cbl()
>>> themselves, permitting the possibility of ppriv->init_gtm.
>>>
>>> This avoids forcing everyone else to bear the memory cost in ata_port
>>> for just these two drivers.
>> The memory overhead is pretty small and more importantly there isn't a
>> good place to load initial GTM.  ACPI is associated with the host during
>> host registration after all private host initialization is complete.
>> When the EH gets invoked, the first thing which is done is forcing PIO0
>> before initial reset.
>>
>> Unless we add another hook, the only place to put this is in private
>> ->error_handler().  A driver can check whether it's being called for the
>> first time and record it in private structure, which isn't too pretty,
>> so I thought doing it this way was fair tradeoff.
> 
> Jeff, do you agree or still think it's better done in LLDs?  I'm okay
> either way.

I trust your judgement...  My reply was more of a "gut feeling" sort of 
thing.

In general, I want to keep libata as close as possible to the "LLD 
call-out model" as possible:  LLD registers itself with system services 
[perhaps using generic helpers to do so].  LLD fills in its own scsi 
host template and ata_port_operations [perhaps using generic helpers to 
do so].  LLD implements specific helpers that control LLD-specific 
behavior, calling out to libata helpers as need arises.

So I tend to prefer adding direct LLD control points to ATA_FLAG_xxx 
control points or other solutions, if the situation permits me to choose.

If you have to ask...  I will always prefer "it" (for some value of...) 
to be done in the LLD.  ;-)

	Jeff



