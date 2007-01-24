From: =?iso-8859-1?Q?Oddbj=F8rn?= Kvalsund <oddbjorn@nixx.no>
Subject: Re: Possible performance issue with sata_sil og Gigabyte i-Ram
Date: Wed, 24 Jan 2007 12:17:01 +0100
Message-ID: <20070124111700.GL1054@nixx.no>
References: <20070123205301.GK1054@nixx.no> <20070123232113.0d6e8b4e@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nixx.no ([80.68.92.62]:34375 "EHLO nixx.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751195AbXAXLVn (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 24 Jan 2007 06:21:43 -0500
Content-Disposition: inline
In-Reply-To: <20070123232113.0d6e8b4e@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan <alan@lxorguk.ukuu.org.uk>
Cc: linux-ide@vger.kernel.org

On Tue 23 Jan 23:21, Alan wrote:
> > Other people using this device report of read/write speeds constant=
ly
> > maxing out their SATA150 or PCI-bus. Is this my sil3114 being the
> > bottleneck? Other devices on the PCI-bus? My general system (see li=
nk to
>=20
> Possibly. 80Mbytes/sec seems to be about all you get from PCI bus wit=
h
> many machines. Remember the SATA150, UDMA/133 and PCI bus limits are
> largely theoretical, especially as most ATA controllers have signific=
ant
> turn around time between commands and cannot queue.

Ah, alright. I'll try to remove the other cards on the PCI-bus to see i=
f
that makes a difference, if not; well I guess 80 MB/s isn't that bad :)

> > from what I can tell from dmesg (U)DMA should be enabled for this d=
rive.
> > I have tried enabling UDMA/133 for the controller (in sata_sil.c), =
giving this
> > output on boot:
>=20
> If you are getting 80Mb/sec then UDMA is enabled 8)

Good!

> > I'm using the old piix-driver (not libata) for the IBM-disk, as I w=
as
> > having some problems getting it to work with the libata-driver. I m=
ight
>=20
> What sort of problems ? I've got an iRAM here for debugging/testing
> courtesy of a company using them and the one I have seems to pass all=
 the
> testing I've thrown at it.

Sorry, I was cramming too much information into that sentence.

I was having problems getting the _IBM IDE-disk_, not the i-Ram, workin=
g
with the ata_piix. I haven't really dug deep into this, but I suspect
it's probably something silly like the drive changing identifier
(hda -> sda) or something like that.

Do you thing this (using the regular piix-driver for the IBM system dis=
k
and the sata_sil-driver for the i-Ram) could be causing any performance
problems?

--=20
Oddbj=F8rn Kvalsund
