From: Tejun Heo <htejun@gmail.com>
Subject: Re: Analysis of EH on Andi's dying disk and stuff to discuss about
Date: Sun, 30 Mar 2008 08:35:58 +0900
Message-ID: <47EED25E.4010805@gmail.com>
References: <20080328093055.GA16736@basil.nowhere.org> <47EDECE5.50309@gmail.com> <47EEAC3F.2070004@rtr.ca> <47EEB0B4.2050808@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.174]:6531 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750913AbYC2XgE (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 29 Mar 2008 19:36:04 -0400
Received: by wf-out-1314.google.com with SMTP id 28so863884wff.4
        for <linux-ide@vger.kernel.org>; Sat, 29 Mar 2008 16:36:03 -0700 (PDT)
In-Reply-To: <47EEB0B4.2050808@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Mark Lord <liml@rtr.ca>, Andi Kleen <andi@firstfloor.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, IDE/ATA development list <linux-ide@vger.kernel.org>, ric@emc.com

Jeff Garzik wrote:
> Mark Lord wrote:
>> Tejun Heo wrote:
>> ..
>>
>>>    So, to handle the common cases better, libata EH times out resets
>>>    quickly.  The first two tries are 10 seconds each and most devices
>>>    get reset properly before it hits the end of the second reset try
>>>    even if it needs to spin up.  What takes the longest is the third
>> ..
>>
>> I think that 10 seconds timeout is just *slightly* too short.
>> There are drives here somewhere, that always fail the first attempt
>> because they take about 12 seconds to spin-up and begin communicating.
> 
> Also, ATAPI sometimes takes quite a while to respond, I've seen, when 
> media is in the driver.

The goal there was to get, say, 90% of devices in the first reset and 
then the rest of sane ones in the second reset and idiots in the third 
reset.  As long as resets don't interfere with the device preparing for 
readiness as is the case for harddrive spinning up, this works just 
fine.  If there are devices which have to restart prepping for readiness 
on each reset, this can be a problem (those fall into the idiot category).

I personally have never seen such a device yet but if there's an ATAPI 
device which doesn't respond to reset till it has spun up the media and 
recognized it, it could be a problem.  I have to say that would be a 
pretty stupid way to implement reset.  Jeff, do you remember which drive 
it was?

-- 
tejun
