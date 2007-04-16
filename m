From: "Tomi Orava" <Tomi.Orava@ncircle.nullnet.fi>
Subject: Re: sata_promise ata exceptions (2.6.20.6)
Date: Mon, 16 Apr 2007 10:02:07 +0300 (EEST)
Message-ID: <63362.194.237.142.10.1176706927.squirrel@ncircle.nullnet.fi>
References: <200704091018.l39AI9tg020015@harpo.it.uu.se>
    <38769.194.237.142.7.1176209348.squirrel@ncircle.nullnet.fi>
    <46231DE3.8070404@ipom.com>
Mime-Version: 1.0
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from emh06.mail.saunalahti.fi ([62.142.5.116]:54188 "EHLO
	emh06.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753888AbXDPHCP (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 16 Apr 2007 03:02:15 -0400
In-Reply-To: <46231DE3.8070404@ipom.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Phil Dibowitz <phil@ipom.com>
Cc: Mikael Pettersson <mikpe@it.uu.se>, linux-ide@vger.kernel.org


Hi,

> Given that the last one was a hardware issue, I bought a new controller.
> Despite my bad luck, given my price-range promise still seemed to be the
> one
> with the most good reports, so I went with that. I was going to go with a
> sil, but I couldn't find one..

Unfortunately, I don't have a solution/fix for you, but out of curiosity,
what hard-disks you have problems with ? Also what is the exact model
of your SATA-controller ?

> Anyway, things are MUCH better now... but about once a week, I get:
>
> ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
> ata2.00: (port_status 0x00001000)
> ata2.00: cmd c8/00:80:9a:71:d0/00:00:00:00:00/ea tag 0 cdb 0x0 data 65536
> in
>          res 40/00:00:06:4f:c2/00:00:00:00:00/00 Emask 0x24 (host bus
> error)
> ata2: soft resetting port
> ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> ata2.00: configured for UDMA/133
> ata2: EH complete
> SCSI device sda: 312581808 512-byte hdwr sectors (160042 MB)
> sda: Write Protect is off
> sda: Mode Sense: 00 3a 00 00
> SCSI device sda: write cache: enabled, read cache: enabled, doesn't
> support
> DPO or FUA

Regards,
Tomi Orava

