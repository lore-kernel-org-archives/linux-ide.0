From: "Morrison, Tom" <tmorrison@empirix.com>
Subject: RE: [PATCH] sata_nv: fix ADMA ATAPI issues with memory over 4GB (v3)
Date: Fri, 23 Nov 2007 13:47:01 -0500
Message-ID: <BD261180E6D35F4D9D32F3E44FD3D901053E8543@EMPBEDEX.empirix.com>
References: <47463534.9010100@shaw.ca> <4746F02D.2060204@rtr.ca> <BD261180E6D35F4D9D32F3E44FD3D901053E8542@EMPBEDEX.empirix.com> <474711FE.8040805@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from empbedex1.empirix.com ([12.38.203.54]:17752 "EHLO
	empbedex1.empirix.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752205AbXKWSrI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 23 Nov 2007 13:47:08 -0500
Content-class: urn:content-classes:message
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Robert Hancock <hancockr@shaw.ca>, linux-kernel <linux-kernel@vger.kernel.org>, ide <linux-ide@vger.kernel.org>, Jeff Garzik <jeff@garzik.org>, Tejun Heo <htejun@gmail.com>

Yes, I believe that - otherwise, this problem would have
been a crisis a LONG time ago...:-)
 
But I do have some more questions in relationship to how 
things are mapped in your environment. I have a flat memory 
map (i.e.: the full 0x0 -- 0x1_0000_0000 is passed to the 32bit 
Linux kernel without any 'holes' and/or reserved areas).
 
Does your Intel memory map have this same type of flat memory 
model (and thus allow use of the FULL lower 4Gig) - or does it 
reserve areas of lower 4Gig for devices and such - if not - where 
are these reserved areas - and how do the relate to the I/O memory
map for the device?
 
In other words, I would be very interested in seeing the memory 
map & the PCI memory mapping to see if any overlap/correspond 
to reserve areas of lower 4 Gig (in a linux 32bit mode)...
 
Tom

________________________________

From: Mark Lord [mailto:liml@rtr.ca]
Sent: Fri 11/23/2007 12:46 PM
To: Morrison, Tom
Cc: Robert Hancock; linux-kernel; ide; Jeff Garzik; Tejun Heo
Subject: Re: [PATCH] sata_nv: fix ADMA ATAPI issues with memory over 4GB (v3)



Morrison, Tom wrote:
> I am hopeful that the sata_mv has this bug (I proved that the
> problem I was experiencing was due to the sata_mv driver
> with 3.75Gig or more of memory)...
> 
> I am on vacation for a week or more ...or I'd tell you today
> if it did have this bug!
..

Yeah, I kind of had your reports in mind when I asked that.  :)

On a related note, I now have lots of Marvell (sata_mv) hardware here,
and an Intel CPU/chipset box with physical RAM above the 4GB boundary.

Cheers


