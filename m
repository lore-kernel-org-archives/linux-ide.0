From: Bodo Eggert <7eggert@elstempel.de>
Subject: Re: tighten ATA kconfig dependancies
Date: Sat, 15 Jul 2006 20:38:01 +0200
Message-ID: <E1G1p1y-0000ZU-Io@be1.lrz>
References: <6yL2J-7rR-1@gated-at.bofh.it> <6yLco-7DB-1@gated-at.bofh.it>
Reply-To: 7eggert@gmx.de
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-in-01.arcor-online.net ([151.189.21.41]:12778 "EHLO
	mail-in-01.arcor-online.net") by vger.kernel.org with ESMTP
	id S964839AbWGPDZ6 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 15 Jul 2006 23:25:58 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Arjan van de Ven <arjan@infradead.org>, Dave Jones <davej@redhat.com>, linux-ide@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>

Arjan van de Ven <arjan@infradead.org> wrote:
> On Sat, 2006-07-15 at 01:34 -0400, Dave Jones wrote:

>> A lot of prehistoric junk shows up on x86-64 configs.
>=20
> ... but in general it helps compile testing if you're hacking stuff;
> if your hacking IDE on x86-64 you now have to compile 32 bit as well =
to
> see if you didn't break the compile for these as well
>=20
> So please don't do this, just disable them in your config...

If you want to compile test these drivers, just revert the patch or edi=
t
the .config.
--=20
Ich danke GMX daf=FCr, die Verwendung meiner Adressen mittels per SPF
verbreiteten L=FCgen zu sabotieren.

http://david.woodhou.se/why-not-spf.html
