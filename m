From: Tejun Heo <tj@kernel.org>
Subject: Re: ahci fails with SATA DVD drive, IDE mode works
Date: Wed, 25 Feb 2009 15:06:12 +0900
Message-ID: <49A4DFD4.3030206@kernel.org>
References: <20090211174558.505354fe@dhcp-100-2-144.bos.redhat.com>	<499D2202.7070503@kernel.org> <20090221181705.0b5f9ed3@dhcp-100-2-144.bos.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:44425 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751149AbZBYGHP (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 25 Feb 2009 01:07:15 -0500
In-Reply-To: <20090221181705.0b5f9ed3@dhcp-100-2-144.bos.redhat.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Chuck Ebbert <cebbert@redhat.com>
Cc: linux-ide@vger.kernel.org

Hello,

Chuck Ebbert wrote:
> I don't have another drive like this one, but maybe can borrow one on
> Monday (it's a SATA notebook drive.) I did get the other information
> though.

How did it go?

> ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> ata2.00: ATAPI: TSSTcorp CDDVDW TS-L633A, UO00, max MWDMA2
> ata2.00: applying bridge limits
> ata2.00: configured for MWDMA2
> scsi 1:0:0:0: CD-ROM            TSSTcorp CDDVDW TS-L633A  UO00 PQ: 0 ANSI: 5
> sr0: scsi3-mmc drive: 62x/62x writer dvd-ram cd/rw xa/form2 cdda tray
...
> I ran hdparm -i first:
> 
>  Model=TSSTcorp CDDVDW TS-L633A                , FwRev=UO00    , SerialNo=                    
>  Config={ Fixed Removeable DTR<=5Mbs DTR>10Mbs nonMagnetic }
>  RawCHS=0/0/0, TrkSize=0, SectSize=0, ECCbytes=0
>  BuffType=unknown, BuffSize=0kB, MaxMultSect=0
>  (maybe): CurCHS=0/0/0, CurSects=0, LBA=yes, LBAsects=0
>  IORDY=on/off, tPIO={min:383,w/IORDY:120}, tDMA={min:120,rec:120}
>  PIO modes:  pio0 pio1 pio2 pio3 pio4.
>  DMA modes:  mdma0 mdma1 *mdma2.
>  AdvancedPM=no
> 
> 
> And then hdparm -I, which took a while and eventually printed:
> 
> /dev/sr0:
> 
> ATA device, with non-removable media
> Standards:
> 	Likely used: 1
> Configuration:
> 	Logical		max	current
> 	cylinders	0	0
> 	heads		0	0
> 	sectors/track	0	0
> 	--
> 	device size with M = 1024*1024:           0 MBytes
> 	device size with M = 1000*1000:           0 MBytes 
> 	cache/buffer size  = unknown
> Capabilities:
> 	IORDY not likely
> 	Cannot perform double-word IO
> 	R/W multiple sector transfer: not supported
> 	DMA: not supported
> 	PIO: pio0 
> 
> 
> Looking in the kernel log, I saw this after running hdparm -I:
> 
> ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 frozen
> ata2.00: cmd a0/01:00:00:00:02/00:00:00:00:00/a0 tag 0 dma 512 in
>          cdb a1 08 2e 00 00 00 00 00  40 ec 00 00 00 00 00 00
>          res 40/00:02:00:08:00/00:00:00:00:00/a0 Emask 0x4 (timeout)
> ata2.00: status: { DRDY }
> ata2: hard resetting link
> ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> ata2.00: configured for MWDMA2
> ata2: EH complete
> 
> And after that the drive was inaccessible, filling the log with
> these messages:
> 
> end_request: I/O error, dev sr0, sector 153612
> sr 1:0:0:0: [sr0] Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE,SUGGEST_OK
> sr 1:0:0:0: [sr0] Sense Key : Illegal Request [current].
> sr 1:0:0:0: [sr0] Add. Sense: Logical block address out of range

Hmmm... Can you please post full kernel log including the booting
part?  There gotta be other errors before the driver gives up on the
device.  Strange.

Thanks.

-- 
tejun
