From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: ide dvd burner detected as ide-tape
Date: Thu, 9 Oct 2008 20:13:50 +0200
Message-ID: <200810092013.50945.bzolnier@gmail.com>
References: <200810010100.06299.th@drillich.com> <200810082125.58994.bzolnier@gmail.com> <200810091643.53702.th@drillich.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.250]:14681 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757739AbYJISP5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 9 Oct 2008 14:15:57 -0400
Received: by an-out-0708.google.com with SMTP id d40so13646and.103
        for <linux-ide@vger.kernel.org>; Thu, 09 Oct 2008 11:15:54 -0700 (PDT)
In-Reply-To: <200810091643.53702.th@drillich.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Thomas Drillich <th@drillich.com>
Cc: linux-hotplug@vger.kernel.org, linux-ide@vger.kernel.org

On Thursday 09 October 2008, Thomas Drillich wrote:
> Am Mittwoch, 8. Oktober 2008 schrieb Bartlomiej Zolnierkiewicz:
> > [ added linux-ide@ to cc: ]
> >
> > On Saturday 04 October 2008, Thomas Drillich wrote:
> > > Am Freitag, 3. Oktober 2008 schrieb Bartlomiej Zolnierkiewicz:
> > > > On Wednesday 01 October 2008, Kay Sievers wrote:
> > > > > On Wed, Oct 1, 2008 at 1:00 AM, Thomas Drillich <th@drillich.=
com>=20
> wrote:
> > > > > > I found in the syslog:
> > > > > > Sep 30 13:44:44 localhost kernel: ide-tape: hda <-> ht0:
> > > > > > HH-@T)SP=C8=B4/=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=
1*00 DRD)RAM
> > > > > > GH22LP20P=EF=BF=BD{=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=
=BD=D0=BB=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BDHH-@T)SP=C8=B4/=EF=
=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD1*00 rev 1*00
> > > > > > Sep 30 13:44:44 localhost kernel: ide-tape: ht0: I/O error,=
 pc =3D
> > > > > > 1a, key =3D  5, asc =3D 64, ascq =3D  0
> > > > > > Sep 30 13:44:44 localhost kernel: ide-tape: hda: invalid ta=
pe speed
> > > > > > (assuming 650KB/sec)
> > > > > > Sep 30 13:44:44 localhost kernel: ide-tape: hda: invalid ma=
x_speed
> > > > > > (assuming 650KB/sec)
> > > > > > Sep 30 13:44:44 localhost kernel: ide-tape: ht0: I/O error,=
 pc =3D
> > > > > > 1a, key =3D  5, asc =3D 64, ascq =3D  0
> > > > > > Sep 30 13:47:17 localhost kernel: ide-tape: hda <-> ht0:
> > > > > > HH-@T)SP=C8=B4/=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=
1*00 DRD)RAM
> > > > > > GH22LP20P=EF=BF=BD{=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=
=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BDHH-@T)SP=C8=B4=
/=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD1*00 rev 1*00
> > > > > > Sep 30 13:47:17 localhost kernel: ide-tape: ht0: I/O error,=
 pc =3D
> > > > > > 1a, key =3D  5, asc =3D 64, ascq =3D  0
> > > > > > Sep 30 13:47:17 localhost kernel: ide-tape: hda: invalid ta=
pe speed
> > > > > > (assuming 650KB/sec)
> > > > > > Sep 30 13:47:17 localhost kernel: ide-tape: hda: invalid ma=
x_speed
> > > > > > (assuming 650KB/sec)
> > > > > > Sep 30 13:47:17 localhost kernel: ide-tape: ht0: I/O error,=
 pc =3D
> > > > > > 1a, key =3D  5, asc =3D 64, ascq =3D  0
> > > > > > -- end snip
> > > > > >
> > > > > > but its a LG GH22LP20 DVD burner
> > > > > >
> > > > > > cat /sys/bus/ide/devices/0.0/model returns
> > > > > >        HL)DP-ST@V@-RAI CH22HP20
> > > > > >
> > > > > > what can I do ?
> > > > >
> > > > > Bart, any idea what's going wrong here, or how to work around=
 it?
> > > >
> > > > ide-tape driving DVD burner is a "CANNOT happen" case...
> > > >
> > > > Thomas, which kernel version is it?  Please post a full dmesg o=
utput.
> > >
> > > Seems that can happen Bart ;-)
> > >
> > > it's a 2.6.26.5 kernel running on debian/testing.
> > >
> > > I moved ide now to module
> > >  alim15x3                7504  0 [permanent]
> > >  ide_pci_generic         5252  0 [permanent]
> > >  ide_core              140572  2 ide_pci_generic,alim15x3
> > >
> > > but it didn't changed anything .. as expected.
> > >
> > > >lspci
> > >
> > >  00:1f.0 IDE interface: ALi Corporation M5229 IDE (rev c7)
> > >
> > > I added /proc/config.gz to the dmesg output
> >
> > Linux version 2.6.26.5-3.00-st20g5 (root@mzpc) (gcc version 4.3.1 (=
Debian
> > 4.3.1-9) ) #1 SMP PREEMPT Fri Oct 3 12:42:56 CEST 2008 ...
> > ALI15X3: IDE controller (0x10b9:0x5229 rev 0xc7) at  PCI slot 0000:=
00:1f.0
> > ACPI: PCI Interrupt 0000:00:1f.0[A] -> GSI 19 (level, low) -> IRQ 1=
9
> > ALI15X3: not 100% native mode: will probe irqs later
> >     ide0: BM-DMA at 0x8880-0x8887
> >     ide1: BM-DMA at 0x8888-0x888f
> > Probing IDE interface ide0...
> > ...
> > hda: HL)DP-ST@V@-RAI CH22HP20, ATAPI TAPE drive
> > ...
> >
> > so this is a probing time device type misdectection
> > (yeah, the impossible has just happened ;).
> >
> > Does BIOS also detect this device as "HL)DP-ST@V@-RAI"?
> yes
> >
> > Please send the output of "hdparm --Istdout /dev/hda" so we can che=
ck
> > whether the problem is a bogus (corrupted?) identify data or some i=
ssue
> > with the device type detection code...
> I'm not able to run hdparam on /dev/hda, udev won't create the device=
 file and
> if I create the device file manually hdparam just stop working.
>=20
> I'd attached cat /proc/ide/hda/identify (hda.identify.txt.gz).
>=20
> >
> > Could you also try 2.6.27-rc9?
> no changes in that kernel version .. I attachted output of dmesg of t=
hat=20
> kernel version.

Thanks.  Does the following patch help?

=46rom: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] ide: quirk for LG GH22LP20 DVD burner

LG GH22LP20 DVD burner ("HL)DP-ST@V@-RAI CH22HP20") with firmware 1.00
reports 0x01 ("Sequential-access device") as the peripheral device type
instead of 0x05 ("CD-ROM device").

Reported-by: Thomas Drillich <th@drillich.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-probe.c |    9 +++++++++
 1 file changed, 9 insertions(+)

Index: b/drivers/ide/ide-probe.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/drivers/ide/ide-probe.c
+++ b/drivers/ide/ide-probe.c
@@ -106,6 +106,12 @@ static void ide_disk_init_mult_count(ide
 	}
 }
=20
+/* LG GH22LP20 DVD burner reports bad peripheral device type */
+static const struct drive_list_entry bad_media_type_list[] =3D {
+	{ "HL)DP-ST@V@-RAI CH22HP20",	"1.00" },
+	{ NULL,		NULL }
+};
+
 /**
  *	do_identify	-	identify a drive
  *	@drive: drive to identify=20
@@ -166,6 +172,9 @@ static inline void do_identify (ide_driv
 	if (cmd =3D=3D WIN_PIDENTIFY) {
 		u8 type =3D (id->config >> 8) & 0x1f;
=20
+		if (ide_in_drive_list(id, bad_media_type_list))
+			type =3D ide_cdrom;
+
 		printk(KERN_CONT "ATAPI ");
 		switch (type) {
 			case ide_floppy:
