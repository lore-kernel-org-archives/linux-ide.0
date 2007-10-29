From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: ATAPI devices in AHCI mode not working
Date: Mon, 29 Oct 2007 20:30:28 +0000
Message-ID: <20071029203028.35645f26@the-village.bc.nu>
References: <39B20DF628532344BC7A2692CB6AEE0701EA6E7D@orsmsx420.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:54648 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753250AbXJ2U2c (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 29 Oct 2007 16:28:32 -0400
In-Reply-To: <39B20DF628532344BC7A2692CB6AEE0701EA6E7D@orsmsx420.amr.corp.intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Gaston, Jason D" <jason.d.gaston@intel.com>
Cc: linux-ide@vger.kernel.org

> ata1.00: ATAPI: TSSTcorpCD/DVDW SH-S183L, SB01, max UDMA/33, ATAPI AN

Everyones favourite vendor right now

> ata1.00: applying bridge limits
> ata1.00: configured for UDMA/33

It seems to be seeing a SATA/PATA bridge here ? This is a PATA device on
a SATA bridge ? If not something is very very broken as we are seeing a
SATA cable type and a device not indentifying itself as SATA.

> ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
> ata1.00: cmd a0/00:00:00:00:00/00:00:00:00:00/a0 tag 0 cdb 0x0 data 0 
>          res 40/00:03:00:00:00/00:00:00:00:00/a0 Emask 0x4 (timeout)
> ata1.00: status: { DRDY }

We try and talk to it, it ends up stuck busy.

> ata1: soft resetting link
> ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> ata1.00: configured for UDMA/33
> ata1: EH complete

Kick it, back it comes
> sr0: scsi3-mmc drive: 32x/40x writer dvd-ram cd/rw xa/form2 cdda tray
> Uniform CD-ROM driver Revision: 3.20
> sr 0:0:0:0: Attached scsi CD-ROM sr0

Fails again
> ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
> ata1.00: cmd a0/00:00:00:00:00/00:00:00:00:00/a0 tag 0 cdb 0x0 data 0 
>          res 40/00:03:00:00:00/00:00:00:00:00/a0 Emask 0x4 (timeout)
> ata1.00: status: { DRDY }
> ata1: soft resetting link

Repeat

> ata1: SATA link down (SStatus 11 SControl 300)
> ata1: failed to recover some devices, retrying in 5 secs
> ata1: hard resetting link
> ata1: SATA link down (SStatus 0 SControl 300)
> ata1: limiting SATA link speed to 1.5 Gbps

Try again at 1.5Gbit

> ata1: hard resetting link
> ata1: SATA link down (SStatus 0 SControl 310)
> ata1.00: disabled
> ata1: EH complete

We give up on it.


First guess would be to replace the TSST drive with another vendors
device and see what occurs. If that does the same thing it eliminates
drive firmware.

If that doesn't help then need to know more about the bridge etc


Alan
