From: Mark Lord <liml@rtr.ca>
Subject: Re: libata fails to recover from HSM violation involving DRQ status
Date: Sat, 28 Apr 2007 18:09:12 -0400
Message-ID: <4633C608.2030906@rtr.ca>
References: <4633AB75.7070107@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([64.26.128.89]:2642 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030912AbXD1WJO (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 28 Apr 2007 18:09:14 -0400
In-Reply-To: <4633AB75.7070107@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Tejun Heo <htejun@gmail.com>, Alan Cox <alan@redhat.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

Mark Lord wrote:
>..
> I triggered this by accident, issuing an IDENTIFY command
> which incorrectly specified ATA_PROT_NODATA.  My error, for sure,
> but libata never recovered from the "stuck DRQ bit" that resulted.
...
> sda: Mode Sense: 00 3a 00 00
> SCSI device sda: write cache: enabled, read cache: enabled, doesn't 
> support DPO or FUA
> ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
> ata1.00: cmd ec/00:00:00:00:00/00:00:00:00:00/00 tag 0 cdb 0x0 data 0 
>         res 58/00:00:00:00:00/00:00:00:00:00/00 Emask 0x2 (HSM violation)
> ata1: soft resetting port
> ata1.00: configured for UDMA/100
> ata1: EH complete
> SCSI device sda: 312581808 512-byte hdwr sectors (160042 MB)
> sda: Write Protect is off
> sda: Mode Sense: 00 3a 00 00
> SCSI device sda: write cache: enabled, read cache: enabled, doesn't 
> support DPO or FUA
> ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
> ata1.00: cmd ec/00:00:00:00:00/00:00:00:00:00/00 tag 0 cdb 0x0 data 0 
>         res 58/00:00:00:00:00/00:00:00:00:00/00 Emask 0x2 (HSM violation)
> ata1: soft resetting port
> ata1.00: configured for UDMA/100
> ata1: EH complete
...
(over and over)

Say.. is this problem as simple as excessive retries for an SG_IO command?
There shouldn't really be *any* retries here, and it should eventually
just fail the command rather than shut down the port.

Or am I just reading the logs wrong?
