From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH 2/3] ARM: sunxi: Add an ahci-platform compatible AHCI
 driver for the Allwinner SUNXi series of SoCs
Date: Thu, 12 Dec 2013 14:40:27 +0800
Message-ID: <20131212064025.GM18380@S2101-09.ap.freescale.net>
References: <1386159055-10264-1-git-send-email-oliver@schinagl.nl>
 <1386159055-10264-3-git-send-email-oliver@schinagl.nl>
 <20131204123708.GD3158@htj.dyndns.org>
 <529F2677.3070208@schinagl.nl>
 <20131204131402.GG3158@htj.dyndns.org>
 <529F2B41.8090009@schinagl.nl>
 <20131204132312.GH3158@htj.dyndns.org>
 <52A87C07.1020102@schinagl.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from tx2ehsobe001.messaging.microsoft.com ([65.55.88.11]:33097 "EHLO
	tx2outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751198Ab3LLGj7 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 12 Dec 2013 01:39:59 -0500
Content-Disposition: inline
In-Reply-To: <52A87C07.1020102@schinagl.nl>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Olliver Schinagl <oliver@schinagl.nl>
Cc: Tejun Heo <tj@kernel.org>, Olliver Schinagl <oliver+list@schinagl.nl>, grant.likely@linaro.org, "rob.herring@calxeda.com" <rob.herring@calxeda.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, dev@linux-sunxi.org, maxime.ripard@free-electrons.com, ijc@hellion.org.uk, hdegoede@redhat.com, Richard Zhu <r65037@freescale.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

On Wed, Dec 11, 2013 at 03:51:51PM +0100, Olliver Schinagl wrote:
> Working on this and studying the existing
> ahci_platform/shci_platform drivers the last few days and was
> figuring out why ahci_platform only supports 1 clock. IMX handles
> this by having 3 clocks defined in the DT, the first one gets
> enabled by default via ahci_platform, the other 2 get enabled in
> IMX's probe function.
> 
> Is it an idea to extend this to support all clocks that would be
> required (via a callback)?

Not really.  We did this for ahci_imx driver only because we do not want
to churn generic ahci_platform driver with those imx specific setup
code.  Note, beside the additional two clocks, we have some PHY
parameters to set up in IMX IOMUXC general purpose registers, and vendor
specific register HOST_TIMER1MS to be set up as well.

> Or do we prefer having the clocks
> separated for other technical reasons? Or do we want to handle the
> clocks via the ahci_platform framework and extend hpriv->clk to an
> array of clocks?

The direction of the generic ahci platform driver will be having it be
a library providing helper functions, as discussed as below.

https://lkml.org/lkml/2013/12/6/153

We can ask the helper function to handle the common clocks and leave the
platform specific ones to platform driver.

Shawn

