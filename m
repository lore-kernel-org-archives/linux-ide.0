From: Marek Vasut <marek.vasut@gmail.com>
Subject: Re: [PATCH v3] PXA DMA-capable PATA driver
Date: Tue, 18 May 2010 10:25:06 +0200
Message-ID: <201005181025.06985.marek.vasut@gmail.com>
References: <1274137768-27707-1-git-send-email-marek.vasut@gmail.com> <4BF20FF6.4020506@garzik.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:51874 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752490Ab0ERI0j convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 18 May 2010 04:26:39 -0400
Received: by fxm10 with SMTP id 10so764681fxm.19
        for <linux-ide@vger.kernel.org>; Tue, 18 May 2010 01:26:37 -0700 (PDT)
In-Reply-To: <4BF20FF6.4020506@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-ide@vger.kernel.org, linux-arm-kernel@lists.infradead.org, eric.y.miao@gmail.com, haojian.zhuang@gmail.com, robert.jarzmik@free.fr, Radoslav Deak <radoslav.deak@voipac.com>

Dne =C3=9At 18. kv=C4=9Btna 2010 05:56:38 Jeff Garzik napsal(a):
> On 05/17/2010 07:09 PM, Marek Vasut wrote:
> > This patch adds a driver for a harddrive attached to PXA address an=
d data
> > bus. Unlike pata_platform, this driver allows usage of PXA DMA
> > controller, making the transmission speed 3x higher.
> >=20
> > Signed-off-by: Marek Vasut<marek.vasut@gmail.com>
> > ---
> >=20
> >   arch/arm/mach-pxa/include/mach/pata_pxa.h |   33 +++
> >   drivers/ata/Kconfig                       |   11 +
> >   drivers/ata/Makefile                      |    1 +
> >   drivers/ata/pata_pxa.c                    |  404
> >   +++++++++++++++++++++++++++++ 4 files changed, 449 insertions(+),=
 0
> >   deletions(-)
> >   create mode 100644 arch/arm/mach-pxa/include/mach/pata_pxa.h
> >   create mode 100644 drivers/ata/pata_pxa.c
>=20
> Acked-by: Jeff Garzik <jgarzik@redhat.com>
>=20
> There are a few minor issues remaining, but we can take care of them
> post-merge.  I presume you'll send this via arm tree.

If you're fine with it, I guess that'd be the best way.

Thanks!
