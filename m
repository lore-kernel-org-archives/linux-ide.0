From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] libata: add host_set->next for legacy two host sets case
Date: Mon, 12 Jun 2006 16:06:25 +0900
Message-ID: <448D1271.6090501@gmail.com>
References: <20060612051727.GD9166@htj.dyndns.org> <448D0FF9.1080605@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0102.google.com ([64.233.162.200]:63275 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751410AbWFLHGb (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 12 Jun 2006 03:06:31 -0400
Received: by nz-out-0102.google.com with SMTP id s18so1567772nze
        for <linux-ide@vger.kernel.org>; Mon, 12 Jun 2006 00:06:30 -0700 (PDT)
In-Reply-To: <448D0FF9.1080605@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org, Albert Lee <albertcc@tw.ibm.com>

Jeff Garzik wrote:
> Tejun Heo wrote:
>> For a legacy ATA controller, libata registers two separate host sets.
>> There was no connection between the two hosts making it impossible to
>> traverse all ports related to the controller.  This patch adds
>> host_set->next which points to the second host_set and implements
>> ata_host_set_for_all_ports() which traverses all ports associated with
>> the controller.  This fixes the following bugs.
>>
>> * On device removal, all ports hanging off the device are properly
>>   detached.  Prior to this patch, ports on the first host_set weren't
>>   detached casuing oops on driver unloading.
>>
>> * On device removal, both host sets are freed
>>
>> This will also be used by new power management code to suspend and
>> resume all ports of a controller.  host_set/port representation will
>> be improved to handle legacy controllers better and this host_set
>> linking hack will go away with it.
>>
>> Signed-off-by: Tejun Heo <htejun@gmail.com>
> 
> NAK.  You don't want to iterate through multiple host sets, _inside_ of 
> function ata_host_set_remove().  ata_host_set_remove() is called with a 
> single host_set, and is designed to remove only a single host set.
> 
> The concept of a host_set list is OK, but I would rather that 
> ata_pci_remove_one() be updated to something like
> 
>     host_set = get-drvdata(...)
> 
>     while (host_set)
>         tmp = host_set
>         host_set = host_set->next
>         ata_host_set_remove(tmp)

I wanted to hide the second host_set behind the first one as there will 
be only one host_set in the future.  But, okay, will update as you said. 
  That should be less confusing.

-- 
tejun
