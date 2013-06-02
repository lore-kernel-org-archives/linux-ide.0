From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] sata_rcar: fix interrupt handling
Date: Sun, 2 Jun 2013 00:58:21 -0700
Message-ID: <20130602075821.GA8286@mtj.dyndns.org>
References: <201306010238.35442.sergei.shtylyov@cogentembedded.com>
 <51A92CF0.3090804@cogentembedded.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pb0-f43.google.com ([209.85.160.43]:57904 "EHLO
	mail-pb0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750805Ab3FBH6Z (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 2 Jun 2013 03:58:25 -0400
Received: by mail-pb0-f43.google.com with SMTP id ma3so4288158pbc.2
        for <linux-ide@vger.kernel.org>; Sun, 02 Jun 2013 00:58:24 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <51A92CF0.3090804@cogentembedded.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: linux-ide@vger.kernel.org, vladimir.barinov@cogentembedded.com

On Sat, Jun 01, 2013 at 03:06:24AM +0400, Sergei Shtylyov wrote:
> Hello.
>=20
> On 06/01/2013 02:38 AM, Sergei Shtylyov wrote:
>=20
> >The driver's interrupt handling code is too picky in deciding whethe=
r it should
> >handle an interrupt or not which causes completely unneeded spurious=
 interrupts.
> >Thus make sata_rcar_{ata|serr}_interrupt() *void*; add ATA status re=
gister read
> >to sata_rcar_ata_interrupt() to clear an unexpected ATA interrupt --=
 it doesn't
> >get cleared by writing to the SATAINTSTAT register in the interrupt =
mode we use.
> >
> >Also, in sata_rcar_ata_interrupt() we should check SATAINTSTAT regis=
ter only for
> >enabled interrupts and we should clear  only those interrupts  that =
we have read
> >as active first time around, because else we have  a  race and risk =
clearing  an
> >interrupt that  can  occur between read  and write of the  SATAINTST=
AT  register
> >and never registering it...
> >
> >Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
>=20
>     Darn, I forgot to Cc: stable@vger.kernel.org again.

Applied to libata/for-3.10-fixes w/ stable cc'd.  BTW, the driver
generates the following compile warning.

   CC      drivers/ata/sata_rcar.o
   drivers/ata/sata_rcar.c: In function =E2=80=98sata_rcar_thaw=E2=80=99=
:
   drivers/ata/sata_rcar.c:183:2: warning: large integer implicitly tru=
ncated to unsigned type [-Woverflow]
  =20
Care to fix it?

Thanks.

--=20
tejun
