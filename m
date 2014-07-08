From: Antoine =?iso-8859-1?Q?T=E9nart?=
	<antoine.tenart-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH v9 3/7] ata: libahci: allow to use multiple PHYs
Date: Tue, 8 Jul 2014 19:03:53 +0200
Message-ID: <20140708170353.GA16148@kwain>
References: <1404728173-20263-1-git-send-email-antoine.tenart@free-electrons.com>
 <1404728173-20263-4-git-send-email-antoine.tenart@free-electrons.com>
 <20140708134000.GC4979@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140708134000.GC4979-Gd/HAXX7CRxy/B6EtB590w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tejun Heo <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Antoine =?iso-8859-1?Q?T=E9nart?= <antoine.tenart-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, sebastian.hesselbarth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, kishon-l0cyMroinI0@public.gmane.org, alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, zmxu-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org, jszhang-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Id: linux-ide@vger.kernel.org

Hello,

On Tue, Jul 08, 2014 at 09:40:00AM -0400, Tejun Heo wrote:
> (Cc'ing Hans.)
>=20
> On Mon, Jul 07, 2014 at 12:16:09PM +0200, Antoine T=E9nart wrote:
> > @@ -482,6 +482,13 @@ void ahci_save_initial_config(struct device *d=
ev,
> >  		port_map &=3D mask_port_map;
> >  	}
> > =20
> > +	/*
> > +	 * If port_map was filled automatically when finding port sub-nod=
es,
> > +	 * make sure we get the right set here.
> > +	 */
> > +	if (hpriv->port_map)
> > +		port_map &=3D hpriv->port_map;
> > +
>=20
> So, hpriv->port is both input and output?  This is messy and can lead
> to confusing failures and there now are multiple ways to modify
> port_map.  If carrying this information through ahci_host_priv is
> necessary, let's remove the direct params and introduce new input
> fields to the struct.

We just use hpriv->port_map to check port_map is valid and describes
available ports there.

hpriv->port_map is filed by the generic ahci_platform_get_resources()
function when using the new bindings and not by the drivers. port_map i=
s
the input from the drivers.

>=20
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
> > +	for (i =3D 0; i < hpriv->nphys; i++) {
> > +		rc =3D phy_init(hpriv->phys[i]);
> > +		if (rc)
> > +			goto disable_phys;
> > +
> > +		rc =3D phy_power_on(hpriv->phys[i]);
> > +		if (rc) {
> > +			phy_exit(hpriv->phys[i]);
> > +			goto disable_phys;
> > +		}
> > +	}
> > +
> > +	return 0;
> > +
> > +disable_phys:
> > +	while (--i >=3D 0) {
> > +		phy_power_off(hpriv->phys[i]);
> > +		phy_exit(hpriv->phys[i]);
> > +	}
> > +	return rc;
> > +}
> > +EXPORT_SYMBOL_GPL(ahci_platform_enable_phys);
>=20
> Do we need to make hpriv->phys[] dynamically allocated?  We already
> have hpriv->clks[AHCI_MAX_CLKS] and it's unlikely that we're gonna
> need more than several phys per host.  Let's go with a simpler fixed
> array.
>=20

Well, a had a review a week ago about in the PHY driver saying I should
avoid using fixed sized arrays... And it was in a driver were we know
the maximum number of PHY available.

I think in this case were the number of PHYs depends on the h/w, we sho=
uld
use a dynamically allocated array.


Antoine

--=20
Antoine T=E9nart, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
