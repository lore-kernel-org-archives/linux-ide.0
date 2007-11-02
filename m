From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 2/3] libata: extend ata_acpi_cbl_80wire() and fix cable
 detection in pata_via and pata_amd
Date: Fri, 2 Nov 2007 15:42:15 +0000
Message-ID: <20071102154215.1a93249c@the-village.bc.nu>
References: <472B402A.4030009@gmail.com>
	<472B4078.90009@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:35973 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756005AbXKBPlG (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 2 Nov 2007 11:41:06 -0400
In-Reply-To: <472B4078.90009@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>

> Using the initial GTM value is the right thing to do because both are
> trying to check firmware setting and by the time ->cable_detect runs
> the controller is already forced into PIO0 by reset.

As we only look at the DMA bits that doesn't matter but I agree it would
be cleaner if we were more careful. Also our mode setting outside
pata_acpi doesn't touch the ACPI settings so its ok for that reason too.

> + * Determine cable type from UDMA configuration in @gtm.  If UDMA is
> + * disabled, it returns ATA_CBL_PATA_UNK.  If UDMA is enabled and
> + * faster than 33, PATA_80; otherwise, PATA_40.

NAK

Consider the case of a UDMA 33 capable device on an 80 wire cable. We
simply can't use the cable detect methods to prove it is 40 wire this way.

What we actually know is

	If UDMA > 33 selected		-> UDMA > 33 works
					80 wire
					Short
					or SATA

	If UDMA > 33 not selected	Unknown
					40 wire
					80 + Drive limit
					80 + Controller limit
					80 + BIOS is set to PIO
					etc

The only case I can see you could reasonably suggest 40 wire would be
IFF the drive is capable of UDMA > 33 _and_ the ACPI mode is UDMA 33.



Alan
