From: thibaut bethune <thibaut.bethune@gmail.com>
Subject: Re: ATA TRIM on non-AHCI motherboards ?
Date: Tue, 20 Sep 2011 01:35:51 +0200
Message-ID: <CAACN17jsVRZ=nXWzvDMSHLmaR1s5a38j_1YWvhq8FFA63_nU6w@mail.gmail.com>
References: <CAACN17gFBF=-UjWzAm_g3QNemyN6to3NaQqBJepWKH=DQkx7-Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qy0-f181.google.com ([209.85.216.181]:34825 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750901Ab1ISXgM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 19 Sep 2011 19:36:12 -0400
Received: by qyk7 with SMTP id 7so7020515qyk.19
        for <linux-ide@vger.kernel.org>; Mon, 19 Sep 2011 16:36:11 -0700 (PDT)
In-Reply-To: <CAACN17gFBF=-UjWzAm_g3QNemyN6to3NaQqBJepWKH=DQkx7-Q@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hello again

I've formatted my SSD using ext4 and enabled TRIM using the "discard" o=
ption.
Then i've run that test
https://sites.google.com/site/lightrush/random-1/checkiftrimonext4isena=
bledandworking
and it failed : no TRIM with that configuration.

Since it's theorically possible to get TRIM without AHCI, only using
48-bit LBA addressing, do you know if a can find a driver that would
enable TRIM ?

thanks in advance

Thibaut
=46rance

2011/9/14 thibaut bethune <thibaut.bethune@gmail.com>:
> Hello,
>
> I'd like to know if my system is ATA TRIM compatible :
>
> 1=B0) I've just bought a SATA SSD (Crucial M4) which handles TRIM
> 2=B0) I'm running Linux 2.6.33 whch also handles TRIM (ext4 + "discar=
d" option)
> 3=B0) My motherboard (ASRock Conroe 1333 DVI/H R2.02, featuring the I=
CH7
> southbridge) doesn't handle AHCI. Yet 48-bit LBA addressing is
> supported.
>
> I did some research and I've read that 48-bit LBA addressing should b=
e
> enough to get TRIM IF the driver is compatible.
>
> Is it the case ?
>
> Thanks in advance
>
> Thibaut
> 35'
> France
>
> Here is the output of "lspci -nn" on my system
>
> 00:00.0 Host bridge [0600]: Intel Corporation 82945G/GZ/P/PL Memory
> Controller Hub [8086:2770] (rev 02)
> 00:02.0 VGA compatible controller [0300]: Intel Corporation 82945G/GZ
> Integrated Graphics Controller [8086:2772] (rev 02)
> 00:1b.0 Audio device [0403]: Intel Corporation N10/ICH 7 Family High
> Definition Audio Controller [8086:27d8] (rev 01)
> 00:1c.0 PCI bridge [0604]: Intel Corporation N10/ICH 7 Family PCI
> Express Port 1 [8086:27d0] (rev 01)
> 00:1c.1 PCI bridge [0604]: Intel Corporation N10/ICH 7 Family PCI
> Express Port 2 [8086:27d2] (rev 01)
> 00:1d.0 USB Controller [0c03]: Intel Corporation N10/ICH 7 Family USB
> UHCI Controller #1 [8086:27c8] (rev 01)
> 00:1d.1 USB Controller [0c03]: Intel Corporation N10/ICH 7 Family USB
> UHCI Controller #2 [8086:27c9] (rev 01)
> 00:1d.2 USB Controller [0c03]: Intel Corporation N10/ICH 7 Family USB
> UHCI Controller #3 [8086:27ca] (rev 01)
> 00:1d.3 USB Controller [0c03]: Intel Corporation N10/ICH 7 Family USB
> UHCI Controller #4 [8086:27cb] (rev 01)
> 00:1d.7 USB Controller [0c03]: Intel Corporation N10/ICH 7 Family USB=
2
> EHCI Controller [8086:27cc] (rev 01)
> 00:1e.0 PCI bridge [0604]: Intel Corporation 82801 PCI Bridge
> [8086:244e] (rev e1)
> 00:1f.0 ISA bridge [0601]: Intel Corporation 82801GB/GR (ICH7 Family)
> LPC Interface Bridge [8086:27b8] (rev 01)
> 00:1f.1 IDE interface [0101]: Intel Corporation 82801G (ICH7 Family)
> IDE Controller [8086:27df] (rev 01)
> 00:1f.2 IDE interface [0101]: Intel Corporation N10/ICH7 Family SATA
> IDE Controller [8086:27c0] (rev 01)
> 00:1f.3 SMBus [0c05]: Intel Corporation N10/ICH 7 Family SMBus
> Controller [8086:27da] (rev 01)
> 01:00.0 Ethernet controller [0200]: Realtek Semiconductor Co., Ltd.
> RTL8111/8168B PCI Express Gigabit Ethernet controller [10ec:8168] (re=
v
> 01)
> 03:02.0 FireWire (IEEE 1394) [0c00]: Texas Instruments TSB12LV23
> IEEE-1394 Controller [104c:8019]
>
