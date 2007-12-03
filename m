From: "Morrison, Tom" <tmorrison@empirix.com>
Subject: RE: [PATCH] sata_mv:  Fix broken Marvell 7042 support.
Date: Mon, 3 Dec 2007 13:37:10 -0500
Message-ID: <BD261180E6D35F4D9D32F3E44FD3D9010ADF35A5@EMPBEDEX.empirix.com>
References: <4751A2DA.6030403@rtr.ca> <BD261180E6D35F4D9D32F3E44FD3D9010ADF2E30@EMPBEDEX.empirix.com> <20071203154749.6lah7pulw8ow0s84@email.syntomax.com> <47543C58.4040106@rtr.ca> <475447A0.2010101@rtr.ca> <47544B2F.5080007@pobox.com> <47544BAA.1020901@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from empbedex1.empirix.com ([12.38.203.54]:11042 "EHLO
	empbedex1.empirix.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750969AbXLCShT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 3 Dec 2007 13:37:19 -0500
Content-class: urn:content-classes:message
In-Reply-To: <47544BAA.1020901@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>, Jeff Garzik <jgarzik@pobox.com>
Cc: hp@syntomax.com, IDE/ATA development list <linux-ide@vger.kernel.org>, Tejun Heo <htejun@gmail.com>, Alan Cox <alan@redhat.com>

Fwiw, I'm not running an add-on card or anything like it - 
no raid - nothing except a 7042 chip as the the front-end 
to 2-4 harddrives in my box) - in this case - I am not 
having a problem...

I write this as perhaps a hint to the 'right' direction to go
looking for the trouble...

all the best~!

-----Original Message-----
From: Mark Lord [mailto:liml@rtr.ca] 
Sent: Monday, December 03, 2007 1:32 PM
To: Jeff Garzik
Cc: hp@syntomax.com; Morrison, Tom; IDE/ATA development list; Tejun Heo;
Alan Cox
Subject: Re: [PATCH] sata_mv: Fix broken Marvell 7042 support.

Jeff Garzik wrote:
> Mark Lord wrote:
>> The BIOS on the Highpoint RR 2300 *corrupts* the GRUB image,
>> so GRUB won't boot for me there.  I actually have to re-install
>> GRUB after each attempt so that the drive is usable again
>> with the onboard Intel (ahci) ports.
>>
>> So one then wonders exactly what the Highpoint BIOS is overwriting,
> 
> RAID metadata, one would assume from the 'RR'...
> 
> I've no idea if the standard solution is applicable to HPT RR: going 
> through BIOS setup and turning off RAID completely, or if not
possible, 
> putting it into JBOD mode.
..

It's an add-on PCIe board, with it's own onboard "RAID management" BIOS.
The onboard BIOS has the drive labelled as "Legacy", but it still seems
to insist upon writing it's meta data at every startup.

So to boot from it, we may need to find a way to keep our bootloader
away from those same sector(s).

Cheers
