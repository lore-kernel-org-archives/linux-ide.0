From: Michael Buesch <fsdeveloper@yahoo.de>
Subject: Re: [2.6] system is very slow during disk access
Date: Thu, 7 Aug 2003 00:27:34 +0200
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <200308070027.59570.fsdeveloper@yahoo.de>
References: <200308062052.10752.fsdeveloper@yahoo.de> <200308062131.46017.fsdeveloper@yahoo.de> <200308070019.17442.gardiol@libero.it>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
In-Reply-To: <200308070019.17442.gardiol@libero.it>
Content-Description: clearsigned data
Content-Disposition: inline
To: gardiol@libero.it
Cc: Frank Van Damme <frank.vandamme@student.kuleuven.ac.be>, linux-ide@vger.kernel.org, linux kernel mailing list <linux-kernel@vger.kernel.org>
List-Id: linux-ide@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Thursday 07 August 2003 00:19, Willy Gardiol wrote:
> Try to unmask IRQ, this should realy help...
> hdparm -u1 /dev/hda
>
> I usually do on my disks:
> hdparm -c1 -u1 -d1 -X69 /dev/hda
> (note: use -X69 only for for an UDMA 100 or 133 drive)

Thanks, -u1 -X69 helps a bit, but the core-problem is still
there. The system still doesn't respond as it should.
It's better, but it's not good.

I'll try to profile, as Andrew said.

- -- 
Regards Michael Buesch  [ http://www.8ung.at/tuxsoft ]
Penguin on this machine:  Linux 2.6.0-test2 - i386

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE/MYDtoxoigfggmSgRAjWCAJ9ro9WuEKVFZ7GK8L/6Yu2Dyx3KZQCgilht
Rtrimh4NthabJn3v3l2siJc=
=/vr8
-----END PGP SIGNATURE-----
