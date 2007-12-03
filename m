From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] sata_mv:  Fix broken Marvell 7042 support.
Date: Mon, 3 Dec 2007 23:10:57 +0000
Message-ID: <20071203231057.39ae9b71@the-village.bc.nu>
References: <4751A2DA.6030403@rtr.ca>
	<BD261180E6D35F4D9D32F3E44FD3D9010ADF2E30@EMPBEDEX.empirix.com>
	<20071203154749.6lah7pulw8ow0s84@email.syntomax.com>
	<47543C58.4040106@rtr.ca>
	<475447A0.2010101@rtr.ca>
	<47544B3C.2010901@rtr.ca>
	<1196712661.6362.5.camel@liza>
	<475465F7.7050705@rtr.ca>
	<1196714235.6362.9.camel@liza>
	<47546CF6.30301@rtr.ca>
	<1196722124.6362.17.camel@liza>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:37454 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750824AbXLCXQ1 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 3 Dec 2007 18:16:27 -0500
In-Reply-To: <1196722124.6362.17.camel@liza>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Hein-Pieter van Braam <hp@syntomax.com>
Cc: Mark Lord <liml@rtr.ca>, "Morrison, Tom" <tmorrison@empirix.com>, IDE/ATA development list <linux-ide@vger.kernel.org>, Jeff Garzik <jgarzik@pobox.com>, Tejun Heo <htejun@gmail.com>, Alan Cox <alan@redhat.com>

On Mon, 03 Dec 2007 23:48:44 +0100
Hein-Pieter van Braam <hp@syntomax.com> wrote:

> > Man, what a quirky BIOS!
> 
> Hum... I can pvcreate on the md device just fine, but after that, pvscan
> won't find it... 
> 
> I have a suspicion that there's a BIOS doing some sector hiding or
> replacement of sorts... 
> 
> *facepalm*

That would make sense. However we have weapons to make it surrender. See
the "dmraid" tool - you should be able to use that as an example of how
to set up device mapper mapped linear mappings to "unshift" partitions.

Alan
