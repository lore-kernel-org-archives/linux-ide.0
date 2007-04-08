From: Ansgar Knappheide <ansgar.knappheide@gmx.de>
Subject: Re: sata_promise ata exceptions (2.6.20.6)
Date: Sun, 08 Apr 2007 12:43:50 +0200
Message-ID: <4618C766.5080903@gmx.de>
References: <46182C10.7010703@ipom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:57998 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1749667AbXDHKlX (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 8 Apr 2007 06:41:23 -0400
In-Reply-To: <46182C10.7010703@ipom.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Phil Dibowitz <phil@ipom.com>
Cc: linux-ide@vger.kernel.org

Phil Dibowitz schrieb:
> ata1.00: exception Emask 0x10 SAct 0x0 SErr 0x180100 action 0x2
> ata1.00: cmd c8/00:d0:8a:31:ae/00:00:00:00:00/e0 tag 0 cdb 0x0 data 106496 in
>          res 51/0c:0f:4b:32:ae/00:00:00:00:00/e0 Emask 0x10 (ATA bus error)
> ata1: soft resetting port
> ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> ata1.00: configured for UDMA/133
> ata1: EH complete
> SCSI device sda: 312581808 512-byte hdwr sectors (160042 MB)
> sda: Write Protect is off
> sda: Mode Sense: 00 3a 00 00
> SCSI device sda: write cache: enabled, read cache: enabled, doesn't support
> DPO or FUA
> ata1.00: exception Emask 0x10 SAct 0x0 SErr 0x380100 action 0x2
> ata1.00: cmd c8/00:a0:12:fa:bc/00:00:00:00:00/e0 tag 0 cdb 0x0 data 81920 in
>          res 51/0c:1f:93:fa:bc/00:00:00:00:00/e0 Emask 0x10 (ATA bus error)
> ata1: soft resetting port
> ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> ata1.00: configured for UDMA/133
> ata1: EH complete
> SCSI device sda: 312581808 512-byte hdwr sectors (160042 MB)
> sda: Write Protect is off
> sda: Mode Sense: 00 3a 00 00
> SCSI device sda: write cache: enabled, read cache: enabled, doesn't support
> DPO or FUA
> ata1.00: limiting speed to UDMA/100
> ata1.00: exception Emask 0x10 SAct 0x0 SErr 0x380100 action 0x2
> ata1.00: cmd c8/00:48:2a:27:ac/00:00:00:00:00/e0 tag 0 cdb 0x0 data 36864 in
>          res 51/0c:27:4b:27:ac/00:00:00:00:00/e0 Emask 0x10 (ATA bus error)
> ata1: soft resetting port
> ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> ata1.00: configured for UDMA/100
> ata1: EH complete
> SCSI device sda: 312581808 512-byte hdwr sectors (160042 MB)
> sda: Write Protect is off
> sda: Mode Sense: 00 3a 00 00
> SCSI device sda: write cache: enabled, read cache: enabled, doesn't support
> DPO or FUA
> ata1.00: limiting speed to UDMA/66
> ata1.00: exception Emask 0x10 SAct 0x0 SErr 0x180100 action 0x2
> ata1.00: cmd c8/00:f8:6a:7a:ae/00:00:00:00:00/e0 tag 0 cdb 0x0 data 126976 in
>          res 51/0c:97:cb:7a:ae/00:00:00:00:00/e0 Emask 0x10 (ATA bus error)
> ata1: soft resetting port
> ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> ata1.00: configured for UDMA/66
> ata1: EH complete
> SCSI device sda: 312581808 512-byte hdwr sectors (160042 MB)
> sda: Write Protect is off
> sda: Mode Sense: 00 3a 00 00
> SCSI device sda: write cache: enabled, read cache: enabled, doesn't support
> DPO or FUA
>
>   
I got similar errors since kernel 2.6.20-xx and the LBA48/EH fix between 
2.6.21-rc5-git10 and 2.6.21-rc5-git13 seems to fix it. I'm no developer, 
but you should perhaps try kernel 2.6.21-rc5-git13 or later.

Greetings
Ansgar Knappheide
