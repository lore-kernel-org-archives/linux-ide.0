From: Marek Vasut <marek.vasut@gmail.com>
Subject: Re: [PATCH v3] PXA DMA-capable PATA driver
Date: Wed, 19 May 2010 14:44:37 +0200
Message-ID: <201005191444.37376.marek.vasut@gmail.com>
References: <1274137768-27707-1-git-send-email-marek.vasut@gmail.com> <201005180112.30792.marek.vasut@gmail.com> <87pr0s6swd.fsf@free.fr>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:46245 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758038Ab0ESMqL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 19 May 2010 08:46:11 -0400
Received: by fxm10 with SMTP id 10so2288847fxm.19
        for <linux-ide@vger.kernel.org>; Wed, 19 May 2010 05:46:08 -0700 (PDT)
In-Reply-To: <87pr0s6swd.fsf@free.fr>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert Jarzmik <robert.jarzmik@free.fr>
Cc: linux-ide@vger.kernel.org, linux-arm-kernel@lists.infradead.org, eric.y.miao@gmail.com, haojian.zhuang@gmail.com, jeff@garzik.org, radoslav.deak@voipac.com

Dne St 19. kv=C4=9Btna 2010 13:19:14 Robert Jarzmik napsal(a):
> Marek Vasut <marek.vasut@gmail.com> writes:
> > Dne =C3=9At 18. kv=C4=9Btna 2010 01:09:28 Marek Vasut napsal(a):
> >> This patch adds a driver for a harddrive attached to PXA address a=
nd
> >> data bus. Unlike pata_platform, this driver allows usage of PXA DM=
A
> >> controller, making the transmission speed 3x higher.
> >=20
> > Hey guys, all the issues pointed out should be addressed. See below=
=2E
> > Cheers!
>=20
> For the first iteration, you can have my :
> Reviewed-by: Robert Jarzmik <robert.jarzmik@free.fr>
>=20
> For the next iteration, it would be good to :
>  - fix the error path in pxa_ata_probe()
>    =3D> if dmam_alloc_coherent() fails
>    =3D> if pxa_request_dma() fails
>  - in pxa_ata_remove()
>    =3D> maybe call devm_iounmap()
>=20

It'd be awesome if you could just point out all the issues at once ... =
about=20
devm_x(), you probably don't need to, it's 'managed'.

> --
> Robert
