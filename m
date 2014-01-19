From: Tejun Heo <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [RFC v3 03/13] ahci-platform: Fix clk
 enable/disable unbalance on suspend/resume
Date: Sun, 19 Jan 2014 06:14:12 -0500
Message-ID: <20140119111412.GA11123@htj.dyndns.org>
References: <1390088935-7193-1-git-send-email-hdegoede@redhat.com>
 <1390088935-7193-4-git-send-email-hdegoede@redhat.com>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sunxi+bncBDQ2FCEAWYLRBB7H52LAKGQEUKREQWQ-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <1390088935-7193-4-git-send-email-hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Content-Disposition: inline
To: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Oliver Schinagl <oliver-dxLnbx3+1qmEVqv0pETR8A@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Richard Zhu <Hong-Xing.Zhu-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: linux-ide@vger.kernel.org

On Sun, Jan 19, 2014 at 12:48:45AM +0100, Hans de Goede wrote:
> For devices where ahci_platform_data provides suspend() there is an unbalance
> in clk enable/disable calls. The suspend path does not disable the clk, but
> the resume path enables it. This commit fixes it by always disabling the clk
> in the suspend path independent of there being an ahci_platform_data suspend
> method.
> 
> On all drivers currently using a suspend method, the suspend method always
> succeeds, so change its return type to void, to avoid having the introduce
> somewhat complex error handling paths.
> 
> The disabling of the clock on suspend is a functional change, to ensure this
> is ok I've audited all drivers using ahci_platform_data:
> 
> arch/arm/mach-davinci/devices-da8xx.c: Does not use a suspend method
> arch/arm/mach-spear/spear1340.c: Does not use the clock framework
> drivers/ata/ahci_imx.c: Does have suspend and resume pdata methods, these
> disable / enable another clock, so likely it is ok to disable / enable the
> clock at of-node index 0 as well, I've ordered a wandboard to be able to
> test these changes.

This isn't your fault but similarly to the previous patch, I'd much
prefer if drivers which need custom ops just override the whole
operation and are allowed to use the default platform from their
custom implementations as they see fit.  Allowing partial overrides
seems like an efficient thing to do at the beginning but if you
continue to stack them, you eventually end up with giant pile of
methods where figuring out which code paths are actually executed
takes quite a bit of effort.  I'd really like to avoid that.

Thanks.

-- 
tejun
