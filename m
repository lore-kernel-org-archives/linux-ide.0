From: Marc Bowes <marcbowes@gmail.com>
Subject: Re: SATA: link online but device misclassified
Date: Thu, 11 Jun 2009 21:32:02 +0200
Message-ID: <cfa4e840906111232i52decee3mf9ab2d0abcaa78d9@mail.gmail.com>
References: <cfa4e840906101715r56b643f4tab58e1c859d119ba@mail.gmail.com>
	 <4A308798.6060803@gmail.com>
	 <cfa4e840906110231u4e90eb22wbeb2d4e748c5624a@mail.gmail.com>
	 <1244746872.3998.88.camel@mulgrave.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ew0-f210.google.com ([209.85.219.210]:38078 "EHLO
	mail-ew0-f210.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755306AbZFKTcG convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 11 Jun 2009 15:32:06 -0400
Received: by ewy6 with SMTP id 6so2313223ewy.37
        for <linux-ide@vger.kernel.org>; Thu, 11 Jun 2009 12:32:07 -0700 (PDT)
In-Reply-To: <1244746872.3998.88.camel@mulgrave.site>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hi and thanks for the reponse.

There are 6 SATA slots on the board, 4 of which are being used (ports
0 & 2 are not being used because they're hard to reach). AHCI is
disabled, but enabling makes no visible difference.

Here is lspci:

@@@@
00:00.0 Host bridge: Intel Corporation 4 Series Chipset DRAM Controller=
 (rev 02)
00:01.0 PCI bridge: Intel Corporation 4 Series Chipset PCI Express
Root Port (rev 02)
00:1a.0 USB Controller: Intel Corporation 82801JI (ICH10 Family) USB
UHCI Controller #4
00:1a.1 USB Controller: Intel Corporation 82801JI (ICH10 Family) USB
UHCI Controller #5
00:1a.2 USB Controller: Intel Corporation 82801JI (ICH10 Family) USB
UHCI Controller #6
00:1a.7 USB Controller: Intel Corporation 82801JI (ICH10 Family) USB2
EHCI Controller #2
00:1b.0 Audio device: Intel Corporation 82801JI (ICH10 Family) HD
Audio Controller
00:1c.0 PCI bridge: Intel Corporation 82801JI (ICH10 Family) PCI Expres=
s Port 1
00:1c.4 PCI bridge: Intel Corporation 82801JI (ICH10 Family) PCI Expres=
s Port 5
00:1d.0 USB Controller: Intel Corporation 82801JI (ICH10 Family) USB
UHCI Controller #1
00:1d.1 USB Controller: Intel Corporation 82801JI (ICH10 Family) USB
UHCI Controller #2
00:1d.2 USB Controller: Intel Corporation 82801JI (ICH10 Family) USB
UHCI Controller #3
00:1d.7 USB Controller: Intel Corporation 82801JI (ICH10 Family) USB2
EHCI Controller #1
00:1e.0 PCI bridge: Intel Corporation 82801 PCI Bridge (rev 90)
00:1f.0 ISA bridge: Intel Corporation 82801JIR (ICH10R) LPC Interface C=
ontroller
00:1f.2 IDE interface: Intel Corporation 82801JI (ICH10 Family) 4 port
SATA IDE Controller
00:1f.3 SMBus: Intel Corporation 82801JI (ICH10 Family) SMBus Controlle=
r
00:1f.5 IDE interface: Intel Corporation 82801JI (ICH10 Family) 2 port
SATA IDE Controller
01:00.0 VGA compatible controller: nVidia Corporation G80 [GeForce
8800 GTX] (rev a2)
02:00.0 PCI bridge: Integrated Device Technology, Inc. PES16T7 PCI
Express Switch (rev 0d)
03:01.0 PCI bridge: Integrated Device Technology, Inc. PES16T7 PCI
Express Switch (rev 0d)
03:02.0 PCI bridge: Integrated Device Technology, Inc. PES16T7 PCI
Express Switch (rev 0d)
03:03.0 PCI bridge: Integrated Device Technology, Inc. PES16T7 PCI
Express Switch (rev 0d)
03:04.0 PCI bridge: Integrated Device Technology, Inc. PES16T7 PCI
Express Switch (rev 0d)
03:05.0 PCI bridge: Integrated Device Technology, Inc. PES16T7 PCI
Express Switch (rev 0d)
03:06.0 PCI bridge: Integrated Device Technology, Inc. PES16T7 PCI
Express Switch (rev 0d)
05:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd.
RTL8111/8168B PCI Express Gigabit Ethernet controller (rev 02)
06:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd.
RTL8111/8168B PCI Express Gigabit Ethernet controller (rev 02)
07:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd.
RTL8111/8168B PCI Express Gigabit Ethernet controller (rev 02)
08:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd.
RTL8111/8168B PCI Express Gigabit Ethernet controller (rev 02)
0a:00.0 SATA controller: JMicron Technologies, Inc. JMicron
20360/20363 AHCI Controller (rev 02)
0a:00.1 IDE interface: JMicron Technologies, Inc. JMicron 20360/20363
AHCI Controller (rev 02)
0b:06.0 FireWire (IEEE 1394): Texas Instruments TSB43AB23
IEEE-1394a-2000 Controller (PHY/Link)
@@@@

On Thu, Jun 11, 2009 at 9:01 PM, James
Bottomley<James.Bottomley@hansenpartnership.com> wrote:
> On Thu, 2009-06-11 at 11:31 +0200, Marc Bowes wrote:
>> I'm not sure if you can attach files, but here goes (attached as dme=
sg.txt)
>
> Actually, this shows the problems are on two unoccupied ahci ports:
>
>
>> [ =A0 =A00.685269] ahci 0000:0a:00.0: version 3.0
>> [ =A0 =A00.685279] ahci 0000:0a:00.0: PCI INT A -> GSI 16 (level, lo=
w) -> IRQ 16
>> [ =A0 =A00.696040] ahci 0000:0a:00.0: AHCI 0001.0000 32 slots 2 port=
s 3 Gbps 0x3 impl SATA mode
>> [ =A0 =A00.696283] ahci 0000:0a:00.0: flags: 64bit ncq pm led clo pm=
p pio slum part
>> [ =A0 =A00.696453] ahci 0000:0a:00.0: setting latency timer to 64
>> [ =A0 =A00.696592] scsi0 : ahci
>> [ =A0 =A00.696907] scsi1 : ahci
>> [ =A0 =A00.697224] ata1: SATA max UDMA/133 abar m8192@0xec400000 por=
t 0xec400100 irq 16
>> [ =A0 =A00.697461] ata2: SATA max UDMA/133 abar m8192@0xec400000 por=
t 0xec400180 irq 16
>> [ =A0 =A06.969039] ata1: link is slow to respond, please be patient =
(ready=3D0)
>> [ =A0 10.743038] ata1: softreset failed (device not ready)
>> [ =A0 10.743191] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 3=
00)
>> [ =A0 10.743344] ata1: link online but device misclassified, retryin=
g
>> [ =A0 17.015051] ata1: link is slow to respond, please be patient (r=
eady=3D0)
>> [ =A0 20.789041] ata1: softreset failed (device not ready)
> ...
>
> Could you confirm that there are actually no devices it's supposed to=
 be
> detecting?
>
> It looks like the AHCI controller at 00:0a:00.0 might be some form of
> piix controller in the ICH10 bridge ... does lspci confirm this? =A0I
> remember you said you had:
>
>> The ATA controllers: Intel Corporation 82801JI (ICH10 Family) 2 port
>> SATA IDE Controller.
>
> Yet the log is finding six ports: four on the piix and two on the
> problem ahci =A0.. is that right?
>
> James
>
>
>
