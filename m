From: Adrian Bunk <bunk@stusta.de>
Subject: Re: Kernel panic with 2.6.15-rc7 + libata1 patch
Date: Sun, 1 Jan 2006 15:57:02 +0100
Message-ID: <20060101145702.GV3811@stusta.de>
References: <43B724BA.90405@bj-ig.de> <43B7EA0A.7040805@bj-ig.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:39696 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932222AbWAAO5C (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 1 Jan 2006 09:57:02 -0500
Content-Disposition: inline
In-Reply-To: <43B7EA0A.7040805@bj-ig.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Ralf =?iso-8859-1?Q?M=FCller?= <ralf@bj-ig.de>
Cc: linux-kernel@vger.kernel.org, jgarzik@pobox.com, linux-ide@vger.kernel.org

On Sun, Jan 01, 2006 at 03:41:14PM +0100, Ralf M=FCller wrote:
> Ralf M=FCller schrieb:
> >Had the following kernel panic with 2.6.15-rc7 + libata1 2.6.15-rc6=20
> >patch (http://www.kernel.org/pub/linux/kernel/people/jgarzik/libata/=
).
> >Ocurred when calling "hddtemp" on a SATA device which has been in=20
> >standby. Maybe someone is interesed:
> >
> >Dec 31 12:45:08 DatenGrab kernel: ATA: abnormal status 0xFF on port=20
> >0xE02A821CDec 31 12:45:11 DatenGrab kernel: ata3: unknown timeout, c=
md=20
> >0xb0 stat 0xffDec 31 12:45:11 DatenGrab kernel: ata3: translated ATA=
=20
> >stat/err 0xff/00 to SCSI SK/ASC/ASCQ 0xb/47/00Dec 31 12:45:11 DatenG=
rab=20
> >kernel: ata3: status=3D0xff { Busy }Dec 31 12:45:11 DatenGrab kernel=
:=20
> >Assertion failed! qc !=3D=20
> >NULL,drivers/scsi/libata-core.c,ata_pio_block,line=3D3216Dec 31 12:4=
5:11=20
> >DatenGrab kernel: e02d9a3e
> >Dec 31 12:45:11 DatenGrab kernel: Modules linked in: iptable_filter=20
> >ip_tables w83627hf hwmon_vid hwmon eeprom i2c_isa nfsd edd ipv6 butt=
on=20
> >battery ac af_packet xfs exportfs reiserfs ohci1394 ieee1394 sk98lin=
=20
> >generic i2c_i801 i2c_core i8xx_tco shpchp pci_hotplug intel_agp agpg=
art=20
> >uhci_hcd raid5 xor parport_pc lp parport sata_promise libata dm_mod =
sg=20
> >skge ohci_hcd ehci_hcd usb_storage usbcore fan thermal processor pii=
x=20
> >sd_mod scsi_mod ide_disk ide_core
> >Dec 31 12:45:11 DatenGrab kernel: CPU:    0Dec 31 12:45:11 DatenGrab=
=20
> >kernel: EIP:    0060:[<e02d9a3e>]    Not tainted VLI
> >Dec 31 12:45:11 DatenGrab kernel: EFLAGS: 00010292 (2.6.15-rc6-defau=
lt)=20
> >Dec 31 12:45:11 DatenGrab kernel: EIP is at ata_pio_block+0xb9/0xfd=20
> >[libata]
> >Dec 31 12:45:11 DatenGrab kernel: eax: 00000056   ebx: c14b5284   ec=
x:=20
> >00000000   edx: 00000000
> >Dec 31 12:45:11 DatenGrab kernel: esi: 58894f50   edi: 00000000   eb=
p:=20
> >c14b5284   esp: de3a7f70
> >Dec 31 12:45:11 DatenGrab kernel: ds: 007b   es: 007b   ss: 0068
> >Dec 31 12:45:11 DatenGrab kernel: Process ata/0 (pid: 2181,=20
> >threadinfo=3Dde3a6000 task=3Dde371a90)
> >Dec 31 12:45:11 DatenGrab kernel: Stack: c14b5284 def063c0 00000287=20
> >e02d9b00 c14b583c c01230a6 e02d9ae3 00000001
> >Dec 31 12:45:11 DatenGrab kernel:        00000000 00000000 00010000=20
> >00000000 00000000 de371a90 c01150bc 00100100
> >Dec 31 12:45:11 DatenGrab kernel:        00200200 ffffffff ffffffff=20
> >de3a6000 de0dbf54 def063c0 c0122f67 c0125c8f
> >Dec 31 12:45:11 DatenGrab kernel: Call Trace:
> >Dec 31 12:45:11 DatenGrab kernel:  [<e02d9b00>] ata_pio_task+0x1d/0x=
54=20
> >[libata]
> >Dec 31 12:45:11 DatenGrab kernel:  [<c01230a6>] worker_thread+0x13f/=
0x19d
> >Dec 31 12:45:11 DatenGrab kernel:  [<e02d9ae3>] ata_pio_task+0x0/0x5=
4=20
> >[libata]
> >Dec 31 12:45:11 DatenGrab kernel:  [<c01150bc>]=20
> >default_wake_function+0x0/0xc
> >Dec 31 12:45:11 DatenGrab kernel:  [<c0122f67>] worker_thread+0x0/0x=
19d
> >Dec 31 12:45:11 DatenGrab kernel:  [<c0125c8f>] kthread+0x63/0x8f
> >Dec 31 12:45:11 DatenGrab kernel:  [<c0125c2c>] kthread+0x0/0x8f
> >Dec 31 12:45:11 DatenGrab kernel:  [<c0101281>]=20
> >kernel_thread_helper+0x5/0xb
> >Dec 31 12:45:11 DatenGrab kernel: Code: 89 df 81 c7 d4 04 00 00 75 2=
1 68=20
> >90 0c 00 00 68 fb cd 2d e0 68 ef cf 2d e0 68 b0 d5 2d e0 68 61 d0 2d=
 e0=20
> >e8 19 e1 e3 df 83 c4 14 <8a> 47 14 83 e8 05 3c 02 77 1b 83 e6 08 75 =
0c=20
> >c7 83 e4 05 00 00
> >Dec 31 12:45:14 DatenGrab kernel:  <3>ata5: unknown timeout, cmd 0xb=
0=20
> >stat 0x58
>=20
> Sorry - the above oops has been with plain 2.6.15-rc7 - the libata1
> patch has been applied but not yet installed at the time of this kern=
el
> panic. With the libata1 patch installed the sata controller is still
> going completly offline when calling hddtemp on a disk in standby but
> there is no kernel panic anymore.

Is this problem present with older kernel (e.g. 2.6.14.x) or is it a=20
newly introduced bug?

I've put Jeff into the Cc of this email since he is the SATA maintainer=
=2E

> Ralf

cu
Adrian

--=20

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

