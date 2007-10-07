From: Hernan G Solari <hgsolari@gmail.com>
Subject: Re: Serial ATA does not find partitions (Hitachi HD, new? ATI controller)
 where old SATA works
Date: Sat, 06 Oct 2007 22:24:37 -0300
Message-ID: <47083555.2060605@gmail.com>
References: <46FC4384.7080607@df.uba.ar> <46FCCD57.2020507@gmail.com> <47014740.5080002@df.uba.ar> <4701EA71.2000609@gmail.com> <470220FE.2090506@gmail.com> <47044C6C.5030905@gmail.com>
Reply-To: hgsolari@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753258AbXJGBXW@vger.kernel.org>
In-Reply-To: <47044C6C.5030905@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, IDE/ATA development list <linux-ide@vger.kernel.org>, linux acpi <linux-acpi@vger.kernel.org>
List-Id: linux-ide@vger.kernel.org


> If you can set up a serial console, it would be better.  If not, can =
you
> please take a photo of the crash and post it?
>  =20
I am running short of elements, no digital camera o movil phone for the=
=20
case or serial link.
However, what it is on the screen when it crashes follows:

KERNEL 2.6.23-rc8
-----------------------------------------------------begin screen dump
PCI: Bridge: 0000:00:14.4
  IO window: a000-afff
  MEM window: d0300000-d03fffff
  PREFETCH window: 50000000-53ffffff
PCI: Enabling device 0000:00:04.0 (0000 -> 0002)
PCI: Enabling device 0000:08:01.0 (0000 -> 0003)
ACPI: PCI Interrupt 0000:08:01.0[A] -> GSI 23 (level, low) -> IRQ 23
NET: Registered protocol family 2
IP route cache hash table entries: 32768 (order: 6, 262144 bytes)
TCP established hash table entries: 131072 (order: 9, 3145728 bytes)
TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
TCP: Hash tables configured (established 131072 bind 65536)
TCP reno registered
Simple Boot Flag at 0x36 set to 0x1
Total HugeTLB memory allocated, 0
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
io scheduler noop registered
io scheduler deadline registered
io scheduler cfq registered (default)
PCI: MSI quirk detected. MSI deactivated.
assign_interrupt_mode Found MSI capability
assign_interrupt_mode Found MSI capability
assign_interrupt_mode Found MSI capability
assign_interrupt_mode Found MSI capability
-------------------------------end screen dump

Not so difficult since most of these lines are also in a succesful boot=
=20
with some of the ACPI turned off.

Hernan

--=20
Hern=E1n Gustavo Solari, solari@df.uba.ar, http://www.df.uba.ar/~solari
