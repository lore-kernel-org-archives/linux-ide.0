From: Hein-Pieter van Braam <hp@tmm.cx>
Subject: Re: 2.6.24.3: regular sata drive resets - worrisome?
Date: Sun, 30 Mar 2008 23:02:15 +0200
Message-ID: <1206910935.12026.2.camel@liza>
References: <200803201518.32109.hpj@urpla.net>
	 <200803300114.40096.hpj@urpla.net> <47EEE4BF.5080609@gmail.com>
	 <200803301400.10766.hpj@urpla.net>  <47EF8A65.1010005@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.tmm.cx ([64.79.204.148]:60043 "EHLO mail.tmm.cx"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753188AbYC3VK0 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 30 Mar 2008 17:10:26 -0400
In-Reply-To: <47EF8A65.1010005@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Roger Heflin <rogerheflin@gmail.com>
Cc: linux-ide@vger.kernel.org

On Sun, 2008-03-30 at 07:41 -0500, Roger Heflin wrote:
> Hans-Peter Jansen wrote:
> > Am Sonntag, 30. M=C3=A4rz 2008 schrieb Tejun Heo:
> >> Hello,
> >>
> >> Hans-Peter Jansen wrote:
> >>>>>> Should I be worried? smartd doesn't show anything suspicious o=
n
> >>>>>> those.
> >>>> Can you please post the result of "smartctl -a /dev/sdX"?
> >>> Here's the last smart report from two of the offending drives. As=
 noted
> >>> before, I did the hardware reorganization, replaced the dog slow =
3ware
> >>> 9500S-8 and the SiI 3124 with a single Areca 1130 and retired the
> >>> drives for now, but a nephew already showed interest. What do you
> >>> think, can I cede those drives with a clear conscience? The
> >>> Hardware_ECC_Recovered values are really worrisome, aren't they?
> >> Different vendors use different scales for the raw values.  The va=
lue is
> >> still pegged at the highest so it could be those raw values are ok=
ay or
> >> that the vendor just doesn't update value field accordingly.  My P=
120
> >> says 0 for the raw value and 904635 for hardware ECC recovered so =
there
> >> is some difference.  What do other non-failing drives say about th=
ose
> >> values?
> >=20
> > The only non-failing drive was sdf as it was running in standby mod=
e in this=20
> > md raid 5 ensemble:
> >=20
> > 20080323-011337-sdc.log:195 Hardware_ECC_Recovered  0x001a   100   =
100   000    Old_age   Always       -       162956700
> > 20080323-011337-sdc.log:196 Reallocated_Event_Count 0x0032   253   =
253   000    Old_age   Always       -       0
> > 20080323-011337-sdc.log:197 Current_Pending_Sector  0x0012   253   =
253   000    Old_age   Always       -       0
> > 20080323-011337-sdc.log:198 Offline_Uncorrectable   0x0030   253   =
253   000    Old_age   Offline      -       0
> > 20080323-011337-sdc.log:199 UDMA_CRC_Error_Count    0x003e   200   =
200   000    Old_age   Always       -       0
> > 20080323-011338-sdd.log:195 Hardware_ECC_Recovered  0x001a   100   =
100   000    Old_age   Always       -       162520674
> > 20080323-011338-sdd.log:196 Reallocated_Event_Count 0x0032   253   =
253   000    Old_age   Always       -       0
> > 20080323-011338-sdd.log:197 Current_Pending_Sector  0x0012   253   =
253   000    Old_age   Always       -       0
> > 20080323-011338-sdd.log:198 Offline_Uncorrectable   0x0030   253   =
253   000    Old_age   Offline      -       0
> > 20080323-011338-sdd.log:199 UDMA_CRC_Error_Count    0x003e   200   =
200   000    Old_age   Always       -       0
> > 20080323-011338-sde.log:195 Hardware_ECC_Recovered  0x001a   100   =
100   000    Old_age   Always       -       148429049
> > 20080323-011338-sde.log:196 Reallocated_Event_Count 0x0032   253   =
253   000    Old_age   Always       -       0
> > 20080323-011338-sde.log:197 Current_Pending_Sector  0x0012   253   =
253   000    Old_age   Always       -       0
> > 20080323-011338-sde.log:198 Offline_Uncorrectable   0x0030   253   =
253   000    Old_age   Offline      -       0
> > 20080323-011338-sde.log:199 UDMA_CRC_Error_Count    0x003e   200   =
200   000    Old_age   Always       -       0
> > 20080323-011339-sdf.log:195 Hardware_ECC_Recovered  0x001a   100   =
100   000    Old_age   Always       -       1559
> > 20080323-011339-sdf.log:196 Reallocated_Event_Count 0x0032   253   =
253   000    Old_age   Always       -       0
> > 20080323-011339-sdf.log:197 Current_Pending_Sector  0x0012   253   =
253   000    Old_age   Always       -       0
> > 20080323-011339-sdf.log:198 Offline_Uncorrectable   0x0030   253   =
253   000    Old_age   Offline      -       0
> > 20080323-011339-sdf.log:199 UDMA_CRC_Error_Count    0x003e   200   =
200   000    Old_age   Always       -       0
> >=20
> >> Hmmm... If the drive is failing FLUSHs, I would expect to see elev=
ated
> >> reallocation counters and maybe some pending counts.  Aieee.. weir=
d.
> >=20
> > But there are no reallocations nor any pending sectors on any of th=
em.
> >=20
> >>>>>> It's been 4 samsung drives at all hanging on a sata sil 3124:
> >>>> FLUSH_EXT timing out usually indicates that the drive is having
> >>>> problem writing out what it has in its cache to the media.  Ther=
e was
> >>>> one case where FLUSH_EXT timeout was caused by the driver failin=
g to
> >>>> switch controller back from NCQ mode before issuing FLUSH_EXT bu=
t that
> >>>> was on sata_nv.  There hasn't been any similar problem on sata_s=
il24.
> >>> Hmm, I didn't noticed any data distortions, and if there where, t=
hey
> >>> live on as copies in their new home..
> >> It should have appeared as read errors.  Maybe the drive successfu=
lly
> >                              ^^^^
> >                              write (I guess)
> >> wrote those sectors after 30+ secs timeout.
> >=20
> > That would point to some driver issue, wouldn't it? Roger Heflin al=
so
> > experienced similar behavior with that controller, which wasn't=20
> > reproducible with another.=20
> >=20
> > I can offer to you rebuilding that md in a test environment, and gi=
ving=20
> > you access to it, if you're interested.
> >=20
> > Anyway, thanks for caring Tejun,
> > Pete
> >=20
>=20
> Here are the errors I get, though look at it closer, I am don't appea=
r to be=20
> getting the reset, just this error from time to time:
>=20
> sd 9:0:0:0: [sde] 976773168 512-byte hardware sectors (500108 MB)
> sd 9:0:0:0: [sde] Write Protect is off
> sd 9:0:0:0: [sde] Mode Sense: 00 3a 00 00
> sd 9:0:0:0: [sde] Write cache: enabled, read cache: enabled, doesn't =
support DPO=20
> or FUA
> ata8.00: exception Emask 0x0 SAct 0x0 SErr 0x280000 action 0x0
> ata8.00: BMDMA2 stat 0x687d8009
> ata8.00: cmd 25/00:80:a7:00:1d/00:01:1d:00:00/e0 tag 0 cdb 0x0 data 1=
96608 in
>           res 51/04:8f:98:01:1d/00:00:1d:00:00/f0 Emask 0x1 (device e=
rror)
> ata8.00: configured for UDMA/100
> ata8: EH complete
> sd 7:0:0:0: [sdd] 976773168 512-byte hardware sectors (500108 MB)
> sd 7:0:0:0: [sdd] Write Protect is off
> sd 7:0:0:0: [sdd] Mode Sense: 00 3a 00 00
> sd 7:0:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't =
support DPO=20
> or FUA
>=20
> I have 4 identical disks, with all 4 connected to the SIL controller =
all give=20
> some errors, moving 2 of the disks to a promise controller makes the =
errors go=20
> away on the 2 connected to the promise controller.   All drives are p=
art of a=20
> software raid5 array.
>=20
> Startup looks like this:
> sata_sil 0000:00:09.0: version 2.3
> ACPI: PCI Interrupt 0000:00:09.0[A] -> GSI 16 (level, low) -> IRQ 20
> sata_sil 0000:00:09.0: Applying R_ERR on DMA activate FIS errata fix
> scsi7 : sata_sil
> scsi8 : sata_sil
> scsi9 : sata_sil
> scsi10 : sata_sil
> ata8: SATA max UDMA/100 cmd 0xf8942080 ctl 0xf894208a bmdma 0xf894200=
0 irq 20
> ata9: SATA max UDMA/100 cmd 0xf89420c0 ctl 0xf89420ca bmdma 0xf894200=
8 irq 20
> ata10: SATA max UDMA/100 cmd 0xf8942280 ctl 0xf894228a bmdma 0xf89422=
00 irq 20
> ata11: SATA max UDMA/100 cmd 0xf89422c0 ctl 0xf89422ca bmdma 0xf89422=
08 irq 20
>=20
> Right now I am running 2.6.23.15-80.fc7, but have also got the errors=
 under 2.6.23.1

I know this is probably not too helpful, but I had the same or similar
problems on a sata_nv based controller back in 2.6.20 ish times. I neve=
r
reported it, sadly... but I managed to get them to go away by disabling
adma on the controller.

Probably not very helpful, 2 cents, and all :)

>=20
>                                      Roger
> --
> To unsubscribe from this list: send the line "unsubscribe linux-ide" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

