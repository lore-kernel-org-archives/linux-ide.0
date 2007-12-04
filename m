From: Hein-Pieter van Braam <hp@syntomax.com>
Subject: Re: [PATCH] sata_mv:  Fix broken Marvell 7042 support.
Date: Tue, 04 Dec 2007 01:01:30 +0100
Message-ID: <1196726490.6362.21.camel@liza>
References: <4751A2DA.6030403@rtr.ca>
	 <BD261180E6D35F4D9D32F3E44FD3D9010ADF2E30@EMPBEDEX.empirix.com>
	 <20071203154749.6lah7pulw8ow0s84@email.syntomax.com>
	 <47543C58.4040106@rtr.ca> <475447A0.2010101@rtr.ca>
	 <47544B3C.2010901@rtr.ca> <1196712661.6362.5.camel@liza>
	 <475465F7.7050705@rtr.ca> <1196714235.6362.9.camel@liza>
	 <47546CF6.30301@rtr.ca> <1196722124.6362.17.camel@liza>
	 <20071203231057.39ae9b71@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from a80-126-0-120.adsl.xs4all.nl ([80.126.0.120]:44792 "EHLO
	ifolder.erca.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751008AbXLDADV (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 3 Dec 2007 19:03:21 -0500
In-Reply-To: <20071203231057.39ae9b71@the-village.bc.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Mark Lord <liml@rtr.ca>, "Morrison, Tom" <tmorrison@empirix.com>, IDE/ATA development list <linux-ide@vger.kernel.org>, Jeff Garzik <jgarzik@pobox.com>, Tejun Heo <htejun@gmail.com>, Alan Cox <alan@redhat.com>

On Mon, 2007-12-03 at 23:10 +0000, Alan Cox wrote:
> On Mon, 03 Dec 2007 23:48:44 +0100
> Hein-Pieter van Braam <hp@syntomax.com> wrote:
> 
> > > Man, what a quirky BIOS!
> > 
> > Hum... I can pvcreate on the md device just fine, but after that, pvscan
> > won't find it... 
> > 
> > I have a suspicion that there's a BIOS doing some sector hiding or
> > replacement of sorts... 
> > 
> > *facepalm*
> 
> That would make sense. However we have weapons to make it surrender. See
> the "dmraid" tool - you should be able to use that as an example of how
> to set up device mapper mapped linear mappings to "unshift" partitions.
> 
> Alan

I did some testing:
First I zero'd the first 80 meg of the md device, then read it back and
compared, still all zero's. Then I rebooted and compared again, still
all zero's

Then I got 8MB of stuff from /dev/urandom, wrote it to a file then wrote
it to md device, read it back into a separate file, they still matched.
I rebooted and read it back for a third time, and they still matched.

I'm not sure if this means anything or not, but I was wondering if my
assertion of BIOS muckery still made sense 

HP


-- 
This message has been scanned for viruses and
dangerous content by MailScanner, and is
believed to be clean.

