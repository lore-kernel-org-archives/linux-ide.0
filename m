From: Borislav Petkov <petkovbb@googlemail.com>
Subject: Re: [PATCH] ide-floppy fix
Date: Wed, 16 Jul 2008 07:20:47 +0200
Message-ID: <20080716052047.GA12383@gollum.tnic>
References: <20080715053356.GA18628@gollum.tnic> <200807161759.16803.bzolnier@gmail.com> <20080715203913.GA23431@gollum.tnic> <200807152258.49462.bzolnier@gmail.com>
Reply-To: petkovbb@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.159]:48684 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751688AbYGPFUa (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 16 Jul 2008 01:20:30 -0400
Received: by fg-out-1718.google.com with SMTP id 19so2389422fgg.17
        for <linux-ide@vger.kernel.org>; Tue, 15 Jul 2008 22:20:28 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <200807152258.49462.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, stable@kernel.org

On Tue, Jul 15, 2008 at 10:58:48PM +0200, Bartlomiej Zolnierkiewicz wro=
te:
> On Tuesday 15 July 2008, Borislav Petkov wrote:
> > On Wed, Jul 16, 2008 at 05:59:16PM +0200, Bartlomiej Zolnierkiewicz=
 wrote:
> > >=20
> > > Hi,
> > >=20
> > > On Tuesday 15 July 2008, Borislav Petkov wrote:
> > >=20
> > > [...]
> > >=20
> > > > On a different note, the current pata tree on top of v2.6.25-21=
25-g50515af blows
> > > > up here with the following error:
> > > >=20
> > > > [    4.296729] Uniform Multi-Platform E-IDE driver
> > > > [    4.297905] ICH4: IDE controller (0x8086:0x24cb rev 0x02) at=
  PCI slot 0000:00:1f.1
> > > > [    4.297986] ACPI: PCI Interrupt 0000:00:1f.1[A] -> GSI 18 (l=
evel, low) -> IRQ 18
> > > > [    4.298153] ICH4: not 100% native mode: will probe irqs late=
r
> > > > [    4.298213]     ide0: BM-DMA at 0xfc00-0xfc07
> > > > [    4.298282]     ide1: BM-DMA at 0xfc08-0xfc0f
> > > > [    4.561768] hda: QUANTUM FIREBALLlct10 20, ATA DISK drive
> > > > [    4.816724] hdb: SAMSUNG SP2014N, ATA DISK drive
> > > > [    4.867959] hda: drive side 80-wire cable detection failed, =
limiting max speed to UDMA33
> > > > [    4.868027] hda: UDMA/33 mode selected
> > > > [    4.868441] hdb: UDMA/100 mode selected
> > > > [    5.540683] hdc: IOMEGA ZIP 100 ATAPI, ATAPI FLOPPY drive
> > > > [    5.795564] hdd: IC35L120AVV207-0, ATA DISK drive
> > > > [    5.847295] hdd: host side 80-wire cable detection failed, l=
imiting max speed to UDMA33
> > > > [    5.847362] hdd: UDMA/33 mode selected
> > > > [    5.847715] ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
> > > > [    5.855487] ide1 at 0x170-0x177,0x376 on irq 15
> > > > [    5.875927] ide_generic: please use "probe_mask=3D0x3f" modu=
le parameter for probing all legacy ISA IDE ports
> > > > [    5.876012] ide_generic: I/O resource 0x1F0-0x1F7 not free.
> > > > [    5.876074] ide_generic: I/O resource 0x170-0x177 not free.
> > > > [   11.342504] hde: no response (status =3D 0xa1), resetting dr=
ive
> > > > [   17.206535] hdf: no response (status =3D 0xa1), resetting dr=
ive
> > >=20
> > > hde? hdf?
> > >=20
> > > [...]
> >=20
> > yep, looks strange to me too. Isn't that the MAX_HWIFS upper bound =
of a loop.. ?
>=20
> Close, it is related to MAX_HWIFS being upper bound on hws[]
> in ide_generic.c but now we loop for ARRAY_SIZE(legacy_bases).
>=20
> IOW there is a memset(hws, 0, MAX_HWIFS) missing at the top of
> ide_generic_init() (please re-test after adding it).
>=20
> This may also explain the later problems with ide_host_register().
>=20
> > > > From: Borislav Petkov <petkovbb@gmail.com>
> > > >=20
> > > > Check the correct flags-location for set features.
> > > >=20
> > > > Signed-off-by: Borislav Petkov <petkovbb@gmail.com>
> > >=20
> > > Thanks, I folded the fix into original patch (->dev_flags is not =
yet
> > > upstream so -stable fix shouldn't be necessary).
> > >=20
> > > While on it: I later noticed that there will be also need for com=
mon
> > > ATA/ATAPI ->dev_flags in the future so I wonder whether current
> > > ->dev_flags should be renamed to ->atapi_flags (& s/*DFLAG*/*AFLA=
G*/).
> > >=20
> > > If there is agreement on this I'll fix it in pata tree.
> >=20
> > ... or if there's room, use a single ->dev_flags for all possible f=
lag settings?
>=20
> Unfortunately there isn't enough room left (27 bits are occupied ATM)
> and having u64 ->dev_flags sucks...

I'm pretty sure some of the 27 will be removed later but yeah, u64 flag=
s is
kinda bad since it has to be always atomically updated and this has to =
be
explicitly staged on 32bit cpus due to the wordsize. I guess two flags =
members
are the easiest thing to do for now, you might add some comments to bot=
h so we
know which is which.

--=20
Regards/Gru=DF,
    Boris.
