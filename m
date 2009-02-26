From: Tejun Heo <tj@kernel.org>
Subject: Re: ahci fails with SATA DVD drive, IDE mode works
Date: Thu, 26 Feb 2009 10:07:17 +0900
Message-ID: <49A5EB45.6050202@kernel.org>
References: <20090211174558.505354fe@dhcp-100-2-144.bos.redhat.com>	<499D2202.7070503@kernel.org>	<20090221181705.0b5f9ed3@dhcp-100-2-144.bos.redhat.com>	<49A4DFD4.3030206@kernel.org> <20090225181530.1c575a30@dhcp-100-2-144.bos.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:60062 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753115AbZBZBIL (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 25 Feb 2009 20:08:11 -0500
In-Reply-To: <20090225181530.1c575a30@dhcp-100-2-144.bos.redhat.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Chuck Ebbert <cebbert@redhat.com>
Cc: linux-ide@vger.kernel.org

Hello,

Chuck Ebbert wrote:
>> How did it go?
> 
> I found another machine with the same chipset and a different ATAPI SATA
> drive; that one works okay in ahci mode.

Well, there's no way all ICH9Ms are broken, so I'm afraid 'the same
chipset' is a tad bit too wide unless it was the same board/machine.

> There are no messages at all between "EH complete" and the string of SCSI
> error messages:
...
> ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 frozen
> ata2.00: cmd a0/01:00:00:00:02/00:00:00:00:00/a0 tag 0 dma 512 in
>          cdb a1 08 2e 00 00 00 00 00  40 ec 00 00 00 00 00 00
>          res 40/00:02:00:08:00/00:00:00:00:00/a0 Emask 0x4 (timeout)
> ata2.00: status: { DRDY }
> ata2: hard resetting link
> ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> ata2.00: configured for MWDMA2
> ata2: EH complete

Here, BLANK has timed out but the device was recovered okay.

> sr 1:0:0:0: [sr0] Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE,SUGGEST_OK
> sr 1:0:0:0: [sr0] Sense Key : Illegal Request [current] 
> sr 1:0:0:0: [sr0] Add. Sense: Logical block address out of range
> end_request: I/O error, dev sr0, sector 0

And after that, the media can't be read, so this one seems normal.

Thanks.

-- 
tejun
