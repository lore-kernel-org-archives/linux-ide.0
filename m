From: Gene Heskett <gene.heskett@gmail.com>
Subject: Re: Problem with ata layer in 2.6.24
Date: Tue, 29 Jan 2008 17:41:49 -0500
Message-ID: <200801291741.50192.gene.heskett@gmail.com>
References: <200801272122.21823.gene.heskett@gmail.com>
 <200801291204.44671.gene.heskett@gmail.com> <20080129185445.1c7d3a83@core>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from vms046pub.verizon.net ([206.46.252.46]:60882 "EHLO
	vms046pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754911AbYA2Wly (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 29 Jan 2008 17:41:54 -0500
In-reply-to: <20080129185445.1c7d3a83@core>
Content-disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Mikael Pettersson <mikpe@it.uu.se>, Richard Heck <rgheck@bobjweil.com>, Daniel Barkalow <barkalow@iabervon.org>, Zan Lynx <zlynx@acm.org>, Calvin Walton <calvin.walton@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux ide Mailing list <linux-ide@vger.kernel.org>

On Tuesday 29 January 2008, Alan Cox wrote:
>> That could stand to be moved or renamed, it is well buried in the menu for
>> the REAL scsi stuffs, which I don't have any of.
>
>Yes you do - USB storage and ATAPI are SCSI

By the linux software definition maybe.  But I've defined scsi as that which 
uses a 50 wire cable using 50 contact centronics connectors since the 
mid '70's, and which often needs a ready supply of nubile virgins to 
sacrifice to make it work, particularly with the old resistor pack 
terminations & psu's whose 5 volt line is only 4.85 volts due to old age.  
That's what I call REAL scsi.  Its also a REAL PITA if the terms aren't 
active.

You can call what you are doing 'scsi' because you are using much the same 
command structure, and that is good, but its not the real thing with all its 
hardware warts and/or capabilities.  For one thing, this version usually 
works. :)

Furinstance, you can tell 2 scsi devices on the same controller to talk to 
each other, moving files from one to the other, and the host controller can 
then goto sleep & the cpu isn't involved until the devices send it a wakeup 
to advise the controller that the transfer has been done, and the controller 
may or may not then interrupt and advise the cpu.  You can do that with 
separate controllers too as long as they have a compatible DMA channel 
available to both.

I doubt libata has that capability now, or ever will, cuz these ide/atapi 
devices are generally dumber than rocks about that.  But any device claiming 
to be scsi-II is supposed to be able to do those sorts of things while the 
cpu is off crunching numbers for BOINC or whatever.

But that puts my mild objections to classifying this as 'scsi' in a more 
understandable context.  :-)

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
When some people decide it's time for everyone to make big changes,
it means that they want you to change first.
