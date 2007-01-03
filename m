From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] libata: add support for ATA_16 commands to ATAPI devices
Date: Tue, 02 Jan 2007 20:06:57 -0500
Message-ID: <459B01B1.7030608@garzik.org>
References: <200701021939.10496.liml@rtr.ca>	<459AFDC2.6060900@garzik.org> <20070103010724.19b17522@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:48372 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752731AbXACBHA (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 2 Jan 2007 20:07:00 -0500
In-Reply-To: <20070103010724.19b17522@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan <alan@lxorguk.ukuu.org.uk>
Cc: Mark Lord <liml@rtr.ca>, Linux IDE <linux-ide@vger.kernel.org>, Tejun Heo <htejun@gmail.com>

Alan wrote:
>> I do not wish to completely eliminate the current behavior, which passes 
>> through all opcodes to the ATAPI device.  You cannot guarantee that 
>> ATA_16 is never used for a vendor-reserved opcode, for example.
> 
> For 16 byte commands via SG_IO you know the command is 16 bytes long as
> the command length is passed in hdr->cmd_len which becomes rq->cmd_len.
> Is that not sufficient to avoid this ATA_16 test if you pass it on to the
> required functions ?

Well, its a question of whether you are executing the supplied cdb as an 
ATA command or a SCSI command.  If executing as an ATA command, libata 
needs to intercept it (as Mark's patch does), because few if any ATAPI 
devices support the ATA_16 command in the firmware.

The current behavior treats everything as SCSI commands, passed to the 
firmware (if a bit massaged, a la INQUIRY), which means there is no way 
for userspace to directly address the underlying ATA bus outside of 
libata-scsi.

Or am I misunderstanding things completely?  :)

	Jeff



