From: Mark Lord <liml@rtr.ca>
Subject: Re: [PATCH] sata_mv:  Fix broken Marvell 7042 support.
Date: Mon, 03 Dec 2007 19:07:02 -0500
Message-ID: <47549A26.6080900@rtr.ca>
References: <4751A2DA.6030403@rtr.ca>	 <BD261180E6D35F4D9D32F3E44FD3D9010ADF2E30@EMPBEDEX.empirix.com>	 <20071203154749.6lah7pulw8ow0s84@email.syntomax.com>	 <47543C58.4040106@rtr.ca> <475447A0.2010101@rtr.ca>	 <47544B3C.2010901@rtr.ca> <1196712661.6362.5.camel@liza>	 <475465F7.7050705@rtr.ca> <1196714235.6362.9.camel@liza>	 <47546CF6.30301@rtr.ca> <1196722124.6362.17.camel@liza>	 <20071203231057.39ae9b71@the-village.bc.nu> <1196726490.6362.21.camel@liza>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:2419 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751033AbXLDAHE (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 3 Dec 2007 19:07:04 -0500
In-Reply-To: <1196726490.6362.21.camel@liza>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Hein-Pieter van Braam <hp@syntomax.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, "Morrison, Tom" <tmorrison@empirix.com>, IDE/ATA development list <linux-ide@vger.kernel.org>, Jeff Garzik <jgarzik@pobox.com>, Tejun Heo <htejun@gmail.com>, Alan Cox <alan@redhat.com>

Hein-Pieter van Braam wrote:
>
> I did some testing:
> First I zero'd the first 80 meg of the md device, then read it back and
> compared, still all zero's. Then I rebooted and compared again, still
> all zero's
> 
> Then I got 8MB of stuff from /dev/urandom, wrote it to a file then wrote
> it to md device, read it back into a separate file, they still matched.
> I rebooted and read it back for a third time, and they still matched.
> 
> I'm not sure if this means anything or not, but I was wondering if my
> assertion of BIOS muckery still made sense 
..

I haven't seen any evidence of it here, either,
so long as BIOS "JBOD volumes" are used.

So I don't have any explanation for your data "moving around"
when you switched drivers, unless *their* driver remaps things
at run-time.

Or were you switching drivers across those reboots (likely, I suppose)?
