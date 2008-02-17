From: Mark Lord <liml@rtr.ca>
Subject: Re: ST31000340NS (1000G) Capacity equal 33MB issue.
Date: Sun, 17 Feb 2008 15:32:33 -0500
Message-ID: <47B899E1.7080903@rtr.ca>
References: <d0d565260802141013q61cb5e7fh7dcf04d7729213f7@mail.gmail.com>	 <d0d565260802141018y63a988bbpc6aecf771baacb84@mail.gmail.com>	 <47B499F2.1010306@rtr.ca> <47B5CC39.7020302@rtr.ca>	 <47B70571.4060303@rtr.ca>	 <d0d565260802170721r34ad933blabb3745691a6a3e9@mail.gmail.com>	 <47B88881.40003@rtr.ca> <87f94c370802171148y15dc3850pf1a679921e5f4de6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:1498 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751949AbYBQUcg (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 17 Feb 2008 15:32:36 -0500
In-Reply-To: <87f94c370802171148y15dc3850pf1a679921e5f4de6@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Greg Freemyer <greg.freemyer@gmail.com>
Cc: Richard Liu <richliu.tw@gmail.com>, linux-ide@vger.kernel.org

Greg Freemyer wrote:
>..
> Very cool new functionality in [hdparm] 8.1
> Looking forward to testing it this week.
> 
> Thanks for your efforts.
> 
> I assume DCO is still able to hide sectors from us?
..

I'm not sure (haven't tried it here yet).

But the way I read the ATA8 specification,
it sounds like "hdparm -N" should show the true capacity,
regardless of DCO.  But what's not clear, is whether one
can then use -Nnnnnnnn to restore the capacity under DCO..

Gotta try it someday, I guess.
