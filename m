From: Oliver Schinagl <oliver-dxLnbx3+1qmEVqv0pETR8A@public.gmane.org>
Subject: Re: [PATCH 2/3] ARM: sunxi: Add an ahci-platform
 compatible AHCI driver for the Allwinner SUNXi series of SoCs
Date: Fri, 06 Dec 2013 10:12:34 +0100
Message-ID: <52A19502.1090409@schinagl.nl>
References: <1386159055-10264-1-git-send-email-oliver@schinagl.nl> <1386159055-10264-3-git-send-email-oliver@schinagl.nl> <20131204123708.GD3158@htj.dyndns.org> <529F2677.3070208@schinagl.nl> <20131204131402.GG3158@htj.dyndns.org> <529F2B41.8090009@schinagl.nl> <20131204132312.GH3158@htj.dyndns.org> <20131206100117.59609a8a@skate>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Return-path: <linux-sunxi+bncBDC2JNWXZAJBBY5KQ2KQKGQENOVH2FQ-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <20131206100117.59609a8a@skate>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: Tejun Heo <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Olliver Schinagl <oliver+list-dxLnbx3+1qmEVqv0pETR8A@public.gmane.org>, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, "rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org" <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dev-3kdeTeqwOZ9EV1b7eY7vFQ@public.gmane.org, maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, ijc-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, Richard Zhu <r65037-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-ide@vger.kernel.org


On 06-12-13 10:01, Thomas Petazzoni wrote:
> Dear Tejun Heo,
>
> On Wed, 4 Dec 2013 08:23:12 -0500, Tejun Heo wrote:
>
>>> But again, point me (for dummies ;) in the right direction and I'll
>>> work on it with some help.
>> Richard and Shawn recently worked on ahci_imx.  Can you guys please
>> talk with each other and figure out what can be done to share as much
>> as possible among these new platform-specific drivers?  I'd really
>> like to see the common things factored out as much as possible with
>> only the actual hardware differences described for each device.
> Also, please Cc me on such discussions. I have a pending AHCI platform
> driver for another ARM SoC family. It is very similar to ahci_platform,
> but needs to do a few more things that are SoC specific (map an
> additional register area, and do some SoC-specific stuff with them).
>
> For the moment, we're left with two approaches:
>
>   * Do what Oliver did, where the ahci_<foo> driver will do its own
>     SoC-specific stuff, and then will register an additional
>     platform_device to trigger the ->probe() of the generic
>     ahci_platform driver. I must say I don't really like this solution,
>     since it involves having two platform_device registered for the same
>     piece of hardware (one platform_device to trigger the ->probe of
>     ahci_<foo>, and another one to trigger the ->probe of ahci_platform).
>
>   * Duplicate in ahci_<foo> the (relatively small) amount of code that
>     is present in ahci_platform.
>
>  From my point of view, ahci_platform should be turned into a small
> "library", that provides an API for ahci_<foo> drivers to 1/ do their
> own custom stuff and 2/ do the common ahci_platform stuff.
>
> This way we avoid the registration of two platform_device for the same
> piece of hardware, and we avoid the duplication of code.
>
> Want me to propose a RFC for this idea?
I've started to do what sdhci does with their pltfrm driver, assuming 
that's the right approach. Since i'm only dabbling and not always 100% 
sure what should or shouldn't be done, it may take a little while, but 
looks promising from my end ;)

So is the sdhci-pltfrm approach the correct one? We still have ahci_* 
drivers, but ahci_platform.c won't be a driver in the sense that it is 
now anymore.

Oliver
>
> Best regards,
>
> Thomas
