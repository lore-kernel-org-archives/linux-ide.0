From: Mark Lord <liml@rtr.ca>
Subject: Re: [PATCH] sata_mv:  Fix broken Marvell 7042 support.
Date: Mon, 03 Dec 2007 18:37:03 -0500
Message-ID: <4754931F.7080705@rtr.ca>
References: <4751A2DA.6030403@rtr.ca>	 <BD261180E6D35F4D9D32F3E44FD3D9010ADF2E30@EMPBEDEX.empirix.com>	 <20071203154749.6lah7pulw8ow0s84@email.syntomax.com>	 <47543C58.4040106@rtr.ca> <475447A0.2010101@rtr.ca>	 <47544B3C.2010901@rtr.ca> <1196712661.6362.5.camel@liza>	 <475465F7.7050705@rtr.ca> <1196714235.6362.9.camel@liza>	 <47546CF6.30301@rtr.ca> <1196720911.6362.14.camel@liza>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:1617 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752295AbXLCXhF (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 3 Dec 2007 18:37:05 -0500
In-Reply-To: <1196720911.6362.14.camel@liza>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Hein-Pieter van Braam <hp@syntomax.com>
Cc: "Morrison, Tom" <tmorrison@empirix.com>, IDE/ATA development list <linux-ide@vger.kernel.org>, Jeff Garzik <jgarzik@pobox.com>, Tejun Heo <htejun@gmail.com>, Alan Cox <alan@redhat.com>

Hein-Pieter van Braam wrote:
>> Man, what a quirky BIOS!
>>
>> Okay, so if I connect a drive and don't do anything in the Highpoint BIOS setup,
>> it then corrupts the drive by overwriting the 9th sector on every reboot.
>>
>> But.. if I connect a drive and go into the Highpoint BIOS setup,
>> and "initialize" the drive there, and then set it all as a "JBOD volume",
>> it then leaves the drive content untouched on subsequent reboots.
>>
>> Screwy to the max.
>>
>> So, I might be able to boot from it by cloning the disk *after* setting
>> it to "JBOD" in the BIOS.  That will take a (longish) while to do.
> 
> I've just managed to boot with PXE and 2.6.23.9 and I have come to the
> following:
> 
> * softraid still works
> * sata_mv is a bit slower than the proprietary highpoint drivers (I get
> 300MB/s from my array rather than 400MB/s)
..

No worries.
That performance number will eventually come up as we develop sata_mv more.

NCQ and IRQ-coalescing together oughta do it.  They're "on the list".

> * they array works
> * the content of the array seems to have shifted 'down' a bit, that's
> probably why it won't boot. 
..

Shifted "down" which way, I wonder... ?
Maybe they're using a Host Protected Area, which would explain why I don't
see them modifying the 9th sector after "initializing" (WTF?) my drive as
a JBOD using their BIOS.

What does "hdparm -g /dev/sd*" show with their driver and with our driver?

