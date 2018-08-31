From: Maxime Ripard <maxime.ripard-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH v4 00/13] ata: ahci_platform: support
 allwinner R40 AHCI
Date: Fri, 31 Aug 2018 09:40:24 +0200
Message-ID: <20180831074024.w7yicj5y4imy57e2@flea>
References: <20180830190120.722-1-clabbe.montjoie@gmail.com>
 <f5838eae-fa6c-8699-14a4-95d0daa8a960@kernel.dk>
 <CAGb2v67miUjqeKeDh_E_XPee_0Hq1C6YrfXxsOp_=NtQY+LLmQ@mail.gmail.com>
 <8fa866c5-6800-505f-53bc-5c1b27582ca6@kernel.dk>
Reply-To: maxime.ripard-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="iiupw3y5uuqzr6al"
Return-path: <linux-sunxi+bncBDSJBYGBRIMBB2XBUPOAKGQELPU2KII-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Content-Disposition: inline
In-Reply-To: <8fa866c5-6800-505f-53bc-5c1b27582ca6-tSWWG44O7X1aa/9Udqfwiw@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Jens Axboe <axboe-tSWWG44O7X1aa/9Udqfwiw@public.gmane.org>
Cc: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, LABBE Corentin <clabbe.montjoie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-sunxi <linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Id: linux-ide@vger.kernel.org


--iiupw3y5uuqzr6al
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline

Hi Jens,

On Thu, Aug 30, 2018 at 08:52:52PM -0600, Jens Axboe wrote:
> On 8/30/18 8:32 PM, Chen-Yu Tsai wrote:
> > Hi,
> > 
> > On Fri, Aug 31, 2018 at 4:31 AM Jens Axboe <axboe-tSWWG44O7X1aa/9Udqfwiw@public.gmane.org> wrote:
> >>
> >> On 8/30/18 1:01 PM, Corentin Labbe wrote:
> >>> Hello
> >>>
> >>> This patchset add support for allwinner R40 AHCI controller.
> >>>
> >>> The whole patchset is tested on sun8i-r40-bananapi-m2-ultra and
> >>> on sun7i-a20-cubieboard2 which doesnt have any of the ressources added
> >>> by this serie, so no regression should come with it.
> >>>
> >>> The last patch(ata: ahci_sunxi: remove PHY code) should not be merged,
> >>> but will be resent for inclustion when all patchs will have hit linus
> >>> tree.
> >>
> >> Applied 1-12 with Hans's blessing, thanks Corentin.
> > 
> > Please don't merge device tree ("dts") patches, i.e. patches 9-12. We will
> > merge them through the sunxi / armsoc tree. Having them in separate trees
> > introduces conflicts when we have other stuff going through our tree.
> 
> OK, fair enough, I can drop those.

And the DT bits actually have some issues that would need to change
the code significantly.

Can you drop all of them please?

Thanks!
Maxmie

-- 
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
--iiupw3y5uuqzr6al--
