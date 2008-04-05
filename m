From: Tejun Heo <htejun@gmail.com>
Subject: Re: [patch 3/3] ata: SWNCQ should be enabled by default
Date: Sat, 05 Apr 2008 09:00:06 +0900
Message-ID: <47F6C106.2080202@gmail.com>
References: <200803282133.m2SLXlWk011463@imap1.linux-foundation.org> <47EE465E.80401@gmail.com> <47EE88C9.3020805@dunaweb.hu> <47EEDACA.4060400@gmail.com> <15F501D1A78BD343BE8F4D8DB854566B1BFE2AF1@hkemmail01.nvidia.com> <47F069D7.3010702@gmail.com> <47F1A888.3020706@shaw.ca> <47F1AADC.1080104@shaw.ca> <15F501D1A78BD343BE8F4D8DB854566B1BFE2AF4@hkemmail01.nvidia.com> <47F5E271.10903@garzik.org> <47F63C77.9010202@shaw.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.233]:59683 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751405AbYDEAAO (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 4 Apr 2008 20:00:14 -0400
Received: by wr-out-0506.google.com with SMTP id c48so285837wra.1
        for <linux-ide@vger.kernel.org>; Fri, 04 Apr 2008 17:00:12 -0700 (PDT)
In-Reply-To: <47F63C77.9010202@shaw.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert Hancock <hancockr@shaw.ca>
Cc: Jeff Garzik <jeff@garzik.org>, Kuan Luo <kluo@nvidia.com>, Zoltan Boszormenyi <zboszor@dunaweb.hu>, akpm@linux-foundation.org, linux-ide@vger.kernel.org, Peer Chen <pchen@nvidia.com>, Allen Martin <AMartin@nvidia.com>

Robert Hancock wrote:
> Jeff Garzik wrote:
>> Kuan Luo wrote:
>>> Robert wrote:
>>>> -Hotplug/hot-unplug fails to work properly, hotplug interrupts not 
>>>> raised (seemingly only on certain boards/configurations as I can't 
>>>> duplicate this problem). 
>>>> http://bugzilla.kernel.org/show_bug.cgi?id=8421
>>>>
>>> I occasionly encountered this problem in one port under certain system,
>>> but didn't see this issue under other systems in the same mainboard.
>>> After adding the operation of manually clearing the added/removed
>>> interrupt bit in NV_INT_STATUS_CK804 register in nv_adma_interrupt 
>>> function,  i saw some improvement. The key problem is that no one who 
>>> knows this controller comes to help
>>> to solve these issue.
>>> Given this disadvantage, i think disabling it maybe is a good choice.
>>> I don't know whether we need to continue to provide patch for adma after
>>> disabling adma function.
>>
>> Is there any hope of getting permission for me to (a) give the NV ADMA 
>> documentation to Robert, or (b) posting the ADMA PDF on 
>> http://gkernel.sourceforge.net/specs/ ?
>>
>> I strongly encourage vendors -- especially with chips at or past 
>> end-of-life -- to help customers and developers by permitting posting 
>> at http://gkernel.sourceforge.net/specs/
>>
>> Thanks,
>>
>>     Jeff
> 
> I would second that call. It's been suggested that 3rd party IP was what 
> inhibited this, I don't know if that is the case or not. But it would be 
> a very nice gesture if NVIDIA would do what it takes to make this possible.

/me thirds.

-- 
tejun
