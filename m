From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] sata_mv:  Fix broken Marvell 7042 support.
Date: Thu, 06 Dec 2007 21:22:39 -0500
Message-ID: <4758AE6F.9060205@pobox.com>
References: <4751A2DA.6030403@rtr.ca>	 <BD261180E6D35F4D9D32F3E44FD3D9010ADF2E30@EMPBEDEX.empirix.com>	 <20071203154749.6lah7pulw8ow0s84@email.syntomax.com>	 <47543C58.4040106@rtr.ca> <475447A0.2010101@rtr.ca>	 <47544B3C.2010901@rtr.ca> <1196712661.6362.5.camel@liza>	 <475465F7.7050705@rtr.ca> <1196714235.6362.9.camel@liza>	 <47546CF6.30301@rtr.ca> <1196722124.6362.17.camel@liza>	 <20071203231057.39ae9b71@the-village.bc.nu> <1196726490.6362.21.camel@liza>	 <47549A26.6080900@rtr.ca> <1196727475.6362.27.camel@liza>	 <47549E0B.9070509@rtr.ca> <1196812599.6909.10.camel@liza> <47572A18.2010904@rtr.ca> <475732C0.2090901@rtr.ca> <475735B4.7020401@rtr.ca> <47573A54.5000004@rtr.ca> <47573C16.7010704@pobox.com> <47577499.7000004@rtr.ca> <47577E0F.1030709@pobox.com> <47587649.5030009@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:35633 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753129AbXLGCW6 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 6 Dec 2007 21:22:58 -0500
In-Reply-To: <47587649.5030009@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Hein-Pieter van Braam <hp@syntomax.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, "Morrison, Tom" <tmorrison@empirix.com>, IDE/ATA development list <linux-ide@vger.kernel.org>, Tejun Heo <htejun@gmail.com>, Alan Cox <alan@redhat.com>

Mark Lord wrote:
> Jeff Garzik wrote:
> ...
>> If you pop the BIOS chip or plug the card into a non-x86 box (or any 
>> of several other alternatives), the problem is likely to go away.
> ..

> Yeah, I was hoping for a removable BIOS chip, but it's soldered in place.
> And that's not a solution for most users anyway.

That was an example, silly :)  I'm not asking users to pop out chips. 
I'm illustrating that they are separate and distinct pieces, and you 
cannot assume.

Boot into a non-x86 platform, or use your x86 BIOS to disable all 
optional ROMs, and the BIOS-stomps-data issue goes away.

I'm not saying the _problem_ goes away; instead I am illustrating why it 
is incorrect to update sata_mv for this problem.  The solution belongs 
elsewhere, because the problem is not with the chip, but the BIOS.

Continuing with the other emails...

> What other cards do we support that automatically overwrite user data
> without confirmation or notice of any kind? 

If you use any vendor RAID (BIOS RAID / "fake RAID"), and fail to use 
DM+dmraid, then data corruption occurs due to lack of knowledge about 
the presence of underlying BIOS-created RAID metadata.

Your case is just another case of problems caused by lack of knowledge 
of the underlying vendor RAID that the BIOS insists upon using.

I'm pretty sure the most recently Fedora release has full dmraid support 
for known formats, so AFAICS the task at hand should be simply to figure 
out how to identify the underlying vendor RAID (on-disk signatures are 
greatly preferred over PCI ID matching), and update dmraid accordingly.

Welcome to the suck that is BIOS RAID :)

	Jeff


