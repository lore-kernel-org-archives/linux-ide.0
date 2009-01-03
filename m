From: Justin Piszcz <jpiszcz@lucidpixels.com>
Subject: Re: marvell sata status?
Date: Sat, 3 Jan 2009 04:13:10 -0500 (EST)
Message-ID: <alpine.DEB.1.10.0901030411510.11184@p34.internal.lan>
References: <20090101051038.GD3386@pimb.org> <alpine.DEB.1.10.0901010444440.427@p34.internal.lan> <495CCE0F.7010002@rtr.ca> <20090101184450.GG3386@pimb.org> <alpine.DEB.1.10.0901011411140.20575@p34.internal.lan> <20090101194302.GH3386@pimb.org>
 <495E3C92.2070304@rtr.ca> <alpine.DEB.1.10.0901021302560.26159@p34.internal.lan> <495E769B.8000407@rtr.ca> <alpine.DEB.1.10.0901021518150.8210@p34.internal.lan> <495EF1D5.1020106@rtr.ca>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from lucidpixels.com ([75.144.35.66]:56821 "EHLO lucidpixels.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751924AbZACJNM (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 3 Jan 2009 04:13:12 -0500
In-Reply-To: <495EF1D5.1020106@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Jody Belka <lists-lkml@pimb.org>, linux-ide@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>



On Sat, 3 Jan 2009, Mark Lord wrote:

> Justin Piszcz wrote:
>> 
>> 
>> On Fri, 2 Jan 2009, Mark Lord wrote:
>> 
>>> Justin Piszcz wrote:
>>>> On Fri, 2 Jan 2009, Mark Lord wrote:
>>> 
>>>>> I suppose, of all of the vendors, Adaptec probably has the best chance
>>>>> of getting that part right, and probably without randomly writing 
>>>>> metadata
>>>>> somewhere on the drive simply for JBOD.
>>>>> 
>>>>> Anyone know for sure ?
>>>>> 
>>>>> Cheers
>>>>> -- 
>>>>> To unsubscribe from this list: send the line "unsubscribe linux-ide" in
>>>>> the body of a message to majordomo@vger.kernel.org
>>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>>> 
>>>> 
>>>> The Star Tech seems to work right, you plug in the disks and they're 
>>>> recognized as regular sata disks, as if on your on-board controller.  No 
>>>> special modifications required.
>>> ..
>>> 
>>> Inconclusive.  The Highpoint cards behave like that, too,
>>> except they silently corrupt a sector (or more) on the drive
>>> at every boot, whether or not one ever "configures" the drive
>>> through the built-in RAID/JBOD BIOS.
> ..
>
> Well.. what do *you* think the answer is?
>
> Unless you've zeroed the entire drive beforehand,
> and then inserted it into a given controller,
> and then scanned for non-zero sectors.. how can you tell?
>
> That's what we ended up having to do with the Highpoint ones,
> and the result was rather shocking at the time.
>
> Cheers
>

One would think if the controller overwrites bits on the device when 
mdadm assembles the raid device it would kick it out of the array for 
being unclean or find a lot of mismatches on the array or is that the 
wrong idea?

Justin.
