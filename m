From: Romain Kubany <rkubany@ikoula.com>
Subject: RE: Possible regression of LBA48 support for piix
Date: Thu, 17 Dec 2009 11:04:38 +0100
Message-ID: <A9C151C7BD19EC47976D4AA14CF277A8BC64DFB2C1@HMCEXMBX01CLUS.hmcikoula.com>
References: <A9C151C7BD19EC47976D4AA14CF277A8BC64DFB2AF@HMCEXMBX01CLUS.hmcikoula.com>
 <19241.63911.160765.909812@pilspetsen.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1764300AbZLQKEp@vger.kernel.org>
In-Reply-To: <19241.63911.160765.909812@pilspetsen.it.uu.se>
Content-Language: fr-FR
Sender: linux-kernel-owner@vger.kernel.org
To: Mikael Pettersson <mikpe@it.uu.se>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
List-Id: linux-ide@vger.kernel.org

Ok, thanks for the prompt reply and the notice for the cc: :)
I'm using libata and ata_piix now.
My disk is seen as "sda" and a lshw is reporting the controler as using=
 "ata_piix" :=20

# lshw -c STORAGE
  *-ide
       description: IDE interface
       product: 82371AB/EB/MB PIIX4 IDE
       vendor: Intel Corporation
       physical id: 7.1
       bus info: pci@0000:00:07.1
       logical name: scsi0
       logical name: scsi1
       version: 01
       width: 32 bits
       clock: 33MHz
       capabilities: ide bus_master emulated
       configuration: driver=3Data_piix latency=3D0

But fdisk always recognize the disk as 136.8Gb :

# fdisk -l

Disk /dev/sda: 136.8 GB, 136899993600 bytes
16 heads, 63 sectors/track, 265260 cylinders
Units =3D cylinders of 1008 * 512 =3D 516096 bytes
Disk identifier: 0xd7267427

   Device Boot      Start         End      Blocks   Id  System
/dev/sda1   *           1         204      102815+  83  Linux
/dev/sda2             205        2236     1024128   82  Linux swap / So=
laris
/dev/sda3            2237       20805     9358776   83  Linux

Here is the new kernel config file : http://pastebin.com/f65fd472b

-----Message d'origine-----
De=A0: linux-kernel-owner@vger.kernel.org [mailto:linux-kernel-owner@vg=
er.kernel.org] De la part de Mikael Pettersson
Envoy=E9=A0: jeudi 17 d=E9cembre 2009 10:28
=C0=A0: Romain Kubany
Cc=A0: linux-kernel@vger.kernel.org
Objet=A0: Re: Possible regression of LBA48 support for piix

Romain Kubany writes:
 > Hello,
 >=20
 > We are using Microsoft Hyper-V Virtualization technology for some of=
 our GNU/Linux guests and we recently discovered=20
 > that the emulated hardware does not seem to support LBA48 adressing =
on IDE controller.
 >=20
 > After some tests, here are the results on a VM with a 200GB virtual =
disk : disk is detected as 214748MB up to kernel 2.6.27.41 and as 13689=
9MB in 2.6.28 and up.
 >=20
 > The two kernels (2.6.27.41 and 2.6.28) were compiled with approximat=
ively the same parameters (just an oldconfig between them, I'll paste a=
 line to their respective config at the end of the mail)
 > except that many changes occured in IDE management between 2.6.27 an=
d 2.6.28 series of the kernel so it is possible that the problem is com=
ing from a misconfiguration on our side (in which case I'll present you=
 my truthful apologies for making you waste your time).
 >=20
 > Here are some useful informations (I think) for start :
 >=20
 > [On the "working" kernel, 2.6.27.41 w/ 200GB recognized vdisk]
 >=20
 > # hdparm -I /dev/hda

Try using libata and ata_piix instead of the old IDE drivers, but
be aware that the disk will show up as /dev/sda not /dev/hda.

Also, IDE/ATA-related issues should be cc:d to linux-ide (see MAINTAINE=
RS).
--
To unsubscribe from this list: send the line "unsubscribe linux-kernel"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
