From: Jason Keltz <jas@cse.yorku.ca>
Subject: Re: ide cdrom problems on new imac
Date: Fri, 6 Jun 2008 21:48:15 -0400 (EDT)
Message-ID: <Pine.LNX.4.63.0806062141280.29139@indigo.cs.yorku.ca>
References: <484970DC.3060209@cse.yorku.ca> <20080606214947.06e19074@core>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from bronze.cs.yorku.ca ([130.63.90.34]:55670 "EHLO
	bronze.cs.yorku.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753871AbYFGBsR (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 6 Jun 2008 21:48:17 -0400
In-Reply-To: <20080606214947.06e19074@core>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org

On Fri, 6 Jun 2008, Alan Cox wrote:

>> It isn't clear to me whether the device is recognized by libata
>> ata_piix, or just by a separate kernel IDE Intel PIIX driver?
>
> One slot by each - CD by old IDE  disk by libata in the dump you gave

When you say "old IDE", can you expand on this one for me.  I'm trying to 
learn as I go along.  This is the old Linux IDE driver with support of an 
Intel PIIX module?  If I understand it correctly, why would RedHat then 
update the PIIX module to support later versions of the Intel chipsets, if 
this can't work properly with the older version of the kernel?

>
>> [<c025d0ae>] (ide_intr+0x0/0x11e)
>> Disabling IRQ #185
>
> and old IDE broke

The strange part is, IDE seems to "work" -- I can mount a CD and read from 
it.  I tried a "cdrecord blank=fast", and it seemed to hang.

> No kernel that old supports the needed workarounds for the ICH behaviour
> change. Intel changed the ICH behaviour on IRQ handling in the later
> chips in some configurations that are mostly used on the mac.
>
> The SATA backport in Centos 4.x doesn't include the needed changes nor
> does the IDE layer. Ditto I believe 5.x.

Yes, as far as I can tell 5.x doesn't do it either.  I guess I have to 
wait for CentOS 6, or go with a distribution like Ubuntu that uses a more 
up to date kernel as a start.

> You need to use the current IRQ clearing logic for both drivers - the old
> logic only clears the ata status register on PIO events, the newer one
> clears both the ata and DMA status to work around the Intel funny.

And I guess it wouldn't be easy for me to make these changes, especially 
without much kernel hacking knowledge?

> [By a strict reading of the spec the Intel behaviour does appear allowed,
> although I hope Intel didn't intend it ...]

Has anyone tried to contact Intel to see their response? They seem to be 
interested in supporting Linux.  I don't know why they would make a change 
that would break things unless there is some valid reasoning behind it. 
Of course I've had many problems with Intel and Linux in the past, and 
when the average consumer approaches them about a problem like this, the 
problem isn't likely to be dealt with.

Thanks for your response. I really appreciate it.

It looks like I'll be able to support the imacs with the older O/S with 
several known "issues". :)

Jas.
