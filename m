From: Mark Lord <liml@rtr.ca>
Subject: Re: [PATCH] libata: add support for ATA_16 commands to ATAPI devices
Date: Wed, 03 Jan 2007 00:44:37 -0500
Message-ID: <459B42C5.2080804@rtr.ca>
References: <200701021939.10496.liml@rtr.ca>	<459AFDC2.6060900@garzik.org> <20070103010724.19b17522@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([64.26.128.89]:4323 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754244AbXACFol (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 3 Jan 2007 00:44:41 -0500
In-Reply-To: <20070103010724.19b17522@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan <alan@lxorguk.ukuu.org.uk>
Cc: Jeff Garzik <jeff@garzik.org>, Linux IDE <linux-ide@vger.kernel.org>, Tejun Heo <htejun@gmail.com>

Alan wrote:
>> I do not wish to completely eliminate the current behavior, which passes 
>> through all opcodes to the ATAPI device.  You cannot guarantee that 
>> ATA_16 is never used for a vendor-reserved opcode, for example.
> 
> For 16 byte commands via SG_IO you know the command is 16 bytes long as
> the command length is passed in hdr->cmd_len which becomes rq->cmd_len.
> Is that not sufficient to avoid this ATA_16 test if you pass it on to the
> required functions ?

No.  The SCSI code calculates the expected cmd_len based on the opcode it sees,
and makes exceptions only for the vendor-specific command blocks,
which ATA_16 is *not* part of.

Cheers
