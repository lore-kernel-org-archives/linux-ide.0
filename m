From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH RFC] pata_platform: add 8 bit data io support
Date: Sun, 12 Oct 2008 09:21:27 +1100
Message-ID: <1223763687.8157.178.camel@pasglop>
References: <20081011180014.GA4908@debian>
Reply-To: benh@kernel.crashing.org
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:47761 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750794AbYJKWVo (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 11 Oct 2008 18:21:44 -0400
In-Reply-To: <20081011180014.GA4908@debian>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Wang Jian <lark@linux.net.cn>
Cc: linuxppc-dev@ozlabs.org, linux-ide@vger.kernel.org, Tejun Heo <htejun@gmail.com>

On Sun, 2008-10-12 at 02:00 +0800, Wang Jian wrote:
> To avoid adding another rare used ata_port member, new bit is added to
> ata_port->flags.
> 
> Originally, I hacked pata_platform to make it 8bit only to support 8bit
> data wired CF card. This patch is more generic.
> 
> With this patch, __pata_platform_probe() interface is changed, and
> pata_of_platform is broken, so a small patch is needed.
> 
> Signed-off-by: Wang Jian <lark@linux.net.cn>
> ---

A couple of things. First I would personally prefer (but I'm not the
libata maintainer so it's up to Jeff ...) if you had a separate patch
that adds the 8-bit support to libata core first, and then a patch that
modifies pata_platform.

Then, in order to avoid breaking bisection, I would like you to fixup
pata_of_platform in the same patch that modifies __pata_platform_probe
so there is no breakage in between patches.

Now, regarding the patch itself, if the core grows a 8-bit flag, then
I strongly suspect the core should also grow the 8-bit xfer function
rather than having it hidden in pata_platform.

Cheers,
Ben.


