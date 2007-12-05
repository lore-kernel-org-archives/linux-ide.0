From: Mark Lord <liml@rtr.ca>
Subject: Re: [PATCH] sata_mv:  Fix broken Marvell 7042 support.
Date: Wed, 05 Dec 2007 18:55:00 -0500
Message-ID: <47573A54.5000004@rtr.ca>
References: <4751A2DA.6030403@rtr.ca>	 <BD261180E6D35F4D9D32F3E44FD3D9010ADF2E30@EMPBEDEX.empirix.com>	 <20071203154749.6lah7pulw8ow0s84@email.syntomax.com>	 <47543C58.4040106@rtr.ca> <475447A0.2010101@rtr.ca>	 <47544B3C.2010901@rtr.ca> <1196712661.6362.5.camel@liza>	 <475465F7.7050705@rtr.ca> <1196714235.6362.9.camel@liza>	 <47546CF6.30301@rtr.ca> <1196722124.6362.17.camel@liza>	 <20071203231057.39ae9b71@the-village.bc.nu> <1196726490.6362.21.camel@liza>	 <47549A26.6080900@rtr.ca> <1196727475.6362.27.camel@liza>	 <47549E0B.9070509@rtr.ca> <1196812599.6909.10.camel@liza> <47572A18.2010904@rtr.ca> <475732C0.2090901@rtr.ca> <475735B4.7020401@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:1494 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751239AbXLEXzB (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 5 Dec 2007 18:55:01 -0500
In-Reply-To: <475735B4.7020401@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Hein-Pieter van Braam <hp@syntomax.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, "Morrison, Tom" <tmorrison@empirix.com>, IDE/ATA development list <linux-ide@vger.kernel.org>, Tejun Heo <htejun@gmail.com>, Alan Cox <alan@redhat.com>

Mark Lord wrote:
>...
>>> Yeah, that's my suspicion too.. they must have just simply moved
>>> the metadata to near the end instead of sector-8.
...
>> They write their RAID metadata near-ish to the end of the drive.
>> On my 320GB drives, it ended up at about -199853 sectors from
>> the end of the drive.  I have no idea what logic leads to them
>> choosing such a peculiar location for it.
> ..
> 
> Correction:  Metadata begins at sector -191192 on my drive.
...

Okay, I figured it out.

The final sector on the drive is at 625142448,
which in hex is sector 0x2542eab0.

The metadata on this drive is at sector 624951296,
which in hex is sector 0x25400000.

Note that this corresponds to a nice round giga-byte value.

So their RAID BIOS is just truncating the drive capacity down
to an even gigabyte, and then putting the metadata right after that.

I don't know what they might do with a drive whose capacity
is exactly some gigabyte value, though --> probably they just
subtract a gigabyte from that, to make room for the metadata.

So..  I do want to make this board usable under Linux.

To do so, requires that we perhaps do a similar capacity truncation
in sata_mv, but only if we see a metadata block at the expected location
(because a "Legacy" mode drive will use the *real* capacity,
placing the metadata in the 9th sector instead.

Jeff / Tejun / Alan:

What do you think we (I) should do here?

0. Initially, we need to further beef-up the recently added boot-time warning
about data-loss.   Again, the BIOS will have *already* written metadata to
the drive before we ever get to warn about it.  We cannot prevent it,
but we should at least warn the user about this absurdity.
It would also be useful to print the max "usable" capacity as part
of this warning (based on the calculation below).

Now we have a choice as to what else to do:

1.  Just clip the drive capacity similar to how the BIOS does it.

   clipped_sectors = ((physical_sectors - 1) & ~0x0000000fffff);

OR:

2. Check for the Highpoint BIOS signature at the metadata sector first,
and only clip capacity if we see their signature there.

OR:

3. Don't clip, but printk() WARNINGs whenever a write is performed
to data beyond the theoretical clipped capacity.

OR:

4. Something better (?).

?????????????????????
