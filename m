From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 1/2] [IDE] Platform IDE driver (was: MMIO IDE driver)
Date: Thu, 26 Jul 2007 00:01:27 +0400
Message-ID: <46A7AC17.9060309@ru.mvista.com>
References: <20070725165318.5331.23795.stgit@localhost.localdomain> <Pine.LNX.4.60.0707252130090.6234@poirot.grange> <46A7A8FB.5090909@ru.mvista.com> <Pine.LNX.4.60.0707252150540.6234@poirot.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.155]:26158 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750822AbXGYT70 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 25 Jul 2007 15:59:26 -0400
In-Reply-To: <Pine.LNX.4.60.0707252150540.6234@poirot.grange>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: Vitaly Bordug <vitb@kernel.crashing.org>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org

Guennadi Liakhovetski wrote:

>>>>This is now very similar to pata_platform.c, they both use
>>>>same platform data structure and same resources.

>>>>To achieve that, byte_lanes_swapping platform data variable
>>>>and platform specified iops removed from that driver. It's fine,
>>>>since those were never used anyway.

>>>>pata_platform and ide_platform are carrying same driver names,
>>>>to easily switch between these drivers, without need to touch
>>>>platform code.

>>>Why? There's a drivers/ide/arm/ide_arm.c IDe driver that some platforms (not
>>>in the mainline) hack to access, e.g., CF cards in true-IDE mode. About a
>>>month ago I submitted a patch to arm-linux-kernel switching that 

>>   Wrong list to submit sych stuff, post to linux-ide.

> Not entirely. The patch (or other patches in the series) would also touch 
> ARM platforms in the mainline, currently using that driver. As I didn't 

    Was worth cross-posting to linux-ide anyway to get the IDE experts' 
feedback. ;-)

> have a chance to test them due to lack of hardware, I posted on arm, 
> asking if anyone would test those platforms for me.

   ... and they laughed at you? ;-)

>>>driver to using platform-device. I got a reply, that it's not worth it now
>>>that IDE is slowly becoming obsolete, and the pata_platform serves the
>>>perpose perfectly well. I found this argument reasonable, I had the same

>>   Ignore such replies in the future. ;-)

> It was largely in accordance with my own opinion, so, I chose to accept 
> it:-)

    It's not clear why you decided to waste time on it then. :-)

>>>doubt, just wanted to double-check. So, why do we now need a new legacy
>>>(a/drivers/ide/legacy/ide_platform.c) driver when a "modern" driver exists?

>>   Good question (I know the answer but won't tell ;-).

> You've been very cooperative, thanks.

    In fact, I also highly doubt that we need it.  What we'd need is an OF driver.

> Thanks
> Guennadi

WBR, Sergei
