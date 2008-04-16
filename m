From: Mark Lord <liml@rtr.ca>
Subject: Re: sata_mv & pmp support
Date: Wed, 16 Apr 2008 08:43:18 -0400
Message-ID: <4805F466.2040500@rtr.ca>
References: <47FA4AFF.2010209@gmail.com> <4803C429.6070201@rtr.ca>	 <4803C850.9010901@rtr.ca> <48040DC8.1050907@gmail.com>	 <48050904.1040808@rtr.ca> <48050CA1.5010800@rtr.ca>	 <48052E08.5040306@gmail.com> <480531DB.3020602@rtr.ca>	 <48055E7C.1060004@rtr.ca> <48056016.6020900@gmail.com> <e7510f760804160005p4590f272pe6bd07836e4a5beb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:2265 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757785AbYDPMnT (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 16 Apr 2008 08:43:19 -0400
In-Reply-To: <e7510f760804160005p4590f272pe6bd07836e4a5beb@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Gwendal Grignou <gwendal@google.com>
Cc: Tejun Heo <htejun@gmail.com>, Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>

Gwendal Grignou wrote:
> At reset time, according to the SATA state machine in SATA spec
> [16.3.3.5.1] A PM waits for a FIS from the host to port 0xF to be
> fully initialized. If for any reason the PM does not issue PHYRDY fast
> enough or other problem the host decide there is no device on the
> port, it will not issue a FIS, and the PM will never be seen.
..

Yes, nothing special there -- libata does all of that (and more).


> A PM will not send asynchronous notification for itself, only to devices
> connected to it [and the host controller must be able to handle it].
> 
> Maybe polling SATA port could help?
..

That's what Tejun meant by a "hotplug even afterwards".
Except he was referring to the hotplug mechanism in the host side
chipset/driver, which is based on PHYRDY, not on any form of AN from the PM.

So the issue is likely that we simply will need hotplug support
in sata_mv before this specific unplug/replug Sil PM works.

No big deal, then -- IRQ/EH/hotplug patches are next in the pipeline
for sata_mv, later this week if all goes well.

Cheers



