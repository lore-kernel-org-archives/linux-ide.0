From: Tejun Heo <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v6 07/18] ahci-platform: "Library-ise"
 ahci_probe functionality
Date: Wed, 19 Feb 2014 09:58:39 -0500
Message-ID: <20140219145839.GF10134@htj.dyndns.org>
References: <1392811320-3132-1-git-send-email-hdegoede@redhat.com>
 <1392811320-3132-8-git-send-email-hdegoede@redhat.com>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sunxi+bncBDQ2FCEAWYLRBIUNSOMAKGQEBSQL5PA-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <1392811320-3132-8-git-send-email-hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Content-Disposition: inline
To: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Oliver Schinagl <oliver-dxLnbx3+1qmEVqv0pETR8A@public.gmane.org>, Richard Zhu <Hong-Xing.Zhu-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: linux-ide@vger.kernel.org

On Wed, Feb 19, 2014 at 01:01:49PM +0100, Hans de Goede wrote:
> ahci_probe consists of 3 steps:
> 1) Get resources (get mmio, clks, regulator)
> 2) Enable resources, handled by ahci_platform_enable_resouces
> 3) The more or less standard ahci-host controller init sequence
> 
> This commit refactors step 1 and 3 into separate functions, so the platform
> drivers for AHCI implementations which need a specific order in step 2,
> and / or need to do some custom register poking at some time, can re-use
> ahci-platform.c code without needing to copy and paste it.
> 
> Note that ahci_platform_init_host's prototype takes the 3 non function
> members of ahci_platform_data as arguments, the idea is that drivers using
> the new exported utility functions will not use ahci_platform_data at all,
> and hopefully in the future ahci_platform_data can go away entirely.
> 
> Signed-off-by: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

Heh, the lack of comments is getting kinda impressive. :)

Thanks.

-- 
tejun
