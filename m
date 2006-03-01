From: Mark Lord <lkml@rtr.ca>
Subject: Re: LibPATA code issues / 2.6.15.4
Date: Wed, 01 Mar 2006 12:46:18 -0500
Message-ID: <4405DDEA.7020309@rtr.ca>
References: <Pine.LNX.4.64.0602140439580.3567@p34> <43F2050B.8020006@dgreaves.com> <Pine.LNX.4.64.0602141211350.10793@p34> <200602141300.37118.lkml@rtr.ca> <440040B4.8030808@dgreaves.com> <440083B4.3030307@rtr.ca> <Pine.LNX.4.64.0602251244070.20297@p34> <4400A1BF.7020109@rtr.ca> <4400B439.8050202@dgreaves.com> <4401122A.3010908@rtr.ca> <44017B4B.3030900@dgreaves.com> <4401B560.40702@rtr.ca> <4403704E.4090109@rtr.ca> <4403A84C.6010804@gmail.com> <4403CEA9.4080603@rtr.ca> <44042863.2050703@dgreaves.com> <44046CE6.60803@rtr.ca> <44046D86.7050809@pobox.com> <4405DCAF.6030500@dgreaves.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([64.26.128.89]:42898 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S932155AbWCARqC (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 1 Mar 2006 12:46:02 -0500
In-Reply-To: <4405DCAF.6030500@dgreaves.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: David Greaves <david@dgreaves.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, Tejun Heo <htejun@gmail.com>, Justin Piszcz <jpiszcz@lucidpixels.com>, linux-kernel@vger.kernel.org, IDE/ATA development list <linux-ide@vger.kernel.org>, albertcc@tw.ibm.com, axboe@suse.de, Linus Torvalds <torvalds@osdl.org>

David Greaves wrote:
>
> I actually have 3 of those drives - one runs through sata_via and
> doesn't have the same problem.
> 
> (the sata_via ones *do* have :
>  ata3: status=0x50 { DriveReady SeekComplete }
>  ata3: PIO error
> problems with SMART)

And once again, not enough information in the error messages
for anyone to actually do anything about it (not David's fault).

What command do you use to get that bug to pop up?

BTW:
hdparm-6.5 is now available (sourceforge),
and should show all of the fancy features
of your drives for comparism between versions.

Cheers
