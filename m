From: Tejun Heo <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v6 00/18] ahci: library-ise ahci_platform,
 add sunxi driver and cleanup imx driver
Date: Wed, 19 Feb 2014 11:25:11 -0500
Message-ID: <20140219162511.GJ10134@htj.dyndns.org>
References: <1392811320-3132-1-git-send-email-hdegoede@redhat.com>
 <20140219150249.GG10134@htj.dyndns.org>
 <5304CD33.1080704@redhat.com>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sunxi+bncBDQ2FCEAWYLRB25VSOMAKGQEKKKIZLY-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <5304CD33.1080704-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Content-Disposition: inline
To: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Oliver Schinagl <oliver-dxLnbx3+1qmEVqv0pETR8A@public.gmane.org>, Richard Zhu <Hong-Xing.Zhu-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: linux-ide@vger.kernel.org

Hello, Hans.

On Wed, Feb 19, 2014 at 04:26:43PM +0100, Hans de Goede wrote:
> The devres usage are really 2 different issues:
> 
> 1) There is the issue that we're getting clocks by index (this is by design as
> clk-names are not generic), but there is no devm_get_clk_by_index (or some
> such), this is a shortcoming of the clk-core, which needs a separate patch
> to fix. I would rather not delay this patch-set based on getting a patch
> into another subsys.

Yes, that'd be my usual preference too.  The only reason I'm hesitant
is because nobody seems to be too interested in long term aspect of
the code base and the only leverage I have seems to be rejecting
drivers until things become right.

> Note that even with devm_get_clk_by_index we can unfortunately not get rid of
> ahci_platform_put_resources() as in Roger's follow-up patches it gets used for
> putting some runtime pm related resources too.
> 
> I guess this argues for simply turning ahci_platform_get_resources into a
> devm_ahci_platform_get_resources doing its own devm handling, and then
> making ahci_platform_put_resources a private function called by the devm
> framework. If you agree I can do that for the next patch-set.

Note that libata core already does something similar.  Please take a
look at ata_host_alloc() for details.  You don't really need to create
a separate devm_ prefixed variant.  Just making the function register
devres automatically should be enough.  If this is too much work, I'm
okay with deferring it until later if you promise to do it soonish.

> 2) In some comments you also seem to want devm variants of enable / disable
> resources, or at least have ahci_platform_put_resources do the disable
> automatically. The problem is that most of the functions called here need to
> be balanced, they increment / decrement usage counters in the clk / regulator
> subsystems, so we cannot simply unconditional do an ahci_platform_disable_resources
> in ahci_platform_put_resources
> 
> Doing the disable automatically requires tracking the enable state, and doing this
> per resource, since the whole idea of having a separate ahci_platform_enable_resources
> is that some drivers may want to override its behavior doing things in a different
> order.
> 
> To ensure proper tracking we would then need to offer ahci_platform_enable_regulator,
> etc. functions, and ensure that all drivers using the ahci_platform framework
> always go through these, rather then calling directly into the relevant framework.
> 
> This is all doable, and I'm not against doing this but before spending a couple of
> hours coding this all up, I would like to hear back from you whether you would like
> to see this, or would rather keep things as is.

Yes, in principle, I want every resource used by ahci_platform to be
devres managed.  I *think* devres should be flexible enough to handle
what you're describing (each devres resource can have data for state
tracking and devres resources can be looked up and modified, so the
different orders should be okay) but if not I'd be happy to help
extend it so that it can.

I'm not sure how many more ahci_platform drivers we'll get but the
rate seems pretty high in recent months, so I think it's worthwhile to
provide full devres coverage even if that complicates ahci_platform a
bit if it can simplify leaf drivers.  Again, if you commit to doing it
in the foreseeable future, I'm okay with proceeding as-is, but it
needs to happen one way or another.

Thanks.

-- 
tejun
