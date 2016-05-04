From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v2 00/23] ata: sata_dwc_460ex: make it working again
Date: Wed, 4 May 2016 15:22:51 +0300
Message-ID: <CAHp75VeeosHAxhXnWY7rc5o969TDyHPRWGdV7kh1_uR+TBa=aA@mail.gmail.com>
References: <1461661404-1952-1-git-send-email-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-oi0-f53.google.com ([209.85.218.53]:36349 "EHLO
	mail-oi0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751423AbcEDMWw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 4 May 2016 08:22:52 -0400
In-Reply-To: <1461661404-1952-1-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, "open list:LINUX FOR POWERPC PA SEMI PWRFICIENT" <linuxppc-dev@lists.ozlabs.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Christian Lamparter <chunkeey@googlemail.com>, =?UTF-8?B?TcOlbnMgUnVsbGfDpXJk?= <mans@mansr.com>, Julian Margetson <runaway@candw.ms>, Vinod Koul <vinod.koul@intel.com>

On Tue, Apr 26, 2016 at 12:03 PM, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
> The last approach in the commit 8b3444852a2b ("sata_dwc_460ex: move t=
o generic
> DMA driver") to switch to generic DMA engine API wasn't tested on bar=
e metal.
> Besides that we expecting new board support coming with the same SATA=
 IP but
> with different DMA.
>
> This series is targetting the following things:
> - a few bug fixes to the original driver
> - a part to fix the DMA engine usage and in particularly dw_dmac driv=
er
> - move driver to use generic PHY and "dmas" property which leads to u=
pdate in DTS
>
> The driver has been tested myself on Sam460ex and WD MyBookLive (apol=
lo3g)
> boards. In any case I ask Christian, M=C3=A5ns, and Julian to indepen=
dently test and
> provide Tested-by tag or an error report.
>
> Series depends on previously published but not yet fully applied seri=
es [1].
>
> The patches are also available via public branch [2].
>
> [1] http://www.spinics.net/lists/dmaengine/msg09250.html
> [2] https://bitbucket.org/andy-shev/linux/branch/topic%2Fdw%2Fsata
>

Tejun, since Vinod applied all necessary patches into his tree, the
series now has just a dependency to whatever branch / tag he marks for
it.
Do we have a chance to see the SATA series be applied in your tree?

> Since v1:
> - simplify patch 8 (David Laight)
> - add Tested-by and Acked-by tags
>
> Andy Shevchenko (11):
>   ata: sata_dwc_460ex: set dma_boundary to 0x1fff
>   ata: sata_dwc_460ex: burst size must be in items not bytes
>   ata: sata_dwc_460ex: DMA is always a flow controller
>   ata: sata_dwc_460ex: select only core part of DMA driver
>   ata: sata_dwc_460ex: don't call ata_sff_qc_issue() on DMA commands
>   ata: sata_dwc_460ex: correct HOSTDEV{P}_FROM_*() macros
>   ata: sata_dwc_460ex: supply physical address of FIFO to DMA
>   ata: sata_dwc_460ex: switch to new dmaengine_terminate_* API
>   ata: sata_dwc_460ex: use devm_ioremap
>   ata: sata_dwc_460ex: make debug messages neat
>   powerpc/4xx: Device tree update for the 460ex DWC SATA
>
> Christian Lamparter (1):
>   ata: sata_dwc_460ex: fix crash on offline links without an attached
>     drive
>
> Mans Rullgard (11):
>   ata: sata_dwc_460ex: remove incorrect locking
>   ata: sata_dwc_460ex: skip dma setup for non-dma commands
>   ata: sata_dwc_460ex: use "dmas" DT property to find dma channel
>   ata: sata_dwc_460ex: add phy support
>   ata: sata_dwc_460ex: get rid of global data
>   ata: sata_dwc_460ex: remove empty libata callback
>   ata: sata_dwc_460ex: get rid of some pointless casts
>   ata: sata_dwc_460ex: get rid of incorrect cast
>   ata: sata_dwc_460ex: add __iomem to register base pointer
>   ata: sata_dwc_460ex: use readl/writel_relaxed()
>   ata: sata_dwc_460ex: tidy up sata_dwc_clear_dmacr()
>
>  arch/powerpc/boot/dts/canyonlands.dts |  15 +-
>  drivers/ata/Kconfig                   |  12 +-
>  drivers/ata/sata_dwc_460ex.c          | 552 +++++++++++++++++-------=
----------
>  3 files changed, 305 insertions(+), 274 deletions(-)
>
> --
> 2.8.0.rc3
>



--=20
With Best Regards,
Andy Shevchenko
