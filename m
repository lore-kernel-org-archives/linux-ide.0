From: Shawn Guo <shawn.guo@freescale.com>
Subject: Re: [PATCH 1/2] ahci: imx: use macros to define registers and bits
Date: Wed, 16 Apr 2014 16:08:50 +0800
Message-ID: <20140416080849.GL2523@dragon>
References: <1397529703-21165-1-git-send-email-shawn.guo@freescale.com>
 <20140416075957.GR5969@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ch1ehsobe003.messaging.microsoft.com ([216.32.181.183]:22303
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754544AbaDPII7 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 16 Apr 2014 04:08:59 -0400
Content-Disposition: inline
In-Reply-To: <20140416075957.GR5969@pengutronix.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: linux-ide@vger.kernel.org, Tejun Heo <tj@kernel.org>, linux-arm-kernel@lists.infradead.org

On Wed, Apr 16, 2014 at 09:59:57AM +0200, Uwe Kleine-K=F6nig wrote:
> On Tue, Apr 15, 2014 at 10:41:42AM +0800, Shawn Guo wrote:
> > diff --git a/drivers/ata/ahci_imx.c b/drivers/ata/ahci_imx.c
> > index 497c7ab..39629b4 100644
> > --- a/drivers/ata/ahci_imx.c
> > +++ b/drivers/ata/ahci_imx.c
> > @@ -28,11 +28,9 @@
> >  #include <linux/libata.h>
> >  #include "ahci.h"
> > =20
> > -enum {
> > -	PORT_PHY_CTL =3D 0x178,			/* Port0 PHY Control */
> > -	PORT_PHY_CTL_PDDQ_LOC =3D 0x100000,	/* PORT_PHY_CTL bits */
> > -	HOST_TIMER1MS =3D 0xe0,			/* Timer 1-ms */
> > -};
> > +#define IMX_SATA_TIMER1MS			0x00e0
> > +#define IMX_SATA_P0PHYCR			0x0178
> > +#define  P0PHYCR_TEST_PDDQ			(1 << 20)
> Did you intentionally not namespace the bit mask?

Yes, with the intention to make the bit names a little shorter.

Shawn

