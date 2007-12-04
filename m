From: Hein-Pieter van Braam <hp@syntomax.com>
Subject: Re: [PATCH] sata_mv:  Fix broken Marvell 7042 support.
Date: Tue, 04 Dec 2007 01:17:55 +0100
Message-ID: <1196727475.6362.27.camel@liza>
References: <4751A2DA.6030403@rtr.ca>
	 <BD261180E6D35F4D9D32F3E44FD3D9010ADF2E30@EMPBEDEX.empirix.com>
	 <20071203154749.6lah7pulw8ow0s84@email.syntomax.com>
	 <47543C58.4040106@rtr.ca> <475447A0.2010101@rtr.ca>
	 <47544B3C.2010901@rtr.ca> <1196712661.6362.5.camel@liza>
	 <475465F7.7050705@rtr.ca> <1196714235.6362.9.camel@liza>
	 <47546CF6.30301@rtr.ca> <1196722124.6362.17.camel@liza>
	 <20071203231057.39ae9b71@the-village.bc.nu> <1196726490.6362.21.camel@liza>
	 <47549A26.6080900@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from a80-126-0-120.adsl.xs4all.nl ([80.126.0.120]:45014 "EHLO
	ifolder.erca.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750808AbXLDATU (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 3 Dec 2007 19:19:20 -0500
In-Reply-To: <47549A26.6080900@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, "Morrison, Tom" <tmorrison@empirix.com>, IDE/ATA development list <linux-ide@vger.kernel.org>, Jeff Garzik <jgarzik@pobox.com>, Tejun Heo <htejun@gmail.com>, Alan Cox <alan@redhat.com>


> I haven't seen any evidence of it here, either,
> so long as BIOS "JBOD volumes" are used.
> 
> So I don't have any explanation for your data "moving around"
> when you switched drivers, unless *their* driver remaps things
> at run-time.
> 
> Or were you switching drivers across those reboots (likely, I suppose)?
> -

No, I wasn't, I still have to try that, but I nuked my filesystem, so I
have to rebuild my kernel... over NFS this time since I don't have any
filesystem modules anymore, so things are slow... it's been building for
an hour now.

I'll come up with the hdparm -g output and the results of this test with
the two different drivers tomorrow. 

also: on a side note, let me state again, that I'm extremely displeased
with highpoint at this point... their whole 'open source linux drivers'
thing is beginning to piss me off more and more. There must be something
that can be done about this? OSI perhaps?


-- 
This message has been scanned for viruses and
dangerous content by MailScanner, and is
believed to be clean.

