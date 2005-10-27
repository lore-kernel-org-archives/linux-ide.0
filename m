From: Mark Lord <liml@rtr.ca>
Subject: Re: [PATCH/RFC] SCSI mid-layer suspend/resume
Date: Wed, 26 Oct 2005 23:35:48 -0400
Message-ID: <43604B14.7080903@rtr.ca>
References: <20051024160531.7d879a7c.randy_d_dunlap@linux.intel.com>	<435D6E47.1030409@pobox.com> <20051025142529.7b23bbc0.randy_d_dunlap@linux.intel.com> <435EA5AB.9010805@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cpu1185.adsl.bellglobal.com ([207.236.110.166]:26242 "EHLO
	mail.rtr.ca") by vger.kernel.org with ESMTP id S964958AbVJ0Dft
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 26 Oct 2005 23:35:49 -0400
In-Reply-To: <435EA5AB.9010805@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Randy Dunlap <randy_d_dunlap@linux.intel.com>, linux-scsi@vger.kernel.org, linux-ide@vger.kernel.org, axboe@suse.de, hch@lst.de

Jeff Garzik wrote:
>
> We have emperical evidence that Jens' patch works on SATA, so see if the 
> two patches can meet in the middle somewhere?

And just to muddy the waters somewhat..

I have an extra hard drive caddy for my Dell notebook,
with a different 2.5" drive mounted in it.

When using THAT drive, my machine cannot resume successully
from suspend-to-RAM.  Hangs with the hard drive light on solid
some of the time, and not on other times.
Drove me crazy figuring this out, but I eventually tried a
different drive and it worked fine.

So.. not all drives work for me.

Now, the drive that doesn't work with suspend/resume (RAM)
happens to claim to support Advanced Power Management.
Except that "hdparm -Bxx" has zero effect on it -- cannot enable
it or modify the setting in anyway.

My other drives also have the APM feature, and have it turned *on*,
and "hdparm -Bxx" can be used to turn it on/off and modify the setting.

Very weird, possibly not related to the resume failures.  Or maybe.

Cheers
