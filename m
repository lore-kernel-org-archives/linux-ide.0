From: Tejun Heo <htejun@gmail.com>
Subject: Re: PCI SATA controllers on embedded, no-BIOS targets
Date: Wed, 23 Aug 2006 03:02:30 +0900
Message-ID: <44EB46B6.3000207@gmail.com>
References: <44EB32E4.8080706@mvista.com> <44EB33BB.4090101@gmail.com> <44EB3650.1080404@mvista.com> <44EB3E2F.4040504@gmail.com> <44EB3F70.6000702@gmail.com> <44EB40DA.3010904@mvista.com> <44EB4658.3060207@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.186]:61394 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932332AbWHVSCq (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 22 Aug 2006 14:02:46 -0400
Received: by nf-out-0910.google.com with SMTP id o25so125018nfa
        for <linux-ide@vger.kernel.org>; Tue, 22 Aug 2006 11:02:39 -0700 (PDT)
In-Reply-To: <44EB4658.3060207@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Kevin Hilman <khilman@mvista.com>
Cc: linux-ide@vger.kernel.org, Deepak Saxena <dsaxena@mvista.com>

Tejun Heo wrote:
> Kevin Hilman wrote:
>>>> I've personally seen it working on XScale and ATI's mips.
>>
>> OK, that's good to know.
>>
>>> For the record, for ATI's new mips platform, sata_sil needs some 
>>> modifications.  Their PCI bridge can't handle byte-aligned mmio and 
>>> the driver had to be modified to use IO address space.
>>
>> I'm using 2.6.18-rc4 on this XScale IXP425 (big endian) and both the 
>> legacy driver (drivers/ide/pci/siimage.c) and the libata driver 
>> (drivers/scsi/sata_sil.c) cause crashes during probing due to bad 
>> memory accesses.
> 
> So, that one can't do byte-aligned mmio either?
> 
>> Switching the legacy driver into PIO mode makes the probing work well, 
>> but still can't figure out what's happening in the libata driver, 
>> AFICT, it can't do PIO.
> 
> By PIO, you mean accessing registers via IO address space instead of 
> memory address space, right?  Not PIO as opposed to DMA.
> 
>> Any chance you can share the changes to use IO address space?  Maybe 
>> the PCI on this XScale has similar limitations.
> 
> Sure, I've just got okay for releasing the code and am going to post the 
> patches on my website anyway.  I'm attaching a patch.  This might not 
> apply cleanly to your kernel but it should give enough idea.  Oh the 
> code kills 4 ports support for 3114 too.

s/kills/doesn't support/

-- 
tejun
