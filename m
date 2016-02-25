From: Tejun Heo <tj@kernel.org>
Subject: Re: rcar_sata DMA warnings on Salvator-X
Date: Thu, 25 Feb 2016 16:40:36 -0500
Message-ID: <20160225214036.GI6092@mtj.duckdns.org>
References: <CAMuHMdU0=_TJVfy=-zXWHkfJSWH_fJULBrL8J9T60QS48WbYcQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAMuHMdU0=_TJVfy=-zXWHkfJSWH_fJULBrL8J9T60QS48WbYcQ@mail.gmail.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Vladimir Barinov <vladimir.barinov@cogentembedded.com>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, linux-renesas-soc@vger.kernel.org, dmaengine@vger.kernel.org, Harvey Hunt <harvey.hunt@imgtec.com>
List-Id: linux-ide@vger.kernel.org

Hello,

cc'ing Harvey.

On Wed, Feb 24, 2016 at 01:42:33PM +0100, Geert Uytterhoeven wrote:
> With CONFIG_DMA_API_DEBUG=y, I sometimes get the below warning
> on r8a7795/salvator-x. My tree is based on renesas-drivers-2016-02-23-v4.5-rc5.
> 
> sata_rcar ee300000.sata: DMA-API: cpu touching an active dma mapped
> cacheline [cln=0x000000000090fba0]
> ------------[ cut here ]------------
> WARNING: at lib/dma-debug.c:604
> Modules linked in:
> 
> CPU: 3 PID: 1619 Comm: bash Tainted: G        W
> 4.5.0-rc5-salvator-x-04682-g420edda42525a16f-dirty #541
> Hardware name: Renesas Salvator-X board based on r8a7795 (DT)
> task: ffffffc03bb30200 ti: ffffffc03b170000 task.ti: ffffffc03b170000
> PC is at debug_dma_assert_idle+0x180/0x1d0

Is this the problem fixed by the following patch from Harvey?

 http://lkml.kernel.org/g/CAMuHMdU0=_TJVfy=-zXWHkfJSWH_fJULBrL8J9T60QS48WbYcQ@mail.gmail.com

Thanks.

-- 
tejun
