From: Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH 2/3] ARM: sunxi: Add an ahci-platform
 compatible AHCI driver for the Allwinner SUNXi series of SoCs
Date: Fri, 6 Dec 2013 10:18:56 +0100
Message-ID: <20131206101856.1864849d@skate>
References: <1386159055-10264-1-git-send-email-oliver@schinagl.nl>
	<1386159055-10264-3-git-send-email-oliver@schinagl.nl>
	<20131204123708.GD3158@htj.dyndns.org>
	<529F2677.3070208@schinagl.nl>
	<20131204131402.GG3158@htj.dyndns.org>
	<529F2B41.8090009@schinagl.nl>
	<20131204132312.GH3158@htj.dyndns.org>
	<20131206100117.59609a8a@skate>
	<52A19502.1090409@schinagl.nl>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sunxi+bncBDUK5F6TRYOBBEVNQ2KQKGQEJSH6QSQ-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <52A19502.1090409-dxLnbx3+1qmEVqv0pETR8A@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: Oliver Schinagl <oliver-dxLnbx3+1qmEVqv0pETR8A@public.gmane.org>
Cc: Tejun Heo <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Olliver Schinagl <oliver+list-dxLnbx3+1qmEVqv0pETR8A@public.gmane.org>, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, "rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org" <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dev-3kdeTeqwOZ9EV1b7eY7vFQ@public.gmane.org, maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, ijc-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, Richard Zhu <r65037-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-ide@vger.kernel.org

Dear Oliver Schinagl,

On Fri, 06 Dec 2013 10:12:34 +0100, Oliver Schinagl wrote:

> >  From my point of view, ahci_platform should be turned into a small
> > "library", that provides an API for ahci_<foo> drivers to 1/ do their
> > own custom stuff and 2/ do the common ahci_platform stuff.
> >
> > This way we avoid the registration of two platform_device for the same
> > piece of hardware, and we avoid the duplication of code.
> >
> > Want me to propose a RFC for this idea?
> I've started to do what sdhci does with their pltfrm driver, assuming 
> that's the right approach. Since i'm only dabbling and not always 100% 
> sure what should or shouldn't be done, it may take a little while, but 
> looks promising from my end ;)

Yes, the approach of shdci_pltfrm is exactly the one I was proposing
here, so it definitely looks like the right direction to me (though my
opinion is not authoritative at all in this area, obviously).

> So is the sdhci-pltfrm approach the correct one? We still have ahci_* 
> drivers, but ahci_platform.c won't be a driver in the sense that it is 
> now anymore.

Yes, seems good. We will still need ahci_<foo> for the various SoC
families, because depending on the SoC, you have different things to do
(take various clocks, or do other SoC-specific configuration). As an
example, the main thing I have to do on the SoC I'm working with is
configuring some memory windows that allow the SATA controller to do
DMA to the DRAM. This configuration is inherently completely specific
to this SoC family, and it wouldn't make sense to have that in an
ahci_platform driver shared by all platforms.

Oliver, can you Cc me on your future patches about this topic, so that
I can test them in the context of the SoC I'm working on?

Thanks!

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
