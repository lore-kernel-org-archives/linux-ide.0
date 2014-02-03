From: Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH RFC v4 00/10] ahci: library-ise
 ahci_platform, add sunxi driver and cleanup imx driver
Date: Mon, 3 Feb 2014 10:31:11 -0600
Message-ID: <CAL_JsqKnus+9rgLAQ990eD-1F6-2G-SuqYuPkmc+Tw6QP1CT4g@mail.gmail.com>
References: <1390236303-22538-1-git-send-email-hdegoede@redhat.com>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sunxi+bncBD62P6P6EQIM7CF7S4CRUBCWSL4EW-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <1390236303-22538-1-git-send-email-hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Tejun Heo <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Oliver Schinagl <oliver-dxLnbx3+1qmEVqv0pETR8A@public.gmane.org>, Richard Zhu <Hong-Xing.Zhu-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
List-Id: linux-ide@vger.kernel.org

On Mon, Jan 20, 2014 at 10:44 AM, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:
> Hi All,
>
> Here is v4 of my patchset for adding ahci-sunxi support. It has grown quite
> a bit since I've been going for a more generic approach this time and I've
> also cleaned up the ahci-imx driver to use the same generic approach.

I don't know if you missed it or just don't intend to refactor all
AHCI drivers, but the highbank driver could benefit from this as well.

Rob

>
> History:
>
> v1, by Olliver Schinagl:
> This was using the approach of having a platform device which probe method
> creates a new child platform device which gets driven by ahci_platform.c,
> as done by ahci_imx.c .
>
> v2, by Hans de Goede:
> Stand-alone platform driver based on Olliver's work
>
> v3, by Hans de Goede:
> patch-series, with 4 different parts
> a) Make ahci_platform.c more generic, handle more then 1 clk, target pwr
>    regulator
> b) New ahci-sunxi code only populating ahci_platform_data, passed to
>    ahci_platform.c to of_device_id matching.
> c) Refactor ahci-imx code to work the same as the new ahci-sunxi code, this
>    is the reason why v3 is an RFC, I'm waiting for the wandboard I ordered to
>    arrive so that I can actually test this.
> d) dts bindings for the sunxi ahci parts
>
> v4, by Hans de Goede:
> patch-series, with 5 different parts:
> a) Make ahci_platform.c more generic, handle more then 1 clk, target pwr
>    regulator
> b) Turn parts of ahci_platform.c into a library for use by other drivers
> c) New ahci-sunxi driver using the ahci_platform.c library functionality
> d) Refactor ahci-imx code to work the same as the new ahci-sunxi code
> e) dts bindings for the sunxi ahci parts
>
> Parts a-d are intended for merging through the ata tree, the dts bindings
> will be merged to Maxime Ripard's sunxi-dts tree.
>
> Regards,
>
> Hans
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
