From: Pratyush Anand <pratyush.anand@gmail.com>
Subject: Re: Crash with sata_sil24 driver
Date: Thu, 5 Jan 2012 12:24:55 +0530
Message-ID: <CAHM4w1me0hHWbCotCUz+sFBz2WEY6Tmoc-urWh=mby=w3Bz+6A@mail.gmail.com>
References: <CAHM4w1kc+5aYWH-09BPTXZdo8+iguFjORKs7mMhG7hea2UU8yQ@mail.gmail.com>
	<CAHM4w1nZ7GgutiuDiTCKu9wUuphn8qOiWgmCYVXXvwW1q8CgoA@mail.gmail.com>
	<20111122150613.GA322@google.com>
	<CAHM4w1nsNTQmAL-0d76O9cYXjNbiq-0f60Y3emWO2yf7HyFWDg@mail.gmail.com>
	<20111123162937.GF25780@google.com>
	<20111123144735.64dc9f05@jbarnes-desktop>
	<CAOS58YPM29xi4Jq5L16fjDQDRzv-yc67tp_yqSwoiFBBbtCZkw@mail.gmail.com>
	<CAHM4w1k-uA1CpbvDAz4ZhETf9_RN1kxf6btXNbxEAvNw6M57rw@mail.gmail.com>
	<CAHM4w1kvz5BXf=7+QgibV3gY5wqOpJXSgd0_X+2_0DGhkSGgKg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:59575 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750904Ab2AEGy5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 5 Jan 2012 01:54:57 -0500
In-Reply-To: <CAHM4w1kvz5BXf=7+QgibV3gY5wqOpJXSgd0_X+2_0DGhkSGgKg@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Jesse Barnes <jbarnes@virtuousgeek.org>, linux-pci@vger.kernel.org, linux-ide@vger.kernel.org, Russell King <linux@arm.linux.org.uk>

Hello Tejun,

I have taken log on the PCIe analyser.
Have put it's text format at the end.

RC is trying to perform MRd(32) at SIL register offset 0x1F00 in packet=
 397184.
This request is turned down by SIL controller and it returns an UR.
=46rom the code it seems that this register is PORT_SCONTROL::SCR_CONTR=
OL.
Why this register is not accessible?

Now , If I co-relate sata_sil24.c code and the log, then I can say that
it performs last instruction of sil24_init_controller i.e.
/* Turn on interrupts */
writel(IRQ_STAT_4PORTS, host_base + HOST_CTRL);
in packet  394937.

When it jumps to ata_host_activate , it tries to access
PORT_SCONTROL::SCR_CONTROL and fails.

Now if I put some delay (say 10us) before jumping to ata_host_activate,=
 same
access is fine and no UR is returned by SATA controller.

Do you see a reason for it?

Regards
Pratyush

Analyser log:
-----------------------------------------------------------------------=
-----------------------
______|________________________________________________________________=
_______
Packet(154900) Downstream 2.5(x1) TLP(0) Msg MsgD(11:10100)
_______| Msg Routing(Local) Length(1) RequesterID(000:00:0) Tag(0)
_______| Message Code(Set_Slot_Power_Limit) Data(1 dword) LCRC(0xB3FD2A=
A7)
_______| Time Stamp(0015 . 426 577 176 s)
_______|_______________________________________________________________=
________
Packet(154903) Upstream 2.5(x1) DLLP ACK AckNak_Seq_Num(0) CRC 16(0xB36=
2)
_______| Time Stamp(0015 . 426 577 544 s)
_______|_______________________________________________________________=
________
Packet(157246) Downstream 2.5(x1) TLP(1) Cfg CfgRd0(00:00100) Length(1)
_______| RequesterID(000:00:0) Tag(0) DeviceID(001:00:0) Register(0x000=
)
_______| 1st BE(1111) LCRC(0xCA7FBC22) Time Stamp(0015 . 431 421 048 s)
_______|_______________________________________________________________=
________
Packet(157247) Upstream 2.5(x1) DLLP ACK AckNak_Seq_Num(1) CRC 16(0x127=
9)
_______| Time Stamp(0015 . 431 421 400 s)
_______|_______________________________________________________________=
________
Packet(157248) Upstream 2.5(x1) TLP(0) Cpl CplD(10:01010) Length(1)
_______| RequesterID(000:00:0) Tag(0) CompleterID(000:00:0) Status(SC) =
BCM(0)
_______| Byte Cnt(4) Lwr Addr(0x00) Device ID(0x3531) Vendor ID(0x1095)
_______| LCRC(0x657AFA3B) Time Stamp(0015 . 431 421 768 s)
_______|_______________________________________________________________=
________
Packet(157249) Downstream 2.5(x1) DLLP ACK AckNak_Seq_Num(0)
_______| CRC 16(0xB362) Time Stamp(0015 . 431 423 192 s)
_______|_______________________________________________________________=
________
Packet(157255) Downstream 2.5(x1) TLP(2) Cfg CfgRd0(00:00100) Length(1)
_______| RequesterID(000:00:0) Tag(1) DeviceID(001:00:0) Register(0x00C=
)
_______| 1st BE(1111) LCRC(0x8A8C9C5D) Time Stamp(0015 . 431 431 456 s)
_______|_______________________________________________________________=
________
Packet(157256) Upstream 2.5(x1) DLLP ACK AckNak_Seq_Num(2) CRC 16(0xF15=
5)
_______| Time Stamp(0015 . 431 431 776 s)
_______|_______________________________________________________________=
________
Packet(157257) Upstream 2.5(x1) TLP(1) Cpl CplD(10:01010) Length(1)
_______| RequesterID(000:00:0) Tag(1) CompleterID(000:00:0) Status(SC) =
BCM(0)
_______| Byte Cnt(4) Lwr Addr(0x00) BIST(0x00) Header Type(0x00)
_______| Master Latency Timer(0x00) Cache Line Size(0x00) LCRC(0xF41356=
71)
_______| Time Stamp(0015 . 431 432 168 s)
_______|_______________________________________________________________=
________
Packet(157258) Downstream 2.5(x1) DLLP ACK AckNak_Seq_Num(1)
_______| CRC 16(0x1279) Time Stamp(0015 . 431 433 608 s)
_______|_______________________________________________________________=
________
Packet(157264) Downstream 2.5(x1) TLP(3) Cfg CfgRd0(00:00100) Length(1)
_______| RequesterID(000:00:0) Tag(2) DeviceID(001:00:0) Register(0x004=
)
_______| 1st BE(1111) LCRC(0x93AF4508) Time Stamp(0015 . 431 440 248 s)
_______|_______________________________________________________________=
________
Packet(157265) Upstream 2.5(x1) DLLP ACK AckNak_Seq_Num(3) CRC 16(0x504=
E)
_______| Time Stamp(0015 . 431 440 576 s)
_______|_______________________________________________________________=
________
Packet(157266) Upstream 2.5(x1) TLP(2) Cpl CplD(10:01010) Length(1)
_______| RequesterID(000:00:0) Tag(2) CompleterID(000:00:0) Status(SC) =
BCM(0)
_______| Byte Cnt(4) Lwr Addr(0x00) Status(0x0010) Command(0x0000)
_______| LCRC(0x8F289AEE) Time Stamp(0015 . 431 440 960 s)
_______|_______________________________________________________________=
________
Packet(157267) Downstream 2.5(x1) DLLP ACK AckNak_Seq_Num(2)
_______| CRC 16(0xF155) Time Stamp(0015 . 431 442 416 s)
_______|_______________________________________________________________=
________
Packet(157273) Downstream 2.5(x1) TLP(4) Cfg CfgRd0(00:00100) Length(1)
_______| RequesterID(000:00:0) Tag(3) DeviceID(001:00:0) Register(0x034=
)
_______| 1st BE(1111) LCRC(0xC24AB398) Time Stamp(0015 . 431 448 648 s)
_______|_______________________________________________________________=
________
Packet(157274) Upstream 2.5(x1) DLLP ACK AckNak_Seq_Num(4) CRC 16(0x370=
C)
_______| Time Stamp(0015 . 431 448 992 s)
_______|_______________________________________________________________=
________
Packet(157275) Upstream 2.5(x1) TLP(3) Cpl CplD(10:01010) Length(1)
_______| RequesterID(000:00:0) Tag(3) CompleterID(000:00:0) Status(SC) =
BCM(0)
_______| Byte Cnt(4) Lwr Addr(0x00) Reserved(0x000000) Capability Point=
er(0x54)
_______| LCRC(0xCDBACDAC) Time Stamp(0015 . 431 449 360 s)
_______|_______________________________________________________________=
________
Packet(157278) Downstream 2.5(x1) DLLP ACK AckNak_Seq_Num(3)
_______| CRC 16(0x504E) Time Stamp(0015 . 431 450 776 s)
_______|_______________________________________________________________=
________
Packet(157282) Downstream 2.5(x1) TLP(5) Cfg CfgRd0(00:00100) Length(1)
_______| RequesterID(000:00:0) Tag(4) DeviceID(001:00:0) Register(0x054=
)
_______| 1st BE(1111) LCRC(0xA7C29215) Time Stamp(0015 . 431 456 840 s)
_______|_______________________________________________________________=
________
Packet(157283) Upstream 2.5(x1) DLLP ACK AckNak_Seq_Num(5) CRC 16(0x961=
7)
_______| Time Stamp(0015 . 431 457 184 s)
_______|_______________________________________________________________=
________
Packet(157284) Upstream 2.5(x1) TLP(4) Cpl CplD(10:01010) Length(1)
_______| RequesterID(000:00:0) Tag(4) CompleterID(000:00:0) Status(SC) =
BCM(0)
_______| Byte Cnt(4) Lwr Addr(0x00) PM Capabilities(0x0622) Next PTR(0x=
5C)
_______| Capability ID(0x01) LCRC(0x6F3DFE46) Time Stamp(0015 . 431 457=
 568 s)
_______|_______________________________________________________________=
________
Packet(157285) Downstream 2.5(x1) DLLP ACK AckNak_Seq_Num(4)
_______| CRC 16(0x370C) Time Stamp(0015 . 431 459 000 s)
_______|_______________________________________________________________=
________
Packet(157289) Downstream 2.5(x1) TLP(6) Cfg CfgRd0(00:00100) Length(1)
_______| RequesterID(000:00:0) Tag(5) DeviceID(001:00:0) Register(0x054=
)
_______| 1st BE(1111) LCRC(0xCC7D0463) Time Stamp(0015 . 431 465 048 s)
_______|_______________________________________________________________=
________
Packet(157291) Upstream 2.5(x1) DLLP ACK AckNak_Seq_Num(6) CRC 16(0x753=
B)
_______| Time Stamp(0015 . 431 465 408 s)
_______|_______________________________________________________________=
________
Packet(157293) Upstream 2.5(x1) TLP(5) Cpl CplD(10:01010) Length(1)
_______| RequesterID(000:00:0) Tag(5) CompleterID(000:00:0) Status(SC) =
BCM(0)
_______| Byte Cnt(4) Lwr Addr(0x00) PM Capabilities(0x0622) Next PTR(0x=
5C)
_______| Capability ID(0x01) LCRC(0x8925040A) Time Stamp(0015 . 431 465=
 792 s)
_______|_______________________________________________________________=
________
Packet(157294) Downstream 2.5(x1) DLLP ACK AckNak_Seq_Num(5)
_______| CRC 16(0x9617) Time Stamp(0015 . 431 467 232 s)
_______|_______________________________________________________________=
________
Packet(157298) Downstream 2.5(x1) TLP(7) Cfg CfgRd0(00:00100) Length(1)
_______| RequesterID(000:00:0) Tag(6) DeviceID(001:00:0) Register(0x05C=
)
_______| 1st BE(1111) LCRC(0xD55EDD36) Time Stamp(0015 . 431 473 296 s)
_______|_______________________________________________________________=
________
Packet(157299) Upstream 2.5(x1) DLLP ACK AckNak_Seq_Num(7) CRC 16(0xD42=
0)
_______| Time Stamp(0015 . 431 473 656 s)
_______|_______________________________________________________________=
________
Packet(157300) Upstream 2.5(x1) TLP(6) Cpl CplD(10:01010) Length(1)
_______| RequesterID(000:00:0) Tag(6) CompleterID(000:00:0) Status(SC) =
BCM(0)
_______| Byte Cnt(4) Lwr Addr(0x00) Message Control(0x0080) Next PTR(0x=
70)
_______| Capability ID(0x05) LCRC(0x2E5F6D14) Time Stamp(0015 . 431 474=
 016 s)
_______|_______________________________________________________________=
________
Packet(157302) Downstream 2.5(x1) DLLP ACK AckNak_Seq_Num(6)
_______| CRC 16(0x753B) Time Stamp(0015 . 431 475 464 s)
_______|_______________________________________________________________=
________
Packet(157309) Downstream 2.5(x1) TLP(8) Cfg CfgRd0(00:00100) Length(1)
_______| RequesterID(000:00:0) Tag(7) DeviceID(001:00:0) Register(0x05C=
)
_______| 1st BE(1111) LCRC(0x4558F1DA) Time Stamp(0015 . 431 481 520 s)
_______|_______________________________________________________________=
________
Packet(157310) Upstream 2.5(x1) DLLP ACK AckNak_Seq_Num(8) CRC 16(0xBBB=
=46)
_______| Time Stamp(0015 . 431 481 848 s)
_______|_______________________________________________________________=
________
Packet(157311) Upstream 2.5(x1) TLP(7) Cpl CplD(10:01010) Length(1)
_______| RequesterID(000:00:0) Tag(7) CompleterID(000:00:0) Status(SC) =
BCM(0)
_______| Byte Cnt(4) Lwr Addr(0x00) Message Control(0x0080) Next PTR(0x=
70)
_______| Capability ID(0x05) LCRC(0xC8479758) Time Stamp(0015 . 431 482=
 224 s)
_______|_______________________________________________________________=
________
Packet(157312) Downstream 2.5(x1) DLLP ACK AckNak_Seq_Num(7)
_______| CRC 16(0xD420) Time Stamp(0015 . 431 483 680 s)
_______|_______________________________________________________________=
________
Packet(157316) Downstream 2.5(x1) TLP(9) Cfg CfgRd0(00:00100) Length(1)
_______| RequesterID(000:00:0) Tag(8) DeviceID(001:00:0) Register(0x070=
)
_______| 1st BE(1111) LCRC(0xF65FE9C4) Time Stamp(0015 . 431 489 664 s)
_______|_______________________________________________________________=
________
Packet(157317) Upstream 2.5(x1) DLLP ACK AckNak_Seq_Num(9) CRC 16(0x1AA=
4)
_______| Time Stamp(0015 . 431 490 008 s)
_______|_______________________________________________________________=
________
Packet(157318) Upstream 2.5(x1) TLP(8) Cpl CplD(10:01010) Length(1)
_______| RequesterID(000:00:0) Tag(8) CompleterID(000:00:0) Status(SC) =
BCM(0)
_______| Byte Cnt(4) Lwr Addr(0x00) PCI Express Capabilities(0x0011)
_______| Next PTR(0x00) Capability ID(0x10) LCRC(0x6EB22F34)
_______| Time Stamp(0015 . 431 490 376 s)
_______|_______________________________________________________________=
________
Packet(157320) Downstream 2.5(x1) DLLP ACK AckNak_Seq_Num(8)
_______| CRC 16(0xBBBF) Time Stamp(0015 . 431 491 816 s)
_______|_______________________________________________________________=
________
Packet(157325) Downstream 2.5(x1) TLP(10) Cfg CfgRd0(00:00100) Length(1=
)
_______| RequesterID(000:00:0) Tag(9) DeviceID(001:00:0) Register(0x070=
)
_______| 1st BE(1111) LCRC(0x9DE07FB2) Time Stamp(0015 . 431 497 968 s)
_______|_______________________________________________________________=
________
Packet(157326) Upstream 2.5(x1) DLLP ACK AckNak_Seq_Num(10) CRC 16(0xF9=
88)
_______| Time Stamp(0015 . 431 498 280 s)
_______|_______________________________________________________________=
________
Packet(157327) Upstream 2.5(x1) TLP(9) Cpl CplD(10:01010) Length(1)
_______| RequesterID(000:00:0) Tag(9) CompleterID(000:00:0) Status(SC) =
BCM(0)
_______| Byte Cnt(4) Lwr Addr(0x00) PCI Express Capabilities(0x0011)
_______| Next PTR(0x00) Capability ID(0x10) LCRC(0x88AAD578)
_______| Time Stamp(0015 . 431 498 648 s)
_______|_______________________________________________________________=
________
Packet(157329) Downstream 2.5(x1) DLLP ACK AckNak_Seq_Num(9)
_______| CRC 16(0x1AA4) Time Stamp(0015 . 431 500 112 s)
_______|_______________________________________________________________=
________
Packet(157336) Downstream 2.5(x1) TLP(11) Cfg CfgRd0(00:00100) Length(1=
)
_______| RequesterID(000:00:0) Tag(10) DeviceID(001:00:0) Register(0x00=
8)
_______| 1st BE(1111) LCRC(0xB8B2A3B7) Time Stamp(0015 . 431 512 472 s)
_______|_______________________________________________________________=
________
Packet(157337) Upstream 2.5(x1) DLLP ACK AckNak_Seq_Num(11) CRC 16(0x58=
93)
_______| Time Stamp(0015 . 431 512 816 s)
_______|_______________________________________________________________=
________
Packet(157338) Upstream 2.5(x1) TLP(10) Cpl CplD(10:01010) Length(1)
_______| RequesterID(000:00:0) Tag(10) CompleterID(000:00:0) Status(SC)=
 BCM(0)
_______| Byte Cnt(4) Lwr Addr(0x00) Class Code(0x018000) Revision ID(0x=
01)
_______| LCRC(0x9538235A) Time Stamp(0015 . 431 513 216 s)
_______|_______________________________________________________________=
________
Packet(157341) Downstream 2.5(x1) DLLP ACK AckNak_Seq_Num(10)
_______| CRC 16(0xF988) Time Stamp(0015 . 431 514 656 s)
_______|_______________________________________________________________=
________
Packet(157352) Downstream 2.5(x1) TLP(12) Cfg CfgRd0(00:00100) Length(1=
)
_______| RequesterID(000:00:0) Tag(11) DeviceID(001:00:0) Register(0x10=
0)
_______| 1st BE(1111) LCRC(0x36DE4C16) Time Stamp(0015 . 431 536 072 s)
_______|_______________________________________________________________=
________
Packet(157353) Upstream 2.5(x1) DLLP ACK AckNak_Seq_Num(12) CRC 16(0x3F=
D1)
_______| Time Stamp(0015 . 431 536 408 s)
_______|_______________________________________________________________=
________
Packet(157354) Upstream 2.5(x1) TLP(11) Cpl CplD(10:01010) Length(1)
_______| RequesterID(000:00:0) Tag(11) CompleterID(000:00:0) Status(SC)=
 BCM(0)
_______| Byte Cnt(4) Lwr Addr(0x00) Next Offset(0x000) Version(0x1)
_______| Capability ID(0x0001) LCRC(0xEFB94643) Time Stamp(0015 . 431
536 792 s)
_______|_______________________________________________________________=
________
Packet(157356) Downstream 2.5(x1) DLLP ACK AckNak_Seq_Num(11)
_______| CRC 16(0x5893) Time Stamp(0015 . 431 538 256 s)
_______|_______________________________________________________________=
________
Packet(157360) Downstream 2.5(x1) TLP(13) Cfg CfgRd0(00:00100) Length(1=
)
_______| RequesterID(000:00:0) Tag(12) DeviceID(001:00:0) Register(0x03=
C)
_______| 1st BE(1111) LCRC(0xCD7AABE0) Time Stamp(0015 . 431 545 456 s)
_______|_______________________________________________________________=
________
Packet(157361) Upstream 2.5(x1) DLLP ACK AckNak_Seq_Num(13) CRC 16(0x9E=
CA)
_______| Time Stamp(0015 . 431 545 792 s)
_______|_______________________________________________________________=
________
Packet(157362) Upstream 2.5(x1) TLP(12) Cpl CplD(10:01010) Length(1)
_______| RequesterID(000:00:0) Tag(12) CompleterID(000:00:0) Status(SC)=
 BCM(0)
_______| Byte Cnt(4) Lwr Addr(0x00) Max_Lat(0x00) Min_Gnt(0x00)
_______| Interrupt Pin(0x01) Interrupt Line(0x00) LCRC(0x0FC9B4DE)
_______| Time Stamp(0015 . 431 546 184 s)
_______|_______________________________________________________________=
________
Packet(157365) Downstream 2.5(x1) DLLP ACK AckNak_Seq_Num(12)
_______| CRC 16(0x3FD1) Time Stamp(0015 . 431 547 632 s)
_______|_______________________________________________________________=
________
Packet(157370) Downstream 2.5(x1) TLP(14) Cfg CfgRd0(00:00100) Length(1=
)
_______| RequesterID(000:00:0) Tag(13) DeviceID(001:00:0) Register(0x03=
C)
_______| 1st BE(1111) LCRC(0xA6C53D96) Time Stamp(0015 . 431 553 768 s)
_______|_______________________________________________________________=
________
Packet(157371) Upstream 2.5(x1) DLLP ACK AckNak_Seq_Num(14) CRC 16(0x7D=
E6)
_______| Time Stamp(0015 . 431 554 112 s)
_______|_______________________________________________________________=
________
Packet(157372) Upstream 2.5(x1) TLP(13) Cpl CplD(10:01010) Length(1)
_______| RequesterID(000:00:0) Tag(13) CompleterID(000:00:0) Status(SC)=
 BCM(0)
_______| Byte Cnt(4) Lwr Addr(0x00) Max_Lat(0x00) Min_Gnt(0x00)
_______| Interrupt Pin(0x01) Interrupt Line(0x00) LCRC(0xE9D14E92)
_______| Time Stamp(0015 . 431 554 480 s)
_______|_______________________________________________________________=
________
Packet(157375) Downstream 2.5(x1) DLLP ACK AckNak_Seq_Num(13)
_______| CRC 16(0x9ECA) Time Stamp(0015 . 431 555 936 s)
_______|_______________________________________________________________=
________
Packet(157379) Downstream 2.5(x1) TLP(15) Cfg CfgRd0(00:00100) Length(1=
)
_______| RequesterID(000:00:0) Tag(14) DeviceID(001:00:0) Register(0x00=
4)
_______| 1st BE(1111) LCRC(0x13D63DE5) Time Stamp(0015 . 431 562 168 s)
_______|_______________________________________________________________=
________
Packet(157380) Upstream 2.5(x1) DLLP ACK AckNak_Seq_Num(15) CRC 16(0xDC=
=46D)
_______| Time Stamp(0015 . 431 562 488 s)
_______|_______________________________________________________________=
________
Packet(157381) Upstream 2.5(x1) TLP(14) Cpl CplD(10:01010) Length(1)
_______| RequesterID(000:00:0) Tag(14) CompleterID(000:00:0) Status(SC)=
 BCM(0)
_______| Byte Cnt(4) Lwr Addr(0x00) Status(0x0010) Command(0x0000)
_______| LCRC(0xA580400C) Time Stamp(0015 . 431 562 856 s)
_______|_______________________________________________________________=
________
Packet(157383) Downstream 2.5(x1) DLLP ACK AckNak_Seq_Num(14)
_______| CRC 16(0x7DE6) Time Stamp(0015 . 431 564 304 s)
_______|_______________________________________________________________=
________
Packet(157387) Downstream 2.5(x1) TLP(16) Cfg CfgWr0(10:00100) Length(1=
)
_______| RequesterID(000:00:0) Tag(15) DeviceID(001:00:0) Register(0x00=
4)
_______| 1st BE(0011) Status(0x0000) Command(0x0000) LCRC(0xDEF43FA6)
_______| Time Stamp(0015 . 431 570 776 s)
_______|_______________________________________________________________=
________
Packet(157388) Upstream 2.5(x1) DLLP ACK AckNak_Seq_Num(16) CRC 16(0xB2=
78)
_______| Time Stamp(0015 . 431 571 112 s)
_______|_______________________________________________________________=
________
Packet(157389) Upstream 2.5(x1) TLP(15) Cpl Cpl(00:01010) Length(0)
_______| RequesterID(000:00:0) Tag(15) CompleterID(001:00:0) Status(SC)=
 BCM(0)
_______| Byte Cnt(4) Lwr Addr(0x00) LCRC(0x02FE4EA2)
_______| Time Stamp(0015 . 431 571 384 s)
_______|_______________________________________________________________=
________
Packet(157390) Downstream 2.5(x1) DLLP ACK AckNak_Seq_Num(15)
_______| CRC 16(0xDCFD) Time Stamp(0015 . 431 572 824 s)
_______|_______________________________________________________________=
________
Packet(157394) Downstream 2.5(x1) TLP(17) Cfg CfgRd0(00:00100) Length(1=
)
_______| RequesterID(000:00:0) Tag(16) DeviceID(001:00:0) Register(0x01=
0)
_______| 1st BE(1111) LCRC(0xEFCBDA88) Time Stamp(0015 . 431 578 360 s)
_______|_______________________________________________________________=
________
Packet(157395) Upstream 2.5(x1) DLLP ACK AckNak_Seq_Num(17) CRC 16(0x13=
63)
_______| Time Stamp(0015 . 431 578 688 s)
_______|_______________________________________________________________=
________
Packet(157397) Upstream 2.5(x1) TLP(16) Cpl CplD(10:01010) Length(1)
_______| RequesterID(000:00:0) Tag(16) CompleterID(001:00:0) Status(SC)=
 BCM(0)
_______| Byte Cnt(4) Lwr Addr(0x00) Base Address Register 0(0x00000004)
_______| LCRC(0xCC4BEC3D) Time Stamp(0015 . 431 579 088 s)
_______|_______________________________________________________________=
________
Packet(157401) Downstream 2.5(x1) DLLP ACK AckNak_Seq_Num(16)
_______| CRC 16(0xB278) Time Stamp(0015 . 431 580 512 s)
_______|_______________________________________________________________=
________
Packet(157406) Downstream 2.5(x1) TLP(18) Cfg CfgWr0(10:00100) Length(1=
)
_______| RequesterID(000:00:0) Tag(17) DeviceID(001:00:0) Register(0x01=
0)
_______| 1st BE(1111) Base Address Register 0(0xFFFFFFFF) LCRC(0xF7378B=
E6)
_______| Time Stamp(0015 . 431 586 848 s)
_______|_______________________________________________________________=
________
Packet(157407) Upstream 2.5(x1) DLLP ACK AckNak_Seq_Num(18) CRC 16(0xF0=
4F)
_______| Time Stamp(0015 . 431 587 200 s)
_______|_______________________________________________________________=
________
Packet(157408) Upstream 2.5(x1) TLP(17) Cpl Cpl(00:01010) Length(0)
_______| RequesterID(000:00:0) Tag(17) CompleterID(001:00:0) Status(SC)=
 BCM(0)
_______| Byte Cnt(4) Lwr Addr(0x00) LCRC(0xB76BEE38)
_______| Time Stamp(0015 . 431 587 472 s)
_______|_______________________________________________________________=
________
Packet(157409) Downstream 2.5(x1) DLLP ACK AckNak_Seq_Num(17)
_______| CRC 16(0x1363) Time Stamp(0015 . 431 588 896 s)
_______|_______________________________________________________________=
________
Packet(157414) Downstream 2.5(x1) TLP(19) Cfg CfgRd0(00:00100) Length(1=
)
_______| RequesterID(000:00:0) Tag(18) DeviceID(001:00:0) Register(0x01=
0)
_______| 1st BE(1111) LCRC(0xAFDF4EA5) Time Stamp(0015 . 431 594 248 s)
_______|_______________________________________________________________=
________
Packet(157415) Upstream 2.5(x1) DLLP ACK AckNak_Seq_Num(19) CRC 16(0x51=
54)
_______| Time Stamp(0015 . 431 594 592 s)
_______|_______________________________________________________________=
________
Packet(157416) Upstream 2.5(x1) TLP(18) Cpl CplD(10:01010) Length(1)
_______| RequesterID(000:00:0) Tag(18) CompleterID(001:00:0) Status(SC)=
 BCM(0)
_______| Byte Cnt(4) Lwr Addr(0x00) Base Address Register 0(0xFFFFFF84)
_______| LCRC(0x29EAFF49) Time Stamp(0015 . 431 594 976 s)
_______|_______________________________________________________________=
________
Packet(157417) Downstream 2.5(x1) DLLP ACK AckNak_Seq_Num(18)
_______| CRC 16(0xF04F) Time Stamp(0015 . 431 596 416 s)
_______|_______________________________________________________________=
________
Packet(157421) Downstream 2.5(x1) TLP(20) Cfg CfgWr0(10:00100) Length(1=
)
_______| RequesterID(000:00:0) Tag(19) DeviceID(001:00:0) Register(0x01=
0)
_______| 1st BE(1111) Base Address Register 0(0x00000004) LCRC(0x76E793=
14)
_______| Time Stamp(0015 . 431 602 688 s)
_______|_______________________________________________________________=
________
Packet(157422) Upstream 2.5(x1) DLLP ACK AckNak_Seq_Num(20) CRC 16(0x36=
16)
_______| Time Stamp(0015 . 431 603 024 s)
_______|_______________________________________________________________=
________
Packet(157423) Upstream 2.5(x1) TLP(19) Cpl Cpl(00:01010) Length(0)
_______| RequesterID(000:00:0) Tag(19) CompleterID(001:00:0) Status(SC)=
 BCM(0)
_______| Byte Cnt(4) Lwr Addr(0x00) LCRC(0x7EBC846A)
_______| Time Stamp(0015 . 431 603 280 s)
_______|_______________________________________________________________=
________
Packet(157426) Downstream 2.5(x1) DLLP ACK AckNak_Seq_Num(19)
_______| CRC 16(0x5154) Time Stamp(0015 . 431 604 720 s)
_______|_______________________________________________________________=
________
Packet(157430) Downstream 2.5(x1) TLP(21) Cfg CfgWr0(10:00100) Length(1=
)
_______| RequesterID(000:00:0) Tag(20) DeviceID(001:00:0) Register(0x00=
4)
_______| 1st BE(0011) Status(0x0000) Command(0x0000) LCRC(0x4D62DF8D)
_______| Time Stamp(0015 . 431 610 400 s)
_______|_______________________________________________________________=
________
Packet(157431) Upstream 2.5(x1) DLLP ACK AckNak_Seq_Num(21) CRC 16(0x97=
0D)
_______| Time Stamp(0015 . 431 610 760 s)
_______|_______________________________________________________________=
________
Packet(157432) Upstream 2.5(x1) TLP(20) Cpl Cpl(00:01010) Length(0)
_______| RequesterID(000:00:0) Tag(20) CompleterID(001:00:0) Status(SC)=
 BCM(0)
_______| Byte Cnt(4) Lwr Addr(0x00) LCRC(0xE12CB658)
_______| Time Stamp(0015 . 431 611 008 s)
_______|_______________________________________________________________=
________
Packet(157435) Downstream 2.5(x1) DLLP ACK AckNak_Seq_Num(20)
_______| CRC 16(0x3616) Time Stamp(0015 . 431 612 416 s)
_______|_______________________________________________________________=
________
Packet(157440) Downstream 2.5(x1) TLP(22) Cfg CfgRd0(00:00100) Length(1=
)
_______| RequesterID(000:00:0) Tag(21) DeviceID(001:00:0) Register(0x01=
4)
_______| 1st BE(1111) LCRC(0x1D9809A2) Time Stamp(0015 . 431 617 904 s)
_______|_______________________________________________________________=
________
Packet(157441) Upstream 2.5(x1) DLLP ACK AckNak_Seq_Num(22) CRC 16(0x74=
21)
_______| Time Stamp(0015 . 431 618 248 s)
_______|_______________________________________________________________=
________
Packet(157442) Upstream 2.5(x1) TLP(21) Cpl CplD(10:01010) Length(1)
_______| RequesterID(000:00:0) Tag(21) CompleterID(001:00:0) Status(SC)=
 BCM(0)
_______| Byte Cnt(4) Lwr Addr(0x00) Base Address Register 1(0x00000000)
_______| LCRC(0xA4A1ED16) Time Stamp(0015 . 431 618 616 s)
_______|_______________________________________________________________=
________
Packet(157444) Downstream 2.5(x1) DLLP ACK AckNak_Seq_Num(21)
_______| CRC 16(0x970D) Time Stamp(0015 . 431 620 032 s)
_______|_______________________________________________________________=
________
Packet(157448) Downstream 2.5(x1) TLP(23) Cfg CfgWr0(10:00100) Length(1=
)
_______| RequesterID(000:00:0) Tag(22) DeviceID(001:00:0) Register(0x01=
4)
_______| 1st BE(1111) Base Address Register 1(0xFFFFFFFF) LCRC(0xC26679=
05)
_______| Time Stamp(0015 . 431 626 344 s)
_______|_______________________________________________________________=
________
Packet(157449) Upstream 2.5(x1) DLLP ACK AckNak_Seq_Num(23) CRC 16(0xD5=
3A)
_______| Time Stamp(0015 . 431 626 712 s)
_______|_______________________________________________________________=
________
Packet(157450) Upstream 2.5(x1) TLP(22) Cpl Cpl(00:01010) Length(0)
_______| RequesterID(000:00:0) Tag(22) CompleterID(001:00:0) Status(SC)=
 BCM(0)
_______| Byte Cnt(4) Lwr Addr(0x00) LCRC(0x28FBDC0A)
_______| Time Stamp(0015 . 431 626 968 s)
_______|_______________________________________________________________=
________
Packet(157451) Downstream 2.5(x1) DLLP ACK AckNak_Seq_Num(22)
_______| CRC 16(0x7421) Time Stamp(0015 . 431 628 376 s)
_______|_______________________________________________________________=
________
Packet(157455) Downstream 2.5(x1) TLP(24) Cfg CfgRd0(00:00100) Length(1=
)
_______| RequesterID(000:00:0) Tag(23) DeviceID(001:00:0) Register(0x01=
4)
_______| 1st BE(1111) LCRC(0xA6352715) Time Stamp(0015 . 431 633 744 s)
_______|_______________________________________________________________=
________
Packet(157456) Upstream 2.5(x1) DLLP ACK AckNak_Seq_Num(24) CRC 16(0xBA=
A5)
_______| Time Stamp(0015 . 431 634 096 s)
_______|_______________________________________________________________=
________
Packet(157457) Upstream 2.5(x1) TLP(23) Cpl CplD(10:01010) Length(1)
_______| RequesterID(000:00:0) Tag(23) CompleterID(001:00:0) Status(SC)=
 BCM(0)
_______| Byte Cnt(4) Lwr Addr(0x00) Base Address Register 1(0xFFFFFFFF)
_______| LCRC(0x8BB0A251) Time Stamp(0015 . 431 634 464 s)
_______|_______________________________________________________________=
________
Packet(157460) Downstream 2.5(x1) DLLP ACK AckNak_Seq_Num(23)
_______| CRC 16(0xD53A) Time Stamp(0015 . 431 635 880 s)
_______|_______________________________________________________________=
________
Packet(157464) Downstream 2.5(x1) TLP(25) Cfg CfgWr0(10:00100) Length(1=
)
_______| RequesterID(000:00:0) Tag(24) DeviceID(001:00:0) Register(0x01=
4)
_______| 1st BE(1111) Base Address Register 1(0x00000000) LCRC(0x048E2F=
84)
_______| Time Stamp(0015 . 431 642 160 s)
_______|_______________________________________________________________=
________
Packet(157465) Upstream 2.5(x1) DLLP ACK AckNak_Seq_Num(25) CRC 16(0x1B=
BE)
_______| Time Stamp(0015 . 431 642 528 s)
_______|_______________________________________________________________=
________
Packet(157466) Upstream 2.5(x1) TLP(24) Cpl Cpl(00:01010) Length(0)
_______| RequesterID(000:00:0) Tag(24) CompleterID(001:00:0) Status(SC)=
 BCM(0)
_______| Byte Cnt(4) Lwr Addr(0x00) LCRC(0x16DAB96E)
_______| Time Stamp(0015 . 431 642 800 s)
_______|_______________________________________________________________=
________
Packet(157467) Downstream 2.5(x1) DLLP ACK AckNak_Seq_Num(24)
_______| CRC 16(0xBAA5) Time Stamp(0015 . 431 644 216 s)
_______|_______________________________________________________________=
________
Packet(157479) Downstream 2.5(x1) TLP(26) Cfg CfgRd0(00:00100) Length(1=
)
_______| RequesterID(000:00:0) Tag(25) DeviceID(001:00:0) Register(0x00=
4)
_______| 1st BE(1111) LCRC(0xF9F1C652) Time Stamp(0015 . 431 664 944 s)
_______|_______________________________________________________________=
________
Packet(157480) Upstream 2.5(x1) DLLP ACK AckNak_Seq_Num(26) CRC 16(0xF8=
92)
_______| Time Stamp(0015 . 431 665 288 s)
_______|_______________________________________________________________=
________
Packet(157482) Upstream 2.5(x1) TLP(25) Cpl CplD(10:01010) Length(1)
_______| RequesterID(000:00:0) Tag(25) CompleterID(001:00:0) Status(SC)=
 BCM(0)
_______| Byte Cnt(4) Lwr Addr(0x00) Status(0x0010) Command(0x0000)
_______| LCRC(0xDF1BF5BE) Time Stamp(0015 . 431 665 672 s)
_______|_______________________________________________________________=
________
Packet(157484) Downstream 2.5(x1) DLLP ACK AckNak_Seq_Num(25)
_______| CRC 16(0x1BBE) Time Stamp(0015 . 431 667 128 s)
_______|_______________________________________________________________=
________
Packet(157488) Downstream 2.5(x1) TLP(27) Cfg CfgWr0(10:00100) Length(1=
)
_______| RequesterID(000:00:0) Tag(26) DeviceID(001:00:0) Register(0x00=
4)
_______| 1st BE(0011) Status(0x0000) Command(0x0000) LCRC(0x68AA32D2)
_______| Time Stamp(0015 . 431 673 560 s)
_______|_______________________________________________________________=
________
Packet(157489) Upstream 2.5(x1) DLLP ACK AckNak_Seq_Num(27) CRC 16(0x59=
89)
_______| Time Stamp(0015 . 431 673 904 s)
_______|_______________________________________________________________=
________
Packet(157490) Upstream 2.5(x1) TLP(26) Cpl Cpl(00:01010) Length(0)
_______| RequesterID(000:00:0) Tag(26) CompleterID(001:00:0) Status(SC)=
 BCM(0)
_______| Byte Cnt(4) Lwr Addr(0x00) LCRC(0xDF0DD33C)
_______| Time Stamp(0015 . 431 674 184 s)
_______|_______________________________________________________________=
________
Packet(157491) Downstream 2.5(x1) DLLP ACK AckNak_Seq_Num(26)
_______| CRC 16(0xF892) Time Stamp(0015 . 431 675 592 s)
_______|_______________________________________________________________=
________
Packet(157498) Downstream 2.5(x1) TLP(28) Cfg CfgRd0(00:00100) Length(1=
)
_______| RequesterID(000:00:0) Tag(27) DeviceID(001:00:0) Register(0x01=
8)
_______| 1st BE(1111) LCRC(0x60D3EAAB) Time Stamp(0015 . 431 681 000 s)
_______|_______________________________________________________________=
________
Packet(157499) Upstream 2.5(x1) DLLP ACK AckNak_Seq_Num(28) CRC 16(0x3E=
CB)
_______| Time Stamp(0015 . 431 681 320 s)
_______|_______________________________________________________________=
________
Packet(157500) Upstream 2.5(x1) TLP(27) Cpl CplD(10:01010) Length(1)
_______| RequesterID(000:00:0) Tag(27) CompleterID(001:00:0) Status(SC)=
 BCM(0)
_______| Byte Cnt(4) Lwr Addr(0x00) Base Address Register 2(0x00000004)
_______| LCRC(0x15AFA1E2) Time Stamp(0015 . 431 681 688 s)
_______|_______________________________________________________________=
________
Packet(157502) Downstream 2.5(x1) DLLP ACK AckNak_Seq_Num(27)
_______| CRC 16(0x5989) Time Stamp(0015 . 431 683 128 s)
_______|_______________________________________________________________=
________
Packet(157506) Downstream 2.5(x1) TLP(29) Cfg CfgWr0(10:00100) Length(1=
)
_______| RequesterID(000:00:0) Tag(28) DeviceID(001:00:0) Register(0x01=
8)
_______| 1st BE(1111) Base Address Register 2(0xFFFFFFFF) LCRC(0x53C487=
E5)
_______| Time Stamp(0015 . 431 689 456 s)
_______|_______________________________________________________________=
________
Packet(157507) Upstream 2.5(x1) DLLP ACK AckNak_Seq_Num(29) CRC 16(0x9F=
D0)
_______| Time Stamp(0015 . 431 689 800 s)
_______|_______________________________________________________________=
________
Packet(157508) Upstream 2.5(x1) TLP(28) Cpl Cpl(00:01010) Length(0)
_______| RequesterID(000:00:0) Tag(28) CompleterID(001:00:0) Status(SC)=
 BCM(0)
_______| Byte Cnt(4) Lwr Addr(0x00) LCRC(0x84756CCA)
_______| Time Stamp(0015 . 431 690 080 s)
_______|_______________________________________________________________=
________
Packet(157510) Downstream 2.5(x1) DLLP ACK AckNak_Seq_Num(28)
_______| CRC 16(0x3ECB) Time Stamp(0015 . 431 691 488 s)
_______|_______________________________________________________________=
________
Packet(157514) Downstream 2.5(x1) TLP(30) Cfg CfgRd0(00:00100) Length(1=
)
_______| RequesterID(000:00:0) Tag(29) DeviceID(001:00:0) Register(0x01=
8)
_______| 1st BE(1111) LCRC(0x3685EF1D) Time Stamp(0015 . 431 696 840 s)
_______|_______________________________________________________________=
________
Packet(157516) Upstream 2.5(x1) DLLP ACK AckNak_Seq_Num(30) CRC 16(0x7C=
=46C)
_______| Time Stamp(0015 . 431 697 208 s)
_______|_______________________________________________________________=
________
Packet(157517) Upstream 2.5(x1) TLP(29) Cpl CplD(10:01010) Length(1)
_______| RequesterID(000:00:0) Tag(29) CompleterID(001:00:0) Status(SC)=
 BCM(0)
_______| Byte Cnt(4) Lwr Addr(0x00) Base Address Register 2(0xFFFFE004)
_______| LCRC(0x5F390884) Time Stamp(0015 . 431 697 576 s)
_______|_______________________________________________________________=
________
Packet(157518) Downstream 2.5(x1) DLLP ACK AckNak_Seq_Num(29)
_______| CRC 16(0x9FD0) Time Stamp(0015 . 431 699 016 s)
_______|_______________________________________________________________=
________
Packet(157522) Downstream 2.5(x1) TLP(31) Cfg CfgWr0(10:00100) Length(1=
)
_______| RequesterID(000:00:0) Tag(30) DeviceID(001:00:0) Register(0x01=
8)
_______| 1st BE(1111) Base Address Register 2(0x00000004) LCRC(0x1D3397=
64)
_______| Time Stamp(0015 . 431 705 272 s)
_______|_______________________________________________________________=
________
Packet(157523) Upstream 2.5(x1) DLLP ACK AckNak_Seq_Num(31) CRC 16(0xDD=
E7)
_______| Time Stamp(0015 . 431 705 624 s)
_______|_______________________________________________________________=
________
Packet(157524) Upstream 2.5(x1) TLP(30) Cpl Cpl(00:01010) Length(0)
_______| RequesterID(000:00:0) Tag(30) CompleterID(001:00:0) Status(SC)=
 BCM(0)
_______| Byte Cnt(4) Lwr Addr(0x00) LCRC(0x4DA20698)
_______| Time Stamp(0015 . 431 705 880 s)
_______|_______________________________________________________________=
________
Packet(157526) Downstream 2.5(x1) DLLP ACK AckNak_Seq_Num(30)
_______| CRC 16(0x7CFC) Time Stamp(0015 . 431 707 312 s)
_______|_______________________________________________________________=
________
Packet(157533) Downstream 2.5(x1) TLP(32) Cfg CfgWr0(10:00100) Length(1=
)
_______| RequesterID(000:00:0) Tag(31) DeviceID(001:00:0) Register(0x00=
4)
_______| 1st BE(0011) Status(0x0000) Command(0x0000) LCRC(0xB1DE63B8)
_______| Time Stamp(0015 . 431 712 960 s)
_______|_______________________________________________________________=
________
Packet(157534) Upstream 2.5(x1) DLLP ACK AckNak_Seq_Num(32) CRC 16(0xB1=
56)
_______| Time Stamp(0015 . 431 713 312 s)
_______|_______________________________________________________________=
________
Packet(157535) Upstream 2.5(x1) TLP(31) Cpl Cpl(00:01010) Length(0)
_______| RequesterID(000:00:0) Tag(31) CompleterID(001:00:0) Status(SC)=
 BCM(0)
_______| Byte Cnt(4) Lwr Addr(0x00) LCRC(0x894A8B5C)
_______| Time Stamp(0015 . 431 713 584 s)
_______|_______________________________________________________________=
________
Packet(157537) Downstream 2.5(x1) DLLP ACK AckNak_Seq_Num(31)
_______| CRC 16(0xDDE7) Time Stamp(0015 . 431 715 000 s)
_______|_______________________________________________________________=
________
Packet(157540) Downstream 2.5(x1) TLP(33) Cfg CfgRd0(00:00100) Length(1=
)
_______| RequesterID(000:00:0) Tag(0) DeviceID(001:00:0) Register(0x01C=
)
_______| 1st BE(1111) LCRC(0x7068C385) Time Stamp(0015 . 431 720 424 s)
_______|_______________________________________________________________=
________
Packet(157541) Upstream 2.5(x1) DLLP ACK AckNak_Seq_Num(33) CRC 16(0x10=
4D)
_______| Time Stamp(0015 . 431 720 760 s)
_______|_______________________________________________________________=
________
Packet(157543) Upstream 2.5(x1) TLP(32) Cpl CplD(10:01010) Length(1)
_______| RequesterID(000:00:0) Tag(0) CompleterID(001:00:0) Status(SC) =
BCM(0)
_______| Byte Cnt(4) Lwr Addr(0x00) Base Address Register 3(0x00000000)
_______| LCRC(0x8775AA88) Time Stamp(0015 . 431 721 152 s)
_______|_______________________________________________________________=
________
Packet(157544) Downstream 2.5(x1) DLLP ACK AckNak_Seq_Num(32)
_______| CRC 16(0xB156) Time Stamp(0015 . 431 722 584 s)
_______|_______________________________________________________________=
________
Packet(157549) Downstream 2.5(x1) TLP(34) Cfg CfgWr0(10:00100) Length(1=
)
_______| RequesterID(000:00:0) Tag(1) DeviceID(001:00:0) Register(0x01C=
)
_______| 1st BE(1111) Base Address Register 3(0xFFFFFFFF) LCRC(0x99F027=
3D)
_______| Time Stamp(0015 . 431 728 864 s)
_______|_______________________________________________________________=
________
Packet(157550) Upstream 2.5(x1) DLLP ACK AckNak_Seq_Num(34) CRC 16(0xF3=
61)
_______| Time Stamp(0015 . 431 729 240 s)
_______|_______________________________________________________________=
________
Packet(157551) Upstream 2.5(x1) TLP(33) Cpl Cpl(00:01010) Length(0)
_______| RequesterID(000:00:0) Tag(1) CompleterID(001:00:0) Status(SC) =
BCM(0)
_______| Byte Cnt(4) Lwr Addr(0x00) LCRC(0xC9945575)
_______| Time Stamp(0015 . 431 729 496 s)
_______|_______________________________________________________________=
________
Packet(157552) Downstream 2.5(x1) DLLP ACK AckNak_Seq_Num(33)
_______| CRC 16(0x104D) Time Stamp(0015 . 431 730 920 s)
_______|_______________________________________________________________=
________
Packet(157556) Downstream 2.5(x1) TLP(35) Cfg CfgRd0(00:00100) Length(1=
)
_______| RequesterID(000:00:0) Tag(2) DeviceID(001:00:0) Register(0x01C=
)
_______| 1st BE(1111) LCRC(0x307C57A8) Time Stamp(0015 . 431 736 256 s)
_______|_______________________________________________________________=
________
Packet(157557) Upstream 2.5(x1) DLLP ACK AckNak_Seq_Num(35) CRC 16(0x52=
7A)
_______| Time Stamp(0015 . 431 736 600 s)
_______|_______________________________________________________________=
________
Packet(157559) Upstream 2.5(x1) TLP(34) Cpl CplD(10:01010) Length(1)
_______| RequesterID(000:00:0) Tag(2) CompleterID(001:00:0) Status(SC) =
BCM(0)
_______| Byte Cnt(4) Lwr Addr(0x00) Base Address Register 3(0xFFFFFFFF)
_______| LCRC(0xA864E5CF) Time Stamp(0015 . 431 736 992 s)
_______|_______________________________________________________________=
________
Packet(157561) Downstream 2.5(x1) DLLP ACK AckNak_Seq_Num(34)
_______| CRC 16(0xF361) Time Stamp(0015 . 431 738 432 s)
_______|_______________________________________________________________=
________
Packet(157567) Downstream 2.5(x1) TLP(36) Cfg CfgWr0(10:00100) Length(1=
)
_______| RequesterID(000:00:0) Tag(3) DeviceID(001:00:0) Register(0x01C=
)
_______| 1st BE(1111) Base Address Register 3(0x00000000) LCRC(0x4FB75D=
40)
_______| Time Stamp(0015 . 431 744 712 s)
_______|_______________________________________________________________=
________
Packet(157568) Upstream 2.5(x1) DLLP ACK AckNak_Seq_Num(36) CRC 16(0x35=
38)
_______| Time Stamp(0015 . 431 745 056 s)
_______|_______________________________________________________________=
________
Packet(157569) Upstream 2.5(x1) TLP(35) Cpl Cpl(00:01010) Length(0)
_______| RequesterID(000:00:0) Tag(3) CompleterID(001:00:0) Status(SC) =
BCM(0)
_______| Byte Cnt(4) Lwr Addr(0x00) LCRC(0x00433F27)
_______| Time Stamp(0015 . 431 745 312 s)
_______|_______________________________________________________________=
________
Packet(157571) Downstream 2.5(x1) DLLP ACK AckNak_Seq_Num(35)
_______| CRC 16(0x527A) Time Stamp(0015 . 431 746 720 s)
_______|_______________________________________________________________=
________
Packet(157580) Downstream 2.5(x1) TLP(37) Cfg CfgRd0(00:00100) Length(1=
)
_______| RequesterID(000:00:0) Tag(4) DeviceID(001:00:0) Register(0x004=
)
_______| 1st BE(1111) LCRC(0xA6D887CD) Time Stamp(0015 . 431 765 840 s)
_______|_______________________________________________________________=
________
Packet(157581) Upstream 2.5(x1) DLLP ACK AckNak_Seq_Num(37) CRC 16(0x94=
23)
_______| Time Stamp(0015 . 431 766 184 s)
_______|_______________________________________________________________=
________
Packet(157582) Upstream 2.5(x1) TLP(36) Cpl CplD(10:01010) Length(1)
_______| RequesterID(000:00:0) Tag(4) CompleterID(001:00:0) Status(SC) =
BCM(0)
_______| Byte Cnt(4) Lwr Addr(0x00) Status(0x0010) Command(0x0000)
_______| LCRC(0x0F02F12A) Time Stamp(0015 . 431 766 552 s)
_______|_______________________________________________________________=
________
Packet(157584) Downstream 2.5(x1) DLLP ACK AckNak_Seq_Num(36)
_______| CRC 16(0x3538) Time Stamp(0015 . 431 767 976 s)
_______|_______________________________________________________________=
________
Packet(157589) Downstream 2.5(x1) TLP(38) Cfg CfgWr0(10:00100) Length(1=
)
_______| RequesterID(000:00:0) Tag(5) DeviceID(001:00:0) Register(0x004=
)
_______| 1st BE(0011) Status(0x0000) Command(0x0000) LCRC(0x9878DB2F)
_______| Time Stamp(0015 . 431 774 440 s)
_______|_______________________________________________________________=
________
Packet(157590) Upstream 2.5(x1) DLLP ACK AckNak_Seq_Num(38) CRC 16(0x77=
0F)
_______| Time Stamp(0015 . 431 774 768 s)
_______|_______________________________________________________________=
________
Packet(157591) Upstream 2.5(x1) TLP(37) Cpl Cpl(00:01010) Length(0)
_______| RequesterID(000:00:0) Tag(5) CompleterID(001:00:0) Status(SC) =
BCM(0)
_______| Byte Cnt(4) Lwr Addr(0x00) LCRC(0x5B3B80D1)
_______| Time Stamp(0015 . 431 775 048 s)
_______|_______________________________________________________________=
________
Packet(157592) Downstream 2.5(x1) DLLP ACK AckNak_Seq_Num(37)
_______| CRC 16(0x9423) Time Stamp(0015 . 431 776 464 s)
_______|_______________________________________________________________=
________
Packet(157598) Downstream 2.5(x1) TLP(39) Cfg CfgRd0(00:00100) Length(1=
)
_______| RequesterID(000:00:0) Tag(6) DeviceID(001:00:0) Register(0x020=
)
_______| 1st BE(1111) LCRC(0x372810DC) Time Stamp(0015 . 431 782 000 s)
_______|_______________________________________________________________=
________
Packet(157599) Upstream 2.5(x1) DLLP ACK AckNak_Seq_Num(39) CRC 16(0xD6=
14)
_______| Time Stamp(0015 . 431 782 312 s)
_______|_______________________________________________________________=
________
Packet(157600) Upstream 2.5(x1) TLP(38) Cpl CplD(10:01010) Length(1)
_______| RequesterID(000:00:0) Tag(6) CompleterID(001:00:0) Status(SC) =
BCM(0)
_______| Byte Cnt(4) Lwr Addr(0x00) Base Address Register 4(0x00000001)
_______| LCRC(0xF7467B41) Time Stamp(0015 . 431 782 680 s)
_______|_______________________________________________________________=
________
Packet(157602) Downstream 2.5(x1) DLLP ACK AckNak_Seq_Num(38)
_______| CRC 16(0x770F) Time Stamp(0015 . 431 784 120 s)
_______|_______________________________________________________________=
________
Packet(157607) Downstream 2.5(x1) TLP(40) Cfg CfgWr0(10:00100) Length(1=
)
_______| RequesterID(000:00:0) Tag(7) DeviceID(001:00:0) Register(0x020=
)
_______| 1st BE(1111) Base Address Register 4(0xFFFFFFFF) LCRC(0x000AC4=
66)
_______| Time Stamp(0015 . 431 790 416 s)
_______|_______________________________________________________________=
________
Packet(157608) Upstream 2.5(x1) DLLP ACK AckNak_Seq_Num(40) CRC 16(0xB9=
8B)
_______| Time Stamp(0015 . 431 790 744 s)
_______|_______________________________________________________________=
________
Packet(157609) Upstream 2.5(x1) TLP(39) Cpl Cpl(00:01010) Length(0)
_______| RequesterID(000:00:0) Tag(7) CompleterID(001:00:0) Status(SC) =
BCM(0)
_______| Byte Cnt(4) Lwr Addr(0x00) LCRC(0x92ECEA83)
_______| Time Stamp(0015 . 431 791 032 s)
_______|_______________________________________________________________=
________
Packet(157610) Downstream 2.5(x1) DLLP ACK AckNak_Seq_Num(39)
_______| CRC 16(0xD614) Time Stamp(0015 . 431 792 448 s)
_______|_______________________________________________________________=
________
Packet(157615) Downstream 2.5(x1) TLP(41) Cfg CfgRd0(00:00100) Length(1=
)
_______| RequesterID(000:00:0) Tag(8) DeviceID(001:00:0) Register(0x020=
)
_______| 1st BE(1111) LCRC(0xF745FC1C) Time Stamp(0015 . 431 797 784 s)
_______|_______________________________________________________________=
________
Packet(157616) Upstream 2.5(x1) DLLP ACK AckNak_Seq_Num(41) CRC 16(0x18=
90)
_______| Time Stamp(0015 . 431 798 104 s)
_______|_______________________________________________________________=
________
Packet(157617) Upstream 2.5(x1) TLP(40) Cpl CplD(10:01010) Length(1)
_______| RequesterID(000:00:0) Tag(8) CompleterID(001:00:0) Status(SC) =
BCM(0)
_______| Byte Cnt(4) Lwr Addr(0x00) Base Address Register 4(0xFFFFFF81)
_______| LCRC(0x384FB2D7) Time Stamp(0015 . 431 798 472 s)
_______|_______________________________________________________________=
________
Packet(157618) Downstream 2.5(x1) DLLP ACK AckNak_Seq_Num(40)
_______| CRC 16(0xB98B) Time Stamp(0015 . 431 799 912 s)
_______|_______________________________________________________________=
________
Packet(157623) Downstream 2.5(x1) TLP(42) Cfg CfgWr0(10:00100) Length(1=
)
_______| RequesterID(000:00:0) Tag(9) DeviceID(001:00:0) Register(0x020=
)
_______| 1st BE(1111) Base Address Register 4(0x00000001) LCRC(0xF2ED36=
CA)
_______| Time Stamp(0015 . 431 806 176 s)
_______|_______________________________________________________________=
________
Packet(157624) Upstream 2.5(x1) DLLP ACK AckNak_Seq_Num(42) CRC 16(0xFB=
BC)
_______| Time Stamp(0015 . 431 806 512 s)
_______|_______________________________________________________________=
________
Packet(157625) Upstream 2.5(x1) TLP(41) Cpl Cpl(00:01010) Length(0)
_______| RequesterID(000:00:0) Tag(9) CompleterID(001:00:0) Status(SC) =
BCM(0)
_______| Byte Cnt(4) Lwr Addr(0x00) LCRC(0xACCD8FE7)
_______| Time Stamp(0015 . 431 806 768 s)
_______|_______________________________________________________________=
________
Packet(157627) Downstream 2.5(x1) DLLP ACK AckNak_Seq_Num(41)
_______| CRC 16(0x1890) Time Stamp(0015 . 431 808 192 s)
_______|_______________________________________________________________=
________
Packet(157633) Downstream 2.5(x1) TLP(43) Cfg CfgWr0(10:00100) Length(1=
)
_______| RequesterID(000:00:0) Tag(10) DeviceID(001:00:0) Register(0x00=
4)
_______| 1st BE(0011) Status(0x0000) Command(0x0000) LCRC(0x07806ECC)
_______| Time Stamp(0015 . 431 813 888 s)
_______|_______________________________________________________________=
________
Packet(157634) Upstream 2.5(x1) DLLP ACK AckNak_Seq_Num(43) CRC 16(0x5A=
A7)
_______| Time Stamp(0015 . 431 814 232 s)
_______|_______________________________________________________________=
________
Packet(157635) Upstream 2.5(x1) TLP(42) Cpl Cpl(00:01010) Length(0)
_______| RequesterID(000:00:0) Tag(10) CompleterID(001:00:0) Status(SC)=
 BCM(0)
_______| Byte Cnt(4) Lwr Addr(0x00) LCRC(0xA1F26871)
_______| Time Stamp(0015 . 431 814 504 s)
_______|_______________________________________________________________=
________
Packet(157637) Downstream 2.5(x1) DLLP ACK AckNak_Seq_Num(42)
_______| CRC 16(0xFBBC) Time Stamp(0015 . 431 815 920 s)
_______|_______________________________________________________________=
________
Packet(157646) Downstream 2.5(x1) TLP(44) Cfg CfgRd0(00:00100) Length(1=
)
_______| RequesterID(000:00:0) Tag(11) DeviceID(001:00:0) Register(0x00=
4)
_______| 1st BE(1111) LCRC(0x9B6044BB) Time Stamp(0015 . 431 833 176 s)
_______|_______________________________________________________________=
________
Packet(157647) Upstream 2.5(x1) DLLP ACK AckNak_Seq_Num(44) CRC 16(0x3D=
E5)
_______| Time Stamp(0015 . 431 833 496 s)
_______|_______________________________________________________________=
________
Packet(157648) Upstream 2.5(x1) TLP(43) Cpl CplD(10:01010) Length(1)
_______| RequesterID(000:00:0) Tag(11) CompleterID(001:00:0) Status(SC)=
 BCM(0)
_______| Byte Cnt(4) Lwr Addr(0x00) Status(0x0010) Command(0x0000)
_______| LCRC(0x0F83251D) Time Stamp(0015 . 431 833 880 s)
_______|_______________________________________________________________=
________
Packet(157649) Downstream 2.5(x1) DLLP ACK AckNak_Seq_Num(43)
_______| CRC 16(0x5AA7) Time Stamp(0015 . 431 835 328 s)
_______|_______________________________________________________________=
________
Packet(157654) Downstream 2.5(x1) TLP(45) Cfg CfgWr0(10:00100) Length(1=
)
_______| RequesterID(000:00:0) Tag(12) DeviceID(001:00:0) Register(0x00=
4)
_______| 1st BE(0011) Status(0x0000) Command(0x0000) LCRC(0x48474466)
_______| Time Stamp(0015 . 431 841 704 s)
_______|_______________________________________________________________=
________
Packet(157655) Upstream 2.5(x1) DLLP ACK AckNak_Seq_Num(45) CRC 16(0x9C=
=46E)
_______| Time Stamp(0015 . 431 842 056 s)
_______|_______________________________________________________________=
________
Packet(157656) Upstream 2.5(x1) TLP(44) Cpl Cpl(00:01010) Length(0)
_______| RequesterID(000:00:0) Tag(12) CompleterID(001:00:0) Status(SC)=
 BCM(0)
_______| Byte Cnt(4) Lwr Addr(0x00) LCRC(0xFA8AD787)
_______| Time Stamp(0015 . 431 842 312 s)
_______|_______________________________________________________________=
________
Packet(157659) Downstream 2.5(x1) DLLP ACK AckNak_Seq_Num(44)
_______| CRC 16(0x3DE5) Time Stamp(0015 . 431 843 736 s)
_______|_______________________________________________________________=
________
Packet(157663) Downstream 2.5(x1) TLP(46) Cfg CfgRd0(00:00100) Length(1=
)
_______| RequesterID(000:00:0) Tag(13) DeviceID(001:00:0) Register(0x02=
4)
_______| 1st BE(1111) LCRC(0x05162F36) Time Stamp(0015 . 431 849 136 s)
_______|_______________________________________________________________=
________
Packet(157664) Upstream 2.5(x1) DLLP ACK AckNak_Seq_Num(46) CRC 16(0x7F=
D2)
_______| Time Stamp(0015 . 431 849 472 s)
_______|_______________________________________________________________=
________
Packet(157665) Upstream 2.5(x1) TLP(45) Cpl CplD(10:01010) Length(1)
_______| RequesterID(000:00:0) Tag(13) CompleterID(001:00:0) Status(SC)=
 BCM(0)
_______| Byte Cnt(4) Lwr Addr(0x00) Base Address Register 5(0x00000000)
_______| LCRC(0x4BC58A26) Time Stamp(0015 . 431 849 856 s)
_______|_______________________________________________________________=
________
Packet(157667) Downstream 2.5(x1) DLLP ACK AckNak_Seq_Num(45)
_______| CRC 16(0x9CFE) Time Stamp(0015 . 431 851 280 s)
_______|_______________________________________________________________=
________
Packet(157673) Downstream 2.5(x1) TLP(47) Cfg CfgWr0(10:00100) Length(1=
)
_______| RequesterID(000:00:0) Tag(14) DeviceID(001:00:0) Register(0x02=
4)
_______| 1st BE(1111) Base Address Register 5(0xFFFFFFFF) LCRC(0x41FBC3=
4F)
_______| Time Stamp(0015 . 431 857 600 s)
_______|_______________________________________________________________=
________
Packet(157674) Upstream 2.5(x1) DLLP ACK AckNak_Seq_Num(47) CRC 16(0xDE=
C9)
_______| Time Stamp(0015 . 431 857 944 s)
_______|_______________________________________________________________=
________
Packet(157675) Upstream 2.5(x1) TLP(46) Cpl Cpl(00:01010) Length(0)
_______| RequesterID(000:00:0) Tag(14) CompleterID(001:00:0) Status(SC)=
 BCM(0)
_______| Byte Cnt(4) Lwr Addr(0x00) LCRC(0x335DBDD5)
_______| Time Stamp(0015 . 431 858 192 s)
_______|_______________________________________________________________=
________
Packet(157676) Downstream 2.5(x1) DLLP ACK AckNak_Seq_Num(46)
_______| CRC 16(0x7FD2) Time Stamp(0015 . 431 859 616 s)
_______|_______________________________________________________________=
________
Packet(157680) Downstream 2.5(x1) TLP(48) Cfg CfgRd0(00:00100) Length(1=
)
_______| RequesterID(000:00:0) Tag(15) DeviceID(001:00:0) Register(0x02=
4)
_______| 1st BE(1111) LCRC(0x641D0635) Time Stamp(0015 . 431 864 968 s)
_______|_______________________________________________________________=
________
Packet(157681) Upstream 2.5(x1) DLLP ACK AckNak_Seq_Num(48) CRC 16(0xB0=
4C)
_______| Time Stamp(0015 . 431 865 296 s)
_______|_______________________________________________________________=
________
Packet(157682) Upstream 2.5(x1) TLP(47) Cpl CplD(10:01010) Length(1)
_______| RequesterID(000:00:0) Tag(15) CompleterID(001:00:0) Status(SC)=
 BCM(0)
_______| Byte Cnt(4) Lwr Addr(0x00) Base Address Register 5(0x00000000)
_______| LCRC(0x87F47EBF) Time Stamp(0015 . 431 865 680 s)
_______|_______________________________________________________________=
________
Packet(157684) Downstream 2.5(x1) DLLP ACK AckNak_Seq_Num(47)
_______| CRC 16(0xDEC9) Time Stamp(0015 . 431 867 112 s)
_______|_______________________________________________________________=
________
Packet(157688) Downstream 2.5(x1) TLP(49) Cfg CfgWr0(10:00100) Length(1=
)
_______| RequesterID(000:00:0) Tag(16) DeviceID(001:00:0) Register(0x02=
4)
_______| 1st BE(1111) Base Address Register 5(0x00000000) LCRC(0x120B6A=
=46E)
_______| Time Stamp(0015 . 431 873 376 s)
_______|_______________________________________________________________=
________
Packet(157689) Upstream 2.5(x1) DLLP ACK AckNak_Seq_Num(49) CRC 16(0x11=
57)
_______| Time Stamp(0015 . 431 873 728 s)
_______|_______________________________________________________________=
________
Packet(157690) Upstream 2.5(x1) TLP(48) Cpl Cpl(00:01010) Length(0)
_______| RequesterID(000:00:0) Tag(16) CompleterID(001:00:0) Status(SC)=
 BCM(0)
_______| Byte Cnt(4) Lwr Addr(0x00) LCRC(0x86C81D4F)
_______| Time Stamp(0015 . 431 873 992 s)
_______|_______________________________________________________________=
________
Packet(157692) Downstream 2.5(x1) DLLP ACK AckNak_Seq_Num(48)
_______| CRC 16(0xB04C) Time Stamp(0015 . 431 875 424 s)
_______|_______________________________________________________________=
________
Packet(157697) Downstream 2.5(x1) TLP(50) Cfg CfgWr0(10:00100) Length(1=
)
_______| RequesterID(000:00:0) Tag(17) DeviceID(001:00:0) Register(0x00=
4)
_______| 1st BE(0011) Status(0x0000) Command(0x0000) LCRC(0xB8E7C765)
_______| Time Stamp(0015 . 431 881 120 s)
_______|_______________________________________________________________=
________
Packet(157699) Upstream 2.5(x1) DLLP ACK AckNak_Seq_Num(50) CRC 16(0xF2=
7B)
_______| Time Stamp(0015 . 431 881 464 s)
_______|_______________________________________________________________=
________
Packet(157700) Upstream 2.5(x1) TLP(49) Cpl Cpl(00:01010) Length(0)
_______| RequesterID(000:00:0) Tag(17) CompleterID(001:00:0) Status(SC)=
 BCM(0)
_______| Byte Cnt(4) Lwr Addr(0x00) LCRC(0x4220908B)
_______| Time Stamp(0015 . 431 881 736 s)
_______|_______________________________________________________________=
________
Packet(157702) Downstream 2.5(x1) DLLP ACK AckNak_Seq_Num(49)
_______| CRC 16(0x1157) Time Stamp(0015 . 431 883 176 s)
_______|_______________________________________________________________=
________
Packet(157707) Downstream 2.5(x1) TLP(51) Cfg CfgRd0(00:00100) Length(1=
)
_______| RequesterID(000:00:0) Tag(18) DeviceID(001:00:0) Register(0x00=
4)
_______| 1st BE(1111) LCRC(0x2740EA0C) Time Stamp(0015 . 431 888 728 s)
_______|_______________________________________________________________=
________
Packet(157708) Upstream 2.5(x1) DLLP ACK AckNak_Seq_Num(51) CRC 16(0x53=
60)
_______| Time Stamp(0015 . 431 889 064 s)
_______|_______________________________________________________________=
________
Packet(157709) Upstream 2.5(x1) TLP(50) Cpl CplD(10:01010) Length(1)
_______| RequesterID(000:00:0) Tag(18) CompleterID(001:00:0) Status(SC)=
 BCM(0)
_______| Byte Cnt(4) Lwr Addr(0x00) Status(0x0010) Command(0x0000)
_______| LCRC(0xFCCD1B4F) Time Stamp(0015 . 431 889 448 s)
_______|_______________________________________________________________=
________
Packet(157710) Downstream 2.5(x1) DLLP ACK AckNak_Seq_Num(50)
_______| CRC 16(0xF27B) Time Stamp(0015 . 431 890 904 s)
_______|_______________________________________________________________=
________
Packet(157714) Downstream 2.5(x1) TLP(52) Cfg CfgWr0(10:00100) Length(1=
)
_______| RequesterID(000:00:0) Tag(19) DeviceID(001:00:0) Register(0x00=
4)
_______| 1st BE(0011) Status(0x0000) Command(0x0000) LCRC(0x8D8006C6)
_______| Time Stamp(0015 . 431 897 240 s)
_______|_______________________________________________________________=
________
Packet(157715) Upstream 2.5(x1) DLLP ACK AckNak_Seq_Num(52) CRC 16(0x34=
22)
_______| Time Stamp(0015 . 431 897 576 s)
_______|_______________________________________________________________=
________
Packet(157717) Upstream 2.5(x1) TLP(51) Cpl Cpl(00:01010) Length(0)
_______| RequesterID(000:00:0) Tag(19) CompleterID(001:00:0) Status(SC)=
 BCM(0)
_______| Byte Cnt(4) Lwr Addr(0x00) LCRC(0x8BF7FAD9)
_______| Time Stamp(0015 . 431 897 848 s)
_______|_______________________________________________________________=
________
Packet(157718) Downstream 2.5(x1) DLLP ACK AckNak_Seq_Num(51)
_______| CRC 16(0x5360) Time Stamp(0015 . 431 899 288 s)
_______|_______________________________________________________________=
________
Packet(157722) Downstream 2.5(x1) TLP(53) Cfg CfgRd0(00:00100) Length(1=
)
_______| RequesterID(000:00:0) Tag(20) DeviceID(001:00:0) Register(0x03=
0)
_______| 1st BE(1111) LCRC(0x5288E25B) Time Stamp(0015 . 431 904 624 s)
_______|_______________________________________________________________=
________
Packet(157723) Upstream 2.5(x1) DLLP ACK AckNak_Seq_Num(53) CRC 16(0x95=
39)
_______| Time Stamp(0015 . 431 904 952 s)
_______|_______________________________________________________________=
________
Packet(157724) Upstream 2.5(x1) TLP(52) Cpl CplD(10:01010) Length(1)
_______| RequesterID(000:00:0) Tag(20) CompleterID(001:00:0) Status(SC)=
 BCM(0)
_______| Byte Cnt(4) Lwr Addr(0x00) Expansion ROM Base Address(0x000000=
00)
_______| LCRC(0xB88BB474) Time Stamp(0015 . 431 905 312 s)
_______|_______________________________________________________________=
________
Packet(157726) Downstream 2.5(x1) DLLP ACK AckNak_Seq_Num(52)
_______| CRC 16(0x3422) Time Stamp(0015 . 431 906 768 s)
_______|_______________________________________________________________=
________
Packet(157732) Downstream 2.5(x1) TLP(54) Cfg CfgWr0(10:00100) Length(1=
)
_______| RequesterID(000:00:0) Tag(21) DeviceID(001:00:0) Register(0x03=
0)
_______| 1st BE(1111) Expansion ROM Base Address(0xFFFFF800) LCRC(0xC8B=
D40A8)
_______| Time Stamp(0015 . 431 913 040 s)
_______|_______________________________________________________________=
________
Packet(157734) Upstream 2.5(x1) DLLP ACK AckNak_Seq_Num(54) CRC 16(0x76=
15)
_______| Time Stamp(0015 . 431 913 384 s)
_______|_______________________________________________________________=
________
Packet(157735) Upstream 2.5(x1) TLP(53) Cpl Cpl(00:01010) Length(0)
_______| RequesterID(000:00:0) Tag(21) CompleterID(001:00:0) Status(SC)=
 BCM(0)
_______| Byte Cnt(4) Lwr Addr(0x00) LCRC(0xD08F452F)
_______| Time Stamp(0015 . 431 913 656 s)
_______|_______________________________________________________________=
________
Packet(157736) Downstream 2.5(x1) DLLP ACK AckNak_Seq_Num(53)
_______| CRC 16(0x9539) Time Stamp(0015 . 431 915 096 s)
_______|_______________________________________________________________=
________
Packet(157741) Downstream 2.5(x1) TLP(55) Cfg CfgRd0(00:00100) Length(1=
)
_______| RequesterID(000:00:0) Tag(22) DeviceID(001:00:0) Register(0x03=
0)
_______| 1st BE(1111) LCRC(0x129C7676) Time Stamp(0015 . 431 920 408 s)
_______|_______________________________________________________________=
________
Packet(157742) Upstream 2.5(x1) DLLP ACK AckNak_Seq_Num(55) CRC 16(0xD7=
0E)
_______| Time Stamp(0015 . 431 920 744 s)
_______|_______________________________________________________________=
________
Packet(157743) Upstream 2.5(x1) TLP(54) Cpl CplD(10:01010) Length(1)
_______| RequesterID(000:00:0) Tag(22) CompleterID(001:00:0) Status(SC)=
 BCM(0)
_______| Byte Cnt(4) Lwr Addr(0x00) Expansion ROM Base Address(0x000000=
00)
_______| LCRC(0x74BA40ED) Time Stamp(0015 . 431 921 112 s)
_______|_______________________________________________________________=
________
Packet(157744) Downstream 2.5(x1) DLLP ACK AckNak_Seq_Num(54)
_______| CRC 16(0x7615) Time Stamp(0015 . 431 922 568 s)
_______|_______________________________________________________________=
________
Packet(157749) Downstream 2.5(x1) TLP(56) Cfg CfgWr0(10:00100) Length(1=
)
_______| RequesterID(000:00:0) Tag(23) DeviceID(001:00:0) Register(0x03=
0)
_______| 1st BE(1111) Expansion ROM Base Address(0x00000000) LCRC(0xF4A=
560E8)
_______| Time Stamp(0015 . 431 928 816 s)
_______|_______________________________________________________________=
________
Packet(157750) Upstream 2.5(x1) DLLP ACK AckNak_Seq_Num(56) CRC 16(0xB8=
91)
_______| Time Stamp(0015 . 431 929 152 s)
_______|_______________________________________________________________=
________
Packet(157751) Upstream 2.5(x1) TLP(55) Cpl Cpl(00:01010) Length(0)
_______| RequesterID(000:00:0) Tag(23) CompleterID(001:00:0) Status(SC)=
 BCM(0)
_______| Byte Cnt(4) Lwr Addr(0x00) LCRC(0x19582F7D)
_______| Time Stamp(0015 . 431 929 408 s)
_______|_______________________________________________________________=
________
Packet(157753) Downstream 2.5(x1) DLLP ACK AckNak_Seq_Num(55)
_______| CRC 16(0xD70E) Time Stamp(0015 . 431 930 832 s)
_______|_______________________________________________________________=
________
Packet(157756) Downstream 2.5(x1) TLP(57) Cfg CfgWr0(10:00100) Length(1=
)
_______| RequesterID(000:00:0) Tag(24) DeviceID(001:00:0) Register(0x00=
4)
_______| 1st BE(0011) Status(0x0000) Command(0x0000) LCRC(0x68D8582C)
_______| Time Stamp(0015 . 431 936 504 s)
_______|_______________________________________________________________=
________
Packet(157758) Upstream 2.5(x1) DLLP ACK AckNak_Seq_Num(57) CRC 16(0x19=
8A)
_______| Time Stamp(0015 . 431 936 856 s)
_______|_______________________________________________________________=
________
Packet(157759) Upstream 2.5(x1) TLP(56) Cpl Cpl(00:01010) Length(0)
_______| RequesterID(000:00:0) Tag(24) CompleterID(001:00:0) Status(SC)=
 BCM(0)
_______| Byte Cnt(4) Lwr Addr(0x00) LCRC(0xE391C7DD)
_______| Time Stamp(0015 . 431 937 104 s)
_______|_______________________________________________________________=
________
Packet(157760) Downstream 2.5(x1) DLLP ACK AckNak_Seq_Num(56)
_______| CRC 16(0xB891) Time Stamp(0015 . 431 938 536 s)
_______|_______________________________________________________________=
________
Packet(157766) Downstream 2.5(x1) TLP(58) Cfg CfgRd0(00:00100) Length(1=
)
_______| RequesterID(000:00:0) Tag(25) DeviceID(001:00:0) Register(0x02=
C)
_______| 1st BE(1111) LCRC(0xF6120DD4) Time Stamp(0015 . 431 943 960 s)
_______|_______________________________________________________________=
________
Packet(157768) Upstream 2.5(x1) DLLP ACK AckNak_Seq_Num(58) CRC 16(0xFA=
A6)
_______| Time Stamp(0015 . 431 944 288 s)
_______|_______________________________________________________________=
________
Packet(157769) Upstream 2.5(x1) TLP(57) Cpl CplD(10:01010) Length(1)
_______| RequesterID(000:00:0) Tag(25) CompleterID(001:00:0) Status(SC)=
 BCM(0)
_______| Byte Cnt(4) Lwr Addr(0x00) Subsystem ID(0x3531)
_______| Subsystem Vendor ID(0x1095) LCRC(0x034AC2DC)
_______| Time Stamp(0015 . 431 944 656 s)
_______|_______________________________________________________________=
________
Packet(157770) Downstream 2.5(x1) DLLP ACK AckNak_Seq_Num(57)
_______| CRC 16(0x198A) Time Stamp(0015 . 431 946 104 s)
_______|_______________________________________________________________=
________
Packet(157775) Downstream 2.5(x1) TLP(59) Cfg CfgRd0(00:00100) Length(1=
)
_______| RequesterID(000:00:0) Tag(26) DeviceID(001:00:0) Register(0x02=
C)
_______| 1st BE(1111) LCRC(0xDDB90F8F) Time Stamp(0015 . 431 952 104 s)
_______|_______________________________________________________________=
________
Packet(157776) Upstream 2.5(x1) DLLP ACK AckNak_Seq_Num(59) CRC 16(0x5B=
BD)
_______| Time Stamp(0015 . 431 952 424 s)
_______|_______________________________________________________________=
________
Packet(157777) Upstream 2.5(x1) TLP(58) Cpl CplD(10:01010) Length(1)
_______| RequesterID(000:00:0) Tag(26) CompleterID(001:00:0) Status(SC)=
 BCM(0)
_______| Byte Cnt(4) Lwr Addr(0x00) Subsystem ID(0x3531)
_______| Subsystem Vendor ID(0x1095) LCRC(0x2963CC09)
_______| Time Stamp(0015 . 431 952 808 s)
_______|_______________________________________________________________=
________
Packet(157778) Downstream 2.5(x1) DLLP ACK AckNak_Seq_Num(58)
_______| CRC 16(0xFAA6) Time Stamp(0015 . 431 954 256 s)
_______|_______________________________________________________________=
________
Packet(157785) Downstream 2.5(x1) TLP(60) Cfg CfgRd0(00:00100) Length(1=
)
_______| RequesterID(000:00:0) Tag(27) DeviceID(001:00:0) Register(0x00=
4)
_______| 1st BE(1111) LCRC(0xDAC4950C) Time Stamp(0015 . 431 965 360 s)
_______|_______________________________________________________________=
________
Packet(157786) Upstream 2.5(x1) DLLP ACK AckNak_Seq_Num(60) CRC 16(0x3C=
=46F)
_______| Time Stamp(0015 . 431 965 688 s)
_______|_______________________________________________________________=
________
Packet(157787) Upstream 2.5(x1) TLP(59) Cpl CplD(10:01010) Length(1)
_______| RequesterID(000:00:0) Tag(27) CompleterID(001:00:0) Status(SC)=
 BCM(0)
_______| Byte Cnt(4) Lwr Addr(0x00) Status(0x0010) Command(0x0000)
_______| LCRC(0xE918A209) Time Stamp(0015 . 431 966 080 s)
_______|_______________________________________________________________=
________
Packet(157788) Downstream 2.5(x1) DLLP ACK AckNak_Seq_Num(59)
_______| CRC 16(0x5BBD) Time Stamp(0015 . 431 967 528 s)
_______|_______________________________________________________________=
________
Packet(157792) Downstream 2.5(x1) TLP(61) Cfg CfgRd0(00:00100) Length(1=
)
_______| RequesterID(000:00:0) Tag(28) DeviceID(001:00:0) Register(0x03=
4)
_______| 1st BE(1111) LCRC(0x4B1DDFEA) Time Stamp(0015 . 431 973 672 s)
_______|_______________________________________________________________=
________
Packet(157794) Upstream 2.5(x1) DLLP ACK AckNak_Seq_Num(61) CRC 16(0x9D=
E4)
_______| Time Stamp(0015 . 431 973 984 s)
_______|_______________________________________________________________=
________
Packet(157797) Upstream 2.5(x1) TLP(60) Cpl CplD(10:01010) Length(1)
_______| RequesterID(000:00:0) Tag(28) CompleterID(001:00:0) Status(SC)=
 BCM(0)
_______| Byte Cnt(4) Lwr Addr(0x00) Reserved(0x000000) Capability Point=
er(0x54)
_______| LCRC(0xBEDE983A) Time Stamp(0015 . 431 974 368 s)
_______|_______________________________________________________________=
________
Packet(157799) Downstream 2.5(x1) DLLP ACK AckNak_Seq_Num(60)
_______| CRC 16(0x3CFF) Time Stamp(0015 . 431 975 824 s)
_______|_______________________________________________________________=
________
Packet(157804) Downstream 2.5(x1) TLP(62) Cfg CfgRd0(00:00100) Length(1=
)
_______| RequesterID(000:00:0) Tag(29) DeviceID(001:00:0) Register(0x05=
4)
_______| 1st BE(1111) LCRC(0x78C3FBD1) Time Stamp(0015 . 431 981 872 s)
_______|_______________________________________________________________=
________
Packet(157805) Upstream 2.5(x1) DLLP ACK AckNak_Seq_Num(62) CRC 16(0x7E=
C8)
_______| Time Stamp(0015 . 431 982 184 s)
_______|_______________________________________________________________=
________
Packet(157806) Upstream 2.5(x1) TLP(61) Cpl CplD(10:01010) Length(1)
_______| RequesterID(000:00:0) Tag(29) CompleterID(001:00:0) Status(SC)=
 BCM(0)
_______| Byte Cnt(4) Lwr Addr(0x00) PM Capabilities(0x0622) Next PTR(0x=
5C)
_______| Capability ID(0x01) LCRC(0x090DC6A1) Time Stamp(0015 . 431 982=
 552 s)
_______|_______________________________________________________________=
________
Packet(157807) Downstream 2.5(x1) DLLP ACK AckNak_Seq_Num(61)
_______| CRC 16(0x9DE4) Time Stamp(0015 . 431 984 000 s)
_______|_______________________________________________________________=
________
Packet(157811) Downstream 2.5(x1) TLP(63) Cfg CfgRd0(00:00100) Length(1=
)
_______| RequesterID(000:00:0) Tag(30) DeviceID(001:00:0) Register(0x05=
4)
_______| 1st BE(1111) LCRC(0x5368F98A) Time Stamp(0015 . 431 990 000 s)
_______|_______________________________________________________________=
________
Packet(157812) Upstream 2.5(x1) DLLP ACK AckNak_Seq_Num(63) CRC 16(0xDF=
D3)
_______| Time Stamp(0015 . 431 990 328 s)
_______|_______________________________________________________________=
________
Packet(157814) Upstream 2.5(x1) TLP(62) Cpl CplD(10:01010) Length(1)
_______| RequesterID(000:00:0) Tag(30) CompleterID(001:00:0) Status(SC)=
 BCM(0)
_______| Byte Cnt(4) Lwr Addr(0x00) PM Capabilities(0x0622) Next PTR(0x=
5C)
_______| Capability ID(0x01) LCRC(0x2324C874) Time Stamp(0015 . 431 990=
 696 s)
_______|_______________________________________________________________=
________
Packet(157815) Downstream 2.5(x1) DLLP ACK AckNak_Seq_Num(62)
_______| CRC 16(0x7EC8) Time Stamp(0015 . 431 992 160 s)
_______|_______________________________________________________________=
________
Packet(157819) Downstream 2.5(x1) TLP(64) Cfg CfgRd0(00:00100) Length(1=
)
_______| RequesterID(000:00:0) Tag(31) DeviceID(001:00:0) Register(0x05=
C)
_______| 1st BE(1111) LCRC(0x759AFAD2) Time Stamp(0015 . 431 998 152 s)
_______|_______________________________________________________________=
________
Packet(157821) Upstream 2.5(x1) DLLP ACK AckNak_Seq_Num(64) CRC 16(0xB7=
0A)
_______| Time Stamp(0015 . 431 998 512 s)
_______|_______________________________________________________________=
________
Packet(157822) Upstream 2.5(x1) TLP(63) Cpl CplD(10:01010) Length(1)
_______| RequesterID(000:00:0) Tag(31) CompleterID(001:00:0) Status(SC)=
 BCM(0)
_______| Byte Cnt(4) Lwr Addr(0x00) Message Control(0x0080) Next PTR(0x=
70)
_______| Capability ID(0x05) LCRC(0x486F55F3) Time Stamp(0015 . 431 998=
 864 s)
_______|_______________________________________________________________=
________
Packet(157823) Downstream 2.5(x1) DLLP ACK AckNak_Seq_Num(63)
_______| CRC 16(0xDFD3) Time Stamp(0015 . 432 000 312 s)
_______|_______________________________________________________________=
________
Packet(157828) Downstream 2.5(x1) TLP(65) Cfg CfgRd0(00:00100) Length(1=
)
_______| RequesterID(000:00:0) Tag(0) DeviceID(001:00:0) Register(0x05C=
)
_______| 1st BE(1111) LCRC(0xBEF3ECFD) Time Stamp(0015 . 432 006 320 s)
_______|_______________________________________________________________=
________
Packet(157829) Upstream 2.5(x1) DLLP ACK AckNak_Seq_Num(65) CRC 16(0x16=
11)
_______| Time Stamp(0015 . 432 006 656 s)
_______|_______________________________________________________________=
________
Packet(157830) Upstream 2.5(x1) TLP(64) Cpl CplD(10:01010) Length(1)
_______| RequesterID(000:00:0) Tag(0) CompleterID(001:00:0) Status(SC) =
BCM(0)
_______| Byte Cnt(4) Lwr Addr(0x00) Message Control(0x0080) Next PTR(0x=
70)
_______| Capability ID(0x05) LCRC(0xA022E3A3) Time Stamp(0015 . 432 007=
 048 s)
_______|_______________________________________________________________=
________
Packet(157834) Downstream 2.5(x1) DLLP ACK AckNak_Seq_Num(64)
_______| CRC 16(0xB70A) Time Stamp(0015 . 432 008 488 s)
_______|_______________________________________________________________=
________
Packet(157838) Downstream 2.5(x1) TLP(66) Cfg CfgRd0(00:00100) Length(1=
)
_______| RequesterID(000:00:0) Tag(1) DeviceID(001:00:0) Register(0x070=
)
_______| 1st BE(1111) LCRC(0x3620A2B9) Time Stamp(0015 . 432 014 464 s)
_______|_______________________________________________________________=
________
Packet(157839) Upstream 2.5(x1) DLLP ACK AckNak_Seq_Num(66) CRC 16(0xF5=
3D)
_______| Time Stamp(0015 . 432 014 816 s)
_______|_______________________________________________________________=
________
Packet(157840) Upstream 2.5(x1) TLP(65) Cpl CplD(10:01010) Length(1)
_______| RequesterID(000:00:0) Tag(1) CompleterID(001:00:0) Status(SC) =
BCM(0)
_______| Byte Cnt(4) Lwr Addr(0x00) PCI Express Capabilities(0x0011)
_______| Next PTR(0x00) Capability ID(0x10) LCRC(0xE04E75B4)
_______| Time Stamp(0015 . 432 015 192 s)
_______|_______________________________________________________________=
________
Packet(157842) Downstream 2.5(x1) DLLP ACK AckNak_Seq_Num(65)
_______| CRC 16(0x1611) Time Stamp(0015 . 432 016 648 s)
_______|_______________________________________________________________=
________
Packet(157847) Downstream 2.5(x1) TLP(67) Cfg CfgRd0(00:00100) Length(1=
)
_______| RequesterID(000:00:0) Tag(2) DeviceID(001:00:0) Register(0x004=
)
_______| 1st BE(1111) LCRC(0x383EC8B5) Time Stamp(0015 . 432 023 632 s)
_______|_______________________________________________________________=
________
Packet(157848) Upstream 2.5(x1) DLLP ACK AckNak_Seq_Num(67) CRC 16(0x54=
26)
_______| Time Stamp(0015 . 432 023 952 s)
_______|_______________________________________________________________=
________
Packet(157849) Upstream 2.5(x1) TLP(66) Cpl CplD(10:01010) Length(1)
_______| RequesterID(000:00:0) Tag(2) CompleterID(001:00:0) Status(SC) =
BCM(0)
_______| Byte Cnt(4) Lwr Addr(0x00) Status(0x0010) Command(0x0000)
_______| LCRC(0x14017928) Time Stamp(0015 . 432 024 328 s)
_______|_______________________________________________________________=
________
Packet(157850) Downstream 2.5(x1) DLLP ACK AckNak_Seq_Num(66)
_______| CRC 16(0xF53D) Time Stamp(0015 . 432 025 768 s)
_______|_______________________________________________________________=
________
Packet(157855) Downstream 2.5(x1) TLP(68) Cfg CfgRd0(00:00100) Length(1=
)
_______| RequesterID(000:00:0) Tag(3) DeviceID(001:00:0) Register(0x034=
)
_______| 1st BE(1111) LCRC(0x69DB3E25) Time Stamp(0015 . 432 031 832 s)
_______|_______________________________________________________________=
________
Packet(157856) Upstream 2.5(x1) DLLP ACK AckNak_Seq_Num(68) CRC 16(0x33=
64)
_______| Time Stamp(0015 . 432 032 176 s)
_______|_______________________________________________________________=
________
Packet(157857) Upstream 2.5(x1) TLP(67) Cpl CplD(10:01010) Length(1)
_______| RequesterID(000:00:0) Tag(3) CompleterID(001:00:0) Status(SC) =
BCM(0)
_______| Byte Cnt(4) Lwr Addr(0x00) Reserved(0x000000) Capability Point=
er(0x54)
_______| LCRC(0x56932E6A) Time Stamp(0015 . 432 032 560 s)
_______|_______________________________________________________________=
________
Packet(157858) Downstream 2.5(x1) DLLP ACK AckNak_Seq_Num(67)
_______| CRC 16(0x5426) Time Stamp(0015 . 432 033 984 s)
_______|_______________________________________________________________=
________
Packet(157863) Downstream 2.5(x1) TLP(69) Cfg CfgRd0(00:00100) Length(1=
)
_______| RequesterID(000:00:0) Tag(4) DeviceID(001:00:0) Register(0x054=
)
_______| 1st BE(1111) LCRC(0x0C531FA8) Time Stamp(0015 . 432 039 992 s)
_______|_______________________________________________________________=
________
Packet(157866) Upstream 2.5(x1) DLLP ACK AckNak_Seq_Num(69) CRC 16(0x92=
7F)
_______| Time Stamp(0015 . 432 040 352 s)
_______|_______________________________________________________________=
________
Packet(157867) Upstream 2.5(x1) TLP(68) Cpl CplD(10:01010) Length(1)
_______| RequesterID(000:00:0) Tag(4) CompleterID(001:00:0) Status(SC) =
BCM(0)
_______| Byte Cnt(4) Lwr Addr(0x00) PM Capabilities(0x0622) Next PTR(0x=
5C)
_______| Capability ID(0x01) LCRC(0xF4141D80) Time Stamp(0015 . 432 040=
 736 s)
_______|_______________________________________________________________=
________
Packet(157870) Downstream 2.5(x1) DLLP ACK AckNak_Seq_Num(68)
_______| CRC 16(0x3364) Time Stamp(0015 . 432 042 168 s)
_______|_______________________________________________________________=
________
Packet(157874) Downstream 2.5(x1) TLP(70) Cfg CfgRd0(00:00100) Length(1=
)
_______| RequesterID(000:00:0) Tag(5) DeviceID(001:00:0) Register(0x054=
)
_______| 1st BE(1111) LCRC(0x67EC89DE) Time Stamp(0015 . 432 048 216 s)
_______|_______________________________________________________________=
________
Packet(157875) Upstream 2.5(x1) DLLP ACK AckNak_Seq_Num(70) CRC 16(0x71=
53)
_______| Time Stamp(0015 . 432 048 528 s)
_______|_______________________________________________________________=
________
Packet(157876) Upstream 2.5(x1) TLP(69) Cpl CplD(10:01010) Length(1)
_______| RequesterID(000:00:0) Tag(5) CompleterID(001:00:0) Status(SC) =
BCM(0)
_______| Byte Cnt(4) Lwr Addr(0x00) PM Capabilities(0x0622) Next PTR(0x=
5C)
_______| Capability ID(0x01) LCRC(0x120CE7CC) Time Stamp(0015 . 432 048=
 904 s)
_______|_______________________________________________________________=
________
Packet(157877) Downstream 2.5(x1) DLLP ACK AckNak_Seq_Num(69)
_______| CRC 16(0x927F) Time Stamp(0015 . 432 050 344 s)
_______|_______________________________________________________________=
________
Packet(157881) Downstream 2.5(x1) TLP(71) Cfg CfgRd0(00:00100) Length(1=
)
_______| RequesterID(000:00:0) Tag(6) DeviceID(001:00:0) Register(0x05C=
)
_______| 1st BE(1111) LCRC(0x7ECF508B) Time Stamp(0015 . 432 056 352 s)
_______|_______________________________________________________________=
________
Packet(157882) Upstream 2.5(x1) DLLP ACK AckNak_Seq_Num(71) CRC 16(0xD0=
48)
_______| Time Stamp(0015 . 432 056 680 s)
_______|_______________________________________________________________=
________
Packet(157883) Upstream 2.5(x1) TLP(70) Cpl CplD(10:01010) Length(1)
_______| RequesterID(000:00:0) Tag(6) CompleterID(001:00:0) Status(SC) =
BCM(0)
_______| Byte Cnt(4) Lwr Addr(0x00) Message Control(0x0080) Next PTR(0x=
70)
_______| Capability ID(0x05) LCRC(0xB5768ED2) Time Stamp(0015 . 432 057=
 064 s)
_______|_______________________________________________________________=
________
Packet(157885) Downstream 2.5(x1) DLLP ACK AckNak_Seq_Num(70)
_______| CRC 16(0x7153) Time Stamp(0015 . 432 058 512 s)
_______|_______________________________________________________________=
________
Packet(157889) Downstream 2.5(x1) TLP(72) Cfg CfgRd0(00:00100) Length(1=
)
_______| RequesterID(000:00:0) Tag(7) DeviceID(001:00:0) Register(0x05C=
)
_______| 1st BE(1111) LCRC(0xEEC97C67) Time Stamp(0015 . 432 064 552 s)
_______|_______________________________________________________________=
________
Packet(157890) Upstream 2.5(x1) DLLP ACK AckNak_Seq_Num(72) CRC 16(0xBF=
D7)
_______| Time Stamp(0015 . 432 064 872 s)
_______|_______________________________________________________________=
________
Packet(157891) Upstream 2.5(x1) TLP(71) Cpl CplD(10:01010) Length(1)
_______| RequesterID(000:00:0) Tag(7) CompleterID(001:00:0) Status(SC) =
BCM(0)
_______| Byte Cnt(4) Lwr Addr(0x00) Message Control(0x0080) Next PTR(0x=
70)
_______| Capability ID(0x05) LCRC(0x536E749E) Time Stamp(0015 . 432 065=
 272 s)
_______|_______________________________________________________________=
________
Packet(157893) Downstream 2.5(x1) DLLP ACK AckNak_Seq_Num(71)
_______| CRC 16(0xD048) Time Stamp(0015 . 432 066 704 s)
_______|_______________________________________________________________=
________
Packet(157898) Downstream 2.5(x1) TLP(73) Cfg CfgRd0(00:00100) Length(1=
)
_______| RequesterID(000:00:0) Tag(8) DeviceID(001:00:0) Register(0x070=
)
_______| 1st BE(1111) LCRC(0x5DCE6479) Time Stamp(0015 . 432 072 712 s)
_______|_______________________________________________________________=
________
Packet(157902) Upstream 2.5(x1) DLLP ACK AckNak_Seq_Num(73) CRC 16(0x1E=
CC)
_______| Time Stamp(0015 . 432 073 040 s)
_______|_______________________________________________________________=
________
Packet(157903) Upstream 2.5(x1) TLP(72) Cpl CplD(10:01010) Length(1)
_______| RequesterID(000:00:0) Tag(8) CompleterID(001:00:0) Status(SC) =
BCM(0)
_______| Byte Cnt(4) Lwr Addr(0x00) PCI Express Capabilities(0x0011)
_______| Next PTR(0x00) Capability ID(0x10) LCRC(0xF59BCCF2)
_______| Time Stamp(0015 . 432 073 408 s)
_______|_______________________________________________________________=
________
Packet(157904) Downstream 2.5(x1) DLLP ACK AckNak_Seq_Num(72)
_______| CRC 16(0xBFD7) Time Stamp(0015 . 432 074 872 s)
_______|_______________________________________________________________=
________
Packet(157908) Downstream 2.5(x1) TLP(74) Cfg CfgRd0(00:00100) Length(1=
)
_______| RequesterID(000:00:0) Tag(9) DeviceID(001:00:0) Register(0x070=
)
_______| 1st BE(1111) LCRC(0x3671F20F) Time Stamp(0015 . 432 080 848 s)
_______|_______________________________________________________________=
________
Packet(157909) Upstream 2.5(x1) DLLP ACK AckNak_Seq_Num(74) CRC 16(0xFD=
E0)
_______| Time Stamp(0015 . 432 081 176 s)
_______|_______________________________________________________________=
________
Packet(157910) Upstream 2.5(x1) TLP(73) Cpl CplD(10:01010) Length(1)
_______| RequesterID(000:00:0) Tag(9) CompleterID(001:00:0) Status(SC) =
BCM(0)
_______| Byte Cnt(4) Lwr Addr(0x00) PCI Express Capabilities(0x0011)
_______| Next PTR(0x00) Capability ID(0x10) LCRC(0x138336BE)
_______| Time Stamp(0015 . 432 081 560 s)
_______|_______________________________________________________________=
________
Packet(157911) Downstream 2.5(x1) DLLP ACK AckNak_Seq_Num(73)
_______| CRC 16(0x1ECC) Time Stamp(0015 . 432 083 008 s)
_______|_______________________________________________________________=
________
Packet(157916) Downstream 2.5(x1) TLP(75) Cfg CfgRd0(00:00100) Length(1=
)
_______| RequesterID(000:00:0) Tag(10) DeviceID(001:00:0) Register(0x00=
4)
_______| 1st BE(1111) LCRC(0x386F9803) Time Stamp(0015 . 432 089 272 s)
_______|_______________________________________________________________=
________
Packet(157917) Upstream 2.5(x1) DLLP ACK AckNak_Seq_Num(75) CRC 16(0x5C=
=46B)
_______| Time Stamp(0015 . 432 089 616 s)
_______|_______________________________________________________________=
________
Packet(157918) Upstream 2.5(x1) TLP(74) Cpl CplD(10:01010) Length(1)
_______| RequesterID(000:00:0) Tag(10) CompleterID(001:00:0) Status(SC)=
 BCM(0)
_______| Byte Cnt(4) Lwr Addr(0x00) Status(0x0010) Command(0x0000)
_______| LCRC(0xE7CC3A22) Time Stamp(0015 . 432 089 976 s)
_______|_______________________________________________________________=
________
Packet(157920) Downstream 2.5(x1) DLLP ACK AckNak_Seq_Num(74)
_______| CRC 16(0xFDE0) Time Stamp(0015 . 432 091 424 s)
_______|_______________________________________________________________=
________
Packet(157924) Downstream 2.5(x1) TLP(76) Cfg CfgRd0(00:00100) Length(1=
)
_______| RequesterID(000:00:0) Tag(11) DeviceID(001:00:0) Register(0x03=
4)
_______| 1st BE(1111) LCRC(0x698A6E93) Time Stamp(0015 . 432 097 464 s)
_______|_______________________________________________________________=
________
Packet(157925) Upstream 2.5(x1) DLLP ACK AckNak_Seq_Num(76) CRC 16(0x3B=
B9)
_______| Time Stamp(0015 . 432 097 816 s)
_______|_______________________________________________________________=
________
Packet(157926) Upstream 2.5(x1) TLP(75) Cpl CplD(10:01010) Length(1)
_______| RequesterID(000:00:0) Tag(11) CompleterID(001:00:0) Status(SC)=
 BCM(0)
_______| Byte Cnt(4) Lwr Addr(0x00) Reserved(0x000000) Capability Point=
er(0x54)
_______| LCRC(0xA55E6D60) Time Stamp(0015 . 432 098 184 s)
_______|_______________________________________________________________=
________
Packet(157929) Downstream 2.5(x1) DLLP ACK AckNak_Seq_Num(75)
_______| CRC 16(0x5CFB) Time Stamp(0015 . 432 099 640 s)
_______|_______________________________________________________________=
________
Packet(157933) Downstream 2.5(x1) TLP(77) Cfg CfgRd0(00:00100) Length(1=
)
_______| RequesterID(000:00:0) Tag(12) DeviceID(001:00:0) Register(0x05=
4)
_______| 1st BE(1111) LCRC(0x0C024F1E) Time Stamp(0015 . 432 105 656 s)
_______|_______________________________________________________________=
________
Packet(157936) Upstream 2.5(x1) DLLP ACK AckNak_Seq_Num(77) CRC 16(0x9A=
A2)
_______| Time Stamp(0015 . 432 105 976 s)
_______|_______________________________________________________________=
________
Packet(157937) Upstream 2.5(x1) TLP(76) Cpl CplD(10:01010) Length(1)
_______| RequesterID(000:00:0) Tag(12) CompleterID(001:00:0) Status(SC)=
 BCM(0)
_______| Byte Cnt(4) Lwr Addr(0x00) PM Capabilities(0x0622) Next PTR(0x=
5C)
_______| Capability ID(0x01) LCRC(0x07D95E8A) Time Stamp(0015 . 432 106=
 360 s)
_______|_______________________________________________________________=
________
Packet(157938) Downstream 2.5(x1) DLLP ACK AckNak_Seq_Num(76)
_______| CRC 16(0x3BB9) Time Stamp(0015 . 432 107 816 s)
_______|_______________________________________________________________=
________
Packet(157942) Downstream 2.5(x1) TLP(78) Cfg CfgRd0(00:00100) Length(1=
)
_______| RequesterID(000:00:0) Tag(13) DeviceID(001:00:0) Register(0x05=
4)
_______| 1st BE(1111) LCRC(0x67BDD968) Time Stamp(0015 . 432 113 912 s)
_______|_______________________________________________________________=
________
Packet(157944) Upstream 2.5(x1) DLLP ACK AckNak_Seq_Num(78) CRC 16(0x79=
8E)
_______| Time Stamp(0015 . 432 114 240 s)
_______|_______________________________________________________________=
________
Packet(157945) Upstream 2.5(x1) TLP(77) Cpl CplD(10:01010) Length(1)
_______| RequesterID(000:00:0) Tag(13) CompleterID(001:00:0) Status(SC)=
 BCM(0)
_______| Byte Cnt(4) Lwr Addr(0x00) PM Capabilities(0x0622) Next PTR(0x=
5C)
_______| Capability ID(0x01) LCRC(0xE1C1A4C6) Time Stamp(0015 . 432 114=
 608 s)
_______|_______________________________________________________________=
________
Packet(157947) Downstream 2.5(x1) DLLP ACK AckNak_Seq_Num(77)
_______| CRC 16(0x9AA2) Time Stamp(0015 . 432 116 048 s)
_______|_______________________________________________________________=
________
Packet(157955) Downstream 2.5(x1) TLP(79) Cfg CfgRd0(00:00100) Length(1=
)
_______| RequesterID(000:00:0) Tag(14) DeviceID(001:00:0) Register(0x00=
4)
_______| 1st BE(1111) LCRC(0xB847B058) Time Stamp(0015 . 432 131 632 s)
_______|_______________________________________________________________=
________
Packet(157956) Upstream 2.5(x1) DLLP ACK AckNak_Seq_Num(79) CRC 16(0xD8=
95)
_______| Time Stamp(0015 . 432 131 992 s)
_______|_______________________________________________________________=
________
Packet(157957) Upstream 2.5(x1) TLP(78) Cpl CplD(10:01010) Length(1)
_______| RequesterID(000:00:0) Tag(14) CompleterID(001:00:0) Status(SC)=
 BCM(0)
_______| Byte Cnt(4) Lwr Addr(0x00) Status(0x0010) Command(0x0000)
_______| LCRC(0x3EA9A3CA) Time Stamp(0015 . 432 132 376 s)
_______|_______________________________________________________________=
________
Packet(157958) Downstream 2.5(x1) DLLP ACK AckNak_Seq_Num(78)
_______| CRC 16(0x798E) Time Stamp(0015 . 432 133 824 s)
_______|_______________________________________________________________=
________
Packet(157965) Downstream 2.5(x1) TLP(80) Cfg CfgRd0(00:00100) Length(1=
)
_______| RequesterID(000:00:0) Tag(15) DeviceID(001:00:0) Register(0x03=
4)
_______| 1st BE(1111) LCRC(0x5ED74226) Time Stamp(0015 . 432 139 968 s)
_______|_______________________________________________________________=
________
Packet(157967) Upstream 2.5(x1) DLLP ACK AckNak_Seq_Num(80) CRC 16(0xB6=
10)
_______| Time Stamp(0015 . 432 140 328 s)
_______|_______________________________________________________________=
________
Packet(157968) Upstream 2.5(x1) TLP(79) Cpl CplD(10:01010) Length(1)
_______| RequesterID(000:00:0) Tag(15) CompleterID(001:00:0) Status(SC)=
 BCM(0)
_______| Byte Cnt(4) Lwr Addr(0x00) Reserved(0x000000) Capability Point=
er(0x54)
_______| LCRC(0x7C3BF488) Time Stamp(0015 . 432 140 696 s)
_______|_______________________________________________________________=
________
Packet(157969) Downstream 2.5(x1) DLLP ACK AckNak_Seq_Num(79)
_______| CRC 16(0xD895) Time Stamp(0015 . 432 142 128 s)
_______|_______________________________________________________________=
________
Packet(157973) Downstream 2.5(x1) TLP(81) Cfg CfgRd0(00:00100) Length(1=
)
_______| RequesterID(000:00:0) Tag(16) DeviceID(001:00:0) Register(0x05=
4)
_______| 1st BE(1111) LCRC(0xCDDFE644) Time Stamp(0015 . 432 148 232 s)
_______|_______________________________________________________________=
________
Packet(157974) Upstream 2.5(x1) DLLP ACK AckNak_Seq_Num(81) CRC 16(0x17=
0B)
_______| Time Stamp(0015 . 432 148 568 s)
_______|_______________________________________________________________=
________
Packet(157975) Upstream 2.5(x1) TLP(80) Cpl CplD(10:01010) Length(1)
_______| RequesterID(000:00:0) Tag(16) CompleterID(001:00:0) Status(SC)=
 BCM(0)
_______| Byte Cnt(4) Lwr Addr(0x00) PM Capabilities(0x0622) Next PTR(0x=
5C)
_______| Capability ID(0x01) LCRC(0xCBEA037C) Time Stamp(0015 . 432 148=
 944 s)
_______|_______________________________________________________________=
________
Packet(157977) Downstream 2.5(x1) DLLP ACK AckNak_Seq_Num(80)
_______| CRC 16(0xB610) Time Stamp(0015 . 432 150 384 s)
_______|_______________________________________________________________=
________
Packet(157981) Downstream 2.5(x1) TLP(82) Cfg CfgRd0(00:00100) Length(1=
)
_______| RequesterID(000:00:0) Tag(17) DeviceID(001:00:0) Register(0x05=
4)
_______| 1st BE(1111) LCRC(0xA6607032) Time Stamp(0015 . 432 156 440 s)
_______|_______________________________________________________________=
________
Packet(157982) Upstream 2.5(x1) DLLP ACK AckNak_Seq_Num(82) CRC 16(0xF4=
27)
_______| Time Stamp(0015 . 432 156 760 s)
_______|_______________________________________________________________=
________
Packet(157983) Upstream 2.5(x1) TLP(81) Cpl CplD(10:01010) Length(1)
_______| RequesterID(000:00:0) Tag(17) CompleterID(001:00:0) Status(SC)=
 BCM(0)
_______| Byte Cnt(4) Lwr Addr(0x00) PM Capabilities(0x0622) Next PTR(0x=
5C)
_______| Capability ID(0x01) LCRC(0x2DF2F930) Time Stamp(0015 . 432 157=
 136 s)
_______|_______________________________________________________________=
________
Packet(157984) Downstream 2.5(x1) DLLP ACK AckNak_Seq_Num(81)
_______| CRC 16(0x170B) Time Stamp(0015 . 432 158 576 s)
_______|_______________________________________________________________=
________
Packet(157989) Downstream 2.5(x1) TLP(83) Cfg CfgRd0(00:00100) Length(1=
)
_______| RequesterID(000:00:0) Tag(18) DeviceID(001:00:0) Register(0x05=
C)
_______| 1st BE(1111) LCRC(0xBF43A967) Time Stamp(0015 . 432 164 576 s)
_______|_______________________________________________________________=
________
Packet(157990) Upstream 2.5(x1) DLLP ACK AckNak_Seq_Num(83) CRC 16(0x55=
3C)
_______| Time Stamp(0015 . 432 164 904 s)
_______|_______________________________________________________________=
________
Packet(157992) Upstream 2.5(x1) TLP(82) Cpl CplD(10:01010) Length(1)
_______| RequesterID(000:00:0) Tag(18) CompleterID(001:00:0) Status(SC)=
 BCM(0)
_______| Byte Cnt(4) Lwr Addr(0x00) Message Control(0x0080) Next PTR(0x=
70)
_______| Capability ID(0x05) LCRC(0x8A88902E) Time Stamp(0015 . 432 165=
 272 s)
_______|_______________________________________________________________=
________
Packet(157994) Downstream 2.5(x1) DLLP ACK AckNak_Seq_Num(82)
_______| CRC 16(0xF427) Time Stamp(0015 . 432 166 728 s)
_______|_______________________________________________________________=
________
Packet(158000) Downstream 2.5(x1) TLP(84) Cfg CfgRd0(00:00100) Length(1=
)
_______| RequesterID(000:00:0) Tag(19) DeviceID(001:00:0) Register(0x05=
C)
_______| 1st BE(1111) LCRC(0x429686D1) Time Stamp(0015 . 432 172 768 s)
_______|_______________________________________________________________=
________
Packet(158001) Upstream 2.5(x1) DLLP ACK AckNak_Seq_Num(84) CRC 16(0x32=
7E)
_______| Time Stamp(0015 . 432 173 104 s)
_______|_______________________________________________________________=
________
Packet(158002) Upstream 2.5(x1) TLP(83) Cpl CplD(10:01010) Length(1)
_______| RequesterID(000:00:0) Tag(19) CompleterID(001:00:0) Status(SC)=
 BCM(0)
_______| Byte Cnt(4) Lwr Addr(0x00) Message Control(0x0080) Next PTR(0x=
70)
_______| Capability ID(0x05) LCRC(0x6C906A62) Time Stamp(0015 . 432 173=
 472 s)
_______|_______________________________________________________________=
________
Packet(158003) Downstream 2.5(x1) DLLP ACK AckNak_Seq_Num(83)
_______| CRC 16(0x553C) Time Stamp(0015 . 432 174 904 s)
_______|_______________________________________________________________=
________
Packet(158008) Downstream 2.5(x1) TLP(85) Cfg CfgRd0(00:00100) Length(1=
)
_______| RequesterID(000:00:0) Tag(20) DeviceID(001:00:0) Register(0x07=
0)
_______| 1st BE(1111) LCRC(0x9C13CD23) Time Stamp(0015 . 432 180 880 s)
_______|_______________________________________________________________=
________
Packet(158009) Upstream 2.5(x1) DLLP ACK AckNak_Seq_Num(85) CRC 16(0x93=
65)
_______| Time Stamp(0015 . 432 181 224 s)
_______|_______________________________________________________________=
________
Packet(158010) Upstream 2.5(x1) TLP(84) Cpl CplD(10:01010) Length(1)
_______| RequesterID(000:00:0) Tag(20) CompleterID(001:00:0) Status(SC)=
 BCM(0)
_______| Byte Cnt(4) Lwr Addr(0x00) PCI Express Capabilities(0x0011)
_______| Next PTR(0x00) Capability ID(0x10) LCRC(0x39A89104)
_______| Time Stamp(0015 . 432 181 608 s)
_______|_______________________________________________________________=
________
Packet(158011) Downstream 2.5(x1) DLLP ACK AckNak_Seq_Num(84)
_______| CRC 16(0x327E) Time Stamp(0015 . 432 183 048 s)
_______|_______________________________________________________________=
________
Packet(158015) Downstream 2.5(x1) TLP(86) Cfg CfgRd0(00:00100) Length(1=
)
_______| RequesterID(000:00:0) Tag(21) DeviceID(001:00:0) Register(0x07=
0)
_______| 1st BE(1111) LCRC(0xF7AC5B55) Time Stamp(0015 . 432 189 056 s)
_______|_______________________________________________________________=
________
Packet(158017) Upstream 2.5(x1) DLLP ACK AckNak_Seq_Num(86) CRC 16(0x70=
49)
_______| Time Stamp(0015 . 432 189 408 s)
_______|_______________________________________________________________=
________
Packet(158019) Upstream 2.5(x1) TLP(85) Cpl CplD(10:01010) Length(1)
_______| RequesterID(000:00:0) Tag(21) CompleterID(001:00:0) Status(SC)=
 BCM(0)
_______| Byte Cnt(4) Lwr Addr(0x00) PCI Express Capabilities(0x0011)
_______| Next PTR(0x00) Capability ID(0x10) LCRC(0xDFB06B48)
_______| Time Stamp(0015 . 432 189 776 s)
_______|_______________________________________________________________=
________
Packet(158021) Downstream 2.5(x1) DLLP ACK AckNak_Seq_Num(85)
_______| CRC 16(0x9365) Time Stamp(0015 . 432 191 216 s)
_______|_______________________________________________________________=
________
Packet(158025) Downstream 2.5(x1) TLP(87) Cfg CfgRd0(00:00100) Length(1=
)
_______| RequesterID(000:00:0) Tag(22) DeviceID(001:00:0) Register(0x10=
0)
_______| 1st BE(1111) LCRC(0xA1474747) Time Stamp(0015 . 432 197 432 s)
_______|_______________________________________________________________=
________
Packet(158026) Upstream 2.5(x1) DLLP ACK AckNak_Seq_Num(87) CRC 16(0xD1=
52)
_______| Time Stamp(0015 . 432 197 768 s)
_______|_______________________________________________________________=
________
Packet(158027) Upstream 2.5(x1) TLP(86) Cpl CplD(10:01010) Length(1)
_______| RequesterID(000:00:0) Tag(22) CompleterID(001:00:0) Status(SC)=
 BCM(0)
_______| Byte Cnt(4) Lwr Addr(0x00) Next Offset(0x000) Version(0x1)
_______| Capability ID(0x0001) LCRC(0x5EBB023F) Time Stamp(0015 . 432
198 136 s)
_______|_______________________________________________________________=
________
Packet(158028) Downstream 2.5(x1) DLLP ACK AckNak_Seq_Num(86)
_______| CRC 16(0x7049) Time Stamp(0015 . 432 199 584 s)
_______|_______________________________________________________________=
________
Packet(158036) Downstream 2.5(x1) TLP(88) Cfg CfgRd0(00:00100) Length(1=
)
_______| RequesterID(000:00:0) Tag(23) DeviceID(001:00:0) Register(0x07=
4)
_______| 1st BE(1111) LCRC(0x55C518E5) Time Stamp(0015 . 432 208 184 s)
_______|_______________________________________________________________=
________
Packet(158037) Upstream 2.5(x1) DLLP ACK AckNak_Seq_Num(88) CRC 16(0xBE=
CD)
_______| Time Stamp(0015 . 432 208 496 s)
_______|_______________________________________________________________=
________
Packet(158038) Upstream 2.5(x1) TLP(87) Cpl CplD(10:01010) Length(1)
_______| RequesterID(000:00:0) Tag(23) CompleterID(001:00:0) Status(SC)=
 BCM(0)
_______| Byte Cnt(4) Lwr Addr(0x00) Device Capabilities(0x00008003)
_______| LCRC(0xF241DF21) Time Stamp(0015 . 432 208 880 s)
_______|_______________________________________________________________=
________
Packet(158039) Downstream 2.5(x1) DLLP ACK AckNak_Seq_Num(87)
_______| CRC 16(0xD152) Time Stamp(0015 . 432 210 328 s)
_______|_______________________________________________________________=
________
Packet(158044) Downstream 2.5(x1) TLP(89) Cfg CfgRd0(00:00100) Length(1=
)
_______| RequesterID(000:00:0) Tag(24) DeviceID(001:00:0) Register(0x08=
0)
_______| 1st BE(1111) LCRC(0x00980873) Time Stamp(0015 . 432 218 816 s)
_______|_______________________________________________________________=
________
Packet(158045) Upstream 2.5(x1) DLLP ACK AckNak_Seq_Num(89) CRC 16(0x1F=
D6)
_______| Time Stamp(0015 . 432 219 168 s)
_______|_______________________________________________________________=
________
Packet(158047) Upstream 2.5(x1) TLP(88) Cpl CplD(10:01010) Length(1)
_______| RequesterID(000:00:0) Tag(24) CompleterID(001:00:0) Status(SC)=
 BCM(0)
_______| Byte Cnt(4) Lwr Addr(0x00) Link Status(0x1011) Link Control(0x=
0000)
_______| LCRC(0xE847E5AB) Time Stamp(0015 . 432 219 552 s)
_______|_______________________________________________________________=
________
Packet(158049) Downstream 2.5(x1) DLLP ACK AckNak_Seq_Num(88)
_______| CRC 16(0xBECD) Time Stamp(0015 . 432 220 984 s)
_______|_______________________________________________________________=
________
Packet(158054) Downstream 2.5(x1) TLP(90) Cfg CfgRd0(00:00100) Length(1=
)
_______| RequesterID(000:00:0) Tag(25) DeviceID(001:00:0) Register(0x08=
0)
_______| 1st BE(1111) LCRC(0x6B279E05) Time Stamp(0015 . 432 228 256 s)
_______|_______________________________________________________________=
________
Packet(158055) Upstream 2.5(x1) DLLP ACK AckNak_Seq_Num(90) CRC 16(0xFC=
=46A)
_______| Time Stamp(0015 . 432 228 584 s)
_______|_______________________________________________________________=
________
Packet(158056) Upstream 2.5(x1) TLP(89) Cpl CplD(10:01010) Length(1)
_______| RequesterID(000:00:0) Tag(25) CompleterID(001:00:0) Status(SC)=
 BCM(0)
_______| Byte Cnt(4) Lwr Addr(0x00) Link Status(0x1011) Link Control(0x=
0000)
_______| LCRC(0x0E5F1FE7) Time Stamp(0015 . 432 228 960 s)
_______|_______________________________________________________________=
________
Packet(158057) Downstream 2.5(x1) DLLP ACK AckNak_Seq_Num(89)
_______| CRC 16(0x1FD6) Time Stamp(0015 . 432 230 408 s)
_______|_______________________________________________________________=
________
Packet(158061) Downstream 2.5(x1) TLP(91) Cfg CfgWr0(10:00100) Length(1=
)
_______| RequesterID(000:00:0) Tag(26) DeviceID(001:00:0) Register(0x08=
0)
_______| 1st BE(0011) Link Status(0x0000) Link Control(0x0040) LCRC(0xF=
3810650)
_______| Time Stamp(0015 . 432 236 832 s)
_______|_______________________________________________________________=
________
Packet(158062) Upstream 2.5(x1) DLLP ACK AckNak_Seq_Num(91) CRC 16(0x5D=
E1)
_______| Time Stamp(0015 . 432 237 184 s)
_______|_______________________________________________________________=
________
Packet(158064) Upstream 2.5(x1) TLP(90) Cpl Cpl(00:01010) Length(0)
_______| RequesterID(000:00:0) Tag(26) CompleterID(001:00:0) Status(SC)=
 BCM(0)
_______| Byte Cnt(4) Lwr Addr(0x00) LCRC(0x749C5E81)
_______| Time Stamp(0015 . 432 237 456 s)
_______|_______________________________________________________________=
________
Packet(158067) Downstream 2.5(x1) DLLP ACK AckNak_Seq_Num(90)
_______| CRC 16(0xFCFA) Time Stamp(0015 . 432 238 880 s)
_______|_______________________________________________________________=
________
Packet(164715) Downstream 2.5(x1) TLP(92) Cfg CfgRd0(00:00100) Length(1=
)
_______| RequesterID(000:00:0) Tag(27) DeviceID(001:00:0) Register(0x07=
C)
_______| 1st BE(1111) LCRC(0x8AE7B85C) Time Stamp(0015 . 445 837 592 s)
_______|_______________________________________________________________=
________
Packet(164716) Upstream 2.5(x1) DLLP ACK AckNak_Seq_Num(92) CRC 16(0x3A=
A3)
_______| Time Stamp(0015 . 445 837 920 s)
_______|_______________________________________________________________=
________
Packet(164718) Upstream 2.5(x1) TLP(91) Cpl CplD(10:01010) Length(1)
_______| RequesterID(000:00:0) Tag(27) CompleterID(001:00:0) Status(SC)=
 BCM(0)
_______| Byte Cnt(4) Lwr Addr(0x00) Link Capabilities(0x0003F411)
_______| LCRC(0x83E5C041) Time Stamp(0015 . 445 838 304 s)
_______|_______________________________________________________________=
________
Packet(164719) Downstream 2.5(x1) DLLP ACK AckNak_Seq_Num(91)
_______| CRC 16(0x5DE1) Time Stamp(0015 . 445 839 752 s)
_______|_______________________________________________________________=
________
Packet(164724) Downstream 2.5(x1) TLP(93) Cfg CfgRd0(00:00100) Length(1=
)
_______| RequesterID(000:00:0) Tag(28) DeviceID(001:00:0) Register(0x08=
0)
_______| 1st BE(1111) LCRC(0x80B02028) Time Stamp(0015 . 445 846 048 s)
_______|_______________________________________________________________=
________
Packet(164725) Upstream 2.5(x1) DLLP ACK AckNak_Seq_Num(93) CRC 16(0x9B=
B8)
_______| Time Stamp(0015 . 445 846 368 s)
_______|_______________________________________________________________=
________
Packet(164726) Upstream 2.5(x1) TLP(92) Cpl CplD(10:01010) Length(1)
_______| RequesterID(000:00:0) Tag(28) CompleterID(001:00:0) Status(SC)=
 BCM(0)
_______| Byte Cnt(4) Lwr Addr(0x00) Link Status(0x1011) Link Control(0x=
0040)
_______| LCRC(0x0C7A68D8) Time Stamp(0015 . 445 846 752 s)
_______|_______________________________________________________________=
________
Packet(164727) Downstream 2.5(x1) DLLP ACK AckNak_Seq_Num(92)
_______| CRC 16(0x3AA3) Time Stamp(0015 . 445 848 216 s)
_______|_______________________________________________________________=
________
Packet(164732) Downstream 2.5(x1) TLP(94) Cfg CfgRd0(00:00100) Length(1=
)
_______| RequesterID(000:00:0) Tag(29) DeviceID(001:00:0) Register(0x07=
4)
_______| 1st BE(1111) LCRC(0xEE3966E4) Time Stamp(0015 . 445 855 304 s)
_______|_______________________________________________________________=
________
Packet(164733) Upstream 2.5(x1) DLLP ACK AckNak_Seq_Num(94) CRC 16(0x78=
94)
_______| Time Stamp(0015 . 445 855 624 s)
_______|_______________________________________________________________=
________
Packet(164735) Upstream 2.5(x1) TLP(93) Cpl CplD(10:01010) Length(1)
_______| RequesterID(000:00:0) Tag(29) CompleterID(001:00:0) Status(SC)=
 BCM(0)
_______| Byte Cnt(4) Lwr Addr(0x00) Device Capabilities(0x00008003)
_______| LCRC(0xCDBD68B2) Time Stamp(0015 . 445 856 008 s)
_______|_______________________________________________________________=
________
Packet(164736) Downstream 2.5(x1) DLLP ACK AckNak_Seq_Num(93)
_______| CRC 16(0x9BB8) Time Stamp(0015 . 445 857 440 s)
_______|_______________________________________________________________=
________
Packet(164741) Downstream 2.5(x1) TLP(95) Cfg CfgRd0(00:00100) Length(1=
)
_______| RequesterID(000:00:0) Tag(30) DeviceID(001:00:0) Register(0x07=
C)
_______| 1st BE(1111) LCRC(0xF71ABFB1) Time Stamp(0015 . 445 863 848 s)
_______|_______________________________________________________________=
________
Packet(164742) Upstream 2.5(x1) DLLP ACK AckNak_Seq_Num(95) CRC 16(0xD9=
8F)
_______| Time Stamp(0015 . 445 864 192 s)
_______|_______________________________________________________________=
________
Packet(164744) Upstream 2.5(x1) TLP(94) Cpl CplD(10:01010) Length(1)
_______| RequesterID(000:00:0) Tag(30) CompleterID(001:00:0) Status(SC)=
 BCM(0)
_______| Byte Cnt(4) Lwr Addr(0x00) Link Capabilities(0x0003F411)
_______| LCRC(0xBC98A3E5) Time Stamp(0015 . 445 864 576 s)
_______|_______________________________________________________________=
________
Packet(164745) Downstream 2.5(x1) DLLP ACK AckNak_Seq_Num(94)
_______| CRC 16(0x7894) Time Stamp(0015 . 445 866 000 s)
_______|_______________________________________________________________=
________
Packet(164752) Downstream 2.5(x1) TLP(96) Cfg CfgRd0(00:00100) Length(1=
)
_______| RequesterID(000:00:0) Tag(31) DeviceID(001:00:0) Register(0x00=
4)
_______| 1st BE(1111) LCRC(0x46083404) Time Stamp(0015 . 445 876 480 s)
_______|_______________________________________________________________=
________
Packet(164753) Upstream 2.5(x1) DLLP ACK AckNak_Seq_Num(96) CRC 16(0xB5=
3E)
_______| Time Stamp(0015 . 445 876 808 s)
_______|_______________________________________________________________=
________
Packet(164755) Upstream 2.5(x1) TLP(95) Cpl CplD(10:01010) Length(1)
_______| RequesterID(000:00:0) Tag(31) CompleterID(001:00:0) Status(SC)=
 BCM(0)
_______| Byte Cnt(4) Lwr Addr(0x00) Status(0x0010) Command(0x0000)
_______| LCRC(0x3E2ADE92) Time Stamp(0015 . 445 877 184 s)
_______|_______________________________________________________________=
________
Packet(164756) Downstream 2.5(x1) DLLP ACK AckNak_Seq_Num(95)
_______| CRC 16(0xD98F) Time Stamp(0015 . 445 878 632 s)
_______|_______________________________________________________________=
________
Packet(164761) Downstream 2.5(x1) TLP(97) Cfg CfgRd0(00:00100) Length(1=
)
_______| RequesterID(000:00:0) Tag(0) DeviceID(001:00:0) Register(0x004=
)
_______| 1st BE(1111) LCRC(0x8D61222B) Time Stamp(0015 . 445 884 864 s)
_______|_______________________________________________________________=
________
Packet(164762) Upstream 2.5(x1) DLLP ACK AckNak_Seq_Num(97) CRC 16(0x14=
25)
_______| Time Stamp(0015 . 445 885 216 s)
_______|_______________________________________________________________=
________
Packet(164763) Upstream 2.5(x1) TLP(96) Cpl CplD(10:01010) Length(1)
_______| RequesterID(000:00:0) Tag(0) CompleterID(001:00:0) Status(SC) =
BCM(0)
_______| Byte Cnt(4) Lwr Addr(0x00) Status(0x0010) Command(0x0000)
_______| LCRC(0x22022E9F) Time Stamp(0015 . 445 885 600 s)
_______|_______________________________________________________________=
________
Packet(164765) Downstream 2.5(x1) DLLP ACK AckNak_Seq_Num(96)
_______| CRC 16(0xB53E) Time Stamp(0015 . 445 887 032 s)
_______|_______________________________________________________________=
________
Packet(164769) Downstream 2.5(x1) TLP(98) Cfg CfgWr0(10:00100) Length(1=
)
_______| RequesterID(000:00:0) Tag(1) DeviceID(001:00:0) Register(0x004=
)
_______| 1st BE(0011) Status(0x0000) Command(0x0140) LCRC(0xD3A8A892)
_______| Time Stamp(0015 . 445 893 392 s)
_______|_______________________________________________________________=
________
Packet(164770) Upstream 2.5(x1) DLLP ACK AckNak_Seq_Num(98) CRC 16(0xF7=
09)
_______| Time Stamp(0015 . 445 893 744 s)
_______|_______________________________________________________________=
________
Packet(164771) Upstream 2.5(x1) TLP(97) Cpl Cpl(00:01010) Length(0)
_______| RequesterID(000:00:0) Tag(1) CompleterID(001:00:0) Status(SC) =
BCM(0)
_______| Byte Cnt(4) Lwr Addr(0x00) LCRC(0x6205D8C8)
_______| Time Stamp(0015 . 445 894 016 s)
_______|_______________________________________________________________=
________
Packet(164774) Downstream 2.5(x1) DLLP ACK AckNak_Seq_Num(97)
_______| CRC 16(0x1425) Time Stamp(0015 . 445 895 432 s)
_______|_______________________________________________________________=
________
Packet(164779) Downstream 2.5(x1) TLP(99) Cfg CfgWr0(10:00100) Length(1=
)
_______| RequesterID(000:00:0) Tag(2) DeviceID(001:00:0) Register(0x00C=
)
_______| 1st BE(0001) BIST(0x8F) Header Type(0xC1) Master Latency Timer=
(0x00)
_______| Cache Line Size(0x08) LCRC(0x8FD93B10) Time Stamp(0015 . 445
901 256 s)
_______|_______________________________________________________________=
________
Packet(164781) Upstream 2.5(x1) DLLP ACK AckNak_Seq_Num(99) CRC 16(0x56=
12)
_______| Time Stamp(0015 . 445 901 616 s)
_______|_______________________________________________________________=
________
Packet(164782) Upstream 2.5(x1) TLP(98) Cpl Cpl(00:01010) Length(0)
_______| RequesterID(000:00:0) Tag(2) CompleterID(001:00:0) Status(SC) =
BCM(0)
_______| Byte Cnt(4) Lwr Addr(0x00) LCRC(0x6F3A3F5E)
_______| Time Stamp(0015 . 445 901 872 s)
_______|_______________________________________________________________=
________
Packet(164783) Downstream 2.5(x1) DLLP ACK AckNak_Seq_Num(98)
_______| CRC 16(0xF709) Time Stamp(0015 . 445 903 296 s)
_______|_______________________________________________________________=
________
Packet(167193) Downstream 2.5(x1) TLP(100) Cfg CfgRd0(00:00100) Length(=
1)
_______| RequesterID(000:00:0) Tag(3) DeviceID(001:00:0) Register(0x004=
)
_______| 1st BE(1111) LCRC(0x30A099B0) Time Stamp(0015 . 450 884 944 s)
_______|_______________________________________________________________=
________
Packet(167194) Upstream 2.5(x1) DLLP ACK AckNak_Seq_Num(100)
_______| CRC 16(0x3150) Time Stamp(0015 . 450 885 272 s)
_______|_______________________________________________________________=
________
Packet(167195) Upstream 2.5(x1) TLP(99) Cpl CplD(10:01010) Length(1)
_______| RequesterID(000:00:0) Tag(3) CompleterID(001:00:0) Status(SC) =
BCM(0)
_______| Byte Cnt(4) Lwr Addr(0x00) Status(0x0010) Command(0x0140)
_______| LCRC(0x0219F6D0) Time Stamp(0015 . 450 885 640 s)
_______|_______________________________________________________________=
________
Packet(167197) Downstream 2.5(x1) DLLP ACK AckNak_Seq_Num(99)
_______| CRC 16(0x5612) Time Stamp(0015 . 450 887 088 s)
_______|_______________________________________________________________=
________
Packet(167201) Downstream 2.5(x1) TLP(101) Cfg CfgRd0(00:00100) Length(=
1)
_______| RequesterID(000:00:0) Tag(4) DeviceID(001:00:0) Register(0x034=
)
_______| 1st BE(1111) LCRC(0xA179D356) Time Stamp(0015 . 450 893 512 s)
_______|_______________________________________________________________=
________
Packet(167202) Upstream 2.5(x1) DLLP ACK AckNak_Seq_Num(101)
_______| CRC 16(0x904B) Time Stamp(0015 . 450 893 856 s)
_______|_______________________________________________________________=
________
Packet(167204) Upstream 2.5(x1) TLP(100) Cpl CplD(10:01010) Length(1)
_______| RequesterID(000:00:0) Tag(4) CompleterID(001:00:0) Status(SC) =
BCM(0)
_______| Byte Cnt(4) Lwr Addr(0x00) Reserved(0x000000) Capability Point=
er(0x54)
_______| LCRC(0x5FED1A79) Time Stamp(0015 . 450 894 232 s)
_______|_______________________________________________________________=
________
Packet(167206) Downstream 2.5(x1) DLLP ACK AckNak_Seq_Num(100)
_______| CRC 16(0x3150) Time Stamp(0015 . 450 895 672 s)
_______|_______________________________________________________________=
________
Packet(167210) Downstream 2.5(x1) TLP(102) Cfg CfgRd0(00:00100) Length(=
1)
_______| RequesterID(000:00:0) Tag(5) DeviceID(001:00:0) Register(0x054=
)
_______| 1st BE(1111) LCRC(0x92A7F76D) Time Stamp(0015 . 450 901 704 s)
_______|_______________________________________________________________=
________
Packet(167212) Upstream 2.5(x1) DLLP ACK AckNak_Seq_Num(102)
_______| CRC 16(0x7367) Time Stamp(0015 . 450 902 056 s)
_______|_______________________________________________________________=
________
Packet(167213) Upstream 2.5(x1) TLP(101) Cpl CplD(10:01010) Length(1)
_______| RequesterID(000:00:0) Tag(5) CompleterID(001:00:0) Status(SC) =
BCM(0)
_______| Byte Cnt(4) Lwr Addr(0x00) PM Capabilities(0x0622) Next PTR(0x=
5C)
_______| Capability ID(0x01) LCRC(0xE83E44E2) Time Stamp(0015 . 450 902=
 424 s)
_______|_______________________________________________________________=
________
Packet(167216) Downstream 2.5(x1) DLLP ACK AckNak_Seq_Num(101)
_______| CRC 16(0x904B) Time Stamp(0015 . 450 903 864 s)
_______|_______________________________________________________________=
________
Packet(167220) Downstream 2.5(x1) TLP(103) Cfg CfgRd0(00:00100) Length(=
1)
_______| RequesterID(000:00:0) Tag(6) DeviceID(001:00:0) Register(0x054=
)
_______| 1st BE(1111) LCRC(0xB90CF536) Time Stamp(0015 . 450 909 888 s)
_______|_______________________________________________________________=
________
Packet(167221) Upstream 2.5(x1) DLLP ACK AckNak_Seq_Num(103)
_______| CRC 16(0xD27C) Time Stamp(0015 . 450 910 248 s)
_______|_______________________________________________________________=
________
Packet(167222) Upstream 2.5(x1) TLP(102) Cpl CplD(10:01010) Length(1)
_______| RequesterID(000:00:0) Tag(6) CompleterID(001:00:0) Status(SC) =
BCM(0)
_______| Byte Cnt(4) Lwr Addr(0x00) PM Capabilities(0x0622) Next PTR(0x=
5C)
_______| Capability ID(0x01) LCRC(0xC2174A37) Time Stamp(0015 . 450 910=
 616 s)
_______|_______________________________________________________________=
________
Packet(167224) Downstream 2.5(x1) DLLP ACK AckNak_Seq_Num(102)
_______| CRC 16(0x7367) Time Stamp(0015 . 450 912 064 s)
_______|_______________________________________________________________=
________
Packet(167228) Downstream 2.5(x1) TLP(104) Cfg CfgRd0(00:00100) Length(=
1)
_______| RequesterID(000:00:0) Tag(7) DeviceID(001:00:0) Register(0x05C=
)
_______| 1st BE(1111) LCRC(0x1B8202D4) Time Stamp(0015 . 450 918 072 s)
_______|_______________________________________________________________=
________
Packet(167229) Upstream 2.5(x1) DLLP ACK AckNak_Seq_Num(104)
_______| CRC 16(0xBDE3) Time Stamp(0015 . 450 918 416 s)
_______|_______________________________________________________________=
________
Packet(167230) Upstream 2.5(x1) TLP(103) Cpl CplD(10:01010) Length(1)
_______| RequesterID(000:00:0) Tag(7) CompleterID(001:00:0) Status(SC) =
BCM(0)
_______| Byte Cnt(4) Lwr Addr(0x00) Message Control(0x0080) Next PTR(0x=
70)
_______| Capability ID(0x05) LCRC(0xA95CD7B0) Time Stamp(0015 . 450 918=
 784 s)
_______|_______________________________________________________________=
________
Packet(167232) Downstream 2.5(x1) DLLP ACK AckNak_Seq_Num(103)
_______| CRC 16(0xD27C) Time Stamp(0015 . 450 920 224 s)
_______|_______________________________________________________________=
________
Packet(167236) Downstream 2.5(x1) TLP(105) Cfg CfgRd0(00:00100) Length(=
1)
_______| RequesterID(000:00:0) Tag(8) DeviceID(001:00:0) Register(0x05C=
)
_______| 1st BE(1111) LCRC(0x4BE9C2F8) Time Stamp(0015 . 450 926 288 s)
_______|_______________________________________________________________=
________
Packet(167238) Upstream 2.5(x1) DLLP ACK AckNak_Seq_Num(105)
_______| CRC 16(0x1CF8) Time Stamp(0015 . 450 926 624 s)
_______|_______________________________________________________________=
________
Packet(167239) Upstream 2.5(x1) TLP(104) Cpl CplD(10:01010) Length(1)
_______| RequesterID(000:00:0) Tag(8) CompleterID(001:00:0) Status(SC) =
BCM(0)
_______| Byte Cnt(4) Lwr Addr(0x00) Message Control(0x0080) Next PTR(0x=
70)
_______| Capability ID(0x05) LCRC(0xA9DD0387) Time Stamp(0015 . 450 927=
 016 s)
_______|_______________________________________________________________=
________
Packet(167241) Downstream 2.5(x1) DLLP ACK AckNak_Seq_Num(104)
_______| CRC 16(0xBDE3) Time Stamp(0015 . 450 928 432 s)
_______|_______________________________________________________________=
________
Packet(167245) Downstream 2.5(x1) TLP(106) Cfg CfgRd0(00:00100) Length(=
1)
_______| RequesterID(000:00:0) Tag(9) DeviceID(001:00:0) Register(0x070=
)
_______| 1st BE(1111) LCRC(0xC33A8CBC) Time Stamp(0015 . 450 934 464 s)
_______|_______________________________________________________________=
________
Packet(167246) Upstream 2.5(x1) DLLP ACK AckNak_Seq_Num(106)
_______| CRC 16(0xFFD4) Time Stamp(0015 . 450 934 800 s)
_______|_______________________________________________________________=
________
Packet(167247) Upstream 2.5(x1) TLP(105) Cpl CplD(10:01010) Length(1)
_______| RequesterID(000:00:0) Tag(9) CompleterID(001:00:0) Status(SC) =
BCM(0)
_______| Byte Cnt(4) Lwr Addr(0x00) PCI Express Capabilities(0x0011)
_______| Next PTR(0x00) Capability ID(0x10) LCRC(0xE9B19590)
_______| Time Stamp(0015 . 450 935 192 s)
_______|_______________________________________________________________=
________
Packet(167250) Downstream 2.5(x1) DLLP ACK AckNak_Seq_Num(105)
_______| CRC 16(0x1CF8) Time Stamp(0015 . 450 936 616 s)
_______|_______________________________________________________________=
________
Packet(167254) Downstream 2.5(x1) TLP(107) Cfg CfgRd0(00:00100) Length(=
1)
_______| RequesterID(000:00:0) Tag(10) DeviceID(001:00:0) Register(0x07=
8)
_______| 1st BE(1111) LCRC(0xDA1955E9) Time Stamp(0015 . 450 942 648 s)
_______|_______________________________________________________________=
________
Packet(167256) Upstream 2.5(x1) DLLP ACK AckNak_Seq_Num(107)
_______| CRC 16(0x5ECF) Time Stamp(0015 . 450 942 984 s)
_______|_______________________________________________________________=
________
Packet(167257) Upstream 2.5(x1) TLP(106) Cpl CplD(10:01010) Length(1)
_______| RequesterID(000:00:0) Tag(10) CompleterID(001:00:0) Status(SC)=
 BCM(0)
_______| Byte Cnt(4) Lwr Addr(0x00) Device Status(0x0000) Device
Control(0x2000)
_______| LCRC(0xACAA167E) Time Stamp(0015 . 450 943 368 s)
_______|_______________________________________________________________=
________
Packet(167258) Downstream 2.5(x1) DLLP ACK AckNak_Seq_Num(106)
_______| CRC 16(0xFFD4) Time Stamp(0015 . 450 944 792 s)
_______|_______________________________________________________________=
________
Packet(167267) Downstream 2.5(x1) TLP(108) Cfg CfgRd0(00:00100) Length(=
1)
_______| RequesterID(000:00:0) Tag(11) DeviceID(001:00:0) Register(0x00=
4)
_______| 1st BE(1111) LCRC(0x30F1C906) Time Stamp(0015 . 450 959 616 s)
_______|_______________________________________________________________=
________
Packet(167268) Upstream 2.5(x1) DLLP ACK AckNak_Seq_Num(108)
_______| CRC 16(0x398D) Time Stamp(0015 . 450 959 960 s)
_______|_______________________________________________________________=
________
Packet(167269) Upstream 2.5(x1) TLP(107) Cpl CplD(10:01010) Length(1)
_______| RequesterID(000:00:0) Tag(11) CompleterID(001:00:0) Status(SC)=
 BCM(0)
_______| Byte Cnt(4) Lwr Addr(0x00) Status(0x0010) Command(0x0140)
_______| LCRC(0xF1D4B5DA) Time Stamp(0015 . 450 960 344 s)
_______|_______________________________________________________________=
________
Packet(167270) Downstream 2.5(x1) DLLP ACK AckNak_Seq_Num(107)
_______| CRC 16(0x5ECF) Time Stamp(0015 . 450 961 792 s)
_______|_______________________________________________________________=
________
Packet(167274) Downstream 2.5(x1) TLP(109) Cfg CfgRd0(00:00100) Length(=
1)
_______| RequesterID(000:00:0) Tag(12) DeviceID(001:00:0) Register(0x03=
4)
_______| 1st BE(1111) LCRC(0xA12883E0) Time Stamp(0015 . 450 967 856 s)
_______|_______________________________________________________________=
________
Packet(167275) Upstream 2.5(x1) DLLP ACK AckNak_Seq_Num(109)
_______| CRC 16(0x9896) Time Stamp(0015 . 450 968 200 s)
_______|_______________________________________________________________=
________
Packet(167277) Upstream 2.5(x1) TLP(108) Cpl CplD(10:01010) Length(1)
_______| RequesterID(000:00:0) Tag(12) CompleterID(001:00:0) Status(SC)=
 BCM(0)
_______| Byte Cnt(4) Lwr Addr(0x00) Reserved(0x000000) Capability Point=
er(0x54)
_______| LCRC(0xAC205973) Time Stamp(0015 . 450 968 568 s)
_______|_______________________________________________________________=
________
Packet(167281) Downstream 2.5(x1) DLLP ACK AckNak_Seq_Num(108)
_______| CRC 16(0x398D) Time Stamp(0015 . 450 970 008 s)
_______|_______________________________________________________________=
________
Packet(167285) Downstream 2.5(x1) TLP(110) Cfg CfgRd0(00:00100) Length(=
1)
_______| RequesterID(000:00:0) Tag(13) DeviceID(001:00:0) Register(0x05=
4)
_______| 1st BE(1111) LCRC(0x92F6A7DB) Time Stamp(0015 . 450 976 024 s)
_______|_______________________________________________________________=
________
Packet(167286) Upstream 2.5(x1) DLLP ACK AckNak_Seq_Num(110)
_______| CRC 16(0x7BBA) Time Stamp(0015 . 450 976 360 s)
_______|_______________________________________________________________=
________
Packet(167287) Upstream 2.5(x1) TLP(109) Cpl CplD(10:01010) Length(1)
_______| RequesterID(000:00:0) Tag(13) CompleterID(001:00:0) Status(SC)=
 BCM(0)
_______| Byte Cnt(4) Lwr Addr(0x00) PM Capabilities(0x0622) Next PTR(0x=
5C)
_______| Capability ID(0x01) LCRC(0x1BF307E8) Time Stamp(0015 . 450 976=
 744 s)
_______|_______________________________________________________________=
________
Packet(167288) Downstream 2.5(x1) DLLP ACK AckNak_Seq_Num(109)
_______| CRC 16(0x9896) Time Stamp(0015 . 450 978 184 s)
_______|_______________________________________________________________=
________
Packet(167293) Downstream 2.5(x1) TLP(111) Cfg CfgRd0(00:00100) Length(=
1)
_______| RequesterID(000:00:0) Tag(14) DeviceID(001:00:0) Register(0x05=
4)
_______| 1st BE(1111) LCRC(0xB95DA580) Time Stamp(0015 . 450 984 192 s)
_______|_______________________________________________________________=
________
Packet(167295) Upstream 2.5(x1) DLLP ACK AckNak_Seq_Num(111)
_______| CRC 16(0xDAA1) Time Stamp(0015 . 450 984 520 s)
_______|_______________________________________________________________=
________
Packet(167296) Upstream 2.5(x1) TLP(110) Cpl CplD(10:01010) Length(1)
_______| RequesterID(000:00:0) Tag(14) CompleterID(001:00:0) Status(SC)=
 BCM(0)
_______| Byte Cnt(4) Lwr Addr(0x00) PM Capabilities(0x0622) Next PTR(0x=
5C)
_______| Capability ID(0x01) LCRC(0x31DA093D) Time Stamp(0015 . 450 984=
 896 s)
_______|_______________________________________________________________=
________
Packet(167297) Downstream 2.5(x1) DLLP ACK AckNak_Seq_Num(110)
_______| CRC 16(0x7BBA) Time Stamp(0015 . 450 986 336 s)
_______|_______________________________________________________________=
________
Packet(167301) Downstream 2.5(x1) TLP(112) Cfg CfgRd0(00:00100) Length(=
1)
_______| RequesterID(000:00:0) Tag(15) DeviceID(001:00:0) Register(0x05=
C)
_______| 1st BE(1111) LCRC(0xC17555D6) Time Stamp(0015 . 450 992 352 s)
_______|_______________________________________________________________=
________
Packet(167302) Upstream 2.5(x1) DLLP ACK AckNak_Seq_Num(112)
_______| CRC 16(0xB424) Time Stamp(0015 . 450 992 672 s)
_______|_______________________________________________________________=
________
Packet(167303) Upstream 2.5(x1) TLP(111) Cpl CplD(10:01010) Length(1)
_______| RequesterID(000:00:0) Tag(15) CompleterID(001:00:0) Status(SC)=
 BCM(0)
_______| Byte Cnt(4) Lwr Addr(0x00) Message Control(0x0080) Next PTR(0x=
70)
_______| Capability ID(0x05) LCRC(0x5A9194BA) Time Stamp(0015 . 450 993=
 064 s)
_______|_______________________________________________________________=
________
Packet(167306) Downstream 2.5(x1) DLLP ACK AckNak_Seq_Num(111)
_______| CRC 16(0xDAA1) Time Stamp(0015 . 450 994 504 s)
_______|_______________________________________________________________=
________
Packet(167310) Downstream 2.5(x1) TLP(113) Cfg CfgRd0(00:00100) Length(=
1)
_______| RequesterID(000:00:0) Tag(16) DeviceID(001:00:0) Register(0x05=
C)
_______| 1st BE(1111) LCRC(0x0A1C43F9) Time Stamp(0015 . 451 000 536 s)
_______|_______________________________________________________________=
________
Packet(167311) Upstream 2.5(x1) DLLP ACK AckNak_Seq_Num(113)
_______| CRC 16(0x153F) Time Stamp(0015 . 451 000 872 s)
_______|_______________________________________________________________=
________
Packet(167312) Upstream 2.5(x1) TLP(112) Cpl CplD(10:01010) Length(1)
_______| RequesterID(000:00:0) Tag(16) CompleterID(001:00:0) Status(SC)=
 BCM(0)
_______| Byte Cnt(4) Lwr Addr(0x00) Message Control(0x0080) Next PTR(0x=
70)
_______| Capability ID(0x05) LCRC(0xBC8BC799) Time Stamp(0015 . 451 001=
 264 s)
_______|_______________________________________________________________=
________
Packet(167315) Downstream 2.5(x1) DLLP ACK AckNak_Seq_Num(112)
_______| CRC 16(0xB424) Time Stamp(0015 . 451 002 712 s)
_______|_______________________________________________________________=
________
Packet(167319) Downstream 2.5(x1) TLP(114) Cfg CfgRd0(00:00100) Length(=
1)
_______| RequesterID(000:00:0) Tag(17) DeviceID(001:00:0) Register(0x07=
0)
_______| 1st BE(1111) LCRC(0x82CF0DBD) Time Stamp(0015 . 451 008 696 s)
_______|_______________________________________________________________=
________
Packet(167320) Upstream 2.5(x1) DLLP ACK AckNak_Seq_Num(114)
_______| CRC 16(0xF613) Time Stamp(0015 . 451 009 016 s)
_______|_______________________________________________________________=
________
Packet(167321) Upstream 2.5(x1) TLP(113) Cpl CplD(10:01010) Length(1)
_______| RequesterID(000:00:0) Tag(17) CompleterID(001:00:0) Status(SC)=
 BCM(0)
_______| Byte Cnt(4) Lwr Addr(0x00) PCI Express Capabilities(0x0011)
_______| Next PTR(0x00) Capability ID(0x10) LCRC(0xFCE7518E)
_______| Time Stamp(0015 . 451 009 384 s)
_______|_______________________________________________________________=
________
Packet(167323) Downstream 2.5(x1) DLLP ACK AckNak_Seq_Num(113)
_______| CRC 16(0x153F) Time Stamp(0015 . 451 010 848 s)
_______|_______________________________________________________________=
________
Packet(167328) Downstream 2.5(x1) TLP(115) Cfg CfgRd0(00:00100) Length(=
1)
_______| RequesterID(000:00:0) Tag(18) DeviceID(001:00:0) Register(0x07=
8)
_______| 1st BE(1111) LCRC(0x9BECD4E8) Time Stamp(0015 . 451 016 904 s)
_______|_______________________________________________________________=
________
Packet(167329) Upstream 2.5(x1) DLLP ACK AckNak_Seq_Num(115)
_______| CRC 16(0x5708) Time Stamp(0015 . 451 017 248 s)
_______|_______________________________________________________________=
________
Packet(167330) Upstream 2.5(x1) TLP(114) Cpl CplD(10:01010) Length(1)
_______| RequesterID(000:00:0) Tag(18) CompleterID(001:00:0) Status(SC)=
 BCM(0)
_______| Byte Cnt(4) Lwr Addr(0x00) Device Status(0x0000) Device
Control(0x2000)
_______| LCRC(0xB9FCD260) Time Stamp(0015 . 451 017 616 s)
_______|_______________________________________________________________=
________
Packet(167332) Downstream 2.5(x1) DLLP ACK AckNak_Seq_Num(114)
_______| CRC 16(0xF613) Time Stamp(0015 . 451 019 056 s)
_______|_______________________________________________________________=
________
Packet(167337) Downstream 2.5(x1) TLP(116) Cfg CfgRd0(00:00100) Length(=
1)
_______| RequesterID(000:00:0) Tag(19) DeviceID(001:00:0) Register(0x07=
8)
_______| 1st BE(1111) LCRC(0x6639FB5E) Time Stamp(0015 . 451 026 456 s)
_______|_______________________________________________________________=
________
Packet(167338) Upstream 2.5(x1) DLLP ACK AckNak_Seq_Num(116)
_______| CRC 16(0x304A) Time Stamp(0015 . 451 026 792 s)
_______|_______________________________________________________________=
________
Packet(167339) Upstream 2.5(x1) TLP(115) Cpl CplD(10:01010) Length(1)
_______| RequesterID(000:00:0) Tag(19) CompleterID(001:00:0) Status(SC)=
 BCM(0)
_______| Byte Cnt(4) Lwr Addr(0x00) Device Status(0x0000) Device
Control(0x2000)
_______| LCRC(0x5FE4282C) Time Stamp(0015 . 451 027 176 s)
_______|_______________________________________________________________=
________
Packet(167340) Downstream 2.5(x1) DLLP ACK AckNak_Seq_Num(115)
_______| CRC 16(0x5708) Time Stamp(0015 . 451 028 624 s)
_______|_______________________________________________________________=
________
Packet(167346) Downstream 2.5(x1) TLP(117) Cfg CfgRd0(00:00100) Length(=
1)
_______| RequesterID(000:00:0) Tag(20) DeviceID(001:00:0) Register(0x07=
8)
_______| 1st BE(1111) LCRC(0x5BD0689E) Time Stamp(0015 . 451 034 712 s)
_______|_______________________________________________________________=
________
Packet(167347) Upstream 2.5(x1) DLLP ACK AckNak_Seq_Num(117)
_______| CRC 16(0x9151) Time Stamp(0015 . 451 035 072 s)
_______|_______________________________________________________________=
________
Packet(167349) Upstream 2.5(x1) TLP(116) Cpl CplD(10:01010) Length(1)
_______| RequesterID(000:00:0) Tag(20) CompleterID(001:00:0) Status(SC)=
 BCM(0)
_______| Byte Cnt(4) Lwr Addr(0x00) Device Status(0x0000) Device
Control(0x2000)
_______| LCRC(0xACA8BF11) Time Stamp(0015 . 451 035 440 s)
_______|_______________________________________________________________=
________
Packet(167350) Downstream 2.5(x1) DLLP ACK AckNak_Seq_Num(116)
_______| CRC 16(0x304A) Time Stamp(0015 . 451 036 872 s)
_______|_______________________________________________________________=
________
Packet(167355) Downstream 2.5(x1) TLP(118) Cfg CfgWr0(10:00100) Length(=
1)
_______| RequesterID(000:00:0) Tag(21) DeviceID(001:00:0) Register(0x07=
8)
_______| 1st BE(1111) Device Status(0x0000) Device Control(0x0000)
_______| LCRC(0x23FB7498) Time Stamp(0015 . 451 043 584 s)
_______|_______________________________________________________________=
________
Packet(167356) Upstream 2.5(x1) DLLP ACK AckNak_Seq_Num(118)
_______| CRC 16(0x727D) Time Stamp(0015 . 451 043 944 s)
_______|_______________________________________________________________=
________
Packet(167357) Upstream 2.5(x1) TLP(117) Cpl Cpl(00:01010) Length(0)
_______| RequesterID(000:00:0) Tag(21) CompleterID(001:00:0) Status(SC)=
 BCM(0)
_______| Byte Cnt(4) Lwr Addr(0x00) LCRC(0x7B1EC892)
_______| Time Stamp(0015 . 451 044 216 s)
_______|_______________________________________________________________=
________
Packet(167359) Downstream 2.5(x1) DLLP ACK AckNak_Seq_Num(117)
_______| CRC 16(0x9151) Time Stamp(0015 . 451 045 616 s)
_______|_______________________________________________________________=
________
Packet(167369) Downstream 2.5(x1) TLP(119) Cfg CfgRd0(00:00100) Length(=
1)
_______| RequesterID(000:00:0) Tag(22) DeviceID(001:00:0) Register(0x03=
C)
_______| 1st BE(1111) LCRC(0x92414DC2) Time Stamp(0015 . 451 067 328 s)
_______|_______________________________________________________________=
________
Packet(167372) Upstream 2.5(x1) DLLP ACK AckNak_Seq_Num(119)
_______| CRC 16(0xD366) Time Stamp(0015 . 451 067 664 s)
_______|_______________________________________________________________=
________
Packet(167373) Upstream 2.5(x1) TLP(118) Cpl CplD(10:01010) Length(1)
_______| RequesterID(000:00:0) Tag(22) CompleterID(001:00:0) Status(SC)=
 BCM(0)
_______| Byte Cnt(4) Lwr Addr(0x00) Max_Lat(0x00) Min_Gnt(0x00)
_______| Interrupt Pin(0x01) Interrupt Line(0x00) LCRC(0xB7B5C4B1)
_______| Time Stamp(0015 . 451 068 040 s)
_______|_______________________________________________________________=
________
Packet(167375) Downstream 2.5(x1) DLLP ACK AckNak_Seq_Num(118)
_______| CRC 16(0x727D) Time Stamp(0015 . 451 069 488 s)
_______|_______________________________________________________________=
________
Packet(167381) Downstream 2.5(x1) TLP(120) Cfg CfgWr0(10:00100) Length(=
1)
_______| RequesterID(000:00:0) Tag(23) DeviceID(001:00:0) Register(0x03=
C)
_______| 1st BE(0001) Max_Lat(0x00) Min_Gnt(0x00) Interrupt Pin(0x00)
_______| Interrupt Line(0xAF) LCRC(0xC0FF1CAD) Time Stamp(0015 . 451 07=
6 624 s)
_______|_______________________________________________________________=
________
Packet(167382) Upstream 2.5(x1) DLLP ACK AckNak_Seq_Num(120)
_______| CRC 16(0xBCF9) Time Stamp(0015 . 451 076 960 s)
_______|_______________________________________________________________=
________
Packet(167383) Upstream 2.5(x1) TLP(119) Cpl Cpl(00:01010) Length(0)
_______| RequesterID(000:00:0) Tag(23) CompleterID(001:00:0) Status(SC)=
 BCM(0)
_______| Byte Cnt(4) Lwr Addr(0x00) LCRC(0xB2C9A2C0)
_______| Time Stamp(0015 . 451 077 216 s)
_______|_______________________________________________________________=
________
Packet(167384) Downstream 2.5(x1) DLLP ACK AckNak_Seq_Num(119)
_______| CRC 16(0xD366) Time Stamp(0015 . 451 078 648 s)
_______|_______________________________________________________________=
________
Packet(180855) Downstream 2.5(x1) TLP(121) Cfg CfgWr0(10:00100) Length(=
1)
_______| RequesterID(000:00:0) Tag(24) DeviceID(001:00:0) Register(0x01=
8)
_______| 1st BE(1111) Base Address Register 2(0x80100004) LCRC(0x2D3222=
1A)
_______| Time Stamp(0015 . 478 931 736 s)
_______|_______________________________________________________________=
________
Packet(180856) Upstream 2.5(x1) DLLP ACK AckNak_Seq_Num(121)
_______| CRC 16(0x1DE2) Time Stamp(0015 . 478 932 096 s)
_______|_______________________________________________________________=
________
Packet(180857) Upstream 2.5(x1) TLP(120) Cpl Cpl(00:01010) Length(0)
_______| RequesterID(000:00:0) Tag(24) CompleterID(001:00:0) Status(SC)=
 BCM(0)
_______| Byte Cnt(4) Lwr Addr(0x00) LCRC(0x48004A60)
_______| Time Stamp(0015 . 478 932 352 s)
_______|_______________________________________________________________=
________
Packet(180858) Downstream 2.5(x1) DLLP ACK AckNak_Seq_Num(120)
_______| CRC 16(0xBCF9) Time Stamp(0015 . 478 933 752 s)
_______|_______________________________________________________________=
________
Packet(180862) Downstream 2.5(x1) TLP(122) Cfg CfgRd0(00:00100) Length(=
1)
_______| RequesterID(000:00:0) Tag(25) DeviceID(001:00:0) Register(0x01=
8)
_______| 1st BE(1111) LCRC(0xE8773448) Time Stamp(0015 . 478 939 608 s)
_______|_______________________________________________________________=
________
Packet(180863) Upstream 2.5(x1) DLLP ACK AckNak_Seq_Num(122)
_______| CRC 16(0xFECE) Time Stamp(0015 . 478 939 952 s)
_______|_______________________________________________________________=
________
Packet(180864) Upstream 2.5(x1) TLP(121) Cpl CplD(10:01010) Length(1)
_______| RequesterID(000:00:0) Tag(25) CompleterID(001:00:0) Status(SC)=
 BCM(0)
_______| Byte Cnt(4) Lwr Addr(0x00) Base Address Register 2(0x80100004)
_______| LCRC(0xA658CAAF) Time Stamp(0015 . 478 940 328 s)
_______|_______________________________________________________________=
________
Packet(180866) Downstream 2.5(x1) DLLP ACK AckNak_Seq_Num(121)
_______| CRC 16(0x1DE2) Time Stamp(0015 . 478 941 760 s)
_______|_______________________________________________________________=
________
Packet(180872) Downstream 2.5(x1) TLP(123) Cfg CfgWr0(10:00100) Length(=
1)
_______| RequesterID(000:00:0) Tag(26) DeviceID(001:00:0) Register(0x01=
C)
_______| 1st BE(1111) Base Address Register 3(0x00000000) LCRC(0x31D273=
17)
_______| Time Stamp(0015 . 478 948 232 s)
_______|_______________________________________________________________=
________
Packet(180874) Upstream 2.5(x1) DLLP ACK AckNak_Seq_Num(123)
_______| CRC 16(0x5FD5) Time Stamp(0015 . 478 948 584 s)
_______|_______________________________________________________________=
________
Packet(180875) Upstream 2.5(x1) TLP(122) Cpl Cpl(00:01010) Length(0)
_______| RequesterID(000:00:0) Tag(26) CompleterID(001:00:0) Status(SC)=
 BCM(0)
_______| Byte Cnt(4) Lwr Addr(0x00) LCRC(0x81D72032)
_______| Time Stamp(0015 . 478 948 856 s)
_______|_______________________________________________________________=
________
Packet(180876) Downstream 2.5(x1) DLLP ACK AckNak_Seq_Num(122)
_______| CRC 16(0xFECE) Time Stamp(0015 . 478 950 288 s)
_______|_______________________________________________________________=
________
Packet(180881) Downstream 2.5(x1) TLP(124) Cfg CfgRd0(00:00100) Length(=
1)
_______| RequesterID(000:00:0) Tag(27) DeviceID(001:00:0) Register(0x01=
C)
_______| 1st BE(1111) LCRC(0x27CD74A2) Time Stamp(0015 . 478 955 648 s)
_______|_______________________________________________________________=
________
Packet(180882) Upstream 2.5(x1) DLLP ACK AckNak_Seq_Num(124)
_______| CRC 16(0x3897) Time Stamp(0015 . 478 955 984 s)
_______|_______________________________________________________________=
________
Packet(180883) Upstream 2.5(x1) TLP(123) Cpl CplD(10:01010) Length(1)
_______| RequesterID(000:00:0) Tag(27) CompleterID(001:00:0) Status(SC)=
 BCM(0)
_______| Byte Cnt(4) Lwr Addr(0x00) Base Address Register 3(0x00000000)
_______| LCRC(0x4C6F261E) Time Stamp(0015 . 478 956 352 s)
_______|_______________________________________________________________=
________
Packet(180885) Downstream 2.5(x1) DLLP ACK AckNak_Seq_Num(123)
_______| CRC 16(0x5FD5) Time Stamp(0015 . 478 957 792 s)
_______|_______________________________________________________________=
________
Packet(188228) Downstream 2.5(x1) TLP(125) Cfg CfgWr0(10:00100) Length(=
1)
_______| RequesterID(000:00:0) Tag(28) DeviceID(001:00:0) Register(0x01=
0)
_______| 1st BE(1111) Base Address Register 0(0x80102004) LCRC(0xB9B8FC=
68)
_______| Time Stamp(0015 . 494 141 072 s)
_______|_______________________________________________________________=
________
Packet(188229) Upstream 2.5(x1) DLLP ACK AckNak_Seq_Num(125)
_______| CRC 16(0x998C) Time Stamp(0015 . 494 141 416 s)
_______|_______________________________________________________________=
________
Packet(188230) Upstream 2.5(x1) TLP(124) Cpl Cpl(00:01010) Length(0)
_______| RequesterID(000:00:0) Tag(28) CompleterID(001:00:0) Status(SC)=
 BCM(0)
_______| Byte Cnt(4) Lwr Addr(0x00) LCRC(0xDAAF9FC4)
_______| Time Stamp(0015 . 494 141 688 s)
_______|_______________________________________________________________=
________
Packet(188232) Downstream 2.5(x1) DLLP ACK AckNak_Seq_Num(124)
_______| CRC 16(0x3897) Time Stamp(0015 . 494 143 120 s)
_______|_______________________________________________________________=
________
Packet(188236) Downstream 2.5(x1) TLP(126) Cfg CfgRd0(00:00100) Length(=
1)
_______| RequesterID(000:00:0) Tag(29) DeviceID(001:00:0) Register(0x01=
0)
_______| 1st BE(1111) LCRC(0x5AD7C71D) Time Stamp(0015 . 494 148 672 s)
_______|_______________________________________________________________=
________
Packet(188237) Upstream 2.5(x1) DLLP ACK AckNak_Seq_Num(126)
_______| CRC 16(0x7AA0) Time Stamp(0015 . 494 149 000 s)
_______|_______________________________________________________________=
________
Packet(188238) Upstream 2.5(x1) TLP(125) Cpl CplD(10:01010) Length(1)
_______| RequesterID(000:00:0) Tag(29) CompleterID(001:00:0) Status(SC)=
 BCM(0)
_______| Byte Cnt(4) Lwr Addr(0x00) Base Address Register 0(0x80102004)
_______| LCRC(0x9F7B1E7F) Time Stamp(0015 . 494 149 384 s)
_______|_______________________________________________________________=
________
Packet(188239) Downstream 2.5(x1) DLLP ACK AckNak_Seq_Num(125)
_______| CRC 16(0x998C) Time Stamp(0015 . 494 150 832 s)
_______|_______________________________________________________________=
________
Packet(188246) Downstream 2.5(x1) TLP(127) Cfg CfgWr0(10:00100) Length(=
1)
_______| RequesterID(000:00:0) Tag(30) DeviceID(001:00:0) Register(0x01=
4)
_______| 1st BE(1111) Base Address Register 1(0x00000000) LCRC(0x451EE0=
5D)
_______| Time Stamp(0015 . 494 157 312 s)
_______|_______________________________________________________________=
________
Packet(188247) Upstream 2.5(x1) DLLP ACK AckNak_Seq_Num(127)
_______| CRC 16(0xDBBB) Time Stamp(0015 . 494 157 648 s)
_______|_______________________________________________________________=
________
Packet(188249) Upstream 2.5(x1) TLP(126) Cpl Cpl(00:01010) Length(0)
_______| RequesterID(000:00:0) Tag(30) CompleterID(001:00:0) Status(SC)=
 BCM(0)
_______| Byte Cnt(4) Lwr Addr(0x00) LCRC(0x1378F596)
_______| Time Stamp(0015 . 494 157 936 s)
_______|_______________________________________________________________=
________
Packet(188251) Downstream 2.5(x1) DLLP ACK AckNak_Seq_Num(126)
_______| CRC 16(0x7AA0) Time Stamp(0015 . 494 159 360 s)
_______|_______________________________________________________________=
________
Packet(188255) Downstream 2.5(x1) TLP(128) Cfg CfgRd0(00:00100) Length(=
1)
_______| RequesterID(000:00:0) Tag(31) DeviceID(001:00:0) Register(0x01=
4)
_______| 1st BE(1111) LCRC(0x6BE71AB7) Time Stamp(0015 . 494 164 728 s)
_______|_______________________________________________________________=
________
Packet(188256) Upstream 2.5(x1) DLLP ACK AckNak_Seq_Num(128)
_______| CRC 16(0xBBB2) Time Stamp(0015 . 494 165 072 s)
_______|_______________________________________________________________=
________
Packet(188257) Upstream 2.5(x1) TLP(127) Cpl CplD(10:01010) Length(1)
_______| RequesterID(000:00:0) Tag(31) CompleterID(001:00:0) Status(SC)=
 BCM(0)
_______| Byte Cnt(4) Lwr Addr(0x00) Base Address Register 1(0x00000000)
_______| LCRC(0x950ABFF6) Time Stamp(0015 . 494 165 456 s)
_______|_______________________________________________________________=
________
Packet(188258) Downstream 2.5(x1) DLLP ACK AckNak_Seq_Num(127)
_______| CRC 16(0xDBBB) Time Stamp(0015 . 494 166 896 s)
_______|_______________________________________________________________=
________
Packet(195099) Downstream 2.5(x1) TLP(129) Cfg CfgWr0(10:00100) Length(=
1)
_______| RequesterID(000:00:0) Tag(0) DeviceID(001:00:0) Register(0x020=
)
_______| 1st BE(1111) Base Address Register 4(0x00080001) LCRC(0x38A15F=
DF)
_______| Time Stamp(0015 . 508 308 608 s)
_______|_______________________________________________________________=
________
Packet(195100) Upstream 2.5(x1) DLLP ACK AckNak_Seq_Num(129)
_______| CRC 16(0x1AA9) Time Stamp(0015 . 508 308 976 s)
_______|_______________________________________________________________=
________
Packet(195102) Upstream 2.5(x1) TLP(128) Cpl Cpl(00:01010) Length(0)
_______| RequesterID(000:00:0) Tag(0) CompleterID(001:00:0) Status(SC) =
BCM(0)
_______| Byte Cnt(4) Lwr Addr(0x00) LCRC(0xEF12CCA2)
_______| Time Stamp(0015 . 508 309 248 s)
_______|_______________________________________________________________=
________
Packet(195103) Downstream 2.5(x1) DLLP ACK AckNak_Seq_Num(128)
_______| CRC 16(0xBBB2) Time Stamp(0015 . 508 310 696 s)
_______|_______________________________________________________________=
________
Packet(195107) Downstream 2.5(x1) TLP(130) Cfg CfgRd0(00:00100) Length(=
1)
_______| RequesterID(000:00:0) Tag(1) DeviceID(001:00:0) Register(0x020=
)
_______| 1st BE(1111) LCRC(0x7EC52ECF) Time Stamp(0015 . 508 316 248 s)
_______|_______________________________________________________________=
________
Packet(195108) Upstream 2.5(x1) DLLP ACK AckNak_Seq_Num(130)
_______| CRC 16(0xF985) Time Stamp(0015 . 508 316 576 s)
_______|_______________________________________________________________=
________
Packet(195109) Upstream 2.5(x1) TLP(129) Cpl CplD(10:01010) Length(1)
_______| RequesterID(000:00:0) Tag(1) CompleterID(001:00:0) Status(SC) =
BCM(0)
_______| Byte Cnt(4) Lwr Addr(0x00) Base Address Register 4(0x00080001)
_______| LCRC(0x1E791A20) Time Stamp(0015 . 508 316 968 s)
_______|_______________________________________________________________=
________
Packet(195110) Downstream 2.5(x1) DLLP ACK AckNak_Seq_Num(129)
_______| CRC 16(0x1AA9) Time Stamp(0015 . 508 318 416 s)
_______|_______________________________________________________________=
________
Packet(305959) Downstream 2.5(x1) TLP(131) Cfg CfgRd0(00:00100) Length(=
1)
_______| RequesterID(000:00:0) Tag(2) DeviceID(001:00:0) Register(0x00C=
)
_______| 1st BE(1111) LCRC(0xB602F4A6) Time Stamp(0015 . 737 541 632 s)
_______|_______________________________________________________________=
________
Packet(305960) Upstream 2.5(x1) DLLP ACK AckNak_Seq_Num(131)
_______| CRC 16(0x589E) Time Stamp(0015 . 737 541 976 s)
_______|_______________________________________________________________=
________
Packet(305961) Upstream 2.5(x1) TLP(130) Cpl CplD(10:01010) Length(1)
_______| RequesterID(000:00:0) Tag(2) CompleterID(001:00:0) Status(SC) =
BCM(0)
_______| Byte Cnt(4) Lwr Addr(0x00) BIST(0x00) Header Type(0x00)
_______| Master Latency Timer(0x00) Cache Line Size(0x08) LCRC(0xB695C5=
40)
_______| Time Stamp(0015 . 737 542 344 s)
_______|_______________________________________________________________=
________
Packet(305964) Downstream 2.5(x1) DLLP ACK AckNak_Seq_Num(130)
_______| CRC 16(0xF985) Time Stamp(0015 . 737 543 792 s)
_______|_______________________________________________________________=
________
Packet(392692) Downstream 2.5(x1) TLP(132) Cfg CfgRd0(00:00100) Length(=
1)
_______| RequesterID(000:00:0) Tag(3) DeviceID(001:00:0) Register(0x058=
)
_______| 1st BE(1111) LCRC(0xA642DD7C) Time Stamp(0015 . 916 884 336 s)
_______|_______________________________________________________________=
________
Packet(392693) Upstream 2.5(x1) DLLP ACK AckNak_Seq_Num(132)
_______| CRC 16(0x3FDC) Time Stamp(0015 . 916 884 680 s)
_______|_______________________________________________________________=
________
Packet(392694) Upstream 2.5(x1) TLP(131) Cpl CplD(10:01010) Length(1)
_______| RequesterID(000:00:0) Tag(3) CompleterID(001:00:0) Status(SC) =
BCM(0)
_______| Byte Cnt(4) Lwr Addr(0x00) Data(0x08) Bridge Extensions (0x00)
_______| PM Status/Control(0x2000) LCRC(0x6D6B1DFF)
_______| Time Stamp(0015 . 916 885 056 s)
_______|_______________________________________________________________=
________
Packet(392696) Downstream 2.5(x1) DLLP ACK AckNak_Seq_Num(131)
_______| CRC 16(0x589E) Time Stamp(0015 . 916 886 496 s)
_______|_______________________________________________________________=
________
Packet(392701) Downstream 2.5(x1) TLP(133) Cfg CfgRd0(00:00100) Length(=
1)
_______| RequesterID(000:00:0) Tag(4) DeviceID(001:00:0) Register(0x004=
)
_______| 1st BE(1111) LCRC(0x44B693DE) Time Stamp(0015 . 916 897 104 s)
_______|_______________________________________________________________=
________
Packet(392702) Upstream 2.5(x1) DLLP ACK AckNak_Seq_Num(133)
_______| CRC 16(0x9EC7) Time Stamp(0015 . 916 897 448 s)
_______|_______________________________________________________________=
________
Packet(392704) Upstream 2.5(x1) TLP(132) Cpl CplD(10:01010) Length(1)
_______| RequesterID(000:00:0) Tag(4) CompleterID(001:00:0) Status(SC) =
BCM(0)
_______| Byte Cnt(4) Lwr Addr(0x00) Status(0x0010) Command(0x0140)
_______| LCRC(0x17C90824) Time Stamp(0015 . 916 897 816 s)
_______|_______________________________________________________________=
________
Packet(392706) Downstream 2.5(x1) DLLP ACK AckNak_Seq_Num(132)
_______| CRC 16(0x3FDC) Time Stamp(0015 . 916 899 240 s)
_______|_______________________________________________________________=
________
Packet(394829) Downstream 2.5(x1) TLP(134) Cfg CfgWr0(10:00100) Length(=
1)
_______| RequesterID(000:00:0) Tag(5) DeviceID(001:00:0) Register(0x004=
)
_______| 1st BE(0011) Status(0x3A31) Command(0x0143) LCRC(0x6EC2C633)
_______| Time Stamp(0015 . 921 287 216 s)
_______|_______________________________________________________________=
________
Packet(394832) Upstream 2.5(x1) DLLP ACK AckNak_Seq_Num(134)
_______| CRC 16(0x7DEB) Time Stamp(0015 . 921 287 560 s)
_______|_______________________________________________________________=
________
Packet(394833) Upstream 2.5(x1) TLP(133) Cpl Cpl(00:01010) Length(0)
_______| RequesterID(000:00:0) Tag(5) CompleterID(001:00:0) Status(SC) =
BCM(0)
_______| Byte Cnt(4) Lwr Addr(0x00) LCRC(0xB95594C2)
_______| Time Stamp(0015 . 921 287 832 s)
_______|_______________________________________________________________=
________
Packet(394835) Downstream 2.5(x1) DLLP ACK AckNak_Seq_Num(133)
_______| CRC 16(0x9EC7) Time Stamp(0015 . 921 289 256 s)
_______|_______________________________________________________________=
________
Packet(394882) Downstream 2.5(x1) TLP(135) Mem MWr(32)(10:00000) Length=
(1)
_______| RequesterID(000:00:0) Tag(0) Address(80102070) 1st BE(1111)
_______| Last BE(0000) Data(1 dword) LCRC(0xAD64CF1B)
_______| Time Stamp(0015 . 921 382 696 s)
_______|_______________________________________________________________=
________
Packet(394883) Upstream 2.5(x1) DLLP ACK AckNak_Seq_Num(135)
_______| CRC 16(0xDCF0) Time Stamp(0015 . 921 383 056 s)
_______|_______________________________________________________________=
________
Packet(394885) Downstream 2.5(x1) TLP(136) Mem MWr(32)(10:00000) Length=
(1)
_______| RequesterID(000:00:0) Tag(0) Address(80102040) 1st BE(1111)
_______| Last BE(0000) Data(1 dword) LCRC(0xFEEF6C7C)
_______| Time Stamp(0015 . 921 383 648 s)
_______|_______________________________________________________________=
________
Packet(394886) Upstream 2.5(x1) DLLP ACK AckNak_Seq_Num(136)
_______| CRC 16(0xB36F) Time Stamp(0015 . 921 383 992 s)
_______|_______________________________________________________________=
________
Packet(394888) Downstream 2.5(x1) TLP(137) Mem MWr(32)(10:00000) Length=
(1)
_______| RequesterID(000:00:0) Tag(0) Address(80101050) 1st BE(1111)
_______| Last BE(0000) Data(1 dword) LCRC(0x44DF02D6)
_______| Time Stamp(0015 . 921 384 600 s)
_______|_______________________________________________________________=
________
Packet(394889) Downstream 2.5(x1) TLP(138) Mem MRd(32)(00:00000) Length=
(1)
_______| RequesterID(000:00:0) Tag(6) Address(80101000) 1st BE(1111)
_______| Last BE(0000) LCRC(0x635D41B3) Time Stamp(0015 . 921 384 696 s=
)
_______|_______________________________________________________________=
________
Packet(394890) Upstream 2.5(x1) DLLP ACK AckNak_Seq_Num(137)
_______| CRC 16(0x1274) Time Stamp(0015 . 921 384 936 s)
_______|_______________________________________________________________=
________
Packet(394891) Upstream 2.5(x1) DLLP ACK AckNak_Seq_Num(138)
_______| CRC 16(0xF158) Time Stamp(0015 . 921 385 024 s)
_______|_______________________________________________________________=
________
Packet(394894) Upstream 2.5(x1) TLP(134) Cpl CplD(10:01010) Length(1)
_______| RequesterID(000:00:0) Tag(6) CompleterID(001:00:0) Status(SC) =
BCM(0)
_______| Byte Cnt(4) Lwr Addr(0x00) Data(1 dword) LCRC(0x7BB10E18)
_______| Time Stamp(0015 . 921 385 440 s)
_______|_______________________________________________________________=
________
Packet(394896) Downstream 2.5(x1) TLP(139) Mem MWr(32)(10:00000) Length=
(1)
_______| RequesterID(000:00:0) Tag(0) Address(80101004) 1st BE(1111)
_______| Last BE(0000) Data(1 dword) LCRC(0x3B2A433E)
_______| Time Stamp(0015 . 921 386 632 s)
_______|_______________________________________________________________=
________
Packet(394897) Downstream 2.5(x1) DLLP ACK AckNak_Seq_Num(134)
_______| CRC 16(0x7DEB) Time Stamp(0015 . 921 386 896 s)
_______|_______________________________________________________________=
________
Packet(394898) Upstream 2.5(x1) DLLP ACK AckNak_Seq_Num(139)
_______| CRC 16(0x5043) Time Stamp(0015 . 921 386 968 s)
_______|_______________________________________________________________=
________
Packet(394901) Downstream 2.5(x1) TLP(140) Mem MRd(32)(00:00000) Length=
(1)
_______| RequesterID(000:00:0) Tag(7) Address(80101000) 1st BE(1111)
_______| Last BE(0000) LCRC(0x1B51F8D8) Time Stamp(0015 . 921 387 792 s=
)
_______|_______________________________________________________________=
________
Packet(394902) Upstream 2.5(x1) DLLP ACK AckNak_Seq_Num(140)
_______| CRC 16(0x3701) Time Stamp(0015 . 921 388 136 s)
_______|_______________________________________________________________=
________
Packet(394903) Upstream 2.5(x1) TLP(135) Cpl CplD(10:01010) Length(1)
_______| RequesterID(000:00:0) Tag(7) CompleterID(001:00:0) Status(SC) =
BCM(0)
_______| Byte Cnt(4) Lwr Addr(0x00) Data(1 dword) LCRC(0xF8CE48EC)
_______| Time Stamp(0015 . 921 388 520 s)
_______|_______________________________________________________________=
________
Packet(394904) Downstream 2.5(x1) DLLP ACK AckNak_Seq_Num(135)
_______| CRC 16(0xDCF0) Time Stamp(0015 . 921 389 936 s)
_______|_______________________________________________________________=
________
Packet(394907) Downstream 2.5(x1) TLP(141) Mem MWr(32)(10:00000) Length=
(1)
_______| RequesterID(000:00:0) Tag(0) Address(80101004) 1st BE(1111)
_______| Last BE(0000) Data(1 dword) LCRC(0xB9D27FE4)
_______| Time Stamp(0015 . 921 390 728 s)
_______|_______________________________________________________________=
________
Packet(394908) Upstream 2.5(x1) DLLP ACK AckNak_Seq_Num(141)
_______| CRC 16(0x961A) Time Stamp(0015 . 921 391 072 s)
_______|_______________________________________________________________=
________
Packet(394910) Downstream 2.5(x1) TLP(142) Mem MWr(32)(10:00000) Length=
(1)
_______| RequesterID(000:00:0) Tag(0) Address(80101040) 1st BE(1100)
_______| Last BE(0000) Data(1 dword) LCRC(0xBEE0170B)
_______| Time Stamp(0015 . 921 391 680 s)
_______|_______________________________________________________________=
________
Packet(394911) Upstream 2.5(x1) DLLP ACK AckNak_Seq_Num(142)
_______| CRC 16(0x7536) Time Stamp(0015 . 921 392 024 s)
_______|_______________________________________________________________=
________
Packet(394914) Downstream 2.5(x1) TLP(143) Mem MWr(32)(10:00000) Length=
(1)
_______| RequesterID(000:00:0) Tag(0) Address(80101044) 1st BE(1100)
_______| Last BE(0000) Data(1 dword) LCRC(0xD2A585BC)
_______| Time Stamp(0015 . 921 392 640 s)
_______|_______________________________________________________________=
________
Packet(394915) Upstream 2.5(x1) DLLP ACK AckNak_Seq_Num(143)
_______| CRC 16(0xD42D) Time Stamp(0015 . 921 392 984 s)
_______|_______________________________________________________________=
________
Packet(394917) Downstream 2.5(x1) TLP(144) Mem MWr(32)(10:00000) Length=
(1)
_______| RequesterID(000:00:0) Tag(0) Address(80101048) 1st BE(1100)
_______| Last BE(0000) Data(1 dword) LCRC(0x94CA126D)
_______| Time Stamp(0015 . 921 393 592 s)
_______|_______________________________________________________________=
________
Packet(394918) Upstream 2.5(x1) DLLP ACK AckNak_Seq_Num(144)
_______| CRC 16(0xBAA8) Time Stamp(0015 . 921 393 928 s)
_______|_______________________________________________________________=
________
Packet(394920) Downstream 2.5(x1) TLP(145) Mem MWr(32)(10:00000) Length=
(1)
_______| RequesterID(000:00:0) Tag(0) Address(80101040) 1st BE(0011)
_______| Last BE(0000) Data(1 dword) LCRC(0xC7857D05)
_______| Time Stamp(0015 . 921 394 536 s)
_______|_______________________________________________________________=
________
Packet(394921) Upstream 2.5(x1) DLLP ACK AckNak_Seq_Num(145)
_______| CRC 16(0x1BB3) Time Stamp(0015 . 921 394 888 s)
_______|_______________________________________________________________=
________
Packet(394924) Downstream 2.5(x1) TLP(146) Mem MWr(32)(10:00000) Length=
(1)
_______| RequesterID(000:00:0) Tag(0) Address(80101044) 1st BE(0011)
_______| Last BE(0000) Data(1 dword) LCRC(0x837867A3)
_______| Time Stamp(0015 . 921 395 480 s)
_______|_______________________________________________________________=
________
Packet(394925) Upstream 2.5(x1) DLLP ACK AckNak_Seq_Num(146)
_______| CRC 16(0xF89F) Time Stamp(0015 . 921 395 840 s)
_______|_______________________________________________________________=
________
Packet(394927) Downstream 2.5(x1) TLP(147) Mem MWr(32)(10:00000) Length=
(1)
_______| RequesterID(000:00:0) Tag(0) Address(80101048) 1st BE(0011)
_______| Last BE(0000) Data(1 dword) LCRC(0xC15E31E1)
_______| Time Stamp(0015 . 921 396 424 s)
_______|_______________________________________________________________=
________
Packet(394928) Downstream 2.5(x1) Packet Error(TLPRsrvErr) TLP(148) Cfg
_______| CfgWr0(10:00100) Length(1) RequesterID(000:00:0) Tag(0)
_______| DeviceID(128:02:0) Register(0x004) 1st BE(1111) Data(1 dword)
_______| LCRC(0xAD031484) Time Stamp(0015 . 921 396 632 s)
_______|_______________________________________________________________=
________
Packet(394929) Upstream 2.5(x1) DLLP ACK AckNak_Seq_Num(147)
_______| CRC 16(0x5984) Time Stamp(0015 . 921 396 784 s)
_______|_______________________________________________________________=
________
Packet(394931) Upstream 2.5(x1) DLLP ACK AckNak_Seq_Num(148)
_______| CRC 16(0x3EC6) Time Stamp(0015 . 921 396 984 s)
_______|_______________________________________________________________=
________
Packet(394932) Upstream 2.5(x1) TLP(136) Cpl Cpl(00:01010) Length(0)
_______| RequesterID(000:00:0) Tag(0) CompleterID(128:02:0) Status(SC) =
BCM(0)
_______| Byte Cnt(4) Lwr Addr(0x00) LCRC(0x08D88000)
_______| Time Stamp(0015 . 921 397 240 s)
_______|_______________________________________________________________=
________
Packet(394933) Downstream 2.5(x1) TLP(149) Mem MWr(32)(10:00000) Length=
(1)
_______| RequesterID(000:00:0) Tag(0) Address(80101004) 1st BE(1111)
_______| Last BE(0000) Data(1 dword) LCRC(0x6832D373)
_______| Time Stamp(0015 . 921 397 368 s)
_______|_______________________________________________________________=
________
Packet(394934) Upstream 2.5(x1) DLLP ACK AckNak_Seq_Num(149)
_______| CRC 16(0x9FDD) Time Stamp(0015 . 921 397 720 s)
_______|_______________________________________________________________=
________
Packet(394937) Downstream 2.5(x1) TLP(150) Mem MWr(32)(10:00000) Length=
(1)
_______| RequesterID(000:00:0) Tag(0) Address(80102040) 1st BE(1111)
_______| Last BE(0000) Data(1 dword) LCRC(0x439E7A72)
_______| Time Stamp(0015 . 921 398 320 s)
_______|_______________________________________________________________=
________
Packet(394938) Upstream 2.5(x1) DLLP ACK AckNak_Seq_Num(150)
_______| CRC 16(0x7CF1) Time Stamp(0015 . 921 398 664 s)
_______|_______________________________________________________________=
________
Packet(394939) Downstream 2.5(x1) DLLP ACK AckNak_Seq_Num(136)
_______| CRC 16(0xB36F) Time Stamp(0015 . 921 398 664 s)
_______|_______________________________________________________________=
________
Packet(394942) Downstream 2.5(x1) TLP(151) Cfg CfgRd0(00:00100) Length(=
1)
_______| RequesterID(000:00:0) Tag(8) DeviceID(001:00:0) Register(0x004=
)
_______| 1st BE(1111) LCRC(0xAE650A7D) Time Stamp(0015 . 921 399 576 s)
_______|_______________________________________________________________=
________
Packet(394943) Upstream 2.5(x1) DLLP ACK AckNak_Seq_Num(151)
_______| CRC 16(0xDDEA) Time Stamp(0015 . 921 399 896 s)
_______|_______________________________________________________________=
________
Packet(394944) Upstream 2.5(x1) TLP(137) Cpl CplD(10:01010) Length(1)
_______| RequesterID(000:00:0) Tag(8) CompleterID(128:02:0) Status(SC) =
BCM(0)
_______| Byte Cnt(4) Lwr Addr(0x00) Status(0x0010) Command(0x0400)
_______| LCRC(0xECD73F89) Time Stamp(0015 . 921 400 288 s)
_______|_______________________________________________________________=
________
Packet(394946) Downstream 2.5(x1) DLLP ACK AckNak_Seq_Num(137)
_______| CRC 16(0x1274) Time Stamp(0015 . 921 401 736 s)
_______|_______________________________________________________________=
________
Packet(394954) Downstream 2.5(x1) TLP(152) Cfg CfgWr0(10:00100) Length(=
1)
_______| RequesterID(000:00:0) Tag(9) DeviceID(001:00:0) Register(0x004=
)
_______| 1st BE(0011) Status(0x0000) Command(0x0404) LCRC(0x643FD67F)
_______| Time Stamp(0015 . 921 414 864 s)
_______|_______________________________________________________________=
________
Packet(394955) Upstream 2.5(x1) DLLP ACK AckNak_Seq_Num(152)
_______| CRC 16(0xB275) Time Stamp(0015 . 921 415 232 s)
_______|_______________________________________________________________=
________
Packet(394956) Upstream 2.5(x1) TLP(138) Cpl Cpl(00:01010) Length(0)
_______| RequesterID(000:00:0) Tag(9) CompleterID(001:00:0) Status(SC) =
BCM(0)
_______| Byte Cnt(4) Lwr Addr(0x00) LCRC(0x80CF5149)
_______| Time Stamp(0015 . 921 415 488 s)
_______|_______________________________________________________________=
________
Packet(394959) Downstream 2.5(x1) DLLP ACK AckNak_Seq_Num(138)
_______| CRC 16(0xF158) Time Stamp(0015 . 921 416 920 s)
_______|_______________________________________________________________=
________
Packet(395551) Downstream 2.5(x1) TLP(153) Mem MWr(32)(10:00000) Length=
(1)
_______| RequesterID(000:00:0) Tag(0) Address(80101014) 1st BE(1111)
_______| Last BE(0000) Data(1 dword) LCRC(0x7AE1EF45)
_______| Time Stamp(0015 . 922 638 208 s)
_______|_______________________________________________________________=
________
Packet(395552) Upstream 2.5(x1) DLLP ACK AckNak_Seq_Num(153)
_______| CRC 16(0x136E) Time Stamp(0015 . 922 638 568 s)
_______|_______________________________________________________________=
________
Packet(397184) Downstream 2.5(x1) TLP(154) Mem MRd(32)(00:00000) Length=
(1)
_______| RequesterID(000:00:0) Tag(10) Address(80101F00) 1st BE(1111)
_______| Last BE(0000) LCRC(0x0D271CF7) Time Stamp(0015 . 926 013 248 s=
)
_______|_______________________________________________________________=
________
Packet(397185) Upstream 2.5(x1) DLLP ACK AckNak_Seq_Num(154)
_______| CRC 16(0xF042) Time Stamp(0015 . 926 013 576 s)
_______|_______________________________________________________________=
________
Packet(397186) Upstream 2.5(x1) TLP(139) Cpl Cpl(00:01010) Length(0)
_______| RequesterID(000:00:0) Tag(10) CompleterID(001:00:0) Status(UR)=
-BAD
_______| BCM(0) Byte Cnt(4) Lwr Addr(0x00) LCRC(0xF04046B8)
_______| Time Stamp(0015 . 926 013 912 s)
_______|_______________________________________________________________=
________
Packet(397187) Downstream 2.5(x1) DLLP ACK AckNak_Seq_Num(139)
_______| CRC 16(0x5043) Time Stamp(0015 . 926 015 328 s)
_______|_______________________________________________________________=
________
-----------------------------------------------------------------------=
-----------------------



On Thu, Dec 15, 2011 at 9:14 AM, Pratyush Anand
<pratyush.anand@gmail.com> wrote:
> Hi Tejun,
>
> Any suugestion to resolve this issue?
>
> Regards
> Pratyush
>
> On Thu, Nov 24, 2011 at 10:06 AM, Pratyush Anand
> <pratyush.anand@gmail.com> wrote:
>> On Thu, Nov 24, 2011 at 7:18 AM, Tejun Heo <tj@kernel.org> wrote:
>>> Hello,
>>>
>>> On Wed, Nov 23, 2011 at 2:47 PM, Jesse Barnes <jbarnes@virtuousgeek=
=2Eorg> wrote:
>>>>> Weird, that basically means that somehow pci_iomap() isn't
>>>>> synchronous. =A0ie. you need to way some time after pci_iomap() b=
efore
>>>>> being able to access the mapped address. =A0Seems like arch / pci
>>>>> weirdness. =A0Jesse, Russell, any ideas?
>>>>
>>>> As Russel said, pci_iomap shouldn't be async. =A0But maybe somethi=
ng else
>>>> in the init function is doing a chip reset or causing the chip to =
go
>>>> off into the weeds for a short time? =A0That's generally the cause=
 of
>>>> target timeouts for PCI devices.
>>>
>>> Yeah, that's much more plausible. Weird that it doesn't happen on x=
86
>>> tho. Maybe different timeouts? Pratyush, can you look at bus trace =
and
>>> see what's going on?
>>
>> It also does not happen always with ARM too. =A0As said earlier only
>> when I run the system at increased CPU frequency.
>> Do you suggest to trace PCIe bus using PCIe bus analyser. I can aran=
ge
>> analyser to do that. But I do not see any kind of abort (like PCIe
>> host/target abort) in this case. So will it really help?
>> Is it possible to share datasheet of SIL3531?
>>
>> Regards
>> Pratyush
>>
>>>
>>> Thanks.
>>>
>>> --
>>> tejun
>>>
