From: Rusty Conover <rconover@infogears.com>
Subject: Re: Resets on sil3124 & sil3726 PMP
Date: Tue, 21 Aug 2007 23:00:32 -0600
Message-ID: <F3FDFA8B-A2EF-4EEE-ACE2-E67776650CF4@infogears.com>
References: <EA70552E-75C2-451D-BF58-A73482FBB14D@infogears.com> <46C5E3A6.9020907@gmail.com> <DFEB0E31-D017-4527-85A4-8D18D379CB0B@infogears.com> <98147300-A282-4909-A393-079365833BD8@infogears.com> <46CBA78D.2070405@gmail.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.infogears.com ([69.51.90.143]:49462 "EHLO
	mail.infogears.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751637AbXHVFAf (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 22 Aug 2007 01:00:35 -0400
In-Reply-To: <46CBA78D.2070405@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org



On Aug 21, 2007, at 9:03 PM, Tejun Heo wrote:

> Rusty Conover wrote:
>> Hi Tejun,
>>
>> Just as some further testing and poking I added the drives to the  
>> list
>> of disks to disable NCQ for, it didn't resolve the issue.
>>
>> I increased the PMP timeout to 1000 rather then 250 and that didn't
>> resolve the problem either.
>>
>> The interface still has timeout errors writing the ext3 fs.
>
> Can you just put one harddisk into one of the PMP slots and test it?
> Does it still suffer timeouts?
>
> -- 
> tejun


Hi Tejun,

Putting just one hard disk into the PMP slots, works great all by  
itself. I created an ext3 fs on it, used dd to dump lots of data to  
it, no problems in all of my testing.

One hard disk in a PMP slot and another hard disk in a native slot on  
a different SATA port work great together.

Two hard disks in the same PMP slot range (slots 1-2), timeout right  
away.

Could it be a problem with timing the PMP requests?

I've tested this on a second separate machine and I'm seeing the same  
timeout errors.

Thanks,

Rusty
