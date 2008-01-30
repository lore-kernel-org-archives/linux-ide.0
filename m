From: rgheck <rgheck@bobjweil.com>
Subject: Re: Problem with ata layer in 2.6.24
Date: Tue, 29 Jan 2008 19:19:33 -0500
Message-ID: <479FC295.7060301@bobjweil.com>
References: <200801272122.21823.gene.heskett@gmail.com> <200801291204.44671.gene.heskett@gmail.com> <20080129185445.1c7d3a83@core> <200801291741.50192.gene.heskett@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from qmta08.emeryville.ca.mail.comcast.net ([76.96.30.80]:33382 "EHLO
	QMTA08.emeryville.ca.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752723AbYA3ATg (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 29 Jan 2008 19:19:36 -0500
In-Reply-To: <200801291741.50192.gene.heskett@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Gene Heskett <gene.heskett@gmail.com>, Linux IDE mailing list <linux-ide@vger.kernel.org>


Gene,

If you still want to try it, I did manage to get the old IDE subsystem 
working. The issue with pata_amd concerns modprobe.conf. You probably 
have an alias to it there, as Fedora seems to insert these. (I don't 
know if they're actually needed or not.) If you comment out that line, 
then mkinitrd will run successfully, and you can try it that way.

By the way, is there an easy way to use different modprobe.conf files 
with different kernels?

Do make sure that you're building whatever drivers you need for your 
particular IDE chipset. (This is under IDE chipset support.) I suppose 
it's safe to build them all as modules. You may also want to compile 
ide-scsi (SCSI emulation support), as some older CD drives seem to need 
this, in the form of an "hdx=ide-scsi" command line option.

Richard

Gene Heskett wrote:
> On Tuesday 29 January 2008, Alan Cox wrote:
>   
>>> That could stand to be moved or renamed, it is well buried in the menu for
>>> the REAL scsi stuffs, which I don't have any of.
>>>       
>> Yes you do - USB storage and ATAPI are SCSI
>>     
>
> By the linux software definition maybe.  But I've defined scsi as that which 
> uses a 50 wire cable using 50 contact centronics connectors since the 
> mid '70's, and which often needs a ready supply of nubile virgins to 
> sacrifice to make it work, particularly with the old resistor pack 
> terminations & psu's whose 5 volt line is only 4.85 volts due to old age.  
> That's what I call REAL scsi.  Its also a REAL PITA if the terms aren't 
> active.
>
> You can call what you are doing 'scsi' because you are using much the same 
> command structure, and that is good, but its not the real thing with all its 
> hardware warts and/or capabilities.  For one thing, this version usually 
> works. :)
>
> Furinstance, you can tell 2 scsi devices on the same controller to talk to 
> each other, moving files from one to the other, and the host controller can 
> then goto sleep & the cpu isn't involved until the devices send it a wakeup 
> to advise the controller that the transfer has been done, and the controller 
> may or may not then interrupt and advise the cpu.  You can do that with 
> separate controllers too as long as they have a compatible DMA channel 
> available to both.
>
> I doubt libata has that capability now, or ever will, cuz these ide/atapi 
> devices are generally dumber than rocks about that.  But any device claiming 
> to be scsi-II is supposed to be able to do those sorts of things while the 
> cpu is off crunching numbers for BOINC or whatever.
>
> But that puts my mild objections to classifying this as 'scsi' in a more 
> understandable context.  :-)
>
>   

