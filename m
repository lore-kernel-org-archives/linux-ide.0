From: Mark Lord <liml@rtr.ca>
Subject: Re: [PATCH] sata_mv:  Fix broken Marvell 7042 support.
Date: Mon, 03 Dec 2007 20:17:39 -0500
Message-ID: <4754AAB3.6070902@rtr.ca>
References: <4751A2DA.6030403@rtr.ca>	<BD261180E6D35F4D9D32F3E44FD3D9010ADF2E30@EMPBEDEX.empirix.com> <20071203154749.6lah7pulw8ow0s84@email.syntomax.com> <47543C58.4040106@rtr.ca> <475447A0.2010101@rtr.ca> <47544B3C.2010901@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:4343 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750806AbXLDBRl (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 3 Dec 2007 20:17:41 -0500
In-Reply-To: <47544B3C.2010901@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: hp@syntomax.com
Cc: "Morrison, Tom" <tmorrison@empirix.com>, IDE/ATA development list <linux-ide@vger.kernel.org>, Jeff Garzik <jgarzik@pobox.com>, Tejun Heo <htejun@gmail.com>, Alan Cox <alan@redhat.com>

Mark Lord wrote:
>
> So to boot from a 7042 the only theoretical choice is the Highpoint board,
> and for that we need to somehow coax it into not overwriting GRUB
> every time the onboard BIOS reinitializes.
..

With the drive set-up as a "JBOD volume" in the HighPoint BIOS,
I've now got a system that boots/runs from a single drive
attached to the HighPoint 2300 PCIe board (Marvell 7042 - sata_mv).

So that much works, which is good!

I also then upgraded the card's BIOS from v1.0 to v2.2,
and didn't notice anything different.

Cheers
