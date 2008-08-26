From: Brad Campbell <brad@wasp.net.au>
Subject: Re: libata bridge limits
Date: Tue, 26 Aug 2008 16:32:03 +0400
Message-ID: <48B3F7C3.6010600@wasp.net.au>
References: <20080826072841.GS20055@kernel.dk> <20080826104237.4b1cd7f6@lxorguk.ukuu.org.uk> <20080826101713.GW20055@kernel.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from 50.38.69.212.in-addr.fnarfbargle.com ([93.93.128.63]:41120 "EHLO
	fnarfbargle.com" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1756056AbYHZNLP (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 26 Aug 2008 09:11:15 -0400
In-Reply-To: <20080826101713.GW20055@kernel.dk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jens Axboe <jens.axboe@oracle.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, jeff@garzik.org, tj@kernel.org, linux-ide@vger.kernel.org

Jens 2 wrote:
> On Tue, Aug 26 2008, Alan Cox wrote:
>>> a) Why was this limit put in there? It limits both transfer speed and
>>>    request size. If it's due to some dodgy drive/bridge, perhaps we
>>>    should just check for that and only apply the transfer limits when
>>>    detected (or blacklisted). On the bridge setups I've seen, I've never
>>>    had problems with killing the limit.
>> Various old bridges need it - and you can't detect the bridge type.
> 
> Not generically, but for some devices (like the Mtron) we can.
> 
>>> b) Put in a whitelist, easy to do for these Mtron drives.
>>>
>>> c) Add a parameter to turn it on (or off, depending on the default) for
>>>    a specific drive.
>>>
>>> I'm in favor of a) personally, but I'd like to hear why the check was
>>> added originally first. Dropping 20-30% of the throughput performance on
>>> the floor without option seems like a really bad choice.

The check was originally put there as some nasty bridges caused all sorts of errors when these 
limits were exceeded, including some random data corruption from memory.

Those particular bridges were/are still widely available an can't be detected / identified using any 
other means.

>> Can I suggest 
>>
>> d) Assume the bridge is ok but teach the SATA error handling code that if
>> there is a timeout immediately with such a bridge then to flip down to
>> UDMA5 and knobble the transfer length.
> 
> That would be nice, assuming that we can rely on safe behaviour (eg not
> data corrupting badness).
> 

I was responsible for that original bridge knobble stuff and fortunately I still have the bridges, 
disks and controllers that triggered the original faults. If someone wants to cook up some code for 
testing I'd be more than happy to stick this stuff on the bench and beat on it for regression purposes.

Brad
-- 
Dolphins are so intelligent that within a few weeks they can
train Americans to stand at the edge of the pool and throw them
fish.
