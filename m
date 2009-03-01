From: Tejun Heo <tj@kernel.org>
Subject: Re: ahci fails with SATA DVD drive, IDE mode works
Date: Sun, 01 Mar 2009 21:26:33 +0900
Message-ID: <49AA7EF9.7000306@kernel.org>
References: <20090211174558.505354fe@dhcp-100-2-144.bos.redhat.com>	<499D2202.7070503@kernel.org>	<20090221181705.0b5f9ed3@dhcp-100-2-144.bos.redhat.com>	<49A4DFD4.3030206@kernel.org>	<20090225181530.1c575a30@dhcp-100-2-144.bos.redhat.com>	<49A5EB45.6050202@kernel.org> <20090227175746.44acdbfa@dhcp-100-2-144.bos.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:58252 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752273AbZCAM0b (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 1 Mar 2009 07:26:31 -0500
In-Reply-To: <20090227175746.44acdbfa@dhcp-100-2-144.bos.redhat.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Chuck Ebbert <cebbert@redhat.com>
Cc: linux-ide@vger.kernel.org

Hello, Chuck.

Chuck Ebbert wrote:
> The other machine has what seems to be a "real" SATA DVD writer in it.
> It reports udma5 as the connect speed. This one seems to be a PATA drive
> with an internal SATA bridge and is connecting as mwdma2.

Ah... that makes sense.  libata has problem with ATAPI devices
connected over a SATA-PATA bridge.  Albert Lee tried to track it down
a while ago but it never got resolved.  :-(

Tracking things like this can be quite difficult.  Eh... having SATA
tracer would be nice.  Oh well...

>>> ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 frozen
>>> ata2.00: cmd a0/01:00:00:00:02/00:00:00:00:00/a0 tag 0 dma 512 in
>>>          cdb a1 08 2e 00 00 00 00 00  40 ec 00 00 00 00 00 00
>>>          res 40/00:02:00:08:00/00:00:00:00:00/a0 Emask 0x4 (timeout)
>>> ata2.00: status: { DRDY }
>>> ata2: hard resetting link
>>> ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
>>> ata2.00: configured for MWDMA2
>>> ata2: EH complete
>> Here, BLANK has timed out but the device was recovered okay.
>>
> 
> I ran 'hdparm -I' here. Why would it send BLANK to the drive??
> (There was a 1.4 GB DVD-RW in the drive when I did that.)

CDB 0xa1 is BLANK alright.  Is the problem reproducible?

> Also there is no "applying bridge limits" message here when it resets
> like there is when the system boots.
> 
>>> sr 1:0:0:0: [sr0] Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE,SUGGEST_OK
>>> sr 1:0:0:0: [sr0] Sense Key : Illegal Request [current] 
>>> sr 1:0:0:0: [sr0] Add. Sense: Logical block address out of range
>>> end_request: I/O error, dev sr0, sector 0
>> And after that, the media can't be read, so this one seems normal.
>>
> 
> The media wasn't blanked -- rebooting lets me read it again.
> 
> Also, running 'hdparm -I' with no disk in the drive outputs:
> 
> /dev/sr0:
>  HDIO_DRIVE_CMD(identify) failed: Invalid exchange
> 
> And strangely enough, I get the same message with a normal DVD disk in
> the drive too...

:-(

-- 
tejun
