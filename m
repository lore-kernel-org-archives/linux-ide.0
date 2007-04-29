From: Tejun Heo <htejun@gmail.com>
Subject: Re: libata fails to recover from HSM violation involving DRQ status
Date: Sun, 29 Apr 2007 12:04:53 +0900
Message-ID: <46340B55.2040009@gmail.com>
References: <4633AB75.7070107@rtr.ca> <4633C608.2030906@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.233]:50261 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754286AbXD2DFu (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 28 Apr 2007 23:05:50 -0400
Received: by wr-out-0506.google.com with SMTP id 76so1297579wra
        for <linux-ide@vger.kernel.org>; Sat, 28 Apr 2007 20:05:50 -0700 (PDT)
In-Reply-To: <4633C608.2030906@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Jeff Garzik <jgarzik@pobox.com>, Alan Cox <alan@redhat.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

Mark Lord wrote:
> Mark Lord wrote:
>> ..
>> I triggered this by accident, issuing an IDENTIFY command
>> which incorrectly specified ATA_PROT_NODATA.  My error, for sure,
>> but libata never recovered from the "stuck DRQ bit" that resulted.
> ...
>> sda: Mode Sense: 00 3a 00 00
>> SCSI device sda: write cache: enabled, read cache: enabled, doesn't
>> support DPO or FUA
>> ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
>> ata1.00: cmd ec/00:00:00:00:00/00:00:00:00:00/00 tag 0 cdb 0x0 data 0
>>         res 58/00:00:00:00:00/00:00:00:00:00/00 Emask 0x2 (HSM violation)
>> ata1: soft resetting port
>> ata1.00: configured for UDMA/100
>> ata1: EH complete
>> SCSI device sda: 312581808 512-byte hdwr sectors (160042 MB)
>> sda: Write Protect is off
>> sda: Mode Sense: 00 3a 00 00
>> SCSI device sda: write cache: enabled, read cache: enabled, doesn't
>> support DPO or FUA
>> ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
>> ata1.00: cmd ec/00:00:00:00:00/00:00:00:00:00/00 tag 0 cdb 0x0 data 0
>>         res 58/00:00:00:00:00/00:00:00:00:00/00 Emask 0x2 (HSM violation)
>> ata1: soft resetting port
>> ata1.00: configured for UDMA/100
>> ata1: EH complete
> ...
> (over and over)
> 
> Say.. is this problem as simple as excessive retries for an SG_IO command?
> There shouldn't really be *any* retries here, and it should eventually
> just fail the command rather than shut down the port.
> 
> Or am I just reading the logs wrong?

libata EH isn't trying to retry the command.  It's trying to revalidate
the device after resetting it to make sure that the device is still
there and listening to commands.  As the device fails to respond to
reset and the following IDENTIFY, libata EH assumes that the device is
dead one way or the other and gives up on the device after a few
reset/revalidate retries.

-- 
tejun
