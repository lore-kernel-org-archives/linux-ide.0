From: =?UTF-8?B?T3phbiDDh2HEn2xheWFu?= <ozan@pardus.org.tr>
Subject: Re: sata_nv times out for BD-ROM iHOS104-08
Date: Sun, 17 Jan 2010 17:28:55 +0200
Message-ID: <4B532CB7.4060005@pardus.org.tr>
References: <Pine.LNX.4.64.0912221105010.5876@stg.biology.emory.edu> 	<4B31C8EE.3030003@kernel.org> <d2d378040912232302u4b550dap687fcadced237935@mail.gmail.com> 	<4B331771.3090309@kernel.org> <d2d378041001161334r6fe3ee65w39cf98a6c2d1d399@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753757Ab0AQP2y@vger.kernel.org>
In-Reply-To: <d2d378041001161334r6fe3ee65w39cf98a6c2d1d399@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?B?Q2VuZ2l6IEfDvG5heQ==?= <cgunay@emory.edu>
Cc: Tejun Heo <tj@kernel.org>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Cengiz G=C3=BCnay wrote:
> 2009/12/24 Tejun Heo <tj@kernel.org>:
>> I don't think the controller has anything to do with the issue but
>> just in case can you please try it with a different controller?
>=20
> I tried the iHOS BD-ROM with a VIA VT6412 SATA controller today and i=
t worked:
>=20

I don't have the possibility to try with another controller but exactly=
 the same issue with PIONEER DVD-RW DVRKD08RS:

[    4.618380] ata1.00: ATAPI: PIONEER DVD-RW DVRKD08RS, 1.02, max UDMA=
/33     =20
[    4.618447] ata1: nv_mode_filter: 0x739f&0x739f->0x739f, BIOS=3D0x70=
00 (0xc000c700) ACPI=3D0x701f (60:600:0x13)                            =
                     =20
[    4.625131] ata1.00: configured for UDMA/33                         =
        =20
[    4.625214] ata1.00: TEST_UNIT_READY failed (err_mask=3D0x2)        =
          =20
[    4.838039] usb 3-2: new low speed USB device using ohci_hcd and add=
ress 2  =20
[    4.909709] input: PS/2 Mouse as /devices/platform/i8042/serio1/inpu=
t/input6=20
[    4.944821] input: AlpsPS/2 ALPS GlidePoint as /devices/platform/i80=
42/serio1/input/input7                                                 =
                 =20
[    5.000029] Clocksource tsc unstable (delta =3D -254057140 ns)      =
          =20
[    5.027063] usb 3-2: New USB device found, idVendor=3D05e3, idProduc=
t=3D1205    =20
[    5.027071] usb 3-2: New USB device strings: Mfr=3D0, Product=3D1, S=
erialNumber=3D0
[    5.027078] usb 3-2: Product: USB Mouse                             =
        =20
[    5.027199] usb 3-2: configuration #1 chosen from 1 choice          =
        =20
[    5.037758] input: USB Mouse               as /devices/pci0000:00/00=
00:00:02.0/usb3/3-2/3-2:1.0/input/input8                               =
                 =20
[    5.037936] generic-usb 0003:05E3:1205.0001: input,hidraw0: USB HID =
v1.10 Mouse [USB Mouse              ] on usb-0000:00:02.0-2/input0     =
                 =20
[    5.708253] ieee1394: Host added: ID:BUS[0-00:1023]  GUID[00023f7cba=
403d32] =20
[    9.769407] ata1: nv_mode_filter: 0x739f&0x739f->0x739f, BIOS=3D0x70=
00 (0xc000c700) ACPI=3D0x701f (60:600:0x13)                            =
                     =20
[    9.775326] ata1.00: configured for UDMA/33                         =
        =20
[    9.775408] ata1.00: TEST_UNIT_READY failed (err_mask=3D0x2)        =
          =20
[    9.775417] ata1.00: limiting speed to UDMA/33:PIO3                 =
        =20
[   14.920401] ata1: nv_mode_filter: 0x738f&0x739f->0x738f, BIOS=3D0x70=
00 (0xc000c700) ACPI=3D0x701f (60:600:0x13)                            =
                     =20
[   14.926332] ata1.00: configured for UDMA/33                         =
        =20
[   14.926412] ata1.00: TEST_UNIT_READY failed (err_mask=3D0x2)        =
          =20
[   14.926418] ata1.00: disabled                                       =
        =20
[   14.926452] ata1: soft resetting link                               =
        =20
[   15.077100] ata1: EH complete                                       =
        =20
[   15.077155] ata2: port disabled. ignoring.
