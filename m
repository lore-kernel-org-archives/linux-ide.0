From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] pata-generic/of: Make probing via device tree
	non-powerpc-specific
Date: Fri, 16 Sep 2011 22:43:13 +0100
Message-ID: <20110916214313.GB16381@n2100.arm.linux.org.uk>
References: <1316183890-13677-1-git-send-email-dave.martin@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:45567 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932274Ab1IPVnj (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 16 Sep 2011 17:43:39 -0400
Content-Disposition: inline
In-Reply-To: <1316183890-13677-1-git-send-email-dave.martin@linaro.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Dave Martin <dave.martin@linaro.org>
Cc: devicetree-discuss@lists.ozlabs.org, Grant Likely <grant.likely@secretlab.ca>, linux-ide@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>, linux-arm-kernel@lists.infradead.org, patches@linaro.org

On Fri, Sep 16, 2011 at 03:38:10PM +0100, Dave Martin wrote:
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
> 
> Tested on ARM Versatile Express, with my soon-to-be-posted device
> tree support patches.

This may not be the correct way to support the CF slot on Versatile
Express - it depends whether the CF slot on VE supports just CF
memory cards or whether it can take any CF card.

If the latter, then what may be inserted could be a CF network card,
and that means it's probably wrong to tell the kernel that what's
there is a PATA interface.
