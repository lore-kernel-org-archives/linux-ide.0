From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: ide cdrom problems on new imac
Date: Sat, 7 Jun 2008 11:01:32 +0100
Message-ID: <20080607110132.30ea73fc@core>
References: <484970DC.3060209@cse.yorku.ca>
	<20080606214947.06e19074@core>
	<Pine.LNX.4.63.0806062141280.29139@indigo.cs.yorku.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:55142 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755635AbYFGKRe (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 7 Jun 2008 06:17:34 -0400
In-Reply-To: <Pine.LNX.4.63.0806062141280.29139@indigo.cs.yorku.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jason Keltz <jas@cse.yorku.ca>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org

> When you say "old IDE", can you expand on this one for me.  I'm trying to 
> learn as I go along.  This is the old Linux IDE driver with support of an 
> Intel PIIX module?  If I understand it correctly, why would RedHat then 

drivers/ide is the old IDE driver which is pretty much for parallel ATA
(big cables) not serial ATA.

> update the PIIX module to support later versions of the Intel chipsets, if 
> this can't work properly with the older version of the kernel?

The bug only shows up on the Mac in specific cases so nobody discovered
it before then.

> Yes, as far as I can tell 5.x doesn't do it either.  I guess I have to 
> wait for CentOS 6, or go with a distribution like Ubuntu that uses a more 
> up to date kernel as a start.

Any distro which tracks recent kernels should work fine so Ubuntu,
Fedora etc. Centos/RHEL/etc backport minimal fixes to old kernels to keep
maximum stability. The Intel chipset bug might get fixed in an update in
future. but I couldn't say.

> > You need to use the current IRQ clearing logic for both drivers - the old
> > logic only clears the ata status register on PIO events, the newer one
> > clears both the ata and DMA status to work around the Intel funny.
> 
> And I guess it wouldn't be easy for me to make these changes, especially 
> without much kernel hacking knowledge?

It's not that big from what I remember, I don't know if Jeff has the
relevant patch to hand ?

> > [By a strict reading of the spec the Intel behaviour does appear allowed,
> > although I hope Intel didn't intend it ...]
> 
> Has anyone tried to contact Intel to see their response? 

I've not pursued it - even if it wasn't intentional it won't get fixed so
we need to support it and now do.

Alan
