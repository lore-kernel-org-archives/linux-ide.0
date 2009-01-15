From: Mark Lord <liml@rtr.ca>
Subject: Re: sata_mv: trial fix for lost NCQ interrupts
Date: Wed, 14 Jan 2009 21:53:51 -0500
Message-ID: <496EA53F.7000605@rtr.ca>
References: <496D04EB.3060803@rtr.ca> <496E53DD.6040408@gmail.com> <496E61E8.5010602@rtr.ca> <496E72D7.2070206@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:47892 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753472AbZAOCxy (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 14 Jan 2009 21:53:54 -0500
In-Reply-To: <496E72D7.2070206@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Harri Olin <harri.olin@gmail.com>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>, Brian Rademacher <rad@radfiles.net>, Eamonn Hamilton <EAMONN.HAMILTON@saic.com>

Harri Olin wrote:
>..
> After first 55 minutes of testing, no timeouts yet, so I'm quite sure it 
> works ok now (yay!). Without this patch, timeouts happened every couple 
> minutes on similar load. I think I'll let it run for a day and report 
> back tomorrow how things are by then.
..

Okay, we have a winner!
I just need to get the "okay" from Marvell,
and then I'll feed this patch for 2.6.29 and earlier -stable streams.

> Note that I didn't apply the previous patch as they don't apply on each 
> other. If needed, I can test it separately after running this for a while.
..

No need.  The earlier patch has no effect, other than speeding up your system
by a slight amount.  I'll submit that for upstream separately, along with a
fix for another "duh!" I noticed in the code.

In the meanwhile, you should keep the working patch (obviously)
in your kernels -- the same/similar patch will apply to earlier
kernels if needed.

Thanks to you and Brian for the legwork!
