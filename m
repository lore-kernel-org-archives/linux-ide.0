From: Mark Lord <liml@rtr.ca>
Subject: Re: [PATCH] sata_mv:  Fix broken Marvell 7042 support.
Date: Mon, 03 Dec 2007 13:44:04 -0500
Message-ID: <47544E74.3000608@rtr.ca>
References: <4751A2DA.6030403@rtr.ca> <BD261180E6D35F4D9D32F3E44FD3D9010ADF2E30@EMPBEDEX.empirix.com> <20071203154749.6lah7pulw8ow0s84@email.syntomax.com> <47543C58.4040106@rtr.ca> <475447A0.2010101@rtr.ca> <47544B2F.5080007@pobox.com> <47544BAA.1020901@rtr.ca> <BD261180E6D35F4D9D32F3E44FD3D9010ADF35A5@EMPBEDEX.empirix.com> <47544DA9.3070702@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:1432 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751475AbXLCSoH (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 3 Dec 2007 13:44:07 -0500
In-Reply-To: <47544DA9.3070702@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Morrison, Tom" <tmorrison@empirix.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, hp@syntomax.com, IDE/ATA development list <linux-ide@vger.kernel.org>, Tejun Heo <htejun@gmail.com>, Alan Cox <alan@redhat.com>

Mark Lord wrote:
> Morrison, Tom wrote:
>> Fwiw, I'm not running an add-on card or anything like it - no raid - 
>> nothing except a 7042 chip as the the front-end to 2-4 harddrives in 
>> my box) - in this case - I am not having a problem...
>>
>> I write this as perhaps a hint to the 'right' direction to go
>> looking for the trouble...
> ..
> 
> Thanks Tom.
> 
> So we know we *can* boot from a bare 7042, which is good!
> 
> I've poked a little more at this here, and I *think* the
> BIOS is overwriting the 9th sector on the drive.
> 
> I'll test that theory a little more.
..

Confirmed.  It writes "lgcy" + stuff into the 9th sector of the drive
(for my "Legacy" drive).

Where does Linux softraid put it's stuff ?

And Hein-Pieter:  what are you using for a bootloader ?

> Any GRUB experts out there?  How do I get GRUB to install
> the stage2 stuff on a partition, instead of in the first 63 sectors ?
..

Technically, I suppose it's the stage 1.5 stuff that's getting nuked.
Or something like that.
