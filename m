From: Robert Jarzmik <robert.jarzmik@free.fr>
Subject: Re: [PATCH v3] PXA DMA-capable PATA driver
Date: Wed, 19 May 2010 13:19:14 +0200
Message-ID: <87pr0s6swd.fsf@free.fr>
References: <1274137768-27707-1-git-send-email-marek.vasut@gmail.com>
	<201005180112.30792.marek.vasut@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp6-g21.free.fr ([212.27.42.6]:34323 "EHLO smtp6-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757918Ab0ESLTZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 19 May 2010 07:19:25 -0400
In-Reply-To: <201005180112.30792.marek.vasut@gmail.com> (Marek Vasut's message of "Tue\, 18 May 2010 01\:12\:30 +0200")
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Marek Vasut <marek.vasut@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-arm-kernel@lists.infradead.org, eric.y.miao@gmail.com, haojian.zhuang@gmail.com, jeff@garzik.org, radoslav.deak@voipac.com

Marek Vasut <marek.vasut@gmail.com> writes:

> Dne =C3=9At 18. kv=C4=9Btna 2010 01:09:28 Marek Vasut napsal(a):
>> This patch adds a driver for a harddrive attached to PXA address and=
 data
>> bus. Unlike pata_platform, this driver allows usage of PXA DMA contr=
oller,
>> making the transmission speed 3x higher.
>
> Hey guys, all the issues pointed out should be addressed. See below.
> Cheers!

=46or the first iteration, you can have my :
Reviewed-by: Robert Jarzmik <robert.jarzmik@free.fr>

=46or the next iteration, it would be good to :
 - fix the error path in pxa_ata_probe()
   =3D> if dmam_alloc_coherent() fails
   =3D> if pxa_request_dma() fails
 - in pxa_ata_remove()
   =3D> maybe call devm_iounmap()

--
Robert
