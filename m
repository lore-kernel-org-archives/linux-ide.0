From: Mark Lord <liml@rtr.ca>
Subject: Re: [PATCH] sata_mv:  Fix broken Marvell 7042 support.
Date: Thu, 06 Dec 2007 17:23:05 -0500
Message-ID: <47587649.5030009@rtr.ca>
References: <4751A2DA.6030403@rtr.ca>	 <BD261180E6D35F4D9D32F3E44FD3D9010ADF2E30@EMPBEDEX.empirix.com>	 <20071203154749.6lah7pulw8ow0s84@email.syntomax.com>	 <47543C58.4040106@rtr.ca> <475447A0.2010101@rtr.ca>	 <47544B3C.2010901@rtr.ca> <1196712661.6362.5.camel@liza>	 <475465F7.7050705@rtr.ca> <1196714235.6362.9.camel@liza>	 <47546CF6.30301@rtr.ca> <1196722124.6362.17.camel@liza>	 <20071203231057.39ae9b71@the-village.bc.nu> <1196726490.6362.21.camel@liza>	 <47549A26.6080900@rtr.ca> <1196727475.6362.27.camel@liza>	 <47549E0B.9070509@rtr.ca> <1196812599.6909.10.camel@liza> <47572A18.2010904@rtr.ca> <475732C0.2090901@rtr.ca> <475735B4.7020401@rtr.ca> <47573A54.5000004@rtr.ca> <47573C16.7010704@pobox.com> <47577499.7000004@rtr.ca> <47577E0F.1030709@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:2392 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752205AbXLFWXH (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 6 Dec 2007 17:23:07 -0500
In-Reply-To: <47577E0F.1030709@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Hein-Pieter van Braam <hp@syntomax.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, "Morrison, Tom" <tmorrison@empirix.com>, IDE/ATA development list <linux-ide@vger.kernel.org>, Tejun Heo <htejun@gmail.com>, Alan Cox <alan@redhat.com>

Jeff Garzik wrote:
...
> If you pop the BIOS chip or plug the card into a non-x86 box (or any of 
> several other alternatives), the problem is likely to go away.
..

Yeah, I was hoping for a removable BIOS chip, but it's soldered in place.
And that's not a solution for most users anyway.

Cheers

