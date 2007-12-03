From: Mark Lord <liml@rtr.ca>
Subject: Re: [PATCH] sata_mv:  Fix broken Marvell 7042 support.
Date: Mon, 03 Dec 2007 15:24:23 -0500
Message-ID: <475465F7.7050705@rtr.ca>
References: <4751A2DA.6030403@rtr.ca>	 <BD261180E6D35F4D9D32F3E44FD3D9010ADF2E30@EMPBEDEX.empirix.com>	 <20071203154749.6lah7pulw8ow0s84@email.syntomax.com>	 <47543C58.4040106@rtr.ca> <475447A0.2010101@rtr.ca>	 <47544B3C.2010901@rtr.ca> <1196712661.6362.5.camel@liza>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:3090 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750740AbXLCUYZ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 3 Dec 2007 15:24:25 -0500
In-Reply-To: <1196712661.6362.5.camel@liza>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Hein-Pieter van Braam <hp@syntomax.com>
Cc: "Morrison, Tom" <tmorrison@empirix.com>, IDE/ATA development list <linux-ide@vger.kernel.org>, Jeff Garzik <jgarzik@pobox.com>, Tejun Heo <htejun@gmail.com>, Alan Cox <alan@redhat.com>

Hein-Pieter van Braam wrote:
>
> Personally, I put all the disks in JBOD mode, but I never had these
> disks connected to anything but my highpoint cards. Perhaps I should
> tell you what my setup's like:
> 
> * In the system I've put 3 Highpoint RocketRaid 2300 cards.
> * Two of the cards each have 4 Hitachi 750GB disks
> * Each disk is put into JBOD mode in the 'Raid' Bios of the 2300
> * On the drives I have 2 partitions, one 200MB partition and a partition
> spanning the rest of the 750GB
> * Both partitions are linux softraid
> * /dev/md0 is a mirror of all 8 disks and serves as /boot (200MB)
> * /dev/md1 contains an LVM volume that houses my other paritions (4.7TB)
> 
> Right now with 2.6.23.9 + patched sata_mv the softraid seems to come up
> just fine but I pvscan is unable to locate the pv located on md1.
> 
> I'll try and make a bootable USB stick with my patched 2.6.23.9 and see
> what the results are then.
..

How are you booting without the USB stick?
Are you booting from the Highpoint card drives?
What bootloader ?

Thanks
