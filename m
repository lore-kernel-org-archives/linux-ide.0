From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] sata_mv:  Fix broken Marvell 7042 support.
Date: Mon, 03 Dec 2007 13:30:07 -0500
Message-ID: <47544B2F.5080007@pobox.com>
References: <4751A2DA.6030403@rtr.ca> <BD261180E6D35F4D9D32F3E44FD3D9010ADF2E30@EMPBEDEX.empirix.com> <20071203154749.6lah7pulw8ow0s84@email.syntomax.com> <47543C58.4040106@rtr.ca> <475447A0.2010101@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:40129 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751334AbXLCSaS (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 3 Dec 2007 13:30:18 -0500
In-Reply-To: <475447A0.2010101@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: hp@syntomax.com, "Morrison, Tom" <tmorrison@empirix.com>, IDE/ATA development list <linux-ide@vger.kernel.org>, Tejun Heo <htejun@gmail.com>, Alan Cox <alan@redhat.com>

Mark Lord wrote:
> The BIOS on the Highpoint RR 2300 *corrupts* the GRUB image,
> so GRUB won't boot for me there.  I actually have to re-install
> GRUB after each attempt so that the drive is usable again
> with the onboard Intel (ahci) ports.
> 
> So one then wonders exactly what the Highpoint BIOS is overwriting,

RAID metadata, one would assume from the 'RR'...

I've no idea if the standard solution is applicable to HPT RR: going 
through BIOS setup and turning off RAID completely, or if not possible, 
putting it into JBOD mode.

	Jeff


