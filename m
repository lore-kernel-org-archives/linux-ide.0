From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: rcar_sata DMA warnings on Salvator-X
Date: Wed, 24 Feb 2016 13:42:33 +0100
Message-ID: <CAMuHMdU0=_TJVfy=-zXWHkfJSWH_fJULBrL8J9T60QS48WbYcQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Tejun Heo <tj@kernel.org>, Vladimir Barinov <vladimir.barinov@cogentembedded.com>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, linux-renesas-soc@vger.kernel.org, dmaengine@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

With CONFIG_DMA_API_DEBUG=y, I sometimes get the below warning
on r8a7795/salvator-x. My tree is based on renesas-drivers-2016-02-23-v4.5-rc5.

sata_rcar ee300000.sata: DMA-API: cpu touching an active dma mapped
cacheline [cln=0x000000000090fba0]
------------[ cut here ]------------
WARNING: at lib/dma-debug.c:604
Modules linked in:

CPU: 3 PID: 1619 Comm: bash Tainted: G        W
4.5.0-rc5-salvator-x-04682-g420edda42525a16f-dirty #541
Hardware name: Renesas Salvator-X board based on r8a7795 (DT)
task: ffffffc03bb30200 ti: ffffffc03b170000 task.ti: ffffffc03b170000
PC is at debug_dma_assert_idle+0x180/0x1d0
LR is at debug_dma_assert_idle+0x180/0x1d0
pc : [<ffffff8004222b00>] lr : [<ffffff8004222b00>] pstate: 60000145
sp : ffffffc03b173c20
x29: ffffffc03b173c20 x28: 00e00000487ddfd3
x27: ffffffc03bb98010 x26: 0000000000000000
x25: ffffffc03bb98010 x24: 0000000000000140
x23: ffffff80047219b8 x22: ffffff80047a1000
x21: ffffff80046f1000 x20: ffffff8004721000
x19: ffffffc6fb048b00 x18: 0000000000000000
x17: 0000007f841b8150 x16: 00000000004e5428
x15: ffffffffffffffff x14: 6863616320646570
x13: 70616d20616d6420 x12: 657669746361206e
x11: 6120676e69686375 x10: 6f7420757063203a
x9 : 4950412d414d4420 x8 : 30303078303d6e6c
x7 : 635b20656e696c65 x6 : ffffff800474e4a5
x5 : 0000000000000000 x4 : 0000000000000000
x3 : 0000000000000000 x2 : 00000000dead4ead
x1 : ffffff8004703108 x0 : 0000000000000066

---[ end trace 435efaf33e0249ee ]---
Call trace:
Exception stack(0xffffffc03b173a60 to 0xffffffc03b173b80)
3a60: ffffffc6fb048b00 ffffff8004721000 ffffffc03b173c20 ffffff8004222b00
3a80: ffffff8004770c80 0000000000000000 000000000000c434 0000000000000002
3aa0: ffffffc03b173ac0 ffffff8004703138 ffffff80045f39d7 0000000000000004
3ac0: ffffffc03b173b60 ffffff80040d3bf4 ffffffc6fb048b00 ffffff8004721000
3ae0: ffffff80046f1000 ffffff80047a1000 ffffff80047219b8 0000000000000140
3b00: 0000000000000066 ffffff8004703108 00000000dead4ead 0000000000000000
3b20: 0000000000000000 0000000000000000 ffffff800474e4a5 635b20656e696c65
3b40: 30303078303d6e6c 4950412d414d4420 6f7420757063203a 6120676e69686375
3b60: 657669746361206e 70616d20616d6420 6863616320646570 ffffffffffffffff
[<ffffff8004222b00>] debug_dma_assert_idle+0x180/0x1d0
[<ffffff800412b0fc>] wp_page_copy.isra.109+0xfc/0x57c
[<ffffff800412f118>] handle_mm_fault+0x125c/0x1300
[<ffffff8004092894>] do_page_fault+0x184/0x328
[<ffffff8004082250>] do_mem_abort+0x40/0x9c
Exception stack(0xffffffc03b173e30 to 0xffffffc03b173f50)
3e20:                                   0000000000000000 0000000000000003
3e40: ffffffffffffffff 00000000004b7844 ffffffc03b173e70 ffffff8004483be8
3e60: 0000000000000000 ffffff80040aa2f0 ffffffc03b173e80 ffffff80040aa2f8
3e80: 0000000000000000 ffffff80040854f0 0000000000000000 000000000000067b
3ea0: ffffffffffffffff 0000007f841b8158 0000000020000000 0000000000000015
3ec0: 0000000000000000 ffffff80040854f0 000000000054d668 0000000000000028
3ee0: 00000000fffffff7 0000000000000001 00000000004f2160 0000808080008000
3f00: 0080008080800000 cecdfefeff08ff30 000000000000009a cdfefeff12cecece
3f20: ff7f7f7f7fffffff 0101010101010101 0000000000000008 ffffffffffffffff
3f40: ffffffffffff0000 ffffffffffffffff
[<ffffff8004085124>] el0_da+0x18/0x1c
Mapped at:
 [<ffffff8004220a08>] dma_entry_alloc+0x98/0xac
 [<ffffff8004222390>] debug_dma_alloc_coherent+0x48/0xe0
 [<ffffff8004292458>] dmam_alloc_coherent+0xa8/0xf8
 [<ffffff80042c7568>] ata_bmdma_port_start+0x40/0x5c
 [<ffffff80042b66f4>] ata_host_start+0xf8/0x19c

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
