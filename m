From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: Re: [PATCH 1/4] ata: ahci_mvebu: new driver for Marvell Armada 380
 AHCI interfaces
Date: Mon, 7 Apr 2014 17:50:54 +0200
Message-ID: <20140407175054.3f57265b@skate>
References: <1396882664-19297-1-git-send-email-thomas.petazzoni@free-electrons.com>
	<1396882664-19297-2-git-send-email-thomas.petazzoni@free-electrons.com>
	<20140407151823.GG18785@lunn.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:48710 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751946AbaDGPu6 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 7 Apr 2014 11:50:58 -0400
In-Reply-To: <20140407151823.GG18785@lunn.ch>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrew Lunn <andrew@lunn.ch>
Cc: Tejun Heo <tj@kernel.org>, Jason Cooper <jason@lakedaemon.net>, Gregory Clement <gregory.clement@free-electrons.com>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, Lior Amsalem <alior@marvell.com>, Tawfik Bayouk <tawfik@marvell.com>, linux-arm-kernel@lists.infradead.org, linux-ide@vger.kernel.org

Dear Andrew Lunn,

On Mon, 7 Apr 2014 17:18:23 +0200, Andrew Lunn wrote:

> > diff --git a/Documentation/devicetree/bindings/ata/ahci-platform.txt b/Documentation/devicetree/bindings/ata/ahci-platform.txt
> > index 48b285f..271746d 100644
> > --- a/Documentation/devicetree/bindings/ata/ahci-platform.txt
> > +++ b/Documentation/devicetree/bindings/ata/ahci-platform.txt
> > @@ -7,7 +7,8 @@ Required properties:
> >  - compatible        : compatible list, one of "snps,spear-ahci",
> >                        "snps,exynos5440-ahci", "ibm,476gtr-ahci",
> >                        "allwinner,sun4i-a10-ahci", "fsl,imx53-ahci"
> > -                      "fsl,imx6q-ahci" or "snps,dwc-ahci"
> > +                      "fsl,imx6q-ahci", "snps,dwc-ahci" or
> > +                      "marvell,armada-380-ahci"
> 
> Hi Thomas
> 
> Since this list is growing, maybe now would be a good time to sort it
> alphabetically?

Ok. I guess this would have to be a separate patch, preliminary to the
introduction of the ahci_mvebu driver.

> > +	dram = mv_mbus_dram_info();
> > +	if (dram)
> > +		ahci_mvebu_mbus_config(hpriv, dram);
> 
> I know this is a common model for mv_sata, which has to deal with
> devices without dram, but can 38x also work without dram? Or should
> missing dram be considered fatal to the probe?

Indeed in the current situation, dram should never be NULL, so the code
could even be:

	ahci_mvebu_mbus_config(hpriv, mv_mbus_dram_info());

Will fix for v2.

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
