From: Bodo Eggert <7eggert@gmx.de>
Subject: Re: Loud "pop" coming from hard drive on reboot
Date: Wed, 18 Apr 2007 13:47:24 +0200
Message-ID: <E1He8dA-0000mw-LI@be1.lrz>
References: <88SeR-5Sf-15@gated-at.bofh.it> <88Sov-662-3@gated-at.bofh.it> <88SHV-6uL-29@gated-at.bofh.it> <8agVk-3wc-81@gated-at.bofh.it> <8b3IR-4mE-25@gated-at.bofh.it> <8b3SA-4z3-5@gated-at.bofh.it> <8b42g-51N-15@gated-at.bofh.it> <8bbdm-7iS-27@gated-at.bofh.it>
Reply-To: 7eggert@gmx.de
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.179]:52616 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422886AbXDRLso (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 18 Apr 2007 07:48:44 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>, Chuck Ebbert <cebbert@redhat.com>, emisca <emisca.ml@gmail.com>, Jan Engelhardt <jengelh@linux01.gwdg.de>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org, Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@osdl.org>

Tejun Heo <htejun@gmail.com> wrote:

> This really isn't a regression.  It's been always like that with liba=
ta.
>  libata doesn't make devices go into standby mode and shutdown(8) doe=
s
> it for libata.  The problem here is that libata does issue
> SYNCHRONIZE_CACHE on shutdown.  So, the sequence of event is...
>=20
> 1. shutdown(8) issues SYNCHRONIZE_CACHE followed by STANDBY_NOW
> 2. kernel shutdown starts
> 3. libata shutdown issues SYNCHRONIZE_CACHE
> 4. power goes off
>=20
> Some drives seem to spin up at step #3 even when its cache is clean a=
nd
> power goes off right after the disk finishes the command.  So, it's
> really bad when it happens - spin down, spin up followed by immediate
> power off.
>=20
> SCSI part of the fix is queued in scsi-misc-2.6 tree and libata-dev p=
art
> is acked and waiting to be merged, so the fix will be available in
> 2.6.22.  However, it's disabled by default to remain compatible with =
the
           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^=
^^^
> current behavior and requires userland change to fully fix the proble=
m.
  ^^^^^^^^^^^^^^^^
It sounds like the Schilling kind of compatibility: "The old burner des=
troyed
your disk on buffer underruns, therefore the new thing should do the sa=
me
instead of giving you a perfectly readable data disk."

Guys, not destroying hardware is _NOT_ bad!
--=20
Anger, fear, aggression. The Dark Side of the Force are they.
Once you start down the Dark Path, forever will it dominate your destin=
y.
        -- Jedi Master Yoda
=46ri=DF, Spammer: QuG4KfL@BSc.7eggert.dyndns.org
