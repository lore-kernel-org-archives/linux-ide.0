From: Tejun Heo <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [RFC v3 08/13] ahci-platform: Allow specifying
 platform_data through of_device_id
Date: Sun, 19 Jan 2014 08:19:10 -0500
Message-ID: <20140119131910.GF11123@htj.dyndns.org>
References: <1390088935-7193-1-git-send-email-hdegoede@redhat.com>
 <1390088935-7193-9-git-send-email-hdegoede@redhat.com>
 <20140119113838.GE11123@htj.dyndns.org>
 <20140119123055.GO15937@n2100.arm.linux.org.uk>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sunxi+bncBDQ2FCEAWYLRBUNB56LAKGQEGKNHIVQ-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <20140119123055.GO15937-l+eeeJia6m9vn6HldHNs0ANdhmdF6hFW@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Content-Disposition: inline
To: Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Cc: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Oliver Schinagl <oliver-dxLnbx3+1qmEVqv0pETR8A@public.gmane.org>, Richard Zhu <Hong-Xing.Zhu-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-ide@vger.kernel.org

On Sun, Jan 19, 2014 at 12:30:55PM +0000, Russell King - ARM Linux wrote:
> I don't see anything wrong with this.  Platform data should _never_ be
> written to, because doing so will change the driver behaviour between
> bindings.  It really should be read-only to driver code.

Hmmm, problems usually arise when const is used to distinguish ro and
rw users.  When it's simple, it seems okay but later on it often ends
up requiring dropping const in almost arbitrary places or forced casts
somewhere random.  Over time, it makes const annotations in the kernel
sparse and inconsistent.  For anything non-trivial, I think it's best
to ignore it.

That said, if the object is actually immutable once initialized, it
shouldn't cause any trouble.  That probably is one of the few proper
use case for const on complex data types.

Thanks.

-- 
tejun
