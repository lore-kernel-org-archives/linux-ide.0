From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: [patch 3/3] ata: SWNCQ should be enabled by default
Date: Fri, 04 Apr 2008 08:34:31 -0600
Message-ID: <47F63C77.9010202@shaw.ca>
References: <200803282133.m2SLXlWk011463@imap1.linux-foundation.org>
 <47EE465E.80401@gmail.com> <47EE88C9.3020805@dunaweb.hu>
 <47EEDACA.4060400@gmail.com>
 <15F501D1A78BD343BE8F4D8DB854566B1BFE2AF1@hkemmail01.nvidia.com>
 <47F069D7.3010702@gmail.com> <47F1A888.3020706@shaw.ca>
 <47F1AADC.1080104@shaw.ca>
 <15F501D1A78BD343BE8F4D8DB854566B1BFE2AF4@hkemmail01.nvidia.com>
 <47F5E271.10903@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from idcmail-mo1so.shaw.ca ([24.71.223.10]:18004 "EHLO
	pd2mo3so.prod.shaw.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754935AbYDDOhB (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 4 Apr 2008 10:37:01 -0400
Received: from pd3mr2so.prod.shaw.ca
 (pd3mr2so-qfe3.prod.shaw.ca [10.0.141.178]) by l-daemon
 (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15 2004))
 with ESMTP id <0JYT00J771X5SA90@l-daemon> for linux-ide@vger.kernel.org; Fri,
 04 Apr 2008 08:36:41 -0600 (MDT)
Received: from pn2ml5so.prod.shaw.ca ([10.0.121.149])
 by pd3mr2so.prod.shaw.ca (Sun Java System Messaging Server 6.2-7.05 (built Sep
 5 2006)) with ESMTP id <0JYT001001X426E0@pd3mr2so.prod.shaw.ca> for
 linux-ide@vger.kernel.org; Fri, 04 Apr 2008 08:36:42 -0600 (MDT)
Received: from [192.168.1.113] ([70.64.130.4])
 by l-daemon (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15 2004))
 with ESMTP id <0JYT00LVR1X37X20@l-daemon> for linux-ide@vger.kernel.org; Fri,
 04 Apr 2008 08:36:40 -0600 (MDT)
In-reply-to: <47F5E271.10903@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Kuan Luo <kluo@nvidia.com>, Tejun Heo <htejun@gmail.com>, Zoltan Boszormenyi <zboszor@dunaweb.hu>, akpm@linux-foundation.org, linux-ide@vger.kernel.org, Peer Chen <pchen@nvidia.com>, Allen Martin <AMartin@nvidia.com>

Jeff Garzik wrote:
> Kuan Luo wrote:
>> Robert wrote:
>>> -Hotplug/hot-unplug fails to work properly, hotplug interrupts not 
>>> raised (seemingly only on certain boards/configurations as I can't 
>>> duplicate this problem). http://bugzilla.kernel.org/show_bug.cgi?id=8421
>>>
>> I occasionly encountered this problem in one port under certain system,
>> but didn't see this issue under other systems in the same mainboard.
>> After adding the operation of manually clearing the added/removed
>> interrupt bit in NV_INT_STATUS_CK804 register in nv_adma_interrupt 
>> function,  i saw some improvement. 
>> The key problem is that no one who knows this controller comes to help
>> to solve these issue.
>> Given this disadvantage, i think disabling it maybe is a good choice.
>> I don't know whether we need to continue to provide patch for adma after
>> disabling adma function.
> 
> Is there any hope of getting permission for me to (a) give the NV ADMA 
> documentation to Robert, or (b) posting the ADMA PDF on 
> http://gkernel.sourceforge.net/specs/ ?
> 
> I strongly encourage vendors -- especially with chips at or past 
> end-of-life -- to help customers and developers by permitting posting at 
> http://gkernel.sourceforge.net/specs/
> 
> Thanks,
> 
>     Jeff

I would second that call. It's been suggested that 3rd party IP was what 
inhibited this, I don't know if that is the case or not. But it would be 
a very nice gesture if NVIDIA would do what it takes to make this possible.
