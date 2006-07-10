From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Follow up? LibPATA code issues / 2.6.15.4 (found the
	opcode=0x35)!
Date: Mon, 10 Jul 2006 16:33:59 +0100
Message-ID: <1152545639.27368.137.camel@localhost.localdomain>
References: <Pine.LNX.4.64.0602140439580.3567@p34>
	 <44AEB3CA.8080606@pobox.com>
	 <Pine.LNX.4.64.0607071520160.2643@p34.internal.lan>
	 <200607091224.31451.liml@rtr.ca>
	 <Pine.LNX.4.64.0607091327160.23992@p34.internal.lan>
	 <Pine.LNX.4.64.0607091612060.3886@p34.internal.lan>
	 <Pine.LNX.4.64.0607091638220.2696@p34.internal.lan>
	 <Pine.LNX.4.64.0607091645480.2696@p34.internal.lan>
	 <Pine.LNX.4.64.0607091704250.2696@p34.internal.lan>
	 <Pine.LNX.4.64.0607091802460.2696@p34.internal.lan>
	 <Pine.LNX.4.64.0607100958540.3591@p34.internal.lan>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:61644 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1422649AbWGJPRH (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 10 Jul 2006 11:17:07 -0400
In-Reply-To: <Pine.LNX.4.64.0607100958540.3591@p34.internal.lan>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Justin Piszcz <jpiszcz@lucidpixels.com>
Cc: Mark Lord <liml@rtr.ca>, Jeff Garzik <jgarzik@pobox.com>, Sander <sander@humilis.net>, linux-kernel@vger.kernel.org, IDE/ATA development list <linux-ide@vger.kernel.org>

Ar Llu, 2006-07-10 am 09:59 -0400, ysgrifennodd Justin Piszcz:
> > [4297741.057000] ata_gen_fixed_sense: failed ata_op=0x35
> > [4297741.057000] ata4: translated ATA stat/err 0x51/04 to SCSI SK/ASC/ASCQ 
> > 0xb/00/00
> > [4297741.057000] ata_gen_ata_desc_sense: failed ata_op=0x51
> > [4297741.057000] ata4: status=0x51 { DriveReady SeekComplete Error }
> > [4297741.057000] ata4: error=0x04 { DriveStatusError }
> >
> > Also got a 0xca.

Thats "write" so if that is reporting as an unknown command something
very odd indeed is happening.


