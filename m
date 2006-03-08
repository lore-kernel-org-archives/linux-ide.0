From: Mark Lord <liml@rtr.ca>
Subject: Re: LibPATA code issues / 2.6.15.4
Date: Tue, 07 Mar 2006 21:57:07 -0500
Message-ID: <440E4803.7070808@rtr.ca>
References: <Pine.LNX.4.64.0602140439580.3567@p34> <43F2050B.8020006@dgreaves.com> <Pine.LNX.4.64.0602141211350.10793@p34> <200602141300.37118.lkml@rtr.ca> <440040B4.8030808@dgreaves.com> <440083B4.3030307@rtr.ca> <Pine.LNX.4.64.0602251244070.20297@p34> <4400A1BF.7020109@rtr.ca> <4400B439.8050202@dgreaves.com> <4401122A.3010908@rtr.ca> <44017B4B.3030900@dgreaves.com> <4401B560.40702@rtr.ca> <4403704E.4090109@rtr.ca> <4403A84C.6010804@gmail.com> <4403CEA9.4080603@rtr.ca> <44042863.2050703@dgreaves.com> <44046013.7070503@rtr.ca> <4404BAD6.3060009@tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([64.26.128.89]:35970 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S932378AbWCHC5N (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 7 Mar 2006 21:57:13 -0500
In-Reply-To: <4404BAD6.3060009@tmr.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bill Davidsen <davidsen@tmr.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org, IDE/ATA development list <linux-ide@vger.kernel.org>, axboe@suse.de, albertcc@tw.ibm.com

Bill Davidsen wrote:
>
> Is there a version of that which will build on x86? I grabbed the 
> version offered at freshmeat, but it won't compile on any x86 distro or 
> gcc version to which I have access. RH8, RH9, FC1, FC3, FC4, ubuntu... 
> with or without using the suggested alternate header.

hdparm-6.5 is the current version now.  Both it, and 6.4,
build/install/run cleanly on Ubunutu-5.10, Debian-Sarge,
and SLES9-SP3.

You seem to be having trouble on only Redhat distros..
I guess they've done something unfriendly again.

Care to be more specific about what Redhat is doing?

Cheers
