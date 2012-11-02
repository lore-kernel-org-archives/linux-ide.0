From: Brian Norris <computersforpeace@gmail.com>
Subject: Re: [PATCH v2 04/14] libata: implement ata_platform_remove_one()
Date: Fri, 02 Nov 2012 12:29:09 -0700
Message-ID: <50941F05.7070901@gmail.com>
References: <1351842388-27210-5-git-send-email-computersforpeace@gmail.com> <1351883393-32354-1-git-send-email-computersforpeace@gmail.com> <50942925.7070407@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:33382 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750982Ab2KBT3M (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 2 Nov 2012 15:29:12 -0400
Received: by mail-pb0-f46.google.com with SMTP id rr4so2651923pbb.19
        for <linux-ide@vger.kernel.org>; Fri, 02 Nov 2012 12:29:11 -0700 (PDT)
In-Reply-To: <50942925.7070407@mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@mvista.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org, Tejun Heo <tj@kernel.org>

On 11/02/2012 01:12 PM, Sergei Shtylyov wrote:
> On 11/02/2012 10:09 PM, Brian Norris wrote:
>> @@ -6350,6 +6351,26 @@ int ata_pci_device_resume(struct pci_dev *pdev)
>>
>>   #endif /* CONFIG_PCI */
>>
>> +/**
>> + *      ata_platform_remove_one- Platform layer callback for device removal
>
>     A space before hyphen is needed.
>
>> + *      @pdev: Platform device that was removed
>> + *
>> + *      Platform layer indicates to libata via this hook that hot-unplug or
>> + *      module unload event has occurred.  Detach all ports.  Resource
>> + *      release is handled via devres.
>> + *
>> + *      LOCKING:
>> + *      Inherited from platform layer (may sleep).
>> + */
>
>     I actually meant indenting with tabs within the comment too. :-)

Ugh, more sloppiness, due to a bad copy&paste job, from 
ata_pci_remove_one(). Thanks for keeping your eyes open. v3 coming...

Brian
