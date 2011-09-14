From: thibaut bethune <thibaut.bethune@gmail.com>
Subject: ATA TRIM on non-AHCI motherboards ?
Date: Wed, 14 Sep 2011 21:23:20 +0200
Message-ID: <CAACN17gFBF=-UjWzAm_g3QNemyN6to3NaQqBJepWKH=DQkx7-Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-vw0-f42.google.com ([209.85.212.42]:33310 "EHLO
	mail-vw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757430Ab1INTXk convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 14 Sep 2011 15:23:40 -0400
Received: by vwl1 with SMTP id 1so3263889vwl.1
        for <linux-ide@vger.kernel.org>; Wed, 14 Sep 2011 12:23:40 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hello,

I'd like to know if my system is ATA TRIM compatible :

1=B0) I've just bought a SATA SSD (Crucial M4) which handles TRIM
2=B0) I'm running Linux 2.6.33 whch also handles TRIM (ext4 + "discard"=
 option)
3=B0) My motherboard (ASRock Conroe 1333 DVI/H R2.02, featuring the ICH=
7
southbridge) doesn't handle AHCI. Yet 48-bit LBA addressing is
supported.

I did some research and I've read that 48-bit LBA addressing should be
enough to get TRIM IF the driver is compatible.

Is it the case ?

Thanks in advance

Thibaut
35'
=46rance

Here is the output of "lspci -nn" on my system

00:00.0 Host bridge [0600]: Intel Corporation 82945G/GZ/P/PL Memory
Controller Hub [8086:2770] (rev 02)
00:02.0 VGA compatible controller [0300]: Intel Corporation 82945G/GZ
Integrated Graphics Controller [8086:2772] (rev 02)
00:1b.0 Audio device [0403]: Intel Corporation N10/ICH 7 Family High
Definition Audio Controller [8086:27d8] (rev 01)
00:1c.0 PCI bridge [0604]: Intel Corporation N10/ICH 7 Family PCI
Express Port 1 [8086:27d0] (rev 01)
00:1c.1 PCI bridge [0604]: Intel Corporation N10/ICH 7 Family PCI
Express Port 2 [8086:27d2] (rev 01)
00:1d.0 USB Controller [0c03]: Intel Corporation N10/ICH 7 Family USB
UHCI Controller #1 [8086:27c8] (rev 01)
00:1d.1 USB Controller [0c03]: Intel Corporation N10/ICH 7 Family USB
UHCI Controller #2 [8086:27c9] (rev 01)
00:1d.2 USB Controller [0c03]: Intel Corporation N10/ICH 7 Family USB
UHCI Controller #3 [8086:27ca] (rev 01)
00:1d.3 USB Controller [0c03]: Intel Corporation N10/ICH 7 Family USB
UHCI Controller #4 [8086:27cb] (rev 01)
00:1d.7 USB Controller [0c03]: Intel Corporation N10/ICH 7 Family USB2
EHCI Controller [8086:27cc] (rev 01)
00:1e.0 PCI bridge [0604]: Intel Corporation 82801 PCI Bridge
[8086:244e] (rev e1)
00:1f.0 ISA bridge [0601]: Intel Corporation 82801GB/GR (ICH7 Family)
LPC Interface Bridge [8086:27b8] (rev 01)
00:1f.1 IDE interface [0101]: Intel Corporation 82801G (ICH7 Family)
IDE Controller [8086:27df] (rev 01)
00:1f.2 IDE interface [0101]: Intel Corporation N10/ICH7 Family SATA
IDE Controller [8086:27c0] (rev 01)
00:1f.3 SMBus [0c05]: Intel Corporation N10/ICH 7 Family SMBus
Controller [8086:27da] (rev 01)
01:00.0 Ethernet controller [0200]: Realtek Semiconductor Co., Ltd.
RTL8111/8168B PCI Express Gigabit Ethernet controller [10ec:8168] (rev
01)
03:02.0 FireWire (IEEE 1394) [0c00]: Texas Instruments TSB12LV23
IEEE-1394 Controller [104c:8019]
