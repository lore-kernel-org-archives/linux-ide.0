From: Mark Lord <liml@rtr.ca>
Subject: Re: [PATCH] sata_mv:  Fix broken Marvell 7042 support.
Date: Mon, 03 Dec 2007 18:47:08 -0500
Message-ID: <4754957C.3040406@rtr.ca>
References: <4751A2DA.6030403@rtr.ca>	<BD261180E6D35F4D9D32F3E44FD3D9010ADF2E30@EMPBEDEX.empirix.com>	<20071203154749.6lah7pulw8ow0s84@email.syntomax.com>	<47543C58.4040106@rtr.ca>	<475447A0.2010101@rtr.ca>	<47544B3C.2010901@rtr.ca>	<1196712661.6362.5.camel@liza>	<475465F7.7050705@rtr.ca>	<1196714235.6362.9.camel@liza>	<47546CF6.30301@rtr.ca>	<1196722124.6362.17.camel@liza> <20071203231057.39ae9b71@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:4249 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751502AbXLCXrL (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 3 Dec 2007 18:47:11 -0500
In-Reply-To: <20071203231057.39ae9b71@the-village.bc.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Hein-Pieter van Braam <hp@syntomax.com>, "Morrison, Tom" <tmorrison@empirix.com>, IDE/ATA development list <linux-ide@vger.kernel.org>, Jeff Garzik <jgarzik@pobox.com>, Tejun Heo <htejun@gmail.com>, Alan Cox <alan@redhat.com>

Alan Cox wrote:
> On Mon, 03 Dec 2007 23:48:44 +0100
> Hein-Pieter van Braam <hp@syntomax.com> wrote:
> 
>>> Man, what a quirky BIOS!
>> Hum... I can pvcreate on the md device just fine, but after that, pvscan
>> won't find it... 
>>
>> I have a suspicion that there's a BIOS doing some sector hiding or
>> replacement of sorts... 
..

Alan, what do we currently do (or not) with regards to HPAs in libata?
