From: Mark Lord <liml@rtr.ca>
Subject: Re: Port Multiplier drives not always all found on cold plug
Date: Sat, 17 May 2008 13:32:27 -0400
Message-ID: <482F16AB.1040003@rtr.ca>
References: <482DB79F.2030204@rtr.ca> <482DBA62.4020209@rtr.ca> <482DBC5C.3020904@rtr.ca> <482DC41F.9080901@rtr.ca> <482DCD1F.4090503@rtr.ca> <482EE9E1.5000805@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:3195 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753238AbYEQRc3 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 17 May 2008 13:32:29 -0400
In-Reply-To: <482EE9E1.5000805@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, Alan Cox <alan@redhat.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

Tejun Heo wrote:
>
> I've been studying things for last two days and discovered a number of 
> things.  I'll soon post patch series.  Thanks a lot for digging into PMP 
> stuff.  It's great to have someone else's eyes on this stuff.
..

Yeah.  It really does help when two or more people totally independently
implement a driver on top of something like that.  For the most part,
this stuff seems to be working rather well, though.  Good job!

Gwendal has been complaining to me about undetected drives on PMP
with sata_mv.  My patchset to fix much of that will be posted here shortly.

But apparently, even with those fixes, he *still* has troubles,
though not as bad as before.  I'm trying to get a nice annotated trace
from him so we can debug that further -- could be due to some of the
stuff you are looking at too, I suppose.

Cheers

Mark

