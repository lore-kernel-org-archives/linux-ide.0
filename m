From: Phil Dibowitz <phil@ipom.com>
Subject: Promise 20378
Date: Sun, 03 Jul 2005 02:53:08 -0700
Message-ID: <42C7B584.401@ipom.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary=------------enig095F8CCBD9EDAB780721B19F
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from msg-mx3.usc.edu ([128.125.137.8]:14591 "EHLO msg-mx3.usc.edu")
	by vger.kernel.org with ESMTP id S261242AbVGCJxQ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 3 Jul 2005 05:53:16 -0400
Received: from [10.1.1.2] ([128.125.81.146])
 by msg-mx3.usc.edu (Sun Java System Messaging Server 6.2-2.02 (built Mar 22
 2005)) with ESMTPSA id <0IJ100BPDQ4LZO60@msg-mx3.usc.edu> for
 linux-ide@vger.kernel.org; Sun, 03 Jul 2005 02:53:15 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig095F8CCBD9EDAB780721B19F
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

So, there doesn't appear to be a driver for the 20378 in the kernel...
though google showed a few people using some proprietary drivers with
varying luck. Ew.

I noticed there are a lot of other Promise drivers in the kernel for the
same general line, which leads me to believe there may be some interest
in getting a 20378 driver in the kernel.

So, since I now own a machine with one, I thought I'd drop this list a
line and say "I can test stuff and provide info on the chipset"...

Specifically, I have a:

0000:02:04.0 RAID bus controller: Promise Technology, Inc. PDC20378
(FastTrak 378/SATA 378) (rev 02)
        Subsystem: Asustek Computer, Inc. PC-DL Deluxe motherboard
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 96 (1000ns min, 4500ns max), Cache Line Size: 0x91 (580
bytes)
        Interrupt: pin A routed to IRQ 11
        Region 0: I/O ports at df00 [size=64]
        Region 1: I/O ports at dfa0 [size=16]
        Region 2: I/O ports at d880 [size=128]
        Region 3: Memory at feafe000 (32-bit, non-prefetchable) [size=4K]
        Region 4: Memory at feac0000 (32-bit, non-prefetchable) [size=128K]
        Capabilities: [60] Power Management version 2
                Flags: PMEClk- DSI+ D1+ D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-


Anyway, I don't know if that's any help, or if there is any interest,
but I thought I'd throw it out there.

PS, I'm not on the list, so please CC me on replies.

Thanks,
-- 
Phil Dibowitz                             phil@ipom.com
Freeware and Technical Pages              Insanity Palace of Metallica
http://www.phildev.net/                   http://www.ipom.com/

"They that can give up essential liberty to obtain a little temporary
safety deserve neither liberty nor safety."
 - Benjamin Franklin, 1759


--------------enig095F8CCBD9EDAB780721B19F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFCx7WEN5XoxaHnMrsRAqivAJ40Lva62Kz5XClPfAS3V1LIiIKOSgCdHXWu
2nOcEuVKfzjWrW9WJFvR+mo=
=tLyT
-----END PGP SIGNATURE-----

--------------enig095F8CCBD9EDAB780721B19F--
