From: Sven Lemke <catnip@web.de>
Subject: [SOLVED] Re: sata_promise - another sata dvd writer problem
Date: Sun, 06 May 2007 19:46:44 +0200
Message-ID: <463E1484.4090803@web.de>
References: <200705061533.l46FXOF8025759@harpo.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fmmailgate03.web.de ([217.72.192.234]:37693 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754797AbXEFRyD (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 6 May 2007 13:54:03 -0400
In-Reply-To: <200705061533.l46FXOF8025759@harpo.it.uu.se>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Mikael Pettersson <mikpe@it.uu.se>

Mikael Pettersson wrote:
> On Sun, 06 May 2007 16:35:11 +0200, Sven Lemke wrote:
>
>> sata_promise 0000:00:0b.0: version 2.05
>> ...
>> ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
>> ata2.00: ATAPI, max UDMA/33
>> ata2.00: applying bridge limits
>> ata2.00: configured for UDMA/33
>> sd 0:0:0:0: [sda] Attached SCSI disk
>> sd 0:0:0:0: Attached scsi generic sg0 type 0
>> scsi 1:0:0:0: CD-ROM TSSTcorp CD/DVDW SH-S183L SB01 PQ: 0 ANSI: 5
>> ...
>> ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
>> ata2.00: (port_status 0x20200000)
>> ata2.00: cmd a0/00:00:00:00:20/00:00:00:00:00/a0 tag 0 cdb 0x0 data 0
>>          res 40/00:02:00:60:00/00:00:00:00:00/a0 Emask 0x5 (timeout)
> etc
>
> Probably fallout from a mistake I made in the error decoding update.
> Apply the patch below, try again, and let us know if it works or not.
>
> /Mikael
>
> --- linux-2.6.21-mm1/drivers/ata/sata_promise.c.~1~	2007-05-05 22:24:41.000000000 +0200
> +++ linux-2.6.21-mm1/drivers/ata/sata_promise.c	2007-05-05 22:25:21.000000000 +0200
> @@ -653,6 +653,8 @@ static void pdc_error_intr(struct ata_po
>  	qc->err_mask |= ac_err_mask;
>  
>  	pdc_reset_port(ap);
> +
> +	ata_port_abort(ap);
>  }
>  
>  static inline unsigned int pdc_host_intr( struct ata_port *ap,
>
This solves the problem. Great job!!

dmesg:
...
ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata2.00: ATAPI, max UDMA/33
ata2.00: applying bridge limits
ata2.00: configured for UDMA/33
...
scsi 1:0:0:0: CD-ROM TSSTcorp CD/DVDW SH-S183L SB01 PQ: 0 ANSI: 5
...
sr 1:0:0:0: Attached scsi CD-ROM sr0
...


Thanks a lot,
Sven

