From: Tejun Heo <tj@kernel.org>
Subject: Re: copy speed slows down after kernel update
Date: Tue, 2 Dec 2014 14:34:45 -0500
Message-ID: <20141202193445.GN10918@htj.dyndns.org>
References: <CAAmAy+=W2Jp=rfqq32VAKt2g6rkyMZUXdU0CUp2zZOUFK71dTQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qg0-f51.google.com ([209.85.192.51]:34340 "EHLO
	mail-qg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934035AbaLBTes (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 2 Dec 2014 14:34:48 -0500
Received: by mail-qg0-f51.google.com with SMTP id l89so9629380qgf.38
        for <linux-ide@vger.kernel.org>; Tue, 02 Dec 2014 11:34:47 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CAAmAy+=W2Jp=rfqq32VAKt2g6rkyMZUXdU0CUp2zZOUFK71dTQ@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: =?utf-8?B?0JzQuNGF0LDQuNC7?= <kriolord@gmail.com>
Cc: linux-ide@vger.kernel.org

Hello,

On Fri, Nov 28, 2014 at 02:13:35PM +0400, =D0=9C=D0=B8=D1=85=D0=B0=D0=B8=
=D0=BB wrote:
> Technical description:
> MacBook Air Model A1370 (googling as: Apple MacBook Air "Core i7" 1.8=
 11"
> (Mid-2011))
> Disk A: Lacie Little Big Disk with Samsung HN-M101MBB 1 TB
> Disk B: Lacie Little Big Disk with OCZ Vertex 3
> Disk C: Seagate thunderbolt Adapter from STCB3000400 with OCZ Vertex =
3
> Disk D: Seagate thunderbolt Adapter from STCB3000400 with Samsung
> HN-M101MBB 1 TB
>=20
> using copy cammand: dd if=3D/dev/sda(internal Mac Book disk)
> of=3D/mnt/sdb1/test.dd bs=3D4M
>=20
> Test bench 1. Bootable distro based on Debian whezzy 7.2 stable from
> October 12, 2013, kernel 3.2.0.4
> 1.1 Disk A (ext2). Stable copying speed =3D 81,4 MB/s.
> 1.2 Disk B (ext2). Stable copying speed =3D 196 MB/s. !!!!!
> 1.3 Disk C (ext2). Stable copying speed =3D 199 MB/s.
> 1.4 Disk D (ext2). Stable copying speed =3D 87 MB/s.
>=20
> Test bench 2. Bootable distro based on Debian jessie from November 17=
,
> 2014, kernel 3.16.7 + thunderbolt driver compiled in.
> 2.1 Disk A (ext2). Stable copying speed =3D 94 MB/s.
> 2.2 Disk B (ext2). Stable copying speed =3D 150 MB/s. !!!!!!
>=20
> Test bench 3. Bootable distro based on Debian jessie from November 17=
,
> 2014, kernel 3.17.3 + thunderbolt driver compiled as module.
> 3.1 Disk A (ext2). Stable copying speed =3D 97 MB/s.
> 3.2 Disk B (ext2). Stable copying speed =3D 151 MB/s.
> 3.3 Disk C (ext2). Stable copying speed =3D 156 MB/s. !!!!!
> 3.4 Disk D (ext2). Stable copying speed =3D 108 MB/s.
>=20
> after and before insmod .../thunderbolt.ko the same results.

Can you please post kernel boot messages from the old and new kernels?

Thanks.

--=20
tejun
