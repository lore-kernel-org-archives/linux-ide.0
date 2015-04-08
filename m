From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: Re: [PATCH v2 1/9] ata: at91: use syscon to configure the smc
Date: Wed, 8 Apr 2015 13:13:35 +0200
Message-ID: <20150408111335.GZ20669@piout.net>
References: <1427138955-3617-1-git-send-email-alexandre.belloni@free-electrons.com>
 <1427138955-3617-2-git-send-email-alexandre.belloni@free-electrons.com>
 <2936706.hVbBP0ExQQ@amdc1032>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:44462 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752517AbbDHLNj (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 8 Apr 2015 07:13:39 -0400
Content-Disposition: inline
In-Reply-To: <2936706.hVbBP0ExQQ@amdc1032>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: linux-arm-kernel@lists.infradead.org, Nicolas Ferre <nicolas.ferre@atmel.com>, Boris Brezillon <boris.brezillon@free-electrons.com>, linux-pcmcia@lists.infradead.org, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Tejun Heo <tj@kernel.org>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>

Hi,

On 08/04/2015 at 13:04:19 +0200, Bartlomiej Zolnierkiewicz wrote :
> On Monday, March 23, 2015 08:29:07 PM Alexandre Belloni wrote:
> > Use syscon/regmap to configure the smc. This allows to avoid using
> > at91sam9_smc.h and to compile the driver in a multiplatform configuration.
> > 
> > The driver will still not probe until the proper DT bindings are added. That
> > binding will include an atmel,smc property that is a phandle to the SMC the CF
> > controller is connected to.
> 
> If the driver is currently working fine in !ARCH_MULTIPLATFORM
> configuration then this patch will make it non-functional until
> atmel,smc property is added to DT.  To prevent this and preserve
> bisectability the patchset should first add atmel,smc property
> and then convert pata_at91 driver to use it.
> 

Starting with 4.1, it will not be possible to use the driver anyway as
all the platforms using it have switched to multiplatform. This patch
makes it compilable again.

Anyway, it seems that there is little interest in that driver and nobody
I contacted has access to a board which can be used to test this.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
