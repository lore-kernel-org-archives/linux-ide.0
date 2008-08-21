From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 1/7] ide: add ide_host_add() helper
Date: Thu, 21 Aug 2008 22:02:11 +0400
Message-ID: <48ADADA3.9060805@ru.mvista.com>
References: <20080628214355.21345.94835.sendpatchset@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:62796 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752883AbYHUSB6 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 21 Aug 2008 14:01:58 -0400
In-Reply-To: <20080628214355.21345.94835.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, khilman@deeprootsystems.com

Bartlomiej Zolnierkiewicz wrote:

> Add ide_host_add() helper which does ide_host_alloc()+ide_host_regist=
er(),
> then convert ide_setup_pci_device[s](), ide_legacy_device_add() and s=
ome
> host drivers to use it.

> While at it:

> * Fix ide_setup_pci_device[s](), ide_arm.c, gayle.c, ide-4drives.c,
>   macide.c, q40ide.c, cmd640.c and cs5520.c to return correct error v=
alue.

> * -ENOENT -> -ENOMEM in rapide.c, ide-h8300.c, ide-generic.c, au1xxx-=
ide.c
>   and pmac.c

> * -ENODEV -> -ENOMEM in palm_bk3710.c, ide_platform.c and delkin_cb.c

> * -1 -> -ENOMEM in ide-pnp.c

> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> Index: b/drivers/ide/arm/palm_bk3710.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- a/drivers/ide/arm/palm_bk3710.c
> +++ b/drivers/ide/arm/palm_bk3710.c
> @@ -351,7 +351,7 @@ static int __devinit palm_bk3710_probe(s
>  	struct resource *mem, *irq;
>  	struct ide_host *host;

    You forgot to remove this variable which caused the warning:

drivers/ide/arm/palm_bk3710.c: In the fucntion =91palm_bk3710_probe=92
drivers/ide/arm/palm_bk3710.c:350: warning: unused variable =91host=92

>  	unsigned long base;
> -	int i;
> +	int i, rc;
>  	hw_regs_t hw, *hws[] =3D { &hw, NULL, NULL, NULL };
> =20
>  	clkp =3D clk_get(NULL, "IDECLK");
> @@ -394,16 +394,14 @@ static int __devinit palm_bk3710_probe(s
>  	hw.irq =3D irq->start;
>  	hw.chipset =3D ide_palm3710;
> =20
> -	host =3D ide_host_alloc(&palm_bk3710_port_info, hws);
> -	if (host =3D=3D NULL)
> +	rc =3D ide_host_add(&palm_bk3710_port_info, hws, NULL);
> +	if (rc)
>  		goto out;
> =20
> -	ide_host_register(host, &palm_bk3710_port_info, hws);
> -
>  	return 0;
>  out:
>  	printk(KERN_WARNING "Palm Chip BK3710 IDE Register Fail\n");
> -	return -ENODEV;
> +	return rc;
>  }
> =20
>  /* work with hotplug and coldplug */

MBR, Sergei
