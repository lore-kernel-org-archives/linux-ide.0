From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] sata_rcar: fix interrupt handling
Date: Sun, 2 Jun 2013 20:49:12 -0700
Message-ID: <20130603034912.GD6071@mtj.dyndns.org>
References: <201306010238.35442.sergei.shtylyov@cogentembedded.com>
 <51A92CF0.3090804@cogentembedded.com>
 <20130602075821.GA8286@mtj.dyndns.org>
 <51AB2F0A.9030703@cogentembedded.com>
 <51AB7A1B.4060905@cogentembedded.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qe0-f42.google.com ([209.85.128.42]:36466 "EHLO
	mail-qe0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750846Ab3FCDtK (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 2 Jun 2013 23:49:10 -0400
Received: by mail-qe0-f42.google.com with SMTP id s14so335639qeb.15
        for <linux-ide@vger.kernel.org>; Sun, 02 Jun 2013 20:49:09 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <51AB7A1B.4060905@cogentembedded.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: linux-ide@vger.kernel.org, vladimir.barinov@cogentembedded.com

Hey,

On Sun, Jun 02, 2013 at 09:00:11PM +0400, Sergei Shtylyov wrote:
> >>    CC      drivers/ata/sata_rcar.o
> >>    drivers/ata/sata_rcar.c: In function =E2=80=98sata_rcar_thaw=E2=
=80=99:
> >>    drivers/ata/sata_rcar.c:183:2: warning: large integer
> >>implicitly truncated to unsigned type [-Woverflow]
> >
> >    It compiles without warnings for me, IIRC. What version of gcc
> >are you using?
>=20
> >>Care to fix it?
> >
> >   I'll look into it...
>=20
>     I tried 4.2.0, 4.3.3 (that one broke with segmentation fault),
> and 4.7.3 and no warning...
> So, please tell me what version you have for the changelog.

I'm on fedora 19 beta x86-64.

$ gcc --version
gcc (GCC) 4.8.0 20130526 (Red Hat 4.8.0-8)
Copyright (C) 2013 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.  There is=
 NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURP=
OSE.

# make drivers/ata/sata_rcar.o
=2E..
  CC      drivers/ata/sata_rcar.o
  drivers/ata/sata_rcar.c: In function =E2=80=98sata_rcar_thaw=E2=80=99=
:
  drivers/ata/sata_rcar.c:183:2: warning: large integer implicitly trun=
cated to unsigned type [-Woverflow]
    iowrite32(~SATA_RCAR_INT_MASK, priv->base + SATAINTSTAT_REG);
    ^
Thanks.

--=20
tejun
