From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v6 00/18] ahci: library-ise ahci_platform, add sunxi
 driver and cleanup imx driver
Date: Wed, 19 Feb 2014 12:42:03 -0500
Message-ID: <20140219174203.GM10134@htj.dyndns.org>
References: <1392811320-3132-1-git-send-email-hdegoede@redhat.com>
 <20140219150249.GG10134@htj.dyndns.org>
 <5304CD33.1080704@redhat.com>
 <20140219162511.GJ10134@htj.dyndns.org>
 <5304E751.5040608@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qg0-f51.google.com ([209.85.192.51]:44400 "EHLO
	mail-qg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754111AbaBSRmI (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 19 Feb 2014 12:42:08 -0500
Content-Disposition: inline
In-Reply-To: <5304E751.5040608@redhat.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Maxime Ripard <maxime.ripard@free-electrons.com>, Oliver Schinagl <oliver@schinagl.nl>, Richard Zhu <Hong-Xing.Zhu@freescale.com>, Roger Quadros <rogerq@ti.com>, Lee Jones <lee.jones@linaro.org>, linux-ide@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree <devicetree@vger.kernel.org>, linux-sunxi@googlegroups.com

On Wed, Feb 19, 2014 at 06:18:09PM +0100, Hans de Goede wrote:
> Most of the resources are already devres managed (I use devm functions
> to get them), the problem is not in freeing our reference to the resources,
> the problem is that we've sequences like this:
> 
> devm_get_foo
> enable_foo
> disable_foo
> (automatic release foo)
> 
> Where enable / disable can be done repeatedly (ie each suspend / resume).
> 
> From your review comments, I take it that you want the final disable_foo
> on driver release to happen automatically.
> 
> My preference for this would be to extend the devres tracking already present
> in the relevant subsystems to keep track of the enable count done through a
> specific reference, to allow automatic disable (if needed) on release.
> 
> But thinking more about this, I think that doing this automatically is a bad
> idea, because then we fixate the shutdown sequence to a certain order (the
> order in which we did the _get_foo for the resources) and the correct order may
> be device specific.
> 
> So TL;DR: Yes to making things so that ahci_platform_put_resources gets done
> automatically, no to automating the disable calls.
> 
> If I don't hear back from you, then I'll respin the patch-set assuming that
> you agree to the above.

Yeah, sounds good enough to me.

Thanks.

-- 
tejun
