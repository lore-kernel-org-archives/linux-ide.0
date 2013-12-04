From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 2/3] ARM: sunxi: Add an ahci-platform compatible AHCI
 driver for the Allwinner SUNXi series of SoCs
Date: Wed, 4 Dec 2013 07:37:08 -0500
Message-ID: <20131204123708.GD3158@htj.dyndns.org>
References: <1386159055-10264-1-git-send-email-oliver@schinagl.nl>
 <1386159055-10264-3-git-send-email-oliver@schinagl.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qe0-f43.google.com ([209.85.128.43]:40848 "EHLO
	mail-qe0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755348Ab3LDMhM (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 4 Dec 2013 07:37:12 -0500
Content-Disposition: inline
In-Reply-To: <1386159055-10264-3-git-send-email-oliver@schinagl.nl>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: oliver@schinagl.nl
Cc: grant.likely@linaro.org, ob.herring@calxeda.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, dev@linux-sunxi.org, maxime.ripard@free-electrons.com, ijc@hellion.org.uk, hdegoede@redhat.com, oliver+list@schinagl.nl

On Wed, Dec 04, 2013 at 01:10:54PM +0100, oliver@schinagl.nl wrote:
> From: Oliver Schinagl <oliver@schinagl.nl>
> 
> This patch adds support for the sunxi series of SoC's by allwinner. It
> plugs into the ahci-platform framework.
> 
> Note: Currently it uses a somewhat hackish approach that probably needs
> a lot more work, but does the same as the IMX SoC's.
> 
> Signed-off-by: Olliver Schinagl <oliver@schinagl.nl>
> ---
>  .../devicetree/bindings/ata/ahci-sunxi.txt         |  24 ++
>  drivers/ata/Kconfig                                |   9 +
>  drivers/ata/Makefile                               |   1 +
>  drivers/ata/ahci_platform.c                        |  12 +
>  drivers/ata/ahci_sunxi.c                           | 305 +++++++++++++++++++++

I'm not really liking the way things are going.  Do we really need
separate drivers for each platform ahci implementation.  Are they
really that different?  Would it be impossible to make ahci_platform
generic enough so that we don't eventually end up with a gazillion
ahci_XXX drivers?

-- 
tejun
