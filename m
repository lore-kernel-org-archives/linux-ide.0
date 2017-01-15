From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 04/10] sata: hardreset: retry if phys link is down
Date: Sun, 15 Jan 2017 18:10:49 -0500
Message-ID: <20170115231049.GC14446@mtj.duckdns.org>
References: <1484311084-31547-1-git-send-email-bgolaszewski@baylibre.com>
 <1484311084-31547-5-git-send-email-bgolaszewski@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-io0-f193.google.com ([209.85.223.193]:35801 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751087AbdAOXK5 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sun, 15 Jan 2017 18:10:57 -0500
Content-Disposition: inline
In-Reply-To: <1484311084-31547-5-git-send-email-bgolaszewski@baylibre.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc: Kevin Hilman <khilman@kernel.org>, Sekhar Nori <nsekhar@ti.com>, Patrick Titiano <ptitiano@baylibre.com>, Michael Turquette <mturquette@baylibre.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Russell King <linux@armlinux.org.uk>, David Lechner <david@lechnology.com>, linux-ide@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hello,

On Fri, Jan 13, 2017 at 01:37:58PM +0100, Bartosz Golaszewski wrote:
> The sata core driver already retries to resume the link because some
> controllers ignore writes to the SControl register.
> 
> We have a use case with the da850 SATA controller where at PLL0
> frequency of 456MHz (needed to properly service the LCD controller)
> the chip becomes unstable and the hardreset operation is ignored the
> first time 50% of times.
> 
> Retrying just the resume operation doesn't work - we need to issue
> the phy/wake reset again to make it work.
> 
> If ata_phys_link_offline() returns true in sata_link_hardreset(),
> retry a couple times before really giving up.

I think it'd be better to implement the driver specific implementation
rather than changing the behavior for everybody.

Thanks.

-- 
tejun
