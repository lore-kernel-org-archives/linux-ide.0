From: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Subject: Re: [PATCH v2 2/4] ARM: sunxi: Add ahci-sunxi driver
 for the Allwinner SUNXi SoCs sata
Date: Sat, 04 Jan 2014 22:47:08 +0100
Message-ID: <3250214.yUrU0CPosZ@wuerfel>
References: <1388826878-5602-1-git-send-email-hdegoede@redhat.com> <1388826878-5602-3-git-send-email-hdegoede@redhat.com> <4502242.kKUgLAVDcb@wuerfel>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sunxi+bncBDEKVJM7XAHRBZMCUKLAKGQEVOLJSCI-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <4502242.kKUgLAVDcb@wuerfel>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Tejun Heo <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Oliver Schinagl <oliver+list-dxLnbx3+1qmEVqv0pETR8A@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Oliver Schinagl <oliver-dxLnbx3+1qmEVqv0pETR8A@public.gmane.org>, linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
List-Id: linux-ide@vger.kernel.org

On Saturday 04 January 2014 22:39:50 Arnd Bergmann wrote:
> > +Required properties:
> > +- compatible : compatible list, contains "allwinner,sun4i-a10-ahci"
> > +- reg                : <registers mapping>
> > +- interrupts : <interrupt mapping for AHCI IRQ>
> > +- clocks     : clocks for ACHI
> > +- clock-names        : clock names for AHCI
> 
> The binding needs to specify the required names for the clocks.

fwiw, the imx driver uses "ahb" and "sata_ref" as the clock names.
I would strongly suggest using the same names here, and documenting
them in the ahci binding as optional.

	Arnd
