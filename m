From: Thiago Farina <tfransosi@gmail.com>
Subject: Re: [PATCH] ide/ide-scan-pci.c: Use for_each_pci_dev().
Date: Tue, 10 May 2011 19:57:13 -0300
Message-ID: <BANLkTim+Oah2dg2hazHU0wuxzJCiEy3Rmw@mail.gmail.com>
References: <1304287825-8023-1-git-send-email-tfransosi@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:37680 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752703Ab1EJW5O convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 10 May 2011 18:57:14 -0400
In-Reply-To: <1304287825-8023-1-git-send-email-tfransosi@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>
Cc: linux-ide@vger.kernel.org

ping?

On Sun, May 1, 2011 at 7:10 PM, Thiago Farina <tfransosi@gmail.com> wro=
te:
> Use for_each_pci_dev() to simplify the code.
>
> Signed-off-by: Thiago Farina <tfransosi@gmail.com>
> ---
> =C2=A0drivers/ide/ide-scan-pci.c | =C2=A0 =C2=A02 +-
> =C2=A01 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/ide/ide-scan-pci.c b/drivers/ide/ide-scan-pci.c
> index 0e79eff..c3da53e 100644
> --- a/drivers/ide/ide-scan-pci.c
> +++ b/drivers/ide/ide-scan-pci.c
> @@ -88,7 +88,7 @@ static int __init ide_scan_pcibus(void)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct list_head *l, *n;
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0pre_init =3D 0;
> - =C2=A0 =C2=A0 =C2=A0 while ((dev =3D pci_get_device(PCI_ANY_ID, PCI=
_ANY_ID, dev)))
> + =C2=A0 =C2=A0 =C2=A0 for_each_pci_dev(dev)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ide_scan_pcide=
v(dev);
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0/*
> --
> 1.7.5.rc2.5.g60e19
>
>
