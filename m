From: Mark Lord <liml@rtr.ca>
Subject: Re: [PATCH] sata_mv:  Fix broken Marvell 7042 support.
Date: Mon, 03 Dec 2007 19:23:39 -0500
Message-ID: <47549E0B.9070509@rtr.ca>
References: <4751A2DA.6030403@rtr.ca>	 <BD261180E6D35F4D9D32F3E44FD3D9010ADF2E30@EMPBEDEX.empirix.com>	 <20071203154749.6lah7pulw8ow0s84@email.syntomax.com>	 <47543C58.4040106@rtr.ca> <475447A0.2010101@rtr.ca>	 <47544B3C.2010901@rtr.ca> <1196712661.6362.5.camel@liza>	 <475465F7.7050705@rtr.ca> <1196714235.6362.9.camel@liza>	 <47546CF6.30301@rtr.ca> <1196722124.6362.17.camel@liza>	 <20071203231057.39ae9b71@the-village.bc.nu> <1196726490.6362.21.camel@liza>	 <47549A26.6080900@rtr.ca> <1196727475.6362.27.camel@liza>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:1745 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750818AbXLDAXl (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 3 Dec 2007 19:23:41 -0500
In-Reply-To: <1196727475.6362.27.camel@liza>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Hein-Pieter van Braam <hp@syntomax.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, "Morrison, Tom" <tmorrison@empirix.com>, IDE/ATA development list <linux-ide@vger.kernel.org>, Jeff Garzik <jgarzik@pobox.com>, Tejun Heo <htejun@gmail.com>, Alan Cox <alan@redhat.com>

Hein-Pieter van Braam wrote:
..
> also: on a side note, let me state again, that I'm extremely displeased
> with highpoint at this point... their whole 'open source linux drivers'
> thing is beginning to piss me off more and more. There must be something
> that can be done about this? OSI perhaps?
..

Their stuff has always seemed more than a little screwy to me.

The solution for us here, is sata_mv, which will replace their drivers
for this series of boards.

But..  Wow!  a BIOS that just arbitrarily decides to overwrite a disk sector
when one connects some other drive to it, without ever even entering their
BIOS setup screen..   And apparently doesn't even need to, since it does NOT
seem to do the same thing to drives that are configured as JBOD within
their BIOS.

Ugh.

Cheers
