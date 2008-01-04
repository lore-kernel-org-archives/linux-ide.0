From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: SATA kernel-buffered read VERY slow (not raid,
 Promise TX300 card); 2.6.23.1(vanilla)
Date: Thu, 03 Jan 2008 20:35:26 -0600
Message-ID: <477D9B6E.7060000@shaw.ca>
References: <fa.o9uy6Qaq3PtHs2Z9lAKGUKvD85I@ifi.uio.no>
 <fa.1kDEq2SPE3FqpM5Mfw9CVGbvVdY@ifi.uio.no>
 <fa.hIZ5+XhGRugySB/HuLxr5qd6gAY@ifi.uio.no>
 <fa.iefWPg3R6g5Pnm/ktSCK9XWVFVw@ifi.uio.no>
 <fa.FhpaleM/osLTMJ85/PuxjxyJeGI@ifi.uio.no>
 <fa.MP5rgMp4TS2+Cfemd/uFOQOuquQ@ifi.uio.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from idcmail-mo1so.shaw.ca ([24.71.223.10]:57071 "EHLO
	pd2mo1so.prod.shaw.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752663AbYADCg6 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 3 Jan 2008 21:36:58 -0500
In-reply-to: <fa.MP5rgMp4TS2+Cfemd/uFOQOuquQ@ifi.uio.no>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Linda Walsh <lkml@tlinx.org>
Cc: Robert Hancock <hancockr@shaw.ca>, Alan Cox <alan@lxorguk.ukuu.org.uk>, LKML <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org

Linda Walsh wrote:
> Robert Hancock wrote:
>> Linda Walsh wrote:
>>> Alan Cox wrote:
>>>>> rate began falling; at 128k block-reads-at-a-time or larger, it 
>>>>> drops below
>>>>> 20MB/s (only on buffered SATA).
>>>> Try disabling NCQ - see if you've got a drive with the 'NCQ = no
>>>> readahead' flaw.
>> http://linux-ata.org/faq.html#ncq
> ---
>    When drive initializes, dmesg says it has NCQ (depth 0/32)
>    Reading the queue_depth under /sys, shows a queuedepth of "1".

Looks like your controller (or at least the Linux driver) doesn't 
actually support NCQ.

>>> 2) Drive Advanced Power Management setting("-B") (write-only):
>>> "HDIO_DRIVE_CMD failed: Input/output error"
>>> 3) Drive Acoustic ("-M"), read = " acoustic      = not supported",
>>> write = " HDIO_DRIVE_CMD:ACOUSTIC failed: Input/output error"
>>
>> Not sure about these ones.. Does anything show up in dmesg when you do 
>> this?
> ---
>    Yes:
>    (for "-B", power-management)
> ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
> ata1.00: port_status 0x20200000
> ata1.00: cmd ef/05:fe:00:00:00/00:00:00:00:00/40 tag 0 cdb 0x0 data 0
>         res 51/04:fe:00:00:00/00:00:00:00:00/40 Emask 0x1 (device error)
> ata1.00: configured for UDMA/133
> ata1: EH complete
> sd 1:0:0:0: [sdb] 1465149168 512-byte hardware sectors (750156 MB)
> sd 1:0:0:0: [sdb] Write Protect is off
> sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
> sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't 
> support DPO or FUA
> ----
>   (for "-M" acoustic management):
> ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
> ata1.00: port_status 0x20200000
> ata1.00: cmd ef/42:fe:00:00:00/00:00:00:00:00/40 tag 0 cdb 0x0 data 0
>         res 51/04:fe:00:00:00/00:00:00:00:00/40 Emask 0x1 (device error)
> ata1.00: configured for UDMA/133
> ata1: EH complete
> sd 1:0:0:0: [sdb] 1465149168 512-byte hardware sectors (750156 MB)
> sd 1:0:0:0: [sdb] Write Protect is off
> sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
> sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't 
> support DPO or FUA

Looks like the drive reports ERR/ABRT (command aborted), meaning it 
likely doesn't support those commands.

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/

