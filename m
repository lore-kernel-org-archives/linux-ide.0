From: Rusty Conover <rconover@infogears.com>
Subject: Re: Resets on sil3124 & sil3726 PMP
Date: Sun, 26 Aug 2007 10:37:09 -0600
Message-ID: <D1F202E2-89B9-44D4-8E9E-0EEFF4CD0612@infogears.com>
References: <EA70552E-75C2-451D-BF58-A73482FBB14D@infogears.com> <46C5E3A6.9020907@gmail.com> <DFEB0E31-D017-4527-85A4-8D18D379CB0B@infogears.com> <98147300-A282-4909-A393-079365833BD8@infogears.com> <46CBA78D.2070405@gmail.com> <F3FDFA8B-A2EF-4EEE-ACE2-E67776650CF4@infogears.com> <46CBCD18.7070507@gmail.com> <B209C20A-580B-4AD6-A6A0-B4377499B8FC@infogears.com> <46CBDA17.6010009@gmail.com> <D2865984-EF5E-400F-9B71-1F95363D4C3F@infogears.com> <46CBDF82.6020206@gmail.com> <7644C0A3-8AEF-4C00-837A-429F73DD616D@infogears.com> <46CF91BA.7030608@gmail.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.infogears.com ([69.51.90.143]:46646 "EHLO
	mail.infogears.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751264AbXHZQhM (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 26 Aug 2007 12:37:12 -0400
In-Reply-To: <46CF91BA.7030608@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org


On Aug 24, 2007, at 8:19 PM, Tejun Heo wrote:

> Hello, Rusty.
>
> Rusty Conover wrote:
>> I have some interesting results.
>>
>> I had a pair of Seagate 250 GB SATA disks (models below) and tried  
>> those
>> out rather then the WD's.    At the 1.5 gbps rather they appear to  
>> work
>> just fine both being on the same PMP, at 3.0 gbps they timeout  
>> just like
>> the other disks did.  Possibly, the code isn't detecting the max  
>> rate of
>> the disks correctly since these drives only do 1.5 and it  
>> attempted to
>> do 3.0 gbps?
>
> Hardware PHY layer is fully responsible of 1.5/3.0 negotiation.  The
> driver can limit the maximum it can go but doesn't have much say in  
> the
> actual negotiation.
>
> Unfortunately, some SATA PHY combinations have problems at 3.0bps.  I
> saw quite a few weird cases.  e.g. marvell PMP can't detect older
> Seagate drives on 3Gbps and can't talk to a first gen Maxtor even at
> 1.5.  I'm still not quite sure how to solve this.  Once detected,  
> libata
> EH will do the right thing and speed down to 1.5 after a few
> transmission errors but it's a bit trickier before detection.  It's
> probably not worth driving fan-out ports at 3.0Ghz in the first  
> place so
> maybe limiting PMP fan-out ports to 1.5 by default can alleviate most
> situations.  Oh well, users won't be happy tho.
>
>> Have you found that drives can be picky if they will work or not with
>> PMP ports?
>
> As I said above, yeap.  Not only PMPs some host PHYs do that too.
>
>> I'll be trying to get a bunch of different drives to replace the ones
>> that don't work with PMP.
>
> Yeah, that will be the easiest way out for the moment.
>
> Thanks.
>

Hi Tejun,

After a lot of fiddling with speed limiting and different drives, I  
still couldn't avoid the port resets under high load.  The new  
seagate drives did work okay when both of them were paired in two PMP  
ports, but when I assembled the full array under high load one or the  
other PMP's would timeout and reset.  Of course this might be okay  
for some people, who don't put a high amount of load on their drives  
but it isn't going to work for me.

After all I decided to send back the piece of hardware and just  
switch to a solution that has the SATA ports on the main board.   
Thanks for you help trying to get all of this working, I probably  
just had a bad adaptor card or drive enclosure.

Thanks again,

Rusty
