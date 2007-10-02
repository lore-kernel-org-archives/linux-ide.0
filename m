From: Mark Lord <liml@rtr.ca>
Subject: Re: Polling (was Re: [PATCHSET 2/2] implement PMP support, take 6)
Date: Tue, 02 Oct 2007 09:06:31 -0400
Message-ID: <47024257.4050606@rtr.ca>
References: <1190521193410-git-send-email-htejun@gmail.com>	<46F9BF3E.5050708@garzik.org>	<46FA1B4E.8090103@gmail.com>	<46FD079F.3010007@garzik.org>	<46FD0D50.8030602@gmail.com>	<46FD1C4A.8010101@garzik.org>	<46FD306C.3050205@gmail.com>	<46FD5DE1.8000206@rtr.ca> <20070928220309.7c9ed816@the-village.bc.nu> <46FDADD9.9050007@garzik.org> <46FE45CE.1050007@rtr.ca> <4700EA52.10701@garzik.org> <47018CEC.6060203@gmail.com> <47024001.6090306@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:1258 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752447AbXJBNGd (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 2 Oct 2007 09:06:33 -0400
In-Reply-To: <47024001.6090306@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Tejun Heo <htejun@gmail.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org

Jeff Garzik wrote:
> Tejun Heo wrote:
>> Jeff Garzik wrote:
>>> Mark Lord wrote:
>>>> Linux kernel development is supposed to happen incrementally nowadays.
>>>> Get a nice working solution in place, and then enhance/tune it.
>>> It's not about enhancing and tuning.
>>>
>>> It's about me (and/or James B) having to __undo__ the current code, just
>>> to get things working on an entire class of SATA-capable controllers out
>>> in the field.
>>
>> Hmmm... Simpy not setting ATA_FLAG_PMP isn't enough?
> 
> The point was that I was going to turn on PMP support for SAS 
> controllers in 2.6.24 to coincide with the merge, but now cannot without 
> fixing things.

So, don't.

Just a few days ago PMP was slated to not be enabled for *any* controllers
until 2.6.25 or so.  Now we have it a release early, for all but SAS.

Cheers
