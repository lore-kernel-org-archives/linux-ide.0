From: Maxime Ripard <maxime.ripard-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH v4 12/13] ARM: dts: sun4i: a10: add
 sata-port/sata-phy nodes
Date: Fri, 31 Aug 2018 12:21:10 +0200
Message-ID: <20180831102110.pskz6jy47elwxguw@flea>
References: <20180830190120.722-1-clabbe.montjoie@gmail.com>
 <20180830190120.722-13-clabbe.montjoie@gmail.com>
 <20180831073724.kuw5tb6yypb4pmkp@flea>
 <20180831075350.GA16301@Red>
Reply-To: maxime.ripard-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="lbw4hb77urw3z3wt"
Return-path: <linux-sunxi+bncBDSJBYGBRIMBBF5NUTOAKGQENCIVMIQ-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Content-Disposition: inline
In-Reply-To: <20180831075350.GA16301@Red>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Corentin Labbe <clabbe.montjoie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: axboe-tSWWG44O7X1aa/9Udqfwiw@public.gmane.org, hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, kishon-l0cyMroinI0@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, wens-jdAy2FN1RRM@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: linux-ide@vger.kernel.org


--lbw4hb77urw3z3wt
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline

On Fri, Aug 31, 2018 at 09:53:50AM +0200, Corentin Labbe wrote:
> On Fri, Aug 31, 2018 at 09:37:24AM +0200, Maxime Ripard wrote:
> > On Thu, Aug 30, 2018 at 09:01:19PM +0200, Corentin Labbe wrote:
> > > This patch convert sun4i-a10 sata to the new binding which use a sata
> > > phy node.
> > > 
> > > Signed-off-by: Corentin Labbe <clabbe.montjoie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> > > ---
> > >  arch/arm/boot/dts/sun4i-a10.dtsi | 13 +++++++++++++
> > >  1 file changed, 13 insertions(+)
> > > 
> > > diff --git a/arch/arm/boot/dts/sun4i-a10.dtsi b/arch/arm/boot/dts/sun4i-a10.dtsi
> > > index 3d62a8950720..52d5c2e79499 100644
> > > --- a/arch/arm/boot/dts/sun4i-a10.dtsi
> > > +++ b/arch/arm/boot/dts/sun4i-a10.dtsi
> > > @@ -556,7 +556,20 @@
> > >  			reg = <0x01c18000 0x1000>;
> > >  			interrupts = <56>;
> > >  			clocks = <&ccu CLK_AHB_SATA>, <&ccu CLK_SATA>;
> > > +			#address-cells = <1>;
> > > +			#size-cells = <0>;
> > >  			status = "disabled";
> > > +
> > > +			sata_port: sata-port@0 {
> > > +				reg = <0>;
> > > +				phys = <&sata_phy>;
> > > +			};
> > > +		};
> > > +
> > > +		sata_phy: sata_phy@1c180c0 {
> > > +			compatible = "allwinner,sun4i-a10-sata-phy";
> > > +			reg = <0x01c180c0 0x200>;
> > > +			#phy-cells = <0>;
> > >  		};
> > 
> > This patch, together with the following one, breaks the DT ABI, this
> > isn't something we can do anymore.
> 
> So what can I do ?

Well, you always have the option of not doing anything.

Maxime

-- 
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
--lbw4hb77urw3z3wt--
