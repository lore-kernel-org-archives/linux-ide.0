From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH 1/2] ahci: imx: use macros to define registers and bits
Date: Wed, 16 Apr 2014 09:59:57 +0200
Message-ID: <20140416075957.GR5969@pengutronix.de>
References: <1397529703-21165-1-git-send-email-shawn.guo@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:56056 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751475AbaDPH77 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 16 Apr 2014 03:59:59 -0400
Content-Disposition: inline
In-Reply-To: <1397529703-21165-1-git-send-email-shawn.guo@freescale.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Shawn Guo <shawn.guo@freescale.com>
Cc: linux-ide@vger.kernel.org, Tejun Heo <tj@kernel.org>, linux-arm-kernel@lists.infradead.org

On Tue, Apr 15, 2014 at 10:41:42AM +0800, Shawn Guo wrote:
> diff --git a/drivers/ata/ahci_imx.c b/drivers/ata/ahci_imx.c
> index 497c7ab..39629b4 100644
> --- a/drivers/ata/ahci_imx.c
> +++ b/drivers/ata/ahci_imx.c
> @@ -28,11 +28,9 @@
>  #include <linux/libata.h>
>  #include "ahci.h"
> =20
> -enum {
> -	PORT_PHY_CTL =3D 0x178,			/* Port0 PHY Control */
> -	PORT_PHY_CTL_PDDQ_LOC =3D 0x100000,	/* PORT_PHY_CTL bits */
> -	HOST_TIMER1MS =3D 0xe0,			/* Timer 1-ms */
> -};
> +#define IMX_SATA_TIMER1MS			0x00e0
> +#define IMX_SATA_P0PHYCR			0x0178
> +#define  P0PHYCR_TEST_PDDQ			(1 << 20)
Did you intentionally not namespace the bit mask?

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
