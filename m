From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH #upstream-fixes] sata_nv: disable ADMA mode by default
Date: Thu, 10 Jan 2008 00:58:14 -0500
Message-ID: <4785B3F6.4000802@garzik.org>
References: <4781F008.9070404@gmail.com> <4782422C.8020202@rtr.ca> <478246AE.3020500@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:33500 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750785AbYAJF6U (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 10 Jan 2008 00:58:20 -0500
In-Reply-To: <478246AE.3020500@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Mark Lord <liml@rtr.ca>, Robert Hancock <hancockr@shaw.ca>, IDE/ATA development list <linux-ide@vger.kernel.org>, Allen Martin <AMartin@nvidia.com>, Peer Chen <pchen@nvidia.com>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>

Tejun Heo wrote:
> There still are remaining issues with ADMA support.  Disable it by
> default and warn when enabling.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> ---
> Jeff, please hold off till Robert acks.  Robert, what do you think?
> 
>  drivers/ata/sata_nv.c |    5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)

Don't worry, I won't "pull the trigger" immediately and without a lot of 
discussion.  (and please help keep nvidia cc'd on changes to sata_nv)

Current sleepless (thus discountable? :)) thoughts:

* definitely leaning towards adma=0 default.  if distros are disabling 
it, and upstream is not, that's a big hint :)

* By switching to the tried-and-true legacy-IDE-like interface, adma=0 
seems to make a lot of problems go away.

* It is so late in 2.6.24-rc, it seems unlikely that we have enough time 
for testing such a major, fundamental behavior change in sata_nv, this 
late in the game.

If it weren't for the time factor, I would be in favor of applying the 
patch and getting test results.

Overall, while I do have docs under NDA (the only one in the world 
outside of NV?), they are pretty bare bones.  And the ADMA interface, 
while found on many thousands of NV chips, was only one rev -- CK804 -- 
and is no longer being used.  NV uses AHCI now.

I think ADMA is an experiment that failed, in both the software sense 
and the hardware sense.  The effort Robert has put into the ADMA code, 
fixing many bugs (I think I have a fix from him still to be applied, 
during my absence) is frankly amazing given the limits, but IMO ADMA is 
just "not there."

If docs were available and NV actively supported the ADMA mode, things 
would probably be different, but they aren't.

	Jeff


