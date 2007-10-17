From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: pata_via refuses to detect one drive
Date: Wed, 17 Oct 2007 16:50:07 +0100
Message-ID: <20071017165007.77471e8d@the-village.bc.nu>
References: <47161F09.3040003@msgid.tls.msk.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:55947 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1762452AbXJQPsG (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 17 Oct 2007 11:48:06 -0400
In-Reply-To: <47161F09.3040003@msgid.tls.msk.ru>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: linux-ide@vger.kernel.org

> Oct 17 18:30:59 linux kernel: ata2: port is slow to respond, please be patient (Status 0x80)
> Oct 17 18:30:59 linux kernel: ata2: SRST failed (errno=-16)

So it failed to reset and come back to sanity.

> Oct 17 18:30:59 linux kernel: ata2.01: ATAPI: FX4830T, R02E, max UDMA/33
> Oct 17 18:30:59 linux kernel: ata2.01: configured for UDMA/33
> Oct 17 18:30:59 linux kernel: scsi 0:0:0:0: Direct-Access     ATA      Hitachi HDS72168 P21O PQ: 0 ANSI: 5
> Oct 17 18:30:59 linux kernel: ata2.01: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2
> Oct 17 18:30:59 linux kernel: ata2.01: cmd a0/00:00:00:00:20/00:00:00:00:00/b0 tag 0 cdb 0x12 data 36 in
> Oct 17 18:30:59 linux kernel:          res 00/00:00:00:00:00/00:00:00:00:00/00 Emask 0x2 (HSM violation)

This looks like both drives end up trying to be the slave ? Its certainly
very vey confused at this point. Interesting it works with the BIOS doing
the reset, wonder what the difference is.

How are the drives jumpered and does it work with just one of the two
present ?

Alan
