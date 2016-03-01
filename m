From: Tejun Heo <tj@kernel.org>
Subject: Re: rcar_sata DMA warnings on Salvator-X
Date: Tue, 1 Mar 2016 12:12:18 -0500
Message-ID: <20160301171218.GH3965@htj.duckdns.org>
References: <CAMuHMdU0=_TJVfy=-zXWHkfJSWH_fJULBrL8J9T60QS48WbYcQ@mail.gmail.com>
 <20160225214036.GI6092@mtj.duckdns.org>
 <CAOS58YMv+vBsCrG3ftJSPAxTXgo9gNmxaVeKv8xfNygJgrmSmA@mail.gmail.com>
 <CAMuHMdXkWTaJQaPj_J8z+7F7GoZhk33hNSiB-wMoNuoi7wawNw@mail.gmail.com>
 <CAMuHMdVL9tYbp6qEqn1wJGat-CwNqtALW82keyZvXDcuDd5SDA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAMuHMdVL9tYbp6qEqn1wJGat-CwNqtALW82keyZvXDcuDd5SDA@mail.gmail.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Vladimir Barinov <vladimir.barinov@cogentembedded.com>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, linux-renesas-soc@vger.kernel.org, dmaengine@vger.kernel.org, Harvey Hunt <harvey.hunt@imgtec.com>
List-Id: linux-ide@vger.kernel.org

Hello,

On Mon, Feb 29, 2016 at 02:44:16PM +0100, Geert Uytterhoeven wrote:
> sata_rcar ee300000.sata: DMA-API: cpu touching an active dma mapped
> cacheline [cln=0x000000000090ff40]
> ------------[ cut here ]------------
> WARNING: at lib/dma-debug.c:604
> Modules linked in:
> 
> CPU: 2 PID: 329 Comm: udevd Not tainted
...
> [<ffffff8004222b00>] debug_dma_assert_idle+0x180/0x1d0
> [<ffffff800412b0fc>] wp_page_copy.isra.109+0xfc/0x57c
> [<ffffff800412f118>] handle_mm_fault+0x125c/0x1300
> [<ffffff8004092894>] do_page_fault+0x184/0x328
> [<ffffff8004082250>] do_mem_abort+0x40/0x9c

So, somehow udev has mmapped a page which is dma mapped and trying to
falut that in?

> Mapped at:
>  [<ffffff8004220a08>] dma_entry_alloc+0x98/0xac
>  [<ffffff8004222390>] debug_dma_alloc_coherent+0x48/0xe0
>  [<ffffff80042926d8>] dmam_alloc_coherent+0xa8/0xf8
>  [<ffffff80042c77dc>] ata_bmdma_port_start+0x40/0x5c
>  [<ffffff80042b6974>] ata_host_start+0xf8/0x19c

And that region was originally allocated by ata_bmdma_port_start()?
The only thing which gets allocated there is the PRD table which is
the scatter-gather list for the DMA engine and has no reason to be
ever accessed from userland.  Any chance you can find out what udev is
doing at that point?

Thanks.

-- 
tejun
