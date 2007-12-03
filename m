From: Hein-Pieter van Braam <hp@syntomax.com>
Subject: Re: [PATCH] sata_mv:  Fix broken Marvell 7042 support.
Date: Mon, 03 Dec 2007 23:28:31 +0100
Message-ID: <1196720911.6362.14.camel@liza>
References: <4751A2DA.6030403@rtr.ca>
	 <BD261180E6D35F4D9D32F3E44FD3D9010ADF2E30@EMPBEDEX.empirix.com>
	 <20071203154749.6lah7pulw8ow0s84@email.syntomax.com>
	 <47543C58.4040106@rtr.ca> <475447A0.2010101@rtr.ca>
	 <47544B3C.2010901@rtr.ca> <1196712661.6362.5.camel@liza>
	 <475465F7.7050705@rtr.ca> <1196714235.6362.9.camel@liza>
	 <47546CF6.30301@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from a80-126-0-120.adsl.xs4all.nl ([80.126.0.120]:43904 "EHLO
	ifolder.erca.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751103AbXLCWis (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 3 Dec 2007 17:38:48 -0500
In-Reply-To: <47546CF6.30301@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: "Morrison, Tom" <tmorrison@empirix.com>, IDE/ATA development list <linux-ide@vger.kernel.org>, Jeff Garzik <jgarzik@pobox.com>, Tejun Heo <htejun@gmail.com>, Alan Cox <alan@redhat.com>


> Man, what a quirky BIOS!
> 
> Okay, so if I connect a drive and don't do anything in the Highpoint BIOS setup,
> it then corrupts the drive by overwriting the 9th sector on every reboot.
> 
> But.. if I connect a drive and go into the Highpoint BIOS setup,
> and "initialize" the drive there, and then set it all as a "JBOD volume",
> it then leaves the drive content untouched on subsequent reboots.
> 
> Screwy to the max.
> 
> So, I might be able to boot from it by cloning the disk *after* setting
> it to "JBOD" in the BIOS.  That will take a (longish) while to do.

I've just managed to boot with PXE and 2.6.23.9 and I have come to the
following:

* softraid still works
* sata_mv is a bit slower than the proprietary highpoint drivers (I get
300MB/s from my array rather than 400MB/s)
* they array works
* the content of the array seems to have shifted 'down' a bit, that's
probably why it won't boot. 

it's a tad weird, but I can see the data just fine when I dump the
content of the drives, but it seems to be in the wrong place.

I'll recreate my volumes with sata_mv now, see if it will work like
this.




-- 
This message has been scanned for viruses and
dangerous content by MailScanner, and is
believed to be clean.

