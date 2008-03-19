From: Volker Armin Hemmann <volker.armin.hemmann@tu-clausthal.de>
Subject: Re: 2.6.24.X: SATA/AHCI related boot delay. - not with 2.6.24.3
Date: Wed, 19 Mar 2008 11:08:18 +0100
Message-ID: <200803191108.18577.volker.armin.hemmann@tu-clausthal.de>
References: <200803091922.33083.volker.armin.hemmann@tu-clausthal.de> <200803190853.10030.volker.armin.hemmann@tu-clausthal.de> <47E0D5C8.9070005@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hades.rz.tu-clausthal.de ([139.174.2.20]:51274 "EHLO
	hades.rz.tu-clausthal.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755561AbYCSTcI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 19 Mar 2008 15:32:08 -0400
In-Reply-To: <47E0D5C8.9070005@gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

On Mittwoch, 19. M=E4rz 2008, Tejun Heo wrote:
> x UDMA/133 abar m8192@0xf9dfc000 port 0xf9dfc200
>
> > irq 315
> > [ =A0 38.125479] ata4: SATA max UDMA/133 abar m8192@0xf9dfc000 port
> > 0xf9dfc280 irq 315
> > [ =A0 38.597035] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl =
300)
> > [ =A0 38.597732] ata1.00: ATA-7: WDC WD1600JS-00MHB1, 10.02E01, max
> > UDMA/133 [ =A0 38.597775] ata1.00: 312581808 sectors, multi 16: LBA=
48
> > [ =A0 38.598405] ata1.00: configured for UDMA/133
> > [ =A0 39.069342] ata2: SATA link up 3.0 Gbps (SStatus 123 SControl =
300)
> > [ =A0 39.084225] ata2.00: ATA-8: SAMSUNG HD501LJ, CR100-12, max UDM=
A7
> > [ =A0 39.084264] ata2.00: 976773168 sectors, multi 16: LBA48 NCQ (d=
epth
> > 0/32) [ =A0 39.086268] ata2.00: configured for UDMA/133
>
> So, just to confirm. =A0With the updated patch, you don't see any pro=
blem,
> right?

Correct. With the updated patch I don't see problems in 'non-raid' mode=
=2E AHCI=20
mode still has problems without nosmi. But that is an entirely differen=
t=20
problem, right?

Gl=FCck Auf,
Volker
