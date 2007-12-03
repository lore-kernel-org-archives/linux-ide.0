From: Hein-Pieter van Braam <hp@syntomax.com>
Subject: Re: [PATCH] sata_mv:  Fix broken Marvell 7042 support.
Date: Mon, 03 Dec 2007 21:37:15 +0100
Message-ID: <1196714235.6362.9.camel@liza>
References: <4751A2DA.6030403@rtr.ca>
	 <BD261180E6D35F4D9D32F3E44FD3D9010ADF2E30@EMPBEDEX.empirix.com>
	 <20071203154749.6lah7pulw8ow0s84@email.syntomax.com>
	 <47543C58.4040106@rtr.ca> <475447A0.2010101@rtr.ca>
	 <47544B3C.2010901@rtr.ca> <1196712661.6362.5.camel@liza>
	 <475465F7.7050705@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from a80-126-0-120.adsl.xs4all.nl ([80.126.0.120]:42685 "EHLO
	ifolder.erca.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750733AbXLCUjs (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 3 Dec 2007 15:39:48 -0500
In-Reply-To: <475465F7.7050705@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: "Morrison, Tom" <tmorrison@empirix.com>, IDE/ATA development list <linux-ide@vger.kernel.org>, Jeff Garzik <jgarzik@pobox.com>, Tejun Heo <htejun@gmail.com>, Alan Cox <alan@redhat.com>

> 
> > I'll try and make a bootable USB stick with my patched 2.6.23.9 and see
> > what the results are then.
> ..
> 
> How are you booting without the USB stick?
> Are you booting from the Highpoint card drives?
> What bootloader ?
> 
> Thanks
> -

Right now I just boot using GRUB really, perhaps the BIOS hides the 9th 
sector if it's in some form of RAID mode? I haven't had any trouble
using GRUB...

I haven't done anything special apart from putting the drives in JBOD
mode, each disk is set to JBOD, it's set per disk, so not one large JBOD
over 8 disks, but 8 separate JBOD volumes.

Hope that helps...


-- 
This message has been scanned for viruses and
dangerous content by MailScanner, and is
believed to be clean.

