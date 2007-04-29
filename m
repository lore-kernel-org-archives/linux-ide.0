From: Mark Lord <liml@rtr.ca>
Subject: Re: libata fails to recover from HSM violation involving DRQ status
Date: Sun, 29 Apr 2007 09:13:39 -0400
Message-ID: <46349A03.9090300@rtr.ca>
References: <4633AB75.7070107@rtr.ca>	<4633B0A6.6090705@garzik.org> <20070428222502.26fc9bbc@the-village.bc.nu> <4633BEE7.8020005@garzik.org> <4633BF6D.40902@rtr.ca> <46340E63.5070209@gmail.com> <4634163D.1040408@gmail.com> <463487F0.4040701@rtr.ca> <46349695.7080706@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([64.26.128.89]:1250 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755268AbXD2NNk (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 29 Apr 2007 09:13:40 -0400
In-Reply-To: <46349695.7080706@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jeff@garzik.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Alan Cox <alan@redhat.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

> 
>>> Ah.. one more thing, is this draining also needed after DMA commands or
>>> only after PIO commands?
> 
> My drive doesn't do IDENTIFY_DMA, so I fed it a READ_DMA instead
> with "no data", and libata recovered without draining. 

More specifically, here's what happens for READ_DMA(1 sector)
with "NON_DATA" specified (same circustances as the failed IDENTIFY):

ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata1.00: cmd c8/00:01:00:00:00/00:00:00:00:00/40 tag 0 cdb 0x0 data 0
         res 40/00:00:00:00:00/00:00:00:00:00/40 Emask 0x4 (timeout)
ata1: port is slow to respond, please be patient (Status 0xd0)
ata1: port failed to respond (30 secs, Status 0xd0)
ata1: soft resetting port
ATA: abnormal status 0xD0 on port 0x000101f7
ATA: abnormal status 0xD0 on port 0x000101f7
ata1.00: configured for UDMA/100
ata1: EH complete
SCSI device sda: 312581808 512-byte hdwr sectors (160042 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: write cache: enabled, read cache: enabled, doesn't support DPO or FUA

So no draining, and all is well again.
Odds look pretty good that this is just a PIO thing.

-ml
