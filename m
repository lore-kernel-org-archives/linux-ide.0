From: "Y.T. Tang" <yuantian.tang-3arQi8VN3Tc@public.gmane.org>
Subject: RE: [PATCH] ahci: qoriq: added ls2088a platforms support
Date: Fri, 20 Jan 2017 03:05:57 +0000
Message-ID: <DB6PR0402MB283718AD367DBE4E6EEEE31FF0710@DB6PR0402MB2837.eurprd04.prod.outlook.com>
References: <1484633521-10938-1-git-send-email-yuantian.tang@nxp.com>
 <20170118195351.GD9171@mtj.duckdns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170118195351.GD9171-qYNAdHglDFBN0TnZuCh8vA@public.gmane.org>
Content-Language: en-US
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tejun Heo <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: "robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "mark.rutland-5wv7dgnIgG8@public.gmane.org" <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-ide@vger.kernel.org



> -----Original Message-----
> From: Tejun Heo [mailto:htejun-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org] On Behalf Of Tejun Heo
> Sent: Thursday, January 19, 2017 3:54 AM
> To: Y.T. Tang <yuantian.tang-3arQi8VN3Tc@public.gmane.org>
> Cc: robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org; mark.rutland-5wv7dgnIgG8@public.gmane.org; linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org;
> devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-arm-
> kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
> Subject: Re: [PATCH] ahci: qoriq: added ls2088a platforms support
>=20
> On Tue, Jan 17, 2017 at 02:12:01PM +0800, yuantian.tang-3arQi8VN3Tc@public.gmane.org wrote:
> > From: Tang Yuantian <Yuantian.Tang-3arQi8VN3Tc@public.gmane.org>
> >
> > Ls2088a is new introduced arm-based soc with sata support with
> > following features:
> > 1. Complies with the serial ATA 3.0 specification and the AHCI 1.3.1
> >    specification
> > 2. Contains a high-speed descriptor-based DMA controller 3. Supports
> > the following:
> >    a. Speeds of 1.5 Gb/s (first-generation SATA), 3 Gb/s
> >       (second-generation SATA), and 6 Gb/s (third-generation SATA)
> >    b. FIS-based switching
> >    c. Native command queuing (NCQ) commands
> >    d. Port multiplier operation
> >    e. Asynchronous notification
> >    f. SATA BIST mode
> >
> > Signed-off-by: Tang Yuantian <yuantian.tang-3arQi8VN3Tc@public.gmane.org>
>=20
> Reverted due to build failure.  Did you even try to compile it before
> submission?  We all make mistakes and that's fine but this one seems a bi=
t
> too careless.  Please don't do this.
>=20

Sorry for the trouble.
I never send a patch without testing.  This patch depends on other two patc=
hes which I sent a long time ago which I thought they were merged.
Anyway, my mistake.
I will resend all the patches with correct order.

Regards,
Yuantian

> Thanks.
>=20
> --
> tejun
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
