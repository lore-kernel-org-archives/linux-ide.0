From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: IO_PAGE_FAULT from SATA card during boot
Date: Mon, 07 Feb 2011 20:04:40 -0600
Message-ID: <4D50A4B8.2070608@gmail.com>
References: <20110129112456.GA13204@arachsys.com> <4D44433F.1040607@gmail.com> <20110130015442.GB13204@arachsys.com> <AANLkTim7+9WVVJAjbj4pNMB9OKVmf2B+XNQ+exDt9_Tm@mail.gmail.com> <20110202135644.GG11670@arachsys.com> <4D49FB9F.9040304@gmail.com> <20110203085601.GB2490@arachsys.com> <20110207174838.GA21124@arachsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:33866 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753369Ab1BHCEo (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 7 Feb 2011 21:04:44 -0500
Received: by iyj8 with SMTP id 8so2808617iyj.19
        for <linux-ide@vger.kernel.org>; Mon, 07 Feb 2011 18:04:43 -0800 (PST)
In-Reply-To: <20110207174838.GA21124@arachsys.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Chris Webb <chris.webb@elastichosts.com>
Cc: linux-ide@vger.kernel.org, Joerg.Roedel@amd.com

On 02/07/2011 11:48 AM, Chris Webb wrote:
> Chris Webb<chris@arachsys.com>  writes:
>
>> Robert Hancock<hancockrwd@gmail.com>  writes:
>>
>>> Is it the same model of add-on card?
>>
>> Hi. Yes, they're four identical machines with four identical SATA
>> controllers.
>>
>>> This controller apparently has both a SATA and PATA controller on
>>> it. The PATA portion doesn't seem to be showing up in lspci, but
>>> obviously the BIOS saw some sign of it - and if the IOMMU reporting
>>> can be believed, it's trying to do a read request for some reason..
>>
>> Since SATA cards are cheap, I've ordered a different AHCI card to try
>> swapping out, so will be able to confirm if it's specific to this SATA card.
>
> I've now done this, swapping in a Highpoint R620. I get the same
> IO_PAGE_FAULT, same timeouts on the sata card, but lspci now shows up the
> device 03:00.1. I've put the new dmesg and lspci output at
>
>    http://cdw.me.uk/tmp/sata-fault-hpt.dmesg
>    http://cdw.me.uk/tmp/sata-fault-hpt.lspci
>
> Again, problem is present both with 2.6.32.25 and 2.6.37.

Curious.. We don't even have a driver loaded for the PATA device on that 
chip so I don't see how we could be telling it to do anything. As far as 
I can see there are a few possible causes: Either the device is 
generating read requests which appear to come from the PATA function 
rather than the SATA one for some reason, the IOMMU is picking up the 
wrong device function for requests from that device, or something in the 
platform is somehow misconfiguring the device to cause this error. It 
may not be easy to figure out which one is the cause, however.

Putting Joerg Roedel from AMD on the CC list to see if he has any more 
insight..
