From: Steven Scholz <steven.scholz@imc-berlin.de>
Subject: Re: HPA and failed opcode was: 0x37 ?
Date: Wed, 31 Jan 2007 14:38:53 +0100
Message-ID: <45C09BED.2040500@imc-berlin.de>
References: <45BF5003.3000503@imc-berlin.de>	 <20070130164401.295f9913@localhost.localdomain>	 <45BF7658.1090204@imc-berlin.de>	 <20070130172629.70ad628d@localhost.localdomain>	 <45BF7E21.7010605@imc-berlin.de>	 <20070130180727.594b35d0@localhost.localdomain>	 <45BF88B9.3050802@imc-berlin.de> <45BF8F33.3070008@ru.mvista.com> <311601c90701301156nb135de6g996eaff8b2f95a6c@mail.gmail.com> <45C0536F.5020005@imc-berlin.de> <45C09172.1030304@ru.mvista.com> <45C094E7.7040500@imc-berlin.de> <45C095B9.30504@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.imc-berlin.de ([217.110.46.186]:4008 "EHLO
	mail.imc-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933231AbXAaNi4 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 31 Jan 2007 08:38:56 -0500
In-Reply-To: <45C095B9.30504@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: "Eric D. Mudama" <edmudama@gmail.com>, linux-ide@vger.kernel.org

Hi,

>>         for (i =3D IDE_DATA_OFFSET; i <=3D IDE_STATUS_OFFSET; i++) {
>>                 hw.io_ports[i] =3D ide_virt_base + (i << 1);
>>         }
>=20
>>         hw.io_ports[IDE_CONTROL_OFFSET] =3D ide_virt_base + 0x10;
>=20
>> Thus it has an offset 0x10 from the base address.
>=20
>> ide0 at 0xc3856000-0xc3856007,0xc3856010 on irq 27
>=20
>> But I just noticed that A[2..0] should look like "110" when accessin=
g the
>> "Device Control Register". Thus the offset should be 0x16 instead! R=
ight?
>=20
>    If your FPGA passes A[2..0] untouched to the IDE bus, it's certain=
ly
> wrong. It must pass 110.

Stupid me. As I mentioned earlier CPU's A[3..1] are connected to HDD's
A[2..0]. And CPU's A4 is used for HDD's CS1 (inverted of course). Thus =
the
offset for IDE_CONTROL_OFFSET must be 0x1C (=3D0x10 + 0x6 << 1).

And vol=E1

ide0 at 0xc3856000-0xc3856007,0xc385601c on irq 27
hda: max request size: 1024KiB
idedisk_supports_hpa(): cfs_enable_1=3D346b, cfs_enable_1=3D3469
idedisk_read_native_max_address_ext(): addr =3D 000004a852ff
idedisk_read_native_max_address_ext(): addr =3D 000004a852ff
idedisk_read_native_max_address_ext(): addr =3D 000004a85300
idedisk_read_native_max_address_ext(): addr =3D 000004a85300
hda: 78140160 sectors (40007 MB) w/8192KiB Cache, CHS=3D16383/255/63
hda: cache flushes supported
 hda: hda1

idedisk_read_native_max_address_ext() works now. No HPA reported anymor=
e!

Thanks a million to everyone!!!!

PS: Still I don't know why ARM reports "max request size: 1024KiB" and =
y86
reports only "max request size: 512KiB" ...

Steven
