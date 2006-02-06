From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: libata-core and pccard CF card reader
Date: Mon, 06 Feb 2006 22:50:09 +0000
Message-ID: <1139266210.10437.56.camel@localhost.localdomain>
References: <20060206221923.GA12063@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:8839 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S964845AbWBFWsY convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 6 Feb 2006 17:48:24 -0500
In-Reply-To: <20060206221923.GA12063@localhost>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mathieu Chouquet-Stringer <mchouque@free.fr>
Cc: linux-ide@vger.kernel.org, jgarzik@pobox.com, Mark Lord <lkml@rtr.ca>

On Llu, 2006-02-06 at 23:19 +0100, Mathieu Chouquet-Stringer wrote:
> ata id isn't ata, 0x848a

848A is CFA from memory. Probably it should be tested for and treated
either as disk, or quite possibly a new class.

> ATA documents, I found it's in fact a known ID and is defined as:
> "CompactFlash=E2=84=A2Association (CFA) feature set" (found in a bunc=
h of
> different working drafts of ATA-x).

Yes it has its own spec which is ATA plus other bits.

> - if it isn't, should we OR it with something like
>   || dev->id[0] =3D=3D 0x848a

I think you want to add an "is_cfa" type macro and check it too

> - or should we just test bit 7 of word 0 ("removable media device")?
> - or did I just open a new can of worms that will lead to adding a ne=
w
>   subclass of device (CFA feature set) in ata_dev_identify?

We know from dev->id that it is CFA so we can probably just call it a
disk

