From: Michael Buesch <fsdeveloper@yahoo.de>
Subject: Re: [2.5.70] possible problem with /dev/diskstats
Date: Sun, 1 Jun 2003 21:31:31 +0200
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <200306012131.32006.fsdeveloper@yahoo.de>
References: <200306011905.h51J57Q03929@owlet.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
In-Reply-To: <200306011905.h51J57Q03929@owlet.beaverton.ibm.com>
Content-Description: clearsigned data
Content-Disposition: inline
To: Rick Lindsley <ricklind@us.ibm.com>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

[I think we can take Andrew out of the cc list, because it
seems to be not caused by his patch, then]
On Sunday 01 June 2003 21:05, Rick Lindsley wrote:
>     Documentation/iostats.txt says about diskstats:
>     [SNIP]
>     Field  9 -- # of I/Os currently in progress
>         The only field that should go to zero. Incremented as request=
s are
>         given to appropriate request_queue_t and decremented as they
> finish. [SNIP]
>
>     But here is a cat /proc/diskstats:
>        3    0 hda 948 317 16216 4294408142 90 333 848 7309 4294967294
> 7309215 4280372198 ~~~~~~~~~~
>
> Yes, I've had a couple of other reports of this.  I suspect there is
> a path by which an "I/O" appears to have been completed while none wa=
s
> begun.  I've only noticed this on my hda drive as well.  What I didn'=
t
> notice was exactly when this behavior began, which may have been usef=
ul
> in tracking down the problem.  You'll notice a couple of other values
> there in the 4.2 billion range that probably suffer from a similar
> (or maybe the same) issue.  I haven't seen this on SCSI drives yet,
> just hda drives, which suggests there may be something about that I/O
> path that bears some closer scrutiny.

I've restarted the server and it has an uptime of
 21:26:36 up  3:20,  1 user,  load average: 0.00, 0.00, 0.00

I've done some disk-io (compiled some software) and the values
now are even lower:

   3    0 hda 1623 415 28028 128689845 408 1657 4144 61294 4294967234 1=
1728672 3714354303
   3    1 hda1 4 8 1 2
   3    2 hda2 1966 28002 2071 4142
   3   64 hdb 381 18 3272 124256894 1662 1332 24000 61697 4294967248 11=
733826 3870100758

Directly after reboot it is:
 21:30:55 up 1 min,  1 user,  load average: 0.15, 0.08, 0.02

   3    0 hda 904 311 15432 4294408137 66 213 564 7358 4294967294 67078=
 4294856106
   3    1 hda1 4 8 0 0
   3    2 hda2 1208 15416 282 564
   3   64 hdb 45 0 344 4294400418 8 3 88 404 4294967294 72358 429484143=
0


Where exactly is the code in the kernel, that produces the diskstats fi=
le,
so I can try grepping through it?

>
> Rick

- --=20
Regards Michael B=FCsch
http://www.8ung.at/tuxsoft
 21:23:47 up  2:09,  3 users,  load average: 1.01, 1.01, 1.00

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+2lSToxoigfggmSgRAuSgAJ42rV0+KTChl6OzUXf7KftHyi8b/wCfXaaJ
nOQzW3tR2UwVo15DpdRPzUQ=3D
=3DnGvx
-----END PGP SIGNATURE-----
