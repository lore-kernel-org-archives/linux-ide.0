From: Rusty Conover <rconover@infogears.com>
Subject: Re: Resets on sil3124 & sil3726 PMP
Date: Wed, 22 Aug 2007 00:11:37 -0600
Message-ID: <B209C20A-580B-4AD6-A6A0-B4377499B8FC@infogears.com>
References: <EA70552E-75C2-451D-BF58-A73482FBB14D@infogears.com> <46C5E3A6.9020907@gmail.com> <DFEB0E31-D017-4527-85A4-8D18D379CB0B@infogears.com> <98147300-A282-4909-A393-079365833BD8@infogears.com> <46CBA78D.2070405@gmail.com> <F3FDFA8B-A2EF-4EEE-ACE2-E67776650CF4@infogears.com> <46CBCD18.7070507@gmail.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.infogears.com ([69.51.90.143]:52224 "EHLO
	mail.infogears.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753907AbXHVGLk (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 22 Aug 2007 02:11:40 -0400
In-Reply-To: <46CBCD18.7070507@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org


On Aug 21, 2007, at 11:43 PM, Tejun Heo wrote:

> Rusty Conover wrote:
>> Putting just one hard disk into the PMP slots, works great all by
>> itself. I created an ext3 fs on it, used dd to dump lots of data  
>> to it,
>> no problems in all of my testing.
>
> Hmmmm..
>
>> One hard disk in a PMP slot and another hard disk in a native slot  
>> on a
>> different SATA port work great together.
>
> Okay.
>
>> Two hard disks in the same PMP slot range (slots 1-2), timeout  
>> right away.
>>
>> Could it be a problem with timing the PMP requests?
>
> Very unlikely.
>
>> I've tested this on a second separate machine and I'm seeing the same
>> timeout errors.
>
> Can you try different combinations (e.g. use different slots of the  
> same
>  PMP, use the slots from the other PMP)?  I still think it's some sort
> of hardware issue.
>


Hi Tejun,

I've tested this on both PMPs, when there is more then 1 disk on the  
PMP ports the timeouts occur.

For instance I tested:

Bays all on PMP1

1,2
1,3
2,4
3,4

Bays on PMP2

6,7
7,8
6,9
6,10

All of those combinations timeout very quickly, just when creating  
the raid device.  On the other attempts I was able to go past  
creating the raid device and attempt to create a ext3 fs. These just  
timeout doing the RAID-10 initial sync after about 5 seconds.

When I test just two disks in different PMP ports on two different  
SATA ports everything works.

When I test three disks, 2 PMP ports of one SATA port and 1 in  
another PMP port of a different SATA port I get the same timeout  
error on the PMP with more then one disk.

It seems to be any arrangement with more then one disk in a set of  
PMP ports leads to timeouts.

If it would help to have access to the machine to possibly debug  
what's going on with the errors, I'd be more then happy to arrange that.

Thanks for your help,

Rusty
