From: Tejun Heo <tj@kernel.org>
Subject: Re: sata_inic162x  LED enable request
Date: Thu, 04 Sep 2008 10:13:40 +0200
Message-ID: <48BF98B4.5070307@kernel.org>
References: <176058.79687.qm@web901.biz.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:37168 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751922AbYIDIPG (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 4 Sep 2008 04:15:06 -0400
In-Reply-To: <176058.79687.qm@web901.biz.mail.mud.yahoo.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bob Stewart <bob@evoria.net>
Cc: echo6 <echo6_uk@yahoo.com>, linux-ide@vger.kernel.org

Hello,

Bob Stewart wrote:
> I've been using the new driver to boot my second machine for about 2
> weeks, now, as well as having another 200GB disk hanging off it; all
> without any problems.  Well done!  What I would like to see is the
> LED enabled properly, although the board uses a different header pin
> for each drive.  Anyway, if I've
>=20
> got it right, here is my suggested change.
>=20
> --- linux-2.6.27-rc5.a/drivers/ata/sata_inic162x.c	2008-08-28
> 18:52:02.000000000 -0400
> +++ linux-2.6.27-rc5.b/drivers/ata/sata_inic162x.c	2008-09-01
> 14:05:24.000000000 -0400
> @@ -96,6 +96,7 @@
>  	PORT_SCR		=3D 0x20,
> =20
>  	/* HOST_CTL bits */
> +	HCTL_LEDEN		=3D (1 << 3),  /* enable LED operation */

Hmm... according to the datasheet, this is SWLED.

  SOFTWARE CONTROL LED ENABLE: When set, software has full control of
  LED activity. When clear, the LED=E2=80=99s are controlled by hardwar=
e.

And then there are two more bits, LED0 and LED1 which seem to be the
actual control knob for LEDs.  From the description it looks like the
bit should stay off so tha the controller hardware can drive LEDs.  I
presume this doesn't work as described?

>  	HCTL_IRQOFF		=3D (1 << 8),  /* global IRQ off */
>  	HCTL_FTHD0		=3D (1 << 10), /* fifo threshold 0 */
>  	HCTL_FTHD1		=3D (1 << 11), /* fifo threshold 1*/
> @@ -540,7 +541,7 @@
>  	void __iomem *port_base =3D inic_port_base(ap);
> =20
>  	/* fire up the ADMA engine */
> -	writew(HCTL_FTHD0, port_base + HOST_CTL);
> +	writew(HCTL_FTHD0 + HCTL_LEDEN, port_base + HOST_CTL);

Nitpick: for flags, it's customary to use | instead of +.

Thanks.

--=20
tejun
