From: Mark Lord <liml@rtr.ca>
Subject: Re: LibPATA code issues / 2.6.15.4
Date: Mon, 27 Feb 2006 23:16:41 -0500
Message-ID: <4403CEA9.4080603@rtr.ca>
References: <Pine.LNX.4.64.0602140439580.3567@p34> <43F2050B.8020006@dgreaves.com> <Pine.LNX.4.64.0602141211350.10793@p34> <200602141300.37118.lkml@rtr.ca> <440040B4.8030808@dgreaves.com> <440083B4.3030307@rtr.ca> <Pine.LNX.4.64.0602251244070.20297@p34> <4400A1BF.7020109@rtr.ca> <4400B439.8050202@dgreaves.com> <4401122A.3010908@rtr.ca> <44017B4B.3030900@dgreaves.com> <4401B560.40702@rtr.ca> <4403704E.4090109@rtr.ca> <4403A84C.6010804@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([64.26.128.89]:32168 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S1750737AbWB1EQn (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 27 Feb 2006 23:16:43 -0500
In-Reply-To: <4403A84C.6010804@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>, David Greaves <david@dgreaves.com>
Cc: Mark Lord <lkml@rtr.ca>, Jeff Garzik <jgarzik@pobox.com>, Justin Piszcz <jpiszcz@lucidpixels.com>, linux-kernel@vger.kernel.org, IDE/ATA development list <linux-ide@vger.kernel.org>, albertcc@tw.ibm.com, axboe@suse.de, Linus Torvalds <torvalds@osdl.org>

Tejun Heo wrote:
..
>> These may be unsafe in general, unless we tag controllers as
>> FUA-capable and NON-FUA-capable, in addition to tagging the drives.
> 
> All sii controllers and piix/ahci seem to handle FUA pretty ok. And 
> yeah, we may have to create controller blacklist too.

Or maybe a whitelist instead, since nearly all existing hardware
pre-dates FUA commands.

Or maybe just have a libata function to test whether the FUA commands
actually work or not, before enabling them for general use.
*That* could be a much better approach, given the large number of
possible drive/controller combos, and it cuts down on the maintenance
headache of having to list everything on a list somewhere.

> BTW, can you let me know what drive we're talking about now (model name 
> and firmware revision)?

David:  we need to see the output from "hdparm --Istdout /dev/sda
(or whichever drive it was that was failing on your system).

Cheers
