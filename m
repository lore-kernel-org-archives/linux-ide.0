From: Borislav Petkov <petkovbb@googlemail.com>
Subject: Re: (fwd) Bug#11922: I/O error on blank tapes
Date: Mon, 4 Feb 2008 22:28:35 +0100
Message-ID: <20080204212835.GA29286@gollum.tnic>
References: <20080204142206.GB5532@stro.at>
Reply-To: petkovbb@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ag-out-0708.google.com ([72.14.246.248]:35287 "EHLO
	ag-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753202AbYBDVac (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 4 Feb 2008 16:30:32 -0500
Received: by ag-out-0708.google.com with SMTP id 35so2171729aga.10
        for <linux-ide@vger.kernel.org>; Mon, 04 Feb 2008 13:30:31 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20080204142206.GB5532@stro.at>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: maximilian attems <max@stro.at>
Cc: linux-ide@vger.kernel.org, Stephen Kitt <steve@sk2.org>, bzolnier@gmail.com

On Mon, Feb 04, 2008 at 03:22:06PM +0100, maximilian attems wrote:

(Added Bart to CC)

> hello borislav,
>=20
> may i forward you that *old* Debian kernel bug,
> have seen you working on ide-tape:
> http://bugs.debian.org/11922
> no we don't carry any ide patches anymore.
>=20
> maybe you've already fixed it in latest?
>=20
> thanks
>=20
> --=20
> maks
>=20
> ----- Forwarded message from Stephen Kitt <steve@sk2.org> -----
>=20
> Subject: Bug#11922: I/O error on blank tapes
> Date: Sat, 1 Dec 2007 19:06:18 +0100
> From: Stephen Kitt <steve@sk2.org>
> To: 11922@bugs.debian.org
>=20
> Hi,
>=20
> This does still occur with 2.6.22; with a blank tape in my HP DDS-4 d=
rive:
>=20
> $ tar tzvf /dev/nst0
> tar: /dev/nst0: Cannot read: Input/output error
> tar: At beginning of tape, quitting now
> tar: Error is not recoverable: exiting now
>=20
> gzip: stdin: unexpected end of file
> tar: Child returned status 2
> tar: Error exit delayed from previous errors
>=20
> Nothing gets logged anywhere, which fits the original bug description=
=2E
>=20
> This is a well-known issue: see for example
> http://www.sibbald.com/bacula/html-manual/Bacula_Console.html (search=
 for
> "blank tape").
>=20
> Regards,
>=20
> Stephen
>=20
>=20
>=20
> --=20
> To UNSUBSCRIBE, email to debian-kernel-REQUEST@lists.debian.org
> with a subject of "unsubscribe". Trouble? Contact listmaster@lists.de=
bian.org
>=20
>=20
> ----- End forwarded message -----

Hi Maks,

we're currently in the process of aggressively cleaning up ide-tape. Ho=
wever,
this brings (almost) no functional changes to the driver and we haven't=
 looked
at any bugs that might exist. Actually, I wanted to probe the community=
 to see
whether anyone is using ide-tape at all, and if not, to remove it compl=
etely.

Since i don't have the hardware, i'm gonna have to ask you (or Stephen)=
 to wait
until all changes have entered mainline and then to try to reproduce th=
e bug again
after having enabled debugging (IDETAPE_DEBUG_LOG) and send me the sysl=
og
output.

Thanks.

--=20
Regards/Gru=DF,
    Boris.
