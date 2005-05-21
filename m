From: Pascal Giard <evilynux@gmail.com>
Subject: 2.6.11-rc4 libata-core (irq 30: nobody cared!)
Date: Sat, 21 May 2005 04:39:36 -0400
Message-ID: <428EF3C8.4000807@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.193]:51149 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261471AbVEUIfx (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 21 May 2005 04:35:53 -0400
Received: by wproxy.gmail.com with SMTP id 69so123590wri
        for <linux-ide@vger.kernel.org>; Sat, 21 May 2005 01:35:52 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org, bkuschak@yahoo.com

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Just so you know...
I've experienced the problem with a sil3112A (Silicon Image) w/ a
Seagate 120GB SATA w/ NCQ. Brian Kuschak's hack=B9 works fine for me.

I'm running a modified version (NCQ hack) of Debian's modified 2.6.11.

Now i'm wondering if there's been some news since then...
I mean, that was posted in february.

Anyway, thanks Brian!

- -Pascal
=B9 http://lkml.org/lkml/2005/2/23/236
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFCjvPI1Lfd97FsypURAgWpAJ4uEBQOURf3yz7TiRc3nLt1EyG85QCfX1ZX
lSIz3Ekx1G/0HpBBHipAZ8g=3D
=3DzCnw
-----END PGP SIGNATURE-----
