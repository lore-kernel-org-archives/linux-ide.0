From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] sata_mv:  Fix broken Marvell 7042 support.
Date: Wed, 05 Dec 2007 19:02:30 -0500
Message-ID: <47573C16.7010704@pobox.com>
References: <4751A2DA.6030403@rtr.ca>	 <BD261180E6D35F4D9D32F3E44FD3D9010ADF2E30@EMPBEDEX.empirix.com>	 <20071203154749.6lah7pulw8ow0s84@email.syntomax.com>	 <47543C58.4040106@rtr.ca> <475447A0.2010101@rtr.ca>	 <47544B3C.2010901@rtr.ca> <1196712661.6362.5.camel@liza>	 <475465F7.7050705@rtr.ca> <1196714235.6362.9.camel@liza>	 <47546CF6.30301@rtr.ca> <1196722124.6362.17.camel@liza>	 <20071203231057.39ae9b71@the-village.bc.nu> <1196726490.6362.21.camel@liza>	 <47549A26.6080900@rtr.ca> <1196727475.6362.27.camel@liza>	 <47549E0B.9070509@rtr.ca> <1196812599.6909.10.camel@liza> <47572A18.2010904@rtr.ca> <475732C0.2090901@rtr.ca> <475735B4.7020401@rtr.ca> <47573A54.5000004@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:59471 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754553AbXLFACx (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 5 Dec 2007 19:02:53 -0500
In-Reply-To: <47573A54.5000004@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Hein-Pieter van Braam <hp@syntomax.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, "Morrison, Tom" <tmorrison@empirix.com>, IDE/ATA development list <linux-ide@vger.kernel.org>, Tejun Heo <htejun@gmail.com>, Alan Cox <alan@redhat.com>

Mark Lord wrote:
> To do so, requires that we perhaps do a similar capacity truncation
> in sata_mv, but only if we see a metadata block at the expected location
> (because a "Legacy" mode drive will use the *real* capacity,
> placing the metadata in the 9th sector instead.

Definitely _not_.  This is a core Linux maxim:  export what the hardware 
exports, no more no less.  We drive the "bare metal."

OTOH it is quite reasonable to explore auto-loading DM on top of the 
bare drive, and populating a DM table, if you see that particular BIOS 
signature or [insert other detection method].

	Jeff


