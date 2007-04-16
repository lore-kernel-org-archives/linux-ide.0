From: Mikael Pettersson <mikpe@it.uu.se>
Subject: Re: sata_promise ata exceptions (2.6.20.6)
Date: Mon, 16 Apr 2007 09:42:19 +0200 (MEST)
Message-ID: <200704160742.l3G7gJYc008895@harpo.it.uu.se>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from aun.it.uu.se ([130.238.12.36]:51486 "EHLO aun.it.uu.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754056AbXDPHma (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 16 Apr 2007 03:42:30 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tomi.Orava@ncircle.nullnet.fi, phil@ipom.com
Cc: linux-ide@vger.kernel.org, mikpe@it.uu.se

On Sun, 15 Apr 2007 23:55:31 -0700, Phil Dibowitz wrote:
> Given that the last one was a hardware issue, I bought a new controller.
> Despite my bad luck, given my price-range promise still seemed to be the =
> one
> with the most good reports, so I went with that. I was going to go with a=
> 
> sil, but I couldn't find one..
> 
> Anyway, things are MUCH better now... but about once a week, I get:
> 
> ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
> ata2.00: (port_status 0x00001000)
> ata2.00: cmd c8/00:80:9a:71:d0/00:00:00:00:00/ea tag 0 cdb 0x0 data 65536=
>  in
>          res 40/00:00:06:4f:c2/00:00:00:00:00/00 Emask 0x24 (host bus err=
> or)
> ata2: soft resetting port
> ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> ata2.00: configured for UDMA/133
> ata2: EH complete
> SCSI device sda: 312581808 512-byte hdwr sectors (160042 MB)
> sda: Write Protect is off
> sda: Mode Sense: 00 3a 00 00
> SCSI device sda: write cache: enabled, read cache: enabled, doesn't suppo=
> rt
> DPO or FUA
> 
> 
> It's the same port_status and Emask/SAct/SErr/action each time... only th=
> e
> cmd/res and data change (obviously those would change)...
> 
> Can anyone tell me what that means?

port_status 0x00001000 is "host bus timeout", which the manual
defines as the host bus being busy for more than 256 clock cycles
during an ATA I/O transfer.

I have no idea what would cause this error, and I've never
seen it myself.

As long as libata recovers and doesn't downgrade your transfer
speed it shouldn't pose too much of a problem.

/Mikael
