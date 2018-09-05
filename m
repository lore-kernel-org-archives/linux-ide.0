From: Maxime Ripard <maxime.ripard-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH v5 0/9] ata: ahci_platform: support
 allwinner R40 AHCI
Date: Wed, 5 Sep 2018 09:25:19 +0200
Message-ID: <20180905072519.wx4wgdklinyysad6@flea>
References: <20180903100201.23131-1-clabbe.montjoie@gmail.com>
 <f70d43de-1305-997e-687a-d6e9978e37f5@kernel.dk>
Reply-To: maxime.ripard-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="a6745kah5qjzlfyb"
Return-path: <linux-sunxi+bncBDSJBYGBRIMBB24JX3OAKGQEGECTC6Y-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Content-Disposition: inline
In-Reply-To: <f70d43de-1305-997e-687a-d6e9978e37f5-tSWWG44O7X1aa/9Udqfwiw@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Jens Axboe <axboe-tSWWG44O7X1aa/9Udqfwiw@public.gmane.org>
Cc: Corentin Labbe <clabbe.montjoie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, wens-jdAy2FN1RRM@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: linux-ide@vger.kernel.org


--a6745kah5qjzlfyb
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline

On Mon, Sep 03, 2018 at 08:26:22AM -0600, Jens Axboe wrote:
> On 9/3/18 4:01 AM, Corentin Labbe wrote:
> > This patchset add support for allwinner R40 AHCI controller.
> > 
> > The whole patchset is tested on sun8i-r40-bananapi-m2-ultra and
> > on sun7i-a20-cubieboard2 which doesnt have any of the ressources added
> > by this serie, so no regression should come with it.
> > 
> > Patchs 1-7 should go via the ata tree
> > Patchs 8,9 should go via the sunxi tree
> 
> Applied 1-7 for 4.20, thanks everyone.

Applied 8 and 9, thanks!
Maxime

-- 
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
--a6745kah5qjzlfyb--
