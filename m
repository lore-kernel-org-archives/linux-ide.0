From: Ric Wheeler <ric@emc.com>
Subject: Re: [PATCHSET #upstream] libata: improve FLUSH error handling
Date: Fri, 28 Mar 2008 12:57:09 -0400
Message-ID: <47ED2365.5020307@emc.com>
References: <12066128663306-git-send-email-htejun@gmail.com>	<47EBAE2B.8070102@rtr.ca>	<47EBB09F.9070607@rtr.ca>	<47EC5079.5020105@gmail.com>	<47EC58F6.3070601@rtr.ca>	<47ECF47A.2040508@emc.com>	<47ED061F.2070701@gmail.com>	<47ED0681.4090003@emc.com> <20080328151625.0791c2dd@core>
Reply-To: ric@emc.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mexforward.lss.emc.com ([128.222.32.20]:48308 "EHLO
	mexforward.lss.emc.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752103AbYC1RAH (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 28 Mar 2008 13:00:07 -0400
In-Reply-To: <20080328151625.0791c2dd@core>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Tejun Heo <htejun@gmail.com>, Mark Lord <liml@rtr.ca>, jeff@garzik.org, linux-ide@vger.kernel.org

Alan Cox wrote:
>> I do agree with the above, we should try to get the FLUSH done according 
>> to spec, I meant to argue that we should bound the time spent. If my 
>> laptop spends more than 30? 60? 120? seconds trying to flush a write 
>> cache, I will probably be looking for a way to force it to power down ;-)
> 
> But if your PhD thesis is being written back you'd be different 8). I am
> not sure we can exceed 30 seconds, currently although we set 60 second
> I/O timeouts we are timing out at 30 seconds in some traces I get sent so
> something is messing up our timeout handling back to the default. I've
> tried tracing it and so far failed to figure it out.

The challenge is in getting the retry, more than in just the timeout on 
just one IO.  For example, if we have a full 16MB write cache and the 
disk is really, really toast (i.e., a head failed which means each and 
every IO in that 16MB will fail), we don't want to do 16MB/512 distinct 
30-60 seconds retries....

That is where Mark's idea about capping the whole sequence of retries 
comes into play - we can use the global timer to prevent this from 
running into an eternity of retry attempts.

> 
>> It is also worth noting that most users of ext3 run without barriers 
>> enabled (and the drive write cache enabled) which means that we test 
>> this corruption path on any non-UPS power failure.
> 
> It is most unfortunate that distributions continue to ship that default.
> 
> Alan

I have been thinking that running without barriers by default is mostly 
OK for laptops (which have a fairly usable UPS in a working battery). If 
we destage the write cache rebustly as this thread is discussing, we 
should cover almost all normal failure cases.

Desktop and server systems should normally use either barriers or 
disable the write cache when ever you have data you care about...

ric
