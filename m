From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: disabling sata_nv ADMA for 2.6.24
Date: Mon, 07 Jan 2008 17:35:23 -0600
Message-ID: <4782B73B.8080309@shaw.ca>
References: <4781F008.9070404@gmail.com> <4782422C.8020202@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from idcmail-mo1so.shaw.ca ([24.71.223.10]:20189 "EHLO
	pd2mo2so.prod.shaw.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755991AbYAGXfv (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 7 Jan 2008 18:35:51 -0500
Received: from pd4mr3so.prod.shaw.ca
 (pd4mr3so-qfe3.prod.shaw.ca [10.0.141.214]) by l-daemon
 (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15 2004))
 with ESMTP id <0JUA003YIS74IS50@l-daemon> for linux-ide@vger.kernel.org; Mon,
 07 Jan 2008 16:35:28 -0700 (MST)
Received: from pn2ml7so.prod.shaw.ca ([10.0.121.151])
 by pd4mr3so.prod.shaw.ca (Sun Java System Messaging Server 6.2-7.05 (built Sep
 5 2006)) with ESMTP id <0JUA000TDS74R410@pd4mr3so.prod.shaw.ca> for
 linux-ide@vger.kernel.org; Mon, 07 Jan 2008 16:35:28 -0700 (MST)
Received: from [192.168.1.113] ([70.64.130.4])
 by l-daemon (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15 2004))
 with ESMTP id <0JUA007Z8S73UTA0@l-daemon> for linux-ide@vger.kernel.org; Mon,
 07 Jan 2008 16:35:27 -0700 (MST)
In-reply-to: <4782422C.8020202@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Tejun Heo <htejun@gmail.com>, Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>

Mark Lord wrote:
> Tejun Heo wrote:
>> Hello, guys.
>>
>> We still have three problems with ADMA.
>>
>> * hard lockup during resume
>> * occasional hard lockup after hotplug or other erros (probably related
>> to the above?)

This has only been reported on one person's MSI board. Apparently 
another revision of the same board is reported to work, and I can't 
duplicate the problem on my Asus board, so it could just be some 
hardware problem on that motherboard.

>> * occasional timeout of FLUSH after NCQ writes
>>
>> I think we should disable ADMA for 2.6.24 and -stable for now.  What do
>> you guys think?

I still can't say I'm really in favor of it.. In particular to do so for 
2.6.24 right now seems excessive, as none of these problems are 
regressions from 2.6.23, and these controllers haven't been tested in 
non-ADMA mode very much since it was made the default, so that change 
might actually cause regressions.

> 
> Heck, given the active vendor neglect here,
> I'm surprised we even bother with it at all!
> 
> Cheers
> 
