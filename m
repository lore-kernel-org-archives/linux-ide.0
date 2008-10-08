From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: ide dvd burner detected as ide-tape
Date: Wed, 8 Oct 2008 21:25:58 +0200
Message-ID: <200810082125.58994.bzolnier@gmail.com>
References: <200810010100.06299.th@drillich.com> <200810031933.41994.bzolnier@gmail.com> <200810041412.44162.th@drillich.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gv-out-0910.google.com ([216.239.58.185]:20098 "EHLO
	gv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755919AbYJHT3B convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 8 Oct 2008 15:29:01 -0400
Received: by gv-out-0910.google.com with SMTP id e6so679819gvc.37
        for <linux-ide@vger.kernel.org>; Wed, 08 Oct 2008 12:29:01 -0700 (PDT)
In-Reply-To: <200810041412.44162.th@drillich.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Thomas Drillich <th@drillich.com>
Cc: Kay Sievers <kay.sievers@vrfy.org>, linux-hotplug@vger.kernel.org, linux-ide@vger.kernel.org


[ added linux-ide@ to cc: ]

On Saturday 04 October 2008, Thomas Drillich wrote:
> Am Freitag, 3. Oktober 2008 schrieb Bartlomiej Zolnierkiewicz:
> > On Wednesday 01 October 2008, Kay Sievers wrote:
> > > On Wed, Oct 1, 2008 at 1:00 AM, Thomas Drillich <th@drillich.com>=
 wrote:
> > > > I found in the syslog:
> > > > Sep 30 13:44:44 localhost kernel: ide-tape: hda <-> ht0:
> > > > HH-@T)SP=C8=B4/=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD1*0=
0 DRD)RAM GH22LP20P=EF=BF=BD{=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=
=BD=D0=BB=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BDHH-@T)SP=C8=B4/=EF=
=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD1*00
> > > > rev 1*00
> > > > Sep 30 13:44:44 localhost kernel: ide-tape: ht0: I/O error, pc =
=3D 1a,
> > > > key =3D  5, asc =3D 64, ascq =3D  0
> > > > Sep 30 13:44:44 localhost kernel: ide-tape: hda: invalid tape s=
peed
> > > > (assuming 650KB/sec)
> > > > Sep 30 13:44:44 localhost kernel: ide-tape: hda: invalid max_sp=
eed
> > > > (assuming 650KB/sec)
> > > > Sep 30 13:44:44 localhost kernel: ide-tape: ht0: I/O error, pc =
=3D 1a,
> > > > key =3D  5, asc =3D 64, ascq =3D  0
> > > > Sep 30 13:47:17 localhost kernel: ide-tape: hda <-> ht0:
> > > > HH-@T)SP=C8=B4/=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD1*0=
0 DRD)RAM GH22LP20P=EF=BF=BD{=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=
=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BDHH-@T)SP=C8=B4=
/=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD1*00
> > > > rev 1*00
> > > > Sep 30 13:47:17 localhost kernel: ide-tape: ht0: I/O error, pc =
=3D 1a,
> > > > key =3D  5, asc =3D 64, ascq =3D  0
> > > > Sep 30 13:47:17 localhost kernel: ide-tape: hda: invalid tape s=
peed
> > > > (assuming 650KB/sec)
> > > > Sep 30 13:47:17 localhost kernel: ide-tape: hda: invalid max_sp=
eed
> > > > (assuming 650KB/sec)
> > > > Sep 30 13:47:17 localhost kernel: ide-tape: ht0: I/O error, pc =
=3D 1a,
> > > > key =3D  5, asc =3D 64, ascq =3D  0
> > > > -- end snip
> > > >
> > > > but its a LG GH22LP20 DVD burner
> > > >
> > > > cat /sys/bus/ide/devices/0.0/model returns
> > > >        HL)DP-ST@V@-RAI CH22HP20
> > > >
> > > > what can I do ?
> > >
> > > Bart, any idea what's going wrong here, or how to work around it?
> >
> > ide-tape driving DVD burner is a "CANNOT happen" case...
> >
> > Thomas, which kernel version is it?  Please post a full dmesg outpu=
t.
> >
> Seems that can happen Bart ;-)
>=20
> it's a 2.6.26.5 kernel running on debian/testing.
>=20
> I moved ide now to module
>  alim15x3                7504  0 [permanent]
>  ide_pci_generic         5252  0 [permanent]
>  ide_core              140572  2 ide_pci_generic,alim15x3
>=20
> but it didn't changed anything .. as expected.
>=20
> >lspci
>  00:1f.0 IDE interface: ALi Corporation M5229 IDE (rev c7)
>=20
> I added /proc/config.gz to the dmesg output

Linux version 2.6.26.5-3.00-st20g5 (root@mzpc) (gcc version 4.3.1 (Debi=
an 4.3.1-9) ) #1 SMP PREEMPT Fri Oct 3 12:42:56 CEST 2008
=2E..
ALI15X3: IDE controller (0x10b9:0x5229 rev 0xc7) at  PCI slot 0000:00:1=
f.0
ACPI: PCI Interrupt 0000:00:1f.0[A] -> GSI 19 (level, low) -> IRQ 19
ALI15X3: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x8880-0x8887
    ide1: BM-DMA at 0x8888-0x888f
Probing IDE interface ide0...
=2E..
hda: HL)DP-ST@V@-RAI CH22HP20, ATAPI TAPE drive
=2E..

so this is a probing time device type misdectection
(yeah, the impossible has just happened ;).

Does BIOS also detect this device as "HL)DP-ST@V@-RAI"?

Please send the output of "hdparm --Istdout /dev/hda" so we can check
whether the problem is a bogus (corrupted?) identify data or some issue
with the device type detection code...

Could you also try 2.6.27-rc9?

Thanks,
Bart
