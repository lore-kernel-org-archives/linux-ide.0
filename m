From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] libata-core More robust parsing for multi_count(v5)
Date: Fri, 20 Mar 2009 20:54:18 -0400
Message-ID: <49C43ABA.4010601@pobox.com>
References: <49C1047D.4000008@rtr.ca>	<49C11A0C.3070502@rtr.ca> <49C11ED4.2030307@rtr.ca>	<49C19087.5000307@gmail.com> <49C190F1.7010202@kernel.org>	<49C28133.8050401@rtr.ca> <49C281A5.5080404@rtr.ca>	<49C2D642.90706@kernel.org> <49C39690.6090802@rtr.ca>	<49C396CF.7030202@rtr.ca> <20090320140714.2e7770d0@lxorguk.ukuu.org.uk> <49C3B7E9.2000505@rtr.ca> <49C4235D.5070303@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:52108 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751049AbZCUAyp (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 20 Mar 2009 20:54:45 -0400
In-Reply-To: <49C4235D.5070303@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Mark Lord <liml@rtr.ca>, Alan Cox <alan@lxorguk.ukuu.org.uk>, IDE/ATA development list <linux-ide@vger.kernel.org>

Tejun Heo wrote:
> Mark Lord wrote:
>> Sure, it will blindly use it if the drive appears to be already configured
>> for it at startup.  But I don't see any where that we issue "SET MULTIPLE"
>> commands or otherwise support turning it on/off or tuning it.
>>
>> I wonder if we even snoop the SET MULTIPLE command from SG_IO /
>> ATA_{12,16}?
>>
>> This is more of an infrastructure thing than a driver-specific setting,
>> so I'm hoping that one of you three (who know the code a lot better
>> than I do) might think about that for the future.
> 
> Right, libata doesn't have any multiple sector related configuration
> whatsoever.  Maybe I'll give it a shot.


Yeah, that has long been a design decision -- avoid all the mechanics of 
PIO-Multi, simply because we did not have much of a need for it (and 
still don't).

Albert Lee worked on PIO-Multi a while ago, which was mainly to get 
ATA_{12,16} working, IIRC.

But overall, I don't see much of a need to introduce it into the main stack?

	Jeff


