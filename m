From: Antoine =?iso-8859-1?Q?T=E9nart?=
	<antoine.tenart@free-electrons.com>
Subject: Re: [PATCH v10 4/8] ata: libahci: allow to use multiple PHYs
Date: Mon, 21 Jul 2014 11:01:00 +0200
Message-ID: <20140721090100.GB32208@kwain>
References: <1405686607-8126-1-git-send-email-antoine.tenart@free-electrons.com>
 <1405686607-8126-5-git-send-email-antoine.tenart@free-electrons.com>
 <20140718151745.0b0114a9@ipc1.ka-ro>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:51326 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753256AbaGUJBF (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 21 Jul 2014 05:01:05 -0400
Content-Disposition: inline
In-Reply-To: <20140718151745.0b0114a9@ipc1.ka-ro>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Lothar =?iso-8859-1?Q?Wa=DFmann?= <LW@KARO-electronics.de>
Cc: Antoine =?iso-8859-1?Q?T=E9nart?= <antoine.tenart@free-electrons.com>, sebastian.hesselbarth@gmail.com, tj@kernel.org, kishon@ti.com, thomas.petazzoni@free-electrons.com, zmxu@marvell.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, alexandre.belloni@free-electrons.com, jszhang@marvell.com, linux-arm-kernel@lists.infradead.org

Hi,

On Fri, Jul 18, 2014 at 03:17:45PM +0200, Lothar Wa=DFmann wrote:
> Antoine T=E9nart wrote:
> > diff --git a/drivers/ata/libahci_platform.c b/drivers/ata/libahci_p=
latform.c
> > index db9b90d876dd..2c2439b4101d 100644
> > --- a/drivers/ata/libahci_platform.c
> > +++ b/drivers/ata/libahci_platform.c
> > @@ -39,6 +39,61 @@ static struct scsi_host_template ahci_platform_s=
ht =3D {
> >  };
> > =20
> >  /**
> > + * ahci_platform_enable_phys - Enable PHYs
> > + * @hpriv: host private area to store config values
> > + *
> > + * This function enables all the PHYs found in hpriv->phys, if any=
=2E
> > + * If a PHY fails to be enabled, it disables all the PHYs already
> > + * enabled in reverse order and returns an error.
> > + *
> > + * RETURNS:
> > + * 0 on success otherwise a negative error code
> > + */
> > +int ahci_platform_enable_phys(struct ahci_host_priv *hpriv)
> > +{
> > +	int i, rc =3D 0;
> > +
> You shouldn't have to initialize rc here, or does your gcc falsely
> complain about an uninitialized variable if you don't?

You're right, this is not needed.

Antoine

--=20
Antoine T=E9nart, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
