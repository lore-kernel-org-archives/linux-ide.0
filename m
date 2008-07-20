From: Borislav Petkov <petkovbb@googlemail.com>
Subject: Re: [PATCH] ide-floppy fix
Date: Sun, 20 Jul 2008 14:06:29 +0200
Message-ID: <20080720120629.GA16529@gollum.tnic>
References: <20080715053356.GA18628@gollum.tnic> <200807152258.49462.bzolnier@gmail.com> <20080716052047.GA12383@gollum.tnic> <200807161956.46981.bzolnier@gmail.com>
Reply-To: petkovbb@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.189]:17005 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753695AbYGTMGT (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 20 Jul 2008 08:06:19 -0400
Received: by nf-out-0910.google.com with SMTP id d3so322180nfc.21
        for <linux-ide@vger.kernel.org>; Sun, 20 Jul 2008 05:06:17 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <200807161956.46981.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, stable@kernel.org

Hi Bart,

On Wed, Jul 16, 2008 at 07:56:46PM +0200, Bartlomiej Zolnierkiewicz wro=
te:
> On Wednesday 16 July 2008, Borislav Petkov wrote:
> > On Tue, Jul 15, 2008 at 10:58:48PM +0200, Bartlomiej Zolnierkiewicz=
 wrote:
> > > On Tuesday 15 July 2008, Borislav Petkov wrote:
> > > > On Wed, Jul 16, 2008 at 05:59:16PM +0200, Bartlomiej Zolnierkie=
wicz wrote:
> > > > >=20
> > > > > Hi,
> > > > >=20
> > > > > On Tuesday 15 July 2008, Borislav Petkov wrote:
> > > > >=20
> > > > > [...]
> > > > >=20
> > > > > > On a different note, the current pata tree on top of v2.6.2=
5-2125-g50515af blows
> > > > > > up here with the following error:
> > > > > >=20
> > > > > > [    4.296729] Uniform Multi-Platform E-IDE driver
> > > > > > [    4.297905] ICH4: IDE controller (0x8086:0x24cb rev 0x02=
) at  PCI slot 0000:00:1f.1
> > > > > > [    4.297986] ACPI: PCI Interrupt 0000:00:1f.1[A] -> GSI 1=
8 (level, low) -> IRQ 18
> > > > > > [    4.298153] ICH4: not 100% native mode: will probe irqs =
later
> > > > > > [    4.298213]     ide0: BM-DMA at 0xfc00-0xfc07
> > > > > > [    4.298282]     ide1: BM-DMA at 0xfc08-0xfc0f
> > > > > > [    4.561768] hda: QUANTUM FIREBALLlct10 20, ATA DISK driv=
e
> > > > > > [    4.816724] hdb: SAMSUNG SP2014N, ATA DISK drive
> > > > > > [    4.867959] hda: drive side 80-wire cable detection fail=
ed, limiting max speed to UDMA33
> > > > > > [    4.868027] hda: UDMA/33 mode selected
> > > > > > [    4.868441] hdb: UDMA/100 mode selected
> > > > > > [    5.540683] hdc: IOMEGA ZIP 100 ATAPI, ATAPI FLOPPY driv=
e
> > > > > > [    5.795564] hdd: IC35L120AVV207-0, ATA DISK drive
> > > > > > [    5.847295] hdd: host side 80-wire cable detection faile=
d, limiting max speed to UDMA33
> > > > > > [    5.847362] hdd: UDMA/33 mode selected
> > > > > > [    5.847715] ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
> > > > > > [    5.855487] ide1 at 0x170-0x177,0x376 on irq 15
> > > > > > [    5.875927] ide_generic: please use "probe_mask=3D0x3f" =
module parameter for probing all legacy ISA IDE ports
> > > > > > [    5.876012] ide_generic: I/O resource 0x1F0-0x1F7 not fr=
ee.
> > > > > > [    5.876074] ide_generic: I/O resource 0x170-0x177 not fr=
ee.
> > > > > > [   11.342504] hde: no response (status =3D 0xa1), resettin=
g drive
> > > > > > [   17.206535] hdf: no response (status =3D 0xa1), resettin=
g drive
> > > > >=20
> > > > > hde? hdf?
> > > > >=20
> > > > > [...]
> > > >=20
> > > > yep, looks strange to me too. Isn't that the MAX_HWIFS upper bo=
und of a loop.. ?
> > >=20
> > > Close, it is related to MAX_HWIFS being upper bound on hws[]
> > > in ide_generic.c but now we loop for ARRAY_SIZE(legacy_bases).
> > >=20
> > > IOW there is a memset(hws, 0, MAX_HWIFS) missing at the top of
> > > ide_generic_init() (please re-test after adding it).
> > >=20
> > > This may also explain the later problems with ide_host_register()=
=2E
>=20
> I fixed this in pata tree now with:
>=20
> "ide-generic: remove ide_default_{io_base,irq}() inlines (take 2)" pa=
tch

here's the root cause for the problem: I had both Intel ICH chipset
(BLK_DEV_PIIX) und generic ide (BLK_DEV_GENERIC) selected in Kconfig an=
d since
ICH4 uses the generic driver detection routine, the second(!) generic d=
etection after the
ICH4 one failed and died. This is why request_region()-resources are sh=
own as
not being free above:

> > > > > > [    5.875927] ide_generic: please use "probe_mask=3D0x3f" =
module parameter for probing all legacy ISA IDE ports
> > > > > > [    5.876012] ide_generic: I/O resource 0x1F0-0x1F7 not fr=
ee.
> > > > > > [    5.876074] ide_generic: I/O resource 0x170-0x177 not fr=
ee.

One of the possible fixes is adding

depends on !BLK_DEV_GENERIC

after each IDE chipset driver using the generic detection in drivers/id=
e/Kconfig
but it's a not-that-elegant one. Another thing would be using a dummy o=
ne like
BLK_DEV_IDEDMA_PCI, but I'm not that sure. Will look into it. I'm prett=
y sure
you have a better idea...

>=20
> > > > > > From: Borislav Petkov <petkovbb@gmail.com>
> > > > > >=20
> > > > > > Check the correct flags-location for set features.
> > > > > >=20
> > > > > > Signed-off-by: Borislav Petkov <petkovbb@gmail.com>
> > > > >=20
> > > > > Thanks, I folded the fix into original patch (->dev_flags is =
not yet
> > > > > upstream so -stable fix shouldn't be necessary).
> > > > >=20
> > > > > While on it: I later noticed that there will be also need for=
 common
> > > > > ATA/ATAPI ->dev_flags in the future so I wonder whether curre=
nt
> > > > > ->dev_flags should be renamed to ->atapi_flags (& s/*DFLAG*/*=
AFLAG*/).
> > > > >=20
> > > > > If there is agreement on this I'll fix it in pata tree.
> > > >=20
> > > > ... or if there's room, use a single ->dev_flags for all possib=
le flag settings?
> > >=20
> > > Unfortunately there isn't enough room left (27 bits are occupied =
ATM)
> > > and having u64 ->dev_flags sucks...
> >=20
> > I'm pretty sure some of the 27 will be removed later but yeah, u64 =
flags is
> > kinda bad since it has to be always atomically updated and this has=
 to be
> > explicitly staged on 32bit cpus due to the wordsize. I guess two fl=
ags members
>=20
> ->dev_flags -> ->atapi_flags & co. are also in pata tree now
>=20
> > are the easiest thing to do for now, you might add some comments to=
 both so we
> > know which is which.
>=20
> Sure, I will remember about this when it comes time for ->dev_flags.
>=20
> Thanks,
> Bart

--=20
Regards/Gru=DF,
    Boris.
