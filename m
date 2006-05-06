From: Leon Woestenberg <leonw@mailcan.com>
Subject: Re: [smartmontools-support]Re: LibPATA code issues / 2.6.16
	(previously, 2.6.15.x)
Date: Sat, 06 May 2006 17:09:12 +0200
Message-ID: <1146928152.2611.18.camel@dhcppc7>
References: <Pine.LNX.4.64.0602140439580.3567@p34>
	 <200602141300.37118.lkml@rtr.ca> <440040B4.8030808@dgreaves.com>
	 <440083B4.3030307@rtr.ca> <Pine.LNX.4.64.0602251244070.20297@p34>
	 <4400A1BF.7020109@rtr.ca> <4400B439.8050202@dgreaves.com>
	 <4401122A.3010908@rtr.ca> <44017B4B.3030900@dgreaves.com>
	 <4401B560.40702@rtr.ca> <4403704E.4090109@rtr.ca>
	 <4403A84C.6010804@gmail.com> <4403CEA9.4080603@rtr.ca>
	 <44042863.2050703@dgreaves.com> <44046CE6.60803@rtr.ca>
	 <44046D86.7050809@pobox.com> <4405DCAF.6030500@dgreaves.com>
	 <4405DDEA.7020309@rtr.ca> <4405E42B.9040804@dgreaves.com>
	 <4405E83D.9000906@rtr.ca> <4405EC94.2030202@dgreaves.com>
	 <4405FAAE.3080705@dgreaves.com> <Pine.LNX.4.64.0603050637110.30164@p34>
	 <Pine.LNX.4.64.0603050740500.3116@p34> <440B6CFE.4010503@rtr.ca>
	 <440B76B4.5080502@pobox.com> <Pine.LNX.4.64.0604211511120.22768@p34>
	 <44493023.4010109@pobox.com> <Pine.LNX.4.64.0604211226120.3701@g5.osdl.org>
	 <444960CC.2000009@pobox.com> <Pine.LNX.4.64.0604211704120.3701@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:11200 "EHLO
	out1.smtp.messagingengine.com") by vger.kernel.org with ESMTP
	id S1750830AbWEFPJU (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 6 May 2006 11:09:20 -0400
In-Reply-To: <Pine.LNX.4.64.0604211704120.3701@g5.osdl.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Linus Torvalds <torvalds@osdl.org>, smartmontools-support@lists.sourceforge.net
Cc: Jeff Garzik <jgarzik@pobox.com>, Justin Piszcz <jpiszcz@lucidpixels.com>, Mark Lord <lkml@rtr.ca>, David Greaves <david@dgreaves.com>, Tejun Heo <htejun@gmail.com>, linux-kernel@vger.kernel.org, IDE/ATA development list <linux-ide@vger.kernel.org>, albertcc@tw.ibm.com, axboe@suse.de

Hi all,

On Fri, 2006-04-21 at 17:05 -0700, Linus Torvalds wrote:
> 
> On Fri, 21 Apr 2006, Jeff Garzik wrote:
> 
> > 
> > Agreed, though the original poster had already done a 400GB dd from
> > /dev/zero...
> 
> Yes, but to a _file_ on the partition (ie he didn't overwrite any existign 
> data, just the empty parts of a filesystem).
> 
> I realize that it's not enough for the "re-allocate on write" behaviour, 
> and for that you really _do_ need to re-write the whole disk to get all 
> the broken blocks reallocated, but my argument was just that we should 
> make sure to _tell_ people when they are overwriting all their old data ;)
> 
I did not realize this before, and asked badblocks maintainer Theodore
if badblocks /some/file was supported (the man page says no); but of
course any filesystem can decide to re-allocate blocks for a file.

However, for large files where parts may be bad sectors, I am still
searching for a way to read, then re-write every physical sector
occupied by the file. 

With the purpose to remap the bad sectors inside large MPEG files (where
I would rather have a few zeroed holes than a read error in them).

Anyone know such tooling exists? I suspect it has to use filesystem
specific IOCTL's to query for the blocks involved.

Regards,

Leon

