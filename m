From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] libata-core More robust parsing for multi_count(v5)
Date: Sat, 21 Mar 2009 08:14:37 +0900
Message-ID: <49C4235D.5070303@kernel.org>
References: <49C1047D.4000008@rtr.ca>	<49C11A0C.3070502@rtr.ca>	<49C11ED4.2030307@rtr.ca>	<49C19087.5000307@gmail.com>	<49C190F1.7010202@kernel.org>	<49C28133.8050401@rtr.ca>	<49C281A5.5080404@rtr.ca>	<49C2D642.90706@kernel.org>	<49C39690.6090802@rtr.ca>	<49C396CF.7030202@rtr.ca> <20090320140714.2e7770d0@lxorguk.ukuu.org.uk> <49C3B7E9.2000505@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:35797 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754768AbZCTXOR (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 20 Mar 2009 19:14:17 -0400
In-Reply-To: <49C3B7E9.2000505@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Jeff Garzik <jgarzik@pobox.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

Hello, Mark.

Mark Lord wrote:
> Alan Cox wrote:
>>> Oh, and zero means "don't care".  So it's really easy to add
>>> to libata without having to patch each and every driver.
>>
>> If its only one driver why not do it the way we do things like transfer
>> length limits for LBA48 (see pata_it821x and others)
> ..
> 
> Thanks.  I'll do that, and probably go that way for the sata_mv limit.

Yeap, for the time being, that seems to be the simplest thing to do.

> The bigger issue here is that libata really doesn't support multiple mode.
> 
> Sure, it will blindly use it if the drive appears to be already configured
> for it at startup.  But I don't see any where that we issue "SET MULTIPLE"
> commands or otherwise support turning it on/off or tuning it.
> 
> I wonder if we even snoop the SET MULTIPLE command from SG_IO /
> ATA_{12,16}?
> 
> This is more of an infrastructure thing than a driver-specific setting,
> so I'm hoping that one of you three (who know the code a lot better
> than I do) might think about that for the future.

Right, libata doesn't have any multiple sector related configuration
whatsoever.  Maybe I'll give it a shot.

Thanks.

-- 
tejun
