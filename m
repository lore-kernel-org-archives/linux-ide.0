From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: disabling sata_nv ADMA for 2.6.24
Date: Mon, 07 Jan 2008 18:12:56 -0600
Message-ID: <4782C008.3030902@shaw.ca>
References: <4781F008.9070404@gmail.com> <4782422C.8020202@rtr.ca>
 <4782B73B.8080309@shaw.ca> <4782BC48.4000309@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from idcmail-mo1so.shaw.ca ([24.71.223.10]:11520 "EHLO
	pd4mo3so.prod.shaw.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758836AbYAHAOc (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 7 Jan 2008 19:14:32 -0500
Received: from pd3mr4so.prod.shaw.ca
 (pd3mr4so-qfe3.prod.shaw.ca [10.0.141.180]) by l-daemon
 (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15 2004))
 with ESMTP id <0JUA001N8TXQER70@l-daemon> for linux-ide@vger.kernel.org; Mon,
 07 Jan 2008 17:13:02 -0700 (MST)
Received: from pn2ml6so.prod.shaw.ca ([10.0.121.150])
 by pd3mr4so.prod.shaw.ca (Sun Java System Messaging Server 6.2-7.05 (built Sep
 5 2006)) with ESMTP id <0JUA00JTGTXPIO60@pd3mr4so.prod.shaw.ca> for
 linux-ide@vger.kernel.org; Mon, 07 Jan 2008 17:13:02 -0700 (MST)
Received: from [192.168.1.113] ([70.64.130.4])
 by l-daemon (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15 2004))
 with ESMTP id <0JUA00EZGTXOA600@l-daemon> for linux-ide@vger.kernel.org; Mon,
 07 Jan 2008 17:13:00 -0700 (MST)
In-reply-to: <4782BC48.4000309@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Mark Lord <liml@rtr.ca>, Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>, Allen Martin <AMartin@nvidia.com>, Peer Chen <pchen@nvidia.com>, Kuan Luo <kluo@nvidia.com>

Tejun Heo wrote:
> Robert Hancock wrote:
>> Mark Lord wrote:
>>> Tejun Heo wrote:
>>>> Hello, guys.
>>>>
>>>> We still have three problems with ADMA.
>>>>
>>>> * hard lockup during resume * occasional hard lockup after
>>>> hotplug or other erros (probably related to the above?)
>> This has only been reported on one person's MSI board. Apparently 
>> another revision of the same board is reported to work, and I can't 
>> duplicate the problem on my Asus board, so it could just be some 
>> hardware problem on that motherboard.
> 
> IIRC, I have two from suse bug reports and both resolved with adma=0.
> I'm not too sure whether post 2.6.23-rcX changes would have fixed those
> problems tho.  FWIW, I've disabled ADMA mode on all suse products.

A hotplug-related problem? Have a link to the reports?

> 
>> I still can't say I'm really in favor of it.. In particular to do so
>> for 2.6.24 right now seems excessive, as none of these problems are
>> regressions from 2.6.23, and these controllers haven't been tested in
>> non-ADMA mode very much since it was made the default, so that change
>> might actually cause regressions.
> 
> Technically, they're regressions from pre-ADMA days - pretty grave ones
> considering some of the failure modes include hard lock up.  Also, they
> don't seem resolvable in foreseeable future at this point.  If this
> isn't gonna improve, I think we should just drop ADMA support altogether
> and concentrate on stabilizing non-ADMA operation.  Stability is far
> more important than small performance improvements or feature supports.

The suspend/resume problem should be resolvable. It worked before and 
should be able to work again. Hopefully debug output with console 
enabled during resume may provide some hints..

The cache flush timeout problem is a bit onerous, but hopefully we can 
figure something out there with some more debugging by the reporter.

> 
> But, yeah, you're right in that the change might cause more problems.
> What's your estimation of such possibility?  I generally feel good about
> non-ADMA mode operation as they seem to solve most reported sata_nv bugs
> but I haven't really followed sata_nv code changes recently.

It's hard to say what may come up if we do this. I seem to recall that 
there were some reports of wierd hotplug issues and high latencies on 
register access that went away with ADMA mode.

I do think it's likely too late in the -rc series to make such a change 
though. Hopefully by 2.6.25 we'll either have the issues fixed or have 
more of an idea whether they can be.

> 
> Maybe this can be resolved by going through one more -rc cycle after the
> change if that's possible.
> 
> Thanks.
> 
