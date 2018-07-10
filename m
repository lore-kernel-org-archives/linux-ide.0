From: Maxime Ripard <maxime.ripard-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH v2 0/4] sun8i: r40: add AHCI
Date: Tue, 10 Jul 2018 14:29:22 +0200
Message-ID: <20180710122922.6sgmgfislqwhn3tt@flea>
References: <1531149658-27030-1-git-send-email-clabbe@baylibre.com>
Reply-To: maxime.ripard-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="vm7covlgenulwjwo"
Return-path: <linux-sunxi+bncBDSJBYGBRIMBBLONSLNAKGQEI5KXCHY-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Content-Disposition: inline
In-Reply-To: <1531149658-27030-1-git-send-email-clabbe-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Corentin Labbe <clabbe-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Cc: linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, wens-jdAy2FN1RRM@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, icenowy-h8G6r0blFSE@public.gmane.org
List-Id: linux-ide@vger.kernel.org


--vm7covlgenulwjwo
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline

On Mon, Jul 09, 2018 at 03:20:54PM +0000, Corentin Labbe wrote:
> Hello
> 
> With Moeicenowy's agreement, I have take leadership ot this patchset.
> 
> There are no really changes appart renaming struct quirck to variant.
> 
> Since the last serie is really old, I will answer comment here.
> The two regulator (1.2 and 2.5V) are not for the PHY since:
> - nothing in the schematic said that they are for the PHY, they seems
>   only for controller
> - all other AHCI driver use 5V for the target/PHY (vs 1.2/2.5 which
>   cannot be used for target)

That's a pretty bad thing to do, especially for old series. You just
dropped all the context that you reply to, and there's no way for any
reviewer to tell if your answers make any kind of sense, or addresses
any question one might have had.

> Furthermore, the AHCI binding support only one regulator per PHY, so
> using the "target" regulator is out of question for registring this two
> non-phy regulator.

Nothing is "out of question", we have the source code and can change
it if needed.

Maxime

-- 
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
--vm7covlgenulwjwo--
