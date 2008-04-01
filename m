From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: [patch 3/3] ata: SWNCQ should be enabled by default
Date: Mon, 31 Mar 2008 21:24:12 -0600
Message-ID: <47F1AADC.1080104@shaw.ca>
References: <200803282133.m2SLXlWk011463@imap1.linux-foundation.org>
 <47EE465E.80401@gmail.com> <47EE88C9.3020805@dunaweb.hu>
 <47EEDACA.4060400@gmail.com>
 <15F501D1A78BD343BE8F4D8DB854566B1BFE2AF1@hkemmail01.nvidia.com>
 <47F069D7.3010702@gmail.com> <47F1A888.3020706@shaw.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from idcmail-mo1so.shaw.ca ([24.71.223.10]:30336 "EHLO
	pd2mo1so.prod.shaw.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752056AbYDAD0U (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 31 Mar 2008 23:26:20 -0400
Received: from pd3mr5so.prod.shaw.ca (pd3mr5so-qfe3.prod.shaw.ca [10.0.141.12])
 by l-daemon (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15 2004))
 with ESMTP id <0JYM00CA3MVW4690@l-daemon> for linux-ide@vger.kernel.org; Mon,
 31 Mar 2008 21:26:20 -0600 (MDT)
Received: from pn2ml3so.prod.shaw.ca ([10.0.121.147])
 by pd3mr5so.prod.shaw.ca (Sun Java System Messaging Server 6.2-7.05 (built Sep
 5 2006)) with ESMTP id <0JYM00HT8MVVZG10@pd3mr5so.prod.shaw.ca> for
 linux-ide@vger.kernel.org; Mon, 31 Mar 2008 21:26:20 -0600 (MDT)
Received: from [192.168.1.113] ([70.64.130.4])
 by l-daemon (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JYM00369MVTKG20@l-daemon> for linux-ide@vger.kernel.org; Mon,
 31 Mar 2008 21:26:19 -0600 (MDT)
In-reply-to: <47F1A888.3020706@shaw.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert Hancock <hancockr@shaw.ca>
Cc: Tejun Heo <htejun@gmail.com>, Kuan Luo <kluo@nvidia.com>, Zoltan Boszormenyi <zboszor@dunaweb.hu>, akpm@linux-foundation.org, jeff@garzik.org, linux-ide@vger.kernel.org, Peer Chen <pchen@nvidia.com>, Allen Martin <AMartin@nvidia.com>

Robert Hancock wrote:
> Tejun Heo wrote:
>> Kuan Luo wrote:
>>> For ADMA, I lean to disable it for default because stability is more
>>> important to our customers. At least, bug in this link:
>>> http://www.gossamer-threads.com/lists/linux/kernel/885929  is not
>>> resolved.
>>
>> Robert, what do you think?  Should we disable ADMA by default from 
>> 2.6.26-rcX?
>>
> 
> I can't say I'm inherently in favor of it, but if people feel strongly 
> enough about it I won't yell too loudly. If we do disable it, I would 
> suggest printing out a message saying it can be enabled when the driver 
> loads if they didn't switch it on, in case people complain about it as a 
> regression otherwise.

BTW, it would be nice if NVIDIA would put some more resources into 
debugging these issues so that we didn't have to take such an action. 
With some of these problems, there are definite limits to what we can do 
to figure out what's going on without knowing what is happening 
internally in the controller.

By my reckoning the known issues are:

-Occasional timeouts when issuing the first command after switching from 
NCQ to non-NCQ commands (even with the udelay() call in the driver to 
partially work around this). When this happens, going into register mode 
during error handling times out.

-When handling a failed command (ex: caused by a bad sector), going into 
register mode times out and retrieving result taskfile from ATA 
registers can cause a MCE due to a northbridge HyperTransport bus 
transaction timeout (reported by Kuan, I don't think anyone else has 
mentioned this one).

-Hotplug/hot-unplug fails to work properly, hotplug interrupts not 
raised (seemingly only on certain boards/configurations as I can't 
duplicate this problem). http://bugzilla.kernel.org/show_bug.cgi?id=8421
