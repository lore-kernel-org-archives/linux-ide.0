From: Antoine =?iso-8859-1?Q?T=E9nart?=
	<antoine.tenart@free-electrons.com>
Subject: Re: [PATCH v11 3/8] ata: libahci_platform: move port_map parameters
 into the AHCI structure
Date: Wed, 30 Jul 2014 10:20:38 +0200
Message-ID: <20140730082038.GB29900@kwain>
References: <1406193450-17283-1-git-send-email-antoine.tenart@free-electrons.com>
 <1406193450-17283-4-git-send-email-antoine.tenart@free-electrons.com>
 <20140729144042.GD4791@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:53458 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751387AbaG3IUn (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 30 Jul 2014 04:20:43 -0400
Content-Disposition: inline
In-Reply-To: <20140729144042.GD4791@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Antoine =?iso-8859-1?Q?T=E9nart?= <antoine.tenart@free-electrons.com>, sebastian.hesselbarth@gmail.com, kishon@ti.com, alexandre.belloni@free-electrons.com, thomas.petazzoni@free-electrons.com, zmxu@marvell.com, jszhang@marvell.com, linux-arm-kernel@lists.infradead.org, linux-ide@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, Jul 29, 2014 at 10:40:42AM -0400, Tejun Heo wrote:
> On Thu, Jul 24, 2014 at 11:17:25AM +0200, Antoine T=E9nart wrote:
> > @@ -321,6 +321,8 @@ struct ahci_host_priv {
> >  	u32			cap;		/* cap to use */
> >  	u32			cap2;		/* cap2 to use */
> >  	u32			port_map;	/* port map to use */
> > +	u32			force_port_map;	/* force port map */
> > +	u32			mask_port_map;	/* mask out particular bits */
>=20
> Let's collect the inputs, including flags, at the top and mark them c=
learly.

Done.

>=20
> >  int ahci_platform_init_host(struct platform_device *pdev,
> >  			    struct ahci_host_priv *hpriv,
> >  			    const struct ata_port_info *pi_template,
> > -			    unsigned long host_flags,
> > -			    unsigned int force_port_map,
> > -			    unsigned int mask_port_map)
> > +			    unsigned long host_flags)
>=20
> This doesn't make much sense to me.  Near the head of the function, i=
t
> does
>=20
> 	hpriv->flags |=3D host_flags;
>=20
> Wouldn't it make more sense to just let the caller set hpriv->flags?

I just removed the host_flags parameter and updated the drivers calling
it.


How do you want me to send the series? There is two conflicts when
applying to libata/for-3.17:
- patch 4/8: it takes into account a patch not in libata/for-3.17 but
  added before rc7. It should be better to first merge rc7, otherwise
  some modifications won't make sense.
- patch 6/8: "fsl,imx53-ahci" was removed from the documentation in
  libata/for-3.17 but not in rc7. Resolving the conflict is really
  simple.

I think it's better to apply the whole thing after merging rc7 into
libata/for-3.17, because it will only have a really simple conflict to
resolve.

Please tell me what do you prefer before I send the updated version.

Antoine

--=20
Antoine T=E9nart, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
