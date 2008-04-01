From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: [patch 3/3] ata: SWNCQ should be enabled by default
Date: Mon, 31 Mar 2008 21:14:16 -0600
Message-ID: <47F1A888.3020706@shaw.ca>
References: <200803282133.m2SLXlWk011463@imap1.linux-foundation.org>
 <47EE465E.80401@gmail.com> <47EE88C9.3020805@dunaweb.hu>
 <47EEDACA.4060400@gmail.com>
 <15F501D1A78BD343BE8F4D8DB854566B1BFE2AF1@hkemmail01.nvidia.com>
 <47F069D7.3010702@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from idcmail-mo1so.shaw.ca ([24.71.223.10]:12508 "EHLO
	pd3mo3so.prod.shaw.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752831AbYDADSC (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 31 Mar 2008 23:18:02 -0400
Received: from pd4mr1so.prod.shaw.ca
 (pd4mr1so-qfe3.prod.shaw.ca [10.0.141.212]) by l-daemon
 (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15 2004))
 with ESMTP id <0JYM00FQIMFBVFE0@l-daemon> for linux-ide@vger.kernel.org; Mon,
 31 Mar 2008 21:16:23 -0600 (MDT)
Received: from pn2ml8so.prod.shaw.ca ([10.0.121.152])
 by pd4mr1so.prod.shaw.ca (Sun Java System Messaging Server 6.2-7.05 (built Sep
 5 2006)) with ESMTP id <0JYM002Z1MFBGE00@pd4mr1so.prod.shaw.ca> for
 linux-ide@vger.kernel.org; Mon, 31 Mar 2008 21:16:23 -0600 (MDT)
Received: from [192.168.1.113] ([70.64.130.4])
 by l-daemon (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15 2004))
 with ESMTP id <0JYM0024QMF91110@l-daemon> for linux-ide@vger.kernel.org; Mon,
 31 Mar 2008 21:16:22 -0600 (MDT)
In-reply-to: <47F069D7.3010702@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Kuan Luo <kluo@nvidia.com>, Zoltan Boszormenyi <zboszor@dunaweb.hu>, akpm@linux-foundation.org, jeff@garzik.org, linux-ide@vger.kernel.org, Peer Chen <pchen@nvidia.com>

Tejun Heo wrote:
> Kuan Luo wrote:
>> For ADMA, I lean to disable it for default because stability is more
>> important to our customers. At least, bug in this link:
>> http://www.gossamer-threads.com/lists/linux/kernel/885929  is not
>> resolved.
> 
> Robert, what do you think?  Should we disable ADMA by default from 
> 2.6.26-rcX?
> 

I can't say I'm inherently in favor of it, but if people feel strongly 
enough about it I won't yell too loudly. If we do disable it, I would 
suggest printing out a message saying it can be enabled when the driver 
loads if they didn't switch it on, in case people complain about it as a 
regression otherwise.
