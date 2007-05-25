From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] libata: Add MMIO support to pata_sil680
Date: Thu, 24 May 2007 20:29:55 -0400
Message-ID: <46562E03.3020503@garzik.org>
References: <20070515061239.611A2DDEE9@ozlabs.org>	<1179209697.32247.153.camel@localhost.localdomain>	<20070523144217.5abd9fdf@the-village.bc.nu>	<1179960518.32247.948.camel@localhost.localdomain>	<20070524003123.77b9c81c@the-village.bc.nu>	<1179963820.32247.996.camel@localhost.localdomain>	<20070524001302.GA18571@devserv.devel.redhat.com>	<1179978137.32247.1035.camel@localhost.localdomain>	<20070524105407.64514929@the-village.bc.nu>	<46556E5D.3070203@pobox.com> <20070524120915.40b594a8@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:49608 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750733AbXEYA37 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 24 May 2007 20:29:59 -0400
In-Reply-To: <20070524120915.40b594a8@the-village.bc.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Linux IDE <linux-ide@vger.kernel.org>

Alan Cox wrote:
> On Thu, 24 May 2007 06:52:13 -0400
> Jeff Garzik <jgarzik@pobox.com> wrote:
> 
>> Alan Cox wrote:
>>>> Currently libata does the 400ns thingy in the inline ata_pause() which
>>>> unconditionally does ata_altstatus(); ndelay(400); (and thus does it on
>>>> PIO, MMIO, anything ...).
>>> It might actually improve performance for PATA if we did as we'll get rid
>>> of an excess (expensive) PCI read access for non MMIO cases.
>> The spec says you should read AltStatus.  I am definitely not inclined 
>> to change that part.
> 
> Which spec says that and where ?

Found it!  It was in the spec I consider more authoritative than any 
official ATA spec:  Hale Landis' ATADRVR (http://www.ata-atapi.com/):


// This macro provides a small delay that is used in several
// places in the ATA command protocols:
// 1) It is recommended that the host delay 400ns after
//    writing the command register.
// 2) ATA-4 has added a new requirement that the host delay
//    400ns if the DEV bit in the Device/Head register is
//    changed.  This was not recommended or required in ATA-1,
//    ATA-2 or ATA-3.  This is the easy way to do that since it
//    works in all PIO modes.
// 3) ATA-4 has added another new requirement that the host delay
//    after the last word of a data transfer before checking the
//    status register.  This was not recommended or required in
//    ATA-1, ATA-2 or ATA-3.  This is the easy to do that since it
//    works in all PIO modes.

#define DELAY400NS  { pio_inbyte( CB_ASTAT ); pio_inbyte( CB_ASTAT );  \
                       pio_inbyte( CB_ASTAT ); pio_inbyte( CB_ASTAT ); }


libata was originally written by following ATADRVR IO-for-IO.  You can 
still see some of the mostly-unmodified bitbang sequences in 
libata-core.c in places like dev-select or dev-chk.  Sometimes you have 
to look pretty hard, since hooks make the bitbang sequences much harder 
to follow.

Obviously libata's "pause" differs from Hale's version a bit, but the 
basic version is sound and works for everybody from ancient PATA PIO to 
modern SATA MMIO.

	Jeff


