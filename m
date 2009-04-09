From: Mark Lord <liml@rtr.ca>
Subject: Re: [PROPOSED] ata: Report 16/32bit PIO as best we can
Date: Thu, 09 Apr 2009 09:02:35 -0400
Message-ID: <49DDF1EB.2060200@rtr.ca>
References: <20090409133221.18202.63779.stgit@t61.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:48506 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761677AbZDINCh (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 9 Apr 2009 09:02:37 -0400
In-Reply-To: <20090409133221.18202.63779.stgit@t61.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-ide@vger.kernel.org, jeff@garzik.org

Alan Cox wrote:
> Something like this then ?
> 
> 
> The legacy old IDE API for this is a bit primitive so we try and map stuff
> sensibly onto it.
> 
> - Add flags2 as we ran out of flags
> - Set PIO over DMA devices to report 32bit
> - Add ability to change the PIO32 settings if the controller permits it
> - Add that functionality into the sff drivers
> - Add that functionality into the VLB legacy driver
> - Turn on the 32bit PIO on the ninja32 and add support there
> 
> Signed-off-by: Alan Cox <alan@linux.intel.com>
..

By all means go ahead with something like this,
and thanks for doing it, Alan.

But.. these do look rather suspiciously like sysfs attrs to me.

We didn't have a sysfs in the IDE days (so Gadi added the klunky
procfs "settings" thing for there), but we do now.

I'm happy to update hdparm to check sysfs if that's where this
ends up, or to do almost nothing for it if we stick with the ioctls.

Thanks either way!
