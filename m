From: Mark Lord <liml@rtr.ca>
Subject: Re: NCQ general question
Date: Wed, 01 Mar 2006 13:34:38 -0500
Message-ID: <4405E93E.3010307@rtr.ca>
References: <5d96567b0602282304o558fb564jd72784bafdd289f5@mail.gmail.com> <440561CB.30201@yahoo.de> <4405A656.1030602@rtr.ca> <4405C41F.5060504@yahoo.de> <20060301160554.GD4816@suse.de> <4405D040.8000700@yahoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([64.26.128.89]:53156 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S1751074AbWCASeV (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 1 Mar 2006 13:34:21 -0500
In-Reply-To: <4405D040.8000700@yahoo.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Gentoopower <gentoopower@yahoo.de>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

Gentoopower wrote:
> Jens Axboe wrote:
>> On Wed, Mar 01 2006, Gentoopower wrote:
..
>>> I can defintely feel the speed difference between the two drives.
>>>     
>> Well that can't be because of NCQ, since it isn't active :-)   
> 
> Got ya:-)
> 
> Who said this box is running only linux?

You did, by posting to the *Linux-IDE* kernel mailing list.

All bets are off for other OSs, especially those that really
*need* NCQ for half-decent performance.

Linux doesn't, but it's definitely nice to wish for.

I've implemented host-queuing support for NCQ and TCQ on
several controllers (for Linux), and it almost always produces
only a tiny *measureable* effect on desktop systems.

Busy servers, with lots of teensy random read requests,
benefit most from it, as do benchmark programs that do a lot of seeking.

But normal system use -- running OO.org, rebuilding kernels,
etc.. no significant measurable difference.  Maybe by fiddling
with the IO scheduler code (which defeats NCQ/TCQ to a degree)..

But I'd happily enable it on my own systems anyway!

Cheers
