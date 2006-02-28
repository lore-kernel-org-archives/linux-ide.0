From: Mark Lord <liml@rtr.ca>
Subject: Re: LibPATA code issues / 2.6.15.4
Date: Mon, 27 Feb 2006 23:11:56 -0500
Message-ID: <4403CD8C.1080603@rtr.ca>
References: <Pine.LNX.4.64.0602140439580.3567@p34> <43F2050B.8020006@dgreaves.com> <Pine.LNX.4.64.0602141211350.10793@p34> <200602141300.37118.lkml@rtr.ca> <440040B4.8030808@dgreaves.com> <440083B4.3030307@rtr.ca> <Pine.LNX.4.64.0602251244070.20297@p34> <4400A1BF.7020109@rtr.ca> <4400B439.8050202@dgreaves.com> <4401122A.3010908@rtr.ca> <44017B4B.3030900@dgreaves.com> <4401B560.40702@rtr.ca> <4403704E.4090109@rtr.ca> <4403A84C.6010804@gmail.com> <Pine.LNX.4.64.0602271744470.22647@g5.osdl.org> <4403B04F.5090405@pobox.com> <Pine.LNX.4.64.0602271813120.22647@g5.osdl.org> <4403C546.7030702@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([64.26.128.89]:54683 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S1751816AbWB1EL6 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 27 Feb 2006 23:11:58 -0500
In-Reply-To: <4403C546.7030702@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Tejun Heo <htejun@gmail.com>, David Greaves <david@dgreaves.com>, Justin Piszcz <jpiszcz@lucidpixels.com>, linux-kernel@vger.kernel.org, IDE/ATA development list <linux-ide@vger.kernel.org>, albertcc@tw.ibm.com, axboe@suse.de

Jeff Garzik wrote:
> Linus Torvalds wrote:
..
>> I really hate having a _global_ variable called "fua". That's just bad 
>> taste. I would suggest calling it "atapi_forced_unit_attention_enabled"

Heh heh..
It's actually short for "Force Unit Access",
though oddly enough I don't think the patch
mentions that in the MODULE_PARM_DESC().

> Here's the cleaner namespace version...

David, do you want to ack this one for us?

Cheers

