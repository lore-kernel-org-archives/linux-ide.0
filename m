From: <tzalezak@centrum.cz>
Subject: HPT370 driver speed under 2.6.x
Date: Fri, 21 May 2004 16:11:13 +0200
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <20040521141119Z1599538-576+65214@mail.centrum.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail1.centrum.cz ([213.29.7.233]:22733 "EHLO mail1.centrum.cz")
	by vger.kernel.org with ESMTP id S265887AbUEUOLe (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 21 May 2004 10:11:34 -0400
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Dear Linux IDE driver developers,

I have found that my HPT370 RAID controller runs quite slow. Two hard d=
rives are connected to it and I've measured speed approx. 20 MB/s for 2=
0 GB Western Digital  Caviar WD200BB and 33 MB/s for 120 GB Seagete ST3=
120026A. These problems occur only with 2.6.x kernels, however, kernels=
 2.4.2x are OK (approx. 30 and 50 MB/s). I've used hdparm and also some=
thing like "time dd if=3D/dev/hda of=3D/dev/null bs=3D1M count=3D128" a=
s a benchmark.

The rest of my hw configuration is:

Pentium II 400 MHz
Motherboard QDI BrillianX-1S (with last available BIOS update)
256 MB SDRAM (64+128+64) at 100 MHz
NVidia RIVA TNT2 ULTRA 32 MB
Sound Blaster AWE64
Realtek 8139 100Mb network interface (sold as "Nettox")
One ancient hard drive WD Caviar 21200 (1.2 GB) and two hard drives men=
tioned above
High-Point HPT370 controller (sold as "Kouwell KW-571A")

I hope you could help me somehow.

Tom=E1=B9 Z=E1le=BE=E1k

--------------------
P=F8=EDjemn=FD design. P=F8=EDjemn=ECj=B9=ED cena! SE T105 ji=BE od 577=
 K=E8. http://user.centrum.cz/redir.php?url=3Dhttp://www.oskarmobil.cz/=
handsets/handset.php



