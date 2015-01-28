From: Phillip Susi <psusi@ubuntu.com>
Subject: Re: SATA disks disabled on boot
Date: Wed, 28 Jan 2015 09:05:22 -0500
Message-ID: <54C8ECA2.3020705@ubuntu.com>
References: <CADqA9uaW6JwirSZQaHjCuB=9GSUQyakOEBAZor1ed-vyjoC=2g@mail.gmail.com> <20140714163641.GF31610@htj.dyndns.org> <CADqA9uYMCdT1ZpHD0fOVoD67PAx6RaY+8grfmG8SRoqnwyyHgw@mail.gmail.com> <20140817133942.GD7679@mtj.dyndns.org> <CADqA9ubrD1+Ri9d080X4xjrr7wsjqGGz5fjTC45QHjr4Fb1QJg@mail.gmail.com> <CADqA9uaj0MrpffnzE8xnhU57Hx9pv7O1sAhB+xS_4hi8z_dkMA@mail.gmail.com> <20141202195653.GQ10918@htj.dyndns.org> <547E4817.8000603@eu.ipp.pt> <20141204174819.GC2995@htj.dyndns.org> <5480F54B.9070306@ubuntu.com> <54822DD3.6040405@eu.ipp.pt> <CADqA9ubh5wHZPHJNYeSrMgOQsRYZSObRkg7irg3w+H+2M+hTmw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qg0-f43.google.com ([209.85.192.43]:56404 "EHLO
	mail-qg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752226AbbA2BRF (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 28 Jan 2015 20:17:05 -0500
Received: by mail-qg0-f43.google.com with SMTP id e89so22137615qgf.2
        for <linux-ide@vger.kernel.org>; Wed, 28 Jan 2015 17:17:04 -0800 (PST)
In-Reply-To: <CADqA9ubh5wHZPHJNYeSrMgOQsRYZSObRkg7irg3w+H+2M+hTmw@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: =?UTF-8?B?TnVubyBNYWdhbGjDo2Vz?= <nunomagalhaes@eu.ipp.pt>, Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 1/27/2015 6:03 PM, Nuno Magalh=C3=A3es wrote:
> Since i've heard the problem could be the PSU, i did some research
> and ended up (layman-ly) concluding that a 500W PSU is sufficient
> for all 4 disks. Still, i wanted to try and enable PUIS on the WDs,
> maybe it could work (the PSU isn't new, wouldn't be as stressed on
> boot, etc).

Yea, a power supply issue is extremely unlikely.  Also if the PSU is
overloaded, it simply shuts down.  It is easy enough to verify the
output voltage with a $10 radio shack multimeter.


> As for the WDs...
>=20
> I went and tried hdparm -s1 --yes-i-know-what-i-am-doing

Yes, WDs require a hardware jumper to enable PUiS, though doing so
isn't going to help you; I mentioned it because when it already IS
enabled, the results of the IDENTIFY_DEVICE command look like swiss
cheese until the drive is forced to spin up by a specific command,
that the kernel knows to issue on boot or resume.

> [   12.824479] ata4.00: failed to IDENTIFY (SPINUP failed,
> err_mask=3D0x4)
>=20
> which i took as a good sign since i didn't want it spinning up.

Well, you *do* want it spinning up of course, so you can access it.

Looking at your dmesg, I noticed this:

[ 1806.776781] ata2.00: ATA-9: WDC WD10EFRX-68PJCN0, 01.01A01, max
UDMA/133
[ 1806.776785] ata2.00: 1953525168 sectors, multi 1: LBA48 NCQ (depth
31/32)
[ 1806.784760] ata2.00: n_sectors mismatch 1953525168 !=3D 268435455
[ 1806.784768] ata2.00: revalidation failed (errno=3D-19)
[ 1806.784780] ata2: limiting SATA link speed to 1.5 Gbps
[ 1806.784787] ata2.00: limiting speed to UDMA/133:PIO3
[ 1811.768094] ata2: hard resetting link
[ 1811.768103] ata2: nv: skipping hardreset on occupied port
[ 1812.236126] ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 300)


THIS appears to be your problem.  It looks like the drive is changing
its mind on its size, indicating some spectacularly broken firmware.
I also notice that it fails to reset the link and lower the speed...
is this controller set to IDE mode in the bios?  If so you might have
better luck in proper AHCI mode.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (MingW32)

iQEcBAEBAgAGBQJUyOyiAAoJENRVrw2cjl5ROpUIAJ9eHjTUDhBhKjcBVQHIKhP9
hIi00ySdjy/+0ZcPak7FCb/iXVmBlxfDvlvRo2/XCjrdMgWn6z6NhoYtoO4zC8uT
BoENSznq+jFfhk6eN2/uCWVRY4jwwd6VlpCIXOOl/dDoA+7QLRzIMB+vqzZ0WEmj
qc6ucL1b7zP8Rj36tBQATV+K9sO4J6wqO0i3RiTnBe93h1hjsyFVn6Y0CnI5sQM/
VwzSILac4yQaFKgTCtJiSN5Zuaq8kDgaBCbloOiuu5TLiwvEduBoQE6NOVUl73bh
tbErHPwrkA7jWjdMektfH9Tzja1tbTWxH1pCUmLQRvOM4IOxD2qKkWDJSkJFP2g=3D
=3DuOZ9
-----END PGP SIGNATURE-----
