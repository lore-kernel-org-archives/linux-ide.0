From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] libata-core More robust parsing for multi_count(v5)
Date: Sun, 12 Apr 2009 11:31:16 -0400
Message-ID: <49E20944.7070709@pobox.com>
References: <49C1047D.4000008@rtr.ca> <49C11A0C.3070502@rtr.ca> <49C11ED4.2030307@rtr.ca> <49C19087.5000307@gmail.com> <49C190F1.7010202@kernel.org> <49C28133.8050401@rtr.ca> <49C281A5.5080404@rtr.ca> <49C2D642.90706@kernel.org> <49C39690.6090802@rtr.ca> <49E20475.1080409@rtr.ca> <20090412161812.78e92948@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:42372 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754115AbZDLPb1 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 12 Apr 2009 11:31:27 -0400
In-Reply-To: <20090412161812.78e92948@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, Mark Lord <liml@rtr.ca>
Cc: Tejun Heo <tj@kernel.org>, IDE/ATA development list <linux-ide@vger.kernel.org>

Alan Cox wrote:
>> The limit for sata_mv chipsets seems to actually be 7-sectors or less
>> for read/write multiple.  Which means a max of 4 in practice.
>>
>> Similarly, we should also be preventing *any* PIO of more than one DRQ
>> for sata_mv.  But I don't see a sensible way to do that either.
> 
> Ugghhh..

Our infrastructure just flat doesn't deal well with per-xfer-mode sector 
count limitations.  It is quite easy for us to limit per-xfer sector 
count on a __per device__ basis -- both SCSI and block layer handle that 
well.

But deviating from that implies potentially having to re-merge (or 
split) block layer requests -- IOW quickly moves into the non-trivial, 
cross-stack category of problem.

Problem is, of course, sector count limits in ATA can be per-command (or 
per-xfer-mode), not just per-device.

	Jeff



