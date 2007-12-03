From: Mark Lord <liml@rtr.ca>
Subject: Re: [PATCH] sata_mv:  Fix broken Marvell 7042 support.
Date: Mon, 03 Dec 2007 13:30:20 -0500
Message-ID: <47544B3C.2010901@rtr.ca>
References: <4751A2DA.6030403@rtr.ca>	<BD261180E6D35F4D9D32F3E44FD3D9010ADF2E30@EMPBEDEX.empirix.com> <20071203154749.6lah7pulw8ow0s84@email.syntomax.com> <47543C58.4040106@rtr.ca> <475447A0.2010101@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:3232 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751353AbXLCSaW (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 3 Dec 2007 13:30:22 -0500
In-Reply-To: <475447A0.2010101@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: hp@syntomax.com
Cc: "Morrison, Tom" <tmorrison@empirix.com>, IDE/ATA development list <linux-ide@vger.kernel.org>, Jeff Garzik <jgarzik@pobox.com>, Tejun Heo <htejun@gmail.com>, Alan Cox <alan@redhat.com>

Mark Lord wrote:
...

> Okay, I've attempted to boot from the RocketRAID 2300 card
> using a known-good boot hard disk.
> 
> No such luck.
> 
> The BIOS on the Highpoint RR 2300 *corrupts* the GRUB image,
> so GRUB won't boot for me there.  I actually have to re-install
> GRUB after each attempt so that the drive is usable again
> with the onboard Intel (ahci) ports.
> 
> So one then wonders exactly what the Highpoint BIOS is overwriting,
> and how that might affect your particular configuration..
> 
> ???
> 
> I'll try booting from another (non-Highpoint) 7042 board next.
> After I repair GRUB again, that is.
...

No joy.  My other 7042 and 6042 cards do not have bootable BIOSs.

So to boot from a 7042 the only theoretical choice is the Highpoint board,
and for that we need to somehow coax it into not overwriting GRUB
every time the onboard BIOS reinitializes.

Tricky to arrange, that.

How are you doing it ?
