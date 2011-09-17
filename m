From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH v2] pata-generic/of: Make probing via device tree
 non-powerpc-specific
Date: Sat, 17 Sep 2011 09:37:32 -0600
Message-ID: <20110917153732.GR3523@ponder.secretlab.ca>
References: <1316183890-13677-1-git-send-email-dave.martin@linaro.org>
 <1316190120-17010-1-git-send-email-dave.martin@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:39328 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753212Ab1IQPhc (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 17 Sep 2011 11:37:32 -0400
Received: by gxk6 with SMTP id 6so2834027gxk.19
        for <linux-ide@vger.kernel.org>; Sat, 17 Sep 2011 08:37:32 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1316190120-17010-1-git-send-email-dave.martin@linaro.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Dave Martin <dave.martin@linaro.org>
Cc: devicetree-discuss@lists.ozlabs.org, linux-ide@vger.kernel.org, patches@linaro.org, Jeff Garzik <jgarzik@pobox.com>, linux-arm-kernel@lists.infradead.org

On Fri, Sep 16, 2011 at 05:22:00PM +0100, Dave Martin wrote:
> This patch enables device-tree-based probing of the pata-generic
> platform driver across all architectures:
> 
>   * make the pata_of_generic module depend on OF instead of PPC_OF;
>   * supply some missing inclues;
>   * replace endianness-sensitive raw access to device tree data
>     with of_property_read_u32() calls.
> 
> Signed-off-by: Dave Martin <dave.martin@linaro.org>
> ---
> v2: correct sense of the check of_property_read_u32(dn, "pio-mode",
> &pio_mode).  Somehow I posted an old version of this patch, depite
> having already fixed this...
> 
> Tested on ARM Versatile Express, with my soon-to-be-posted device
> tree support patches.
> 
> I'm not in a position to build/test this for powerpc easily --
> if anyone is able to do that, it would be appreciated.

What driver is normally used for versatile express pata?  This driver
is kind of legacy in that it was created when there was a split
between platform_device and of_platform_devices.  But that split was a
bad idea and the same driver should be used regardless of whether or
not DT is enabled.  pata_of_platform.c really should be removed.

So, instead of removing the PPC_OF restriction from
pata_of_platform.c, you should look at adding DT support to the
existing binding.  Bonus points if you can roll pata_of_platform.c
support into pata_platform.c (assuming that is the correct driver).

g.

