From: Jure =?UTF-8?Q?Pe=C3=A8ar?= <pegasus@nerv.eu.org>
Subject: sil3112 on alpha
Date: Mon, 23 Aug 2004 20:31:06 +0200
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <20040823203106.1ffded22.pegasus@nerv.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from feather2.animeslovenija.org ([193.77.122.70]:44762 "EHLO
	mail.animeslovenija.org") by vger.kernel.org with ESMTP
	id S266663AbUHWSbN (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 23 Aug 2004 14:31:13 -0400
Received: from localhost (disko [192.168.200.4])
	by mail.animeslovenija.org (8.7.6/8.7.6) with ESMTP id 05EBD9BD4
	for <linux-ide@vger.kernel.org>; Mon, 23 Aug 2004 20:31:18 +0200 (CEST)
Received: from mail.animeslovenija.org ([192.168.200.3])
 by localhost (disko [192.168.200.4]) (amavisd-new, port 10024) with LMTP
 id 21106-02 for <linux-ide@vger.kernel.org>;
 Mon, 23 Aug 2004 20:31:09 +0200 (CEST)
Received: from moonlight.pecar.org (jarse [193.95.219.68])
	by mail.animeslovenija.org (8.7.6/8.7.6) with ESMTP id 0E8629BD1
	for <linux-ide@vger.kernel.org>; Mon, 23 Aug 2004 20:31:12 +0200 (CEST)
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


Hi all,

I have an alphaserver 1000a with four ibm IC35 drives sitting on two cm=
d680
cards in it. On them are a couple of evms volumes exported via nfs. Tod=
ay i
started to put some load on them and got this:

alphabox kernel: hdg: dma_intr: status=3D0x51 { DriveReady SeekComplete=
 Error
}
alphabox kernel: hdg: dma_intr: error=3D0x01 { AddrMarkNotFound },
LBAsect=3D849603, sector=3D849600
alphabox kernel: hdg: dma_intr: status=3D0x51 { DriveReady SeekComplete=
 Error
}
alphabox kernel: hdg: dma_intr: error=3D0x01 { AddrMarkNotFound },
LBAsect=3D849600, sector=3D849600
alphabox kernel: hdg: dma_intr: status=3D0x51 { DriveReady SeekComplete=
 Error
}
alphabox kernel: hdg: dma_intr: error=3D0x01 { AddrMarkNotFound },
LBAsect=3D849600, sector=3D849600
alphabox kernel: hdg: dma_intr: status=3D0x51 { DriveReady SeekComplete=
 Error
}
alphabox kernel: hdg: dma_intr: error=3D0x01 { AddrMarkNotFound },
LBAsect=3D849600, sector=3D849600
alphabox kernel: hdg: DMA disabled
alphabox kernel: ide3: reset: success

and then a whole lot of:

CIA machine check: vector=3D0x670 pc=3D0xfffffc0000463534 code=3D0x98
machine check type: processor detected hard error
pc =3D [ide_mm_insl+36/80]  ra =3D [ata_input_data+128/224] ps =3D 0007=
    Not
tainted
v0 =3D 0000000000000020  t0 =3D ffffffff8a17e9fd  t1 =3D 00000000000000=
01
t2 =3D 00000000ffffffff  t3 =3D 000000000005d775  t4 =3D 00000000000000=
00
t5 =3D fffffc00006b0000  t6 =3D 0000000100f65566  t7 =3D fffffc00005d80=
00
a0 =3D fffffc86022f20c0  a1 =3D fffffc00005dbcb8  a2 =3D 00000000000000=
01
a3 =3D 0000000000000000  a4 =3D 0000000000000000  a5 =3D 00000000000000=
05
t8 =3D 000000000000001f  t9 =3D fffffc0000683540  t10=3D 00000000000000=
00
t11=3D 000000000000000a  pv =3D fffffc0000463510  at =3D 00000000000000=
00
gp =3D fffffc000066c400  sp =3D fffffc00005dbc30

I guess there's something in the recovery code not properly aligned the=
 way
alpha CPU wants it. So maybe the times will help here:

dma_intr errors showed at 20:03:28, followed by machine check errors at
20:03:45, 20:04:59, 20:05:3, 20:05:32, 20:05:41, 20:05:42, 20:05:52,
20:06:10, 20:06:20, 20:06:21, 20:06:33, 20:09:01, 20:09:10, 20:09:11,
20:09:20, 20:09:21, 20:09:30, 20:09:31, 20:09:40, 20:09:41 and ended at
20:09:47 with=20

alphabox kernel: hdg: task_in_intr: status=3D0x59 { DriveReady SeekComp=
lete
DataRequest Error }
alphabox kernel: hdg: task_in_intr: error=3D0x01 { AddrMarkNotFound },
LBAsect=3D859808, sector=3D859808
alphabox kernel: hdg: task_in_intr: status=3D0x59 { DriveReady SeekComp=
lete
DataRequest Error }
alphabox kernel: hdg: task_in_intr: error=3D0x01 { AddrMarkNotFound },
LBAsect=3D859808, sector=3D859808
alphabox kernel: hdg: task_in_intr: status=3D0x59 { DriveReady SeekComp=
lete
DataRequest Error }
alphabox kernel: hdg: task_in_intr: error=3D0x10 { SectorIdNotFound },
LBAsect=3D859808, sector=3D859808
alphabox kernel: hdg: task_in_intr: status=3D0x59 { DriveReady SeekComp=
lete
DataRequest Error }
alphabox kernel: hdg: task_in_intr: error=3D0x01 { AddrMarkNotFound },
LBAsect=3D862096, sector=3D862096
alphabox kernel: hdg: task_in_intr: status=3D0x59 { DriveReady SeekComp=
lete
DataRequest Error }
alphabox kernel: hdg: task_in_intr: error=3D0x01 { AddrMarkNotFound },
LBAsect=3D862096, sector=3D862096
alphabox kernel: hdg: task_in_intr: status=3D0x59 { DriveReady SeekComp=
lete
DataRequest Error }
alphabox kernel: hdg: task_in_intr: error=3D0x01 { AddrMarkNotFound },
LBAsect=3D862096, sector=3D862096
alphabox kernel: hdg: task_in_intr: status=3D0x59 { DriveReady SeekComp=
lete
DataRequest Error }
alphabox kernel: hdg: task_in_intr: error=3D0x01 { AddrMarkNotFound },
LBAsect=3D862096, sector=3D862096
alphabox kernel: ide3: reset: success

Apart from the fact, that my hdg is obviously not all that healty, it l=
ooks
there's something in the dma recovery code that alphas do not really li=
ke.
Does the fact that it gets tipped about every 10 seconds for a second r=
ings
any bells?

Kernel 2.6.7-rc3-mm1.


--=20

Jure Pe=E8ar
