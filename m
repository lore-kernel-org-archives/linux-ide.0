From: Michael Buesch <fsdeveloper@yahoo.de>
Subject: [2.6] system is very slow during disk access
Date: Wed, 6 Aug 2003 20:51:55 +0200
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <200308062052.10752.fsdeveloper@yahoo.de>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
Content-Description: clearsigned data
Content-Disposition: inline
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Cc: linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi.

I have massive problems with linux-2.6.0-test2.
When some process writes something to disk, it's very hard
to go on working with the system.

Some test-szenario:
$ dd if=/dev/zero of=./test.file

While dd is running, xmms skips playing every now and then
and the mouse is near to be unusable. The Mouse-cursor
behaves some kind of very lazy and some times it jumps
from one point on the display to another.
When I stop disk-access, it works again quite fine.

Would be cool, if you could give me some point to start
for tracking this down.

Please CC me, as I'm not subscribed to linux-ide. Thanks.
- -- 
Regards Michael Buesch  [ http://www.8ung.at/tuxsoft ]
Penguin on this machine:  Linux 2.6.0-test2 - i386

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE/MU5XoxoigfggmSgRAjksAJsEfEP7chsGZLTkwNHK00Qn83UCbwCghgc+
8fXS+vHuygb4xhj0CwlQBV4=
=Cr38
-----END PGP SIGNATURE-----
