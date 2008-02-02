From: Bodo Eggert <7eggert@gmx.de>
Subject: Re: [PATCH] ide-core: remove conditional compiling with MODULE in ide-core.c
Date: Sat, 02 Feb 2008 19:58:15 +0100
Message-ID: <E1JLNZ9-0000iB-G8@be1.7eggert.dyndns.org>
References: <9Slso-6q4-5@gated-at.bofh.it>
Reply-To: 7eggert@gmx.de
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.179]:54612 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752154AbYBBS6X (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 2 Feb 2008 13:58:23 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Denis Cheng <crquan@gmail.com>, linux-kernel@vger.kernel.org, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-ide@vger.kernel.org

Denis Cheng <crquan@gmail.com> wrote:

> use module_init/module_exit to replace the original cond-compiling, t=
hese
> macros were well designed to deal module/built-in compiling.
>=20
> the original __setup with null string was invalid and not executed,
> __setup("", ide_setup);
>=20
> however, with the current module_param mechanics, module parameters a=
lso can
> be input on the kernel command line, with this style:
>=20
> ide-core.options=3D"ide=3Dnodma hdd=3Dcdrom idebus=3D..."
>=20
> so Documentation/kernel-parameters.txt also updated.

> --- a/Documentation/kernel-parameters.txt

> -     ide=3D            [HW] (E)IDE subsystem
> -                     Format: ide=3Dnodma or ide=3Ddoubler or ide=3Dr=
everse
> -                     See Documentation/ide.txt.
> -
> -     ide?=3D           [HW] (E)IDE subsystem
> -                     Format: ide?=3Dnoprobe or chipset specific para=
meters.
> -                     See Documentation/ide.txt.
> -
> -     idebus=3D         [HW] (E)IDE subsystem - VLB/PCI bus speed
> +     ide-core.options=3D [HW] (E)IDE subsystem
> +                     Format: ide-core.options=3D"ide=3Dnodma hdd=3Dc=
drom idebus=3D..."

IMO you should use separate options for things like nodma while you're =
at it.

=A2=A2

