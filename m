From: Greg Freemyer <greg.freemyer@gmail.com>
Subject: Re: [opensuse-kernel] SSD / filesystem / TRIM
Date: Mon, 30 Aug 2010 15:14:29 -0400
Message-ID: <AANLkTinNt83RYu+ssRHzLT=E+Nk5kTk4Q+sfxQk5SP4+@mail.gmail.com>
References: <4C759825.60503@web.de>
	<AANLkTimrOOPExu+hU9wNubT3wgJWwUxMwjREn2p=x-qT@mail.gmail.com>
	<4C7A2949.8070606@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:47075 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751787Ab0H3TOa convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 30 Aug 2010 15:14:30 -0400
Received: by iwn5 with SMTP id 5so5111683iwn.19
        for <linux-ide@vger.kernel.org>; Mon, 30 Aug 2010 12:14:29 -0700 (PDT)
In-Reply-To: <4C7A2949.8070606@web.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Thomas Hertweck <Thomas.Hertweck@web.de>
Cc: opensuse-kernel@opensuse.org, Mark Lord <kernel@teksavvy.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

(Putting Mark Lord and linux-ide in cc:)

Mark,

Thomas has tried to use wiper.sh / hdparm v9.28 to trim a SSD and it
failed.  See below:

This is with the openSUSE 2.6.34 kernel.

On Sun, Aug 29, 2010 at 5:32 AM, Thomas Hertweck <Thomas.Hertweck@web.d=
e> wrote:
<snip>

> I have now installed openSUSE 11.3 on a OCZ Vertex 2E SSD. I used a
> standard ext4 filesystem, the mount options at the moment are
> "rw,noatime,acl,user_xattr". Unfortunately, wiper.sh doesn't work at =
all.
>
> $> wiper.sh --verbose --commit /dev/sdb1
> wiper.sh: Linux SATA SSD TRIM utility, version 2.6, by Mark Lord.
> wiper.sh: This tool is DANGEROUS! Please read and understand
> wiper.sh: /usr/share/doc/packages/hdparm/README.wiper
> wiper.sh: before going any further.
> rootdev=3D/dev/sdb1
> fsmode2: fsmode=3Dread-write
> /: fstype=3Dext4
> freesize =3D 45338732 KB, reserved =3D 453387 KB
> Preparing for online TRIM of free space on /dev/sdb1 (ext4 mounted
> read-write at /).
> This operation could silently destroy your data. =A0Are you sure (y/N=
)? y
> Creating temporary file (44885345 KB)..
> Syncing disks..
> Beginning TRIM operations..
> get_trimlist=3D/sbin/hdparm --fibmap WIPER_TMPFILE.13467
> /dev/sdb:
> trimming 89770696 sectors from 1493 ranges
> FAILED: Input/output error
> Removing temporary file..
> Syncing disks..
> Aborted.
>
> No joy, obviously. So what can I do?
<snip>

> The motherboard, by the
> way, is an Asus P6X58D-E, the SSD is attached to one of the 3GB/s SAT=
A
> ports (Intel chip). There's also a 6GB/s SATA port (Marvell chip) on =
the
> board, but I couldn't find Linux support for that (that's why I haven=
't
> used this port).
>
>
> Well,... See above.
>
> Regards,
> Thomas

Mark, any thoughts why it didn't work.  Have you added anything
relevant to hdparm since v.9.28 that would help?

Greg
