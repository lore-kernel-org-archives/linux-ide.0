From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: rcar_sata DMA warnings on Salvator-X
Date: Mon, 29 Feb 2016 14:44:16 +0100
Message-ID: <CAMuHMdVL9tYbp6qEqn1wJGat-CwNqtALW82keyZvXDcuDd5SDA@mail.gmail.com>
References: <CAMuHMdU0=_TJVfy=-zXWHkfJSWH_fJULBrL8J9T60QS48WbYcQ@mail.gmail.com>
	<20160225214036.GI6092@mtj.duckdns.org>
	<CAOS58YMv+vBsCrG3ftJSPAxTXgo9gNmxaVeKv8xfNygJgrmSmA@mail.gmail.com>
	<CAMuHMdXkWTaJQaPj_J8z+7F7GoZhk33hNSiB-wMoNuoi7wawNw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-io0-f169.google.com ([209.85.223.169]:35438 "EHLO
	mail-io0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752677AbcB2NoS (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 29 Feb 2016 08:44:18 -0500
In-Reply-To: <CAMuHMdXkWTaJQaPj_J8z+7F7GoZhk33hNSiB-wMoNuoi7wawNw@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Vladimir Barinov <vladimir.barinov@cogentembedded.com>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, linux-renesas-soc@vger.kernel.org, dmaengine@vger.kernel.org, Harvey Hunt <harvey.hunt@imgtec.com>

Hi Tejun,

On Fri, Feb 26, 2016 at 9:21 AM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> On Thu, Feb 25, 2016 at 10:42 PM, Tejun Heo <tj@kernel.org> wrote:
>> On Thu, Feb 25, 2016 at 4:40 PM, Tejun Heo <tj@kernel.org> wrote:
>>> Is this the problem fixed by the following patch from Harvey?
>>>
>>>  http://lkml.kernel.org/g/CAMuHMdU0=_TJVfy=-zXWHkfJSWH_fJULBrL8J9T60QS48WbYcQ@mail.gmail.com
>>
>> Oops, I meant
>>
>> http://lkml.kernel.org/g/1456327003-16295-1-git-send-email-harvey.hunt@imgtec.com
>
> Thanks, looks plausible, I'll give it a try.
>
> Note that I couldn't reproduce this at will, so I'll just let you know if I
> see it again, despite this patch.

Unfortunately I've just got another one, with the above patch applied:

sata_rcar ee300000.sata: DMA-API: cpu touching an active dma mapped
cacheline [cln=0x000000000090ff40]
------------[ cut here ]------------
WARNING: at lib/dma-debug.c:604
Modules linked in:

CPU: 2 PID: 329 Comm: udevd Not tainted
4.5.0-rc5-salvator-x-04739-gd9f979182e2877a4 #557
Hardware name: Renesas Salvator-X board based on r8a7795 (DT)
task: ffffffc6fa63a180 ti: ffffffc6fa7c4000 task.ti: ffffffc6fa7c4000
PC is at debug_dma_assert_idle+0x180/0x1d0
LR is at debug_dma_assert_idle+0x180/0x1d0
pc : [<ffffff8004222b00>] lr : [<ffffff8004222b00>] pstate: 60000145
sp : ffffffc6fa7c7c20
x29: ffffffc6fa7c7c20 x28: 00e00000487fafd3
x27: ffffffc03b010f40 x26: 0000000000000000
x25: ffffffc03b010f40 x24: 0000000000000140
x23: ffffff80047219b8 x22: ffffff80047a1000
x21: ffffff80046f1000 x20: ffffff8004721000
x19: ffffffc6fb03d600 x18: 0000007feb6bbf20
x17: 0000007fa0722650 x16: 000000557d095af0
x15: 0000007fa07f2588 x14: 70616d20616d6420
x13: 657669746361206e x12: 6120676e69686375
x11: 6f7420757063203a x10: 4950412d414d4420
x9 : 3a617461732e3030 x8 : ffffff80047564d4
x7 : 0000000000000000 x6 : 0000000000000004
x5 : 0000000000000016 x4 : 0000000000000066
x3 : 00ffffffffffffff x2 : 00000000dead4ead
x1 : 0000000000000140 x0 : 0000000000000066

---[ end trace 7f71ed044e72e67d ]---
Call trace:
Exception stack(0xffffffc6fa7c7a60 to 0xffffffc6fa7c7b80)
7a60: ffffffc6fb03d600 ffffff8004721000 ffffffc6fa7c7c20 ffffff8004222b00
7a80: ffffffc6fa7c7aa0 ffffff80040d1dcc ffffff8004703138 0000000000000004
7aa0: ffffffc6fa7c7ac0 ffffff80040d3a00 0000000000000002 0000000000000004
7ac0: ffffffc6fa7c7b60 ffffff80040d3bf4 ffffffc6fb03d600 ffffff8004721000
7ae0: ffffff80046f1000 ffffff80047a1000 ffffff80047219b8 0000000000000140
7b00: 0000000000000066 0000000000000140 00000000dead4ead 00ffffffffffffff
7b20: 0000000000000066 0000000000000016 0000000000000004 0000000000000000
7b40: ffffff80047564d4 3a617461732e3030 4950412d414d4420 6f7420757063203a
7b60: 6120676e69686375 657669746361206e 70616d20616d6420 0000007fa07f2588
[<ffffff8004222b00>] debug_dma_assert_idle+0x180/0x1d0
[<ffffff800412b0fc>] wp_page_copy.isra.109+0xfc/0x57c
[<ffffff800412f118>] handle_mm_fault+0x125c/0x1300
[<ffffff8004092894>] do_page_fault+0x184/0x328
[<ffffff8004082250>] do_mem_abort+0x40/0x9c
Exception stack(0xffffffc6fa7c7e30 to 0xffffffc6fa7c7f50)
7e20:                                   0000000000000000 000000557d0a6740
7e40: ffffffffffffffff 0000007fa0722798 00000000a0000000 0000000000000015
7e60: 000000000000011e 00000000000000d7 ffffffc6fa7c7e80 ffffff8004133120
7e80: ffffffc6fa7c7ec0 ffffff8004133140 0000000000000000 0000000000000000
7ea0: ffffffffffffffff 00000000365c03fd 0000000000000000 0000000000010000
7ec0: 0000000000000000 ffffff80040854f0 0000000000000000 0000000000000007
7ee0: 0000000000000038 0000000000000040 0000007feb6c0188 0000000000000002
7f00: 0000000000000000 726f635f38766d72 003735615f786574 fefeff3634605e77
7f20: 7f7f7f7f7f7f7f7f 0101010101010101 0000000000000028 0000000000000010
7f40: 0000000000000000 0000007fa07f2588
[<ffffff8004085124>] el0_da+0x18/0x1c
Mapped at:
 [<ffffff8004220a08>] dma_entry_alloc+0x98/0xac
 [<ffffff8004222390>] debug_dma_alloc_coherent+0x48/0xe0
 [<ffffff80042926d8>] dmam_alloc_coherent+0xa8/0xf8
 [<ffffff80042c77dc>] ata_bmdma_port_start+0x40/0x5c
 [<ffffff80042b6974>] ata_host_start+0xf8/0x19c

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
