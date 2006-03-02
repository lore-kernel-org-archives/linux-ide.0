From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: FUA and 311x (was Re: LibPATA code issues / 2.6.15.4)
Date: Thu, 02 Mar 2006 11:37:46 -0500
Message-ID: <44071F5A.6050104@pobox.com>
References: <1141239617.23202.5.camel@rousalka.dyndns.org>	    <4405F471.8000602@rtr.ca>	    <1141254762.11543.10.camel@rousalka.dyndns.org>    <311601c90603011719k43af0fbbg889f47d798e22839@mail.gmail.com>    <440650BC.5090501@pobox.com> <4406512A.9080708@pobox.com> <65320.192.54.193.25.1141315183.squirrel@rousalka.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:57024 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751078AbWCBQh7 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 2 Mar 2006 11:37:59 -0500
In-Reply-To: <65320.192.54.193.25.1141315183.squirrel@rousalka.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Nicolas Mailhot <nicolas.mailhot@laposte.net>
Cc: Jens Axboe <axboe@suse.de>, "Eric D. Mudama" <edmudama@gmail.com>, Tejun Heo <htejun@gmail.com>, Nicolas Mailhot <nicolas.mailhot@gmail.com>, Mark Lord <liml@rtr.ca>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Carlos Pardo <carlos.pardo@siliconimage.com>

Nicolas Mailhot wrote:
> The controller in the bugzilla entry ie a SiI 3114.
> It was a quick fix and I did expect more thorough investigation later
> (probably 2.6.17 frame). Though it seems FUA-related problems are so
> numerous FUA itself will be blacklisted for 2.6.16, so the limited
> blacklist is no longer needed.

Well, we're looking for a long term solution :)

Disabling FUA by default in 2.6.16 is a temporary solution.

	Jeff


