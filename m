From: Michael Buesch <fsdeveloper@yahoo.de>
Subject: Re: [2.6] system is very slow during disk access
Date: Thu, 7 Aug 2003 11:53:02 +0200
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <200308071153.18361.fsdeveloper@yahoo.de>
References: <200308062052.10752.fsdeveloper@yahoo.de> <200308062247.17816.fsdeveloper@yahoo.de> <3F31D205.2080008@vgertech.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
In-Reply-To: <3F31D205.2080008@vgertech.com>
Content-Description: clearsigned data
Content-Disposition: inline
To: Nuno Silva <nuno.silva@vgertech.com>
Cc: Jean-Yves LENHOF <jean-yves@lenhof.eu.org>, insecure@mail.od.ua, linux kernel mailing list <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org, Andrew Morton <akpm@osdl.org>
List-Id: linux-ide@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Thursday 07 August 2003 06:13, Nuno Silva wrote:
> Hi!

Hi,

> There are some references to: hdparm -a 512 /dev/hda.
> For some folks this improves fs performance.
>
> Does it work for you?

Changing read-ahead doesn't work. Neither to 8 nor to 512.
I think it doesn't have something to do with read-ahead,
because the system-performance-drop occurs while
writing to the disk.
My dd-example wrote to disk:

dd if=/dev/zero of=./t.test


I just ran a few other tests:

dd if=/dev/hda of=/dev/null
doesn't drop system performance and the system is very usable
while dd is running.
So reading from a plain partition is OK.


dd if=/dev/zero of=/dev/hdc7
This slows down the system _very_ much, but it's still usable.
The mouse curser doesn't jump randomly over the screen, like it
did while
dd if=/dev/zero of=./t.test

So my guess, it may have something to do with reiserFS.
So I ran another test:

I did
mke2fs /dev/hdc7
mount /dev/hdc7 /mnt/data_1
cd /mnt/data_1
dd if=/dev/zero of=./t.test

And now the surprise. :)
Here the system-behaviour is exactly the same, as while
writing to the plain partition.
The cursor is not smooth, but it's usable and it doesn't
jump ramdonly over the screen.

So I think it has something to do with reiserFS.
Where can I start to track it down, why reiserFS
is doing this?
Hmm, I'll try to enable
CONFIG_REISERFS_CHECK
and
CONFIG_REISERFS_PROC_INFO

Can somebody tell me how to debug reiserFS with these
options enabled?

> Regards,
> Nuno Silva

Short note: hda and hdc are both exactly the same devices.

- -- 
Regards Michael Buesch  [ http://www.8ung.at/tuxsoft ]
Penguin on this machine:  Linux 2.6.0-test2 - i386

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE/MiGKoxoigfggmSgRAt+PAJ9gI8Z5Osm4/DcnFZsPtR7x4UQpZACfZw7R
GxC2PwCVOAWFFE39Fw9ttKM=
=v0nD
-----END PGP SIGNATURE-----
