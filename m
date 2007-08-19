From: Tejun Heo <htejun@gmail.com>
Subject: Re: SATA error while resume
Date: Mon, 20 Aug 2007 00:49:03 +0900
Message-ID: <46C8666F.4080603@gmail.com>
References: <46C80999.1060700@gmail.com> <46C852DE.8040701@rtr.ca> <46C85ED8.5080801@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <46C85ED8.5080801@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Maciek Rutecki <maciej.rutecki@gmail.com>
Cc: Mark Lord <liml@rtr.ca>, Linux-kernel <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org, linux-acpi@vger.kernel.org, rjw@sisk.pl
List-Id: linux-ide@vger.kernel.org

Maciek Rutecki wrote:
> rutek:/home/maciek# swapoff /dev/sda6
> rutek:/home/maciek# sync
> rutek:/home/maciek# cat /dev/zero > /dev/sda6
> cat: b=C5=82=C4=85d zapisu: B=C5=82=C4=85d wej=C5=9Bcia/wyj=C5=9Bcia =
(write error, after few minutes,
> probably sda6 is full)
>=20
> rutek:/home/maciek# dd if=3D/dev/zero of=3D/dev/sda6
> dd: zapis do `/dev/sda6': B=C5=82=C4=85d wej=C5=9Bcia/wyj=C5=9Bcia
> 5992177+0 przeczytanych record=C3=B3w
> 5992176+0 zapisanych record=C3=B3w
> skopiowane 3067994112 bajt=C3=B3w (3,1 GB), 298,159 sekund, 10,3 MB/s
> rutek:/home/maciek# mkswap /dev/sda6
> Setting up swapspace version 1, size =3D 3067990 kB
> no label, UUID=3D2061df6e-d385-4367-9a4c-c8431e57b73a
> rutek:/home/maciek# swapon /dev/sda6
>=20
>=20
> dmesg:
> Adding 2996080k swap on /dev/sda6.  Priority:-2 extents:1 across:2996=
080k
>=20
> Also I try:
> dd if=3D=3D/dev/sda... of=3D/dev/null for all partitions
> Test disk with bios utility and smartctl. Use autotest (bash shared
> mapping and disktest). No errors/warnings. Only (sometimes) while sys=
tem
> resume from suspend to disk. Disk 10 months old...

Hmmmm... Does Power-Off_Retract_Count increase after suspend/resume cyc=
le?

--=20
tejun
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
