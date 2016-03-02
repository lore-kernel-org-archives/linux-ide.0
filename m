From: Dirk Behme <dirk.behme@gmail.com>
Subject: Re: rcar_sata DMA warnings on Salvator-X
Date: Wed, 2 Mar 2016 08:35:28 +0100
Message-ID: <56D697C0.9000501@gmail.com>
References: <CAMuHMdU0=_TJVfy=-zXWHkfJSWH_fJULBrL8J9T60QS48WbYcQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-wm0-f54.google.com ([74.125.82.54]:38094 "EHLO
	mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750977AbcCBHfh (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 2 Mar 2016 02:35:37 -0500
In-Reply-To: <CAMuHMdU0=_TJVfy=-zXWHkfJSWH_fJULBrL8J9T60QS48WbYcQ@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>, Tejun Heo <tj@kernel.org>, Vladimir Barinov <vladimir.barinov@cogentembedded.com>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, linux-renesas-soc@vger.kernel.org, dmaengine@vger.kernel.org

Hi,

On 24.02.2016 13:42, Geert Uytterhoeven wrote:
> With CONFIG_DMA_API_DEBUG=y, I sometimes get the below warning
> on r8a7795/salvator-x. My tree is based on renesas-drivers-2016-02-23-v4.5-rc5.


Some weeks ago I've had a look at porting the eMMC support from the 
4.2 Renesas BSP to the 4.4 based renesas-drivers [1]. I never got it 
working, as it always crashed immediately at every kernel boot with 
various error messages. Often something like [2], but often something 
quite different, too.

As the MMC related patches I ported seem to work on the Renesas 4.2 
BSP, and the 4.4 renesas-drivers shouldn't be that different, I was 
hoping that the same code works on 4.2 and 4.4.  But it doesn't, even 
though I compared the resulting MMC code to be identical. As the 
crashes are often different ones, often in core parts of the kernel, I 
was suspecting a DMA related issue, too.

So maybe we have a 'general' DMA issue on Salvator-X? Somehow 
independent on the specific SATA and MMC code?

Just my $0.02. Maybe something to at least think about. Sorry if these 
are totally unrelated issues.

Best regards

Dirk

[1] 
https://github.com/dirkbehme/linux-renesas-rcar-gen3/commits/dirk/gen3-latest-update

[2]

...
ALSA device list:
   #0: rsnd-dai.0-ak4613-hifi
mmc0: MAN_BKOPS_EN bit is not set
mmc0: new HS200 MMC card at address 0001
mmcblk0: mmc0:0001 BGSD3R 29.1 GiB
mmcblk0boot0: mmc0:0001 BGSD3R partition 1 16.0 MiB
mmcblk0boot1: mmc0:0001 BGSD3R partition 2 16.0 MiB
mmcblk0rpmb: mmc0:0001 BGSD3R partition 3 4.00 MiB
------------[ cut here ]------------
kernel BUG at mm/vmalloc.c:460!
Internal error: Oops - BUG: 0 [#1] PREEMPT SMP
Modules linked in:
CPU: 1 PID: 6 Comm: kworker/u16:0 Not tainted 4.4.0-rc3+ #1
Hardware name: Renesas Salvator-X board based on r8a7795 (DT)
Workqueue: kmmcd mmc_rescan
task: ffffffc5bc483700 ti: ffffffc5bc4bc000 task.ti: ffffffc5bc4bc000
PC is at alloc_vmap_area.isra.44+0x2d8/0x2fc
LR is at alloc_vmap_area.isra.44+0x23c/0x2fc
pc : [<ffffffc000175f3c>] lr : [<ffffffc000175ea0>] pstate: a0000045
sp : ffffffc5bc4bf740
x29: ffffffc5bc4bf740 x28: 0000000000000001
x27: 0000000000002000 x26: ffffffc0009d8410
x25: ffffff8000002000 x24: ffffffc0009d8410
x23: ffffff8000000000 x22: ffffffffffffffff
x21: ffffffc000961980 x20: ffffffbdbfff0000
x19: ffffffc5bb443a00 x18: ffffffc000691000
x17: 0000000000000007 x16: 000000000000000e
x15: ffffffbdd8105020 x14: 0000000000000003
x13: 00000000ffffff80 x12: ffffffc0009c17b8
x11: ffffffc0009c17d8 x10: 0000000000000003
x9 : 0000000000000001 x8 : 0000000000000001
x7 : 0000000000000000 x6 : 000000000000003f
x5 : ffffffbdbff78000 x4 : ffffffc5bc401618
x3 : ffffffc03299c718 x2 : ffffffc5bb443a30
x1 : 0000000000000000 x0 : 0000000000000000

Process kworker/u16:0 (pid: 6, stack limit = 0xffffffc5bc4bc020)
Stack: (0xffffffc5bc4bf740 to 0xffffffc5bc4c0000)
f740: ffffffc5bc4bf7c0 ffffffc0001769b0 0000000000001000 ffffffc5bb443980
f760: 0000000000000022 0000000000000001 ffffffc0003075e4 00000000024080c2
f780: ffffff8000000000 ffffffbdbfff0000 00e8000000000713 0000000000000003
f7a0: ffffff8000000000 ffffffc5bb443a00 0000000000000000 00000000001bb5c0
f7c0: ffffffc5bc4bf820 ffffffc000177140 0000000000000400 0000000000000008
f7e0: ffffffc032958000 ffffffc5bc140000 00000000ffffffff ffffffc0007fc470
f800: 00000000024080c2 0000000000000001 ffffffc032958048 ffffffc032958000
f820: ffffffc5bc4bf890 ffffffc00017753c ffffffc5bb443900 0000000000000008
f840: ffffffc032958000 ffffffc5bc140000 ffffffc0007fc4c8 ffffffc0007fc470
f860: 0000000000000000 0000000000000001 ffffffc5bc140000 ffffffc0007fc470
f880: ffffffc0003075e4 0000000000000001 ffffffc5bc4bf8a0 ffffffc0003075e4
f8a0: ffffffc5bc4bf8e0 ffffffc000306d0c ffffffc5bc140000 ffffffc032958000
f8c0: ffffffc5bc140000 ffffffc0007fc4f8 ffffffc0007fc4c8 0000000200000001
f8e0: ffffffc5bc4bf940 ffffffc0001d6afc ffffffc5bc140000 ffffffc032958000
f900: 0000000000000000 ffffffc5bc140018 0000000000000000 0000000000000001
f920: 0000000000000000 0000000000000001 ffffffc5bc140000 0000000000000003
f940: ffffffc5bc4bf9a0 ffffffc0001d6c34 ffffffc032958000 ffffffc032958070
f960: 0000000000000000 ffffffc5bc140000 ffffffc032960168 ffffffc032958080
f980: 0000000000000001 0000000000000001 ffffffc5bc4bf9b0 00000000001bb2c4
f9a0: ffffffc5bc4bfa30 ffffffc0003048c8 ffffffc032958000 ffffffc032958070
f9c0: ffffffc03295800c ffffffc5bc140000 ffffffc032960168 ffffffc032958080
f9e0: 0000000000000001 ffffffc032af0314 ffffffc00082c950 0000000000000003
fa00: ffffffc5bc4bfa10 ffffffc000303560 ffffffc5bc4bfa30 ffffffc0003048ac
fa20: ffffffc032958000 ffffffc032958070 ffffffc5bc4bfaa0 ffffffc0004ceab0
fa40: ffffffc032af0800 0000000000000003 ffffffc032af0be8 ffffffc032af0000
fa60: ffffffc032af0800 ffffffc032af0008 ffffffc032af0bb8 ffffffc5bc4bfad0
fa80: 0b300000bc4bfa90 00000000ffffffc8 ffffffc032af0800 ffffffc03295b00c
faa0: ffffffc5bc4bfad0 ffffffc0004cf098 ffffffc032af051c 0000000000000003
fac0: ffffffc032af2000 ffffffc032af0000 ffffffc5bc4bfb50 ffffffc0004c257c
fae0: ffffffc032af0008 ffffffc0009eb000 0000000000000000 ffffffc00099bb48
fb00: 0000000000000002 ffffffc0009eb000 0000000000000000 ffffffc00099b490
fb20: ffffffc00094a000 ffffffc5bc4192a0 42694720312e3932 ffffffc0003df200
fb40: 42694d2030302e34 ffffffc0003e2700 ffffffc5bc4bfb60 ffffffc0003e2808
fb60: ffffffc5bc4bfba0 ffffffc0003e2a5c ffffffc00099bb48 ffffffc5bc4bfc40
fb80: ffffffc032af0008 0000000000000001 ffffffc000988000 ffffffc0003e0ad0
fba0: ffffffc5bc4bfbd0 ffffffc0003e0ac4 0000000000000000 ffffffc5bc4bfc40
fbc0: ffffffc0003e29d0 0000000000000000 ffffffc5bc4bfc10 ffffffc0003e2580
fbe0: ffffffc032af0008 ffffffc032af0068 ffffffc00099b340 ffffffc032af0068
fc00: ffffffc5bbfd7cd0 ffffffc032b4e468 ffffffc5bc4bfc50 ffffffc0003e2bb4
fc20: ffffffc032af0018 ffffffc032af0008 ffffffc00099b340 ffffffc032b98808
fc40: ffffffc032af0008 0000000000000001 ffffffc5bc4bfc60 ffffffc0003e1bcc
fc60: ffffffc5bc4bfc90 ffffffc0003dfc48 ffffffc032af0018 ffffffc032af0008
fc80: 0000000000000000 ffffffc0003dfc40 ffffffc5bc4bfcf0 ffffffc0004c2a30
fca0: ffffffc032af0000 ffffffc032af0008 0000000000000000 ffffffc032b98800
fcc0: ffffffc032b98bd8 0000000000061a80 ffffffc0006a7938 ffffffc5bc419070
fce0: ffffffc5bc4bfcf0 ffffffc0004c2a18 ffffffc5bc4bfd10 ffffffc0004c5ce0
fd00: ffffffc032b98800 0000000000000000 ffffffc5bc4bfd40 ffffffc0004c2240
fd20: ffffffc032b987d8 ffffffc032b98b40 0000000000000000 40ff8080bc4bfc90
fd40: ffffffc5bc4bfd90 ffffffc0000c998c ffffffc5bc45a900 ffffffc032b98bd8
fd60: ffffffc5bb95d000 0000000000000000 ffffffc5bc419000 0000000000000000
fd80: ffffffc5bc419018 ffffffc0000c9980 ffffffc5bc4bfdd0 ffffffc0000c9c94
fda0: ffffffc5bc45a900 ffffffc5bc45a930 ffffffc5bc419018 ffffffc5bc419000
fdc0: ffffffc5bc4bc000 ffffffc0009c381b ffffffc5bc4bfe30 ffffffc0000cf640
fde0: ffffffc5bc425b80 ffffffc0009cc068 ffffffc0007e02e8 ffffffc5bc45a900
fe00: ffffffc0000c9b5c 0000000000000000 0000000000000000 0000000000000000
fe20: 0000000000000000 0000000000000000 0000000000000000 ffffffc000085c50
fe40: ffffffc0000cf560 ffffffc5bc425b80 0000000000000000 0000000000000000
fe60: 0000000000000000 ffffffc0000d7ad0 ffffffc0000cf560 0000000000000000
fe80: 0000000000000000 ffffffc5bc45a900 0000000000000000 0000000000000000
fea0: ffffffc5bc4bfea0 ffffffc5bc4bfea0 0000000000000000 ffffffc000000000
fec0: ffffffc5bc4bfec0 ffffffc5bc4bfec0 0000000000000000 0000000000000000
fee0: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
ff00: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
ff20: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
ff40: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
ff60: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
ff80: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
ffa0: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
ffc0: 0000000000000000 0000000000000000 0000000000000000 0000000000000005
ffe0: 0000000000000000 0000000000000000 ffffffffffffffff ffffffffffffffff
Call trace:
[<ffffffc000175f3c>] alloc_vmap_area.isra.44+0x2d8/0x2fc
[<ffffffc0001769b0>] __get_vm_area_node.isra.45+0x9c/0x170
[<ffffffc000177140>] __vmalloc_node_range+0x6c/0x26c
[<ffffffc00017753c>] vzalloc+0x40/0x4c
[<ffffffc0003075e4>] check_partition+0x4c/0x224
[<ffffffc000306d0c>] rescan_partitions+0xb4/0x294
[<ffffffc0001d6afc>] __blkdev_get+0x22c/0x320
[<ffffffc0001d6c34>] blkdev_get+0x44/0x31c
[<ffffffc0003048c8>] add_disk+0x38c/0x3fc
[<ffffffc0004ceab0>] mmc_add_disk+0x24/0x110
[<ffffffc0004cf098>] mmc_blk_probe+0x1c8/0x2c0
[<ffffffc0004c257c>] mmc_bus_probe+0x1c/0x24
[<ffffffc0003e2808>] driver_probe_device+0x1ec/0x2e8
[<ffffffc0003e2a5c>] __device_attach_driver+0x8c/0xb0
[<ffffffc0003e0ac4>] bus_for_each_drv+0x54/0x94
[<ffffffc0003e2580>] __device_attach+0xc0/0x128
[<ffffffc0003e2bb4>] device_initial_probe+0x10/0x18
[<ffffffc0003e1bcc>] bus_probe_device+0x90/0x98
[<ffffffc0003dfc48>] device_add+0x3c0/0x53c
[<ffffffc0004c2a30>] mmc_add_card+0xdc/0x25c
[<ffffffc0004c5ce0>] mmc_attach_mmc+0xa4/0x150
[<ffffffc0004c2240>] mmc_rescan+0x2b4/0x338
[<ffffffc0000c998c>] process_one_work+0x138/0x308
[<ffffffc0000c9c94>] worker_thread+0x138/0x438
[<ffffffc0000cf640>] kthread+0xe0/0xf4
[<ffffffc000085c50>] ret_from_fork+0x10/0x40
Code: d4210000 92800160 17fffff2 d4210000 (d4210000)
---[ end trace 3c272cba005aa838 ]---
Unable to handle kernel paging request at virtual address ffffffffffffffd8
pgd = ffffffc0009ff000
[ffffffffffffffd8] *pgd=0000000000000000, *pud=0000000000000000
Internal error: Oops: 96000005 [#2] PREEMPT SMP
Modules linked in:
CPU: 1 PID: 6 Comm: kworker/u16:0 Tainted: G      D         4.4.0-rc3+ #1
Hardware name: Renesas Salvator-X board based on r8a7795 (DT)
task: ffffffc5bc483700 ti: ffffffc5bc4bc000 task.ti: ffffffc5bc4bc000
PC is at kthread_data+0x4/0xc
LR is at wq_worker_sleeping+0x14/0xcc
pc : [<ffffffc0000cfbf4>] lr : [<ffffffc0000ca780>] pstate: 600003c5
sp : ffffffc5bc4bf3d0
x29: ffffffc5bc4bf3d0 x28: 0000000000000001
x27: ffffffc5bc480000 x26: 0000000000000000
x25: 0000000000000001 x24: ffffffc5bc483b58
x23: ffffffc000620308 x22: ffffffc5bc483700
x21: ffffffc5bff46d00 x20: ffffffc00094a000
x19: 0000000000000001 x18: ffffffc000691000
x17: 0000000000000007 x16: 000000000000000e
x15: 0000000000000001 x14: 0000000000000007
x13: 000000000000000e x12: 0000000000000000
x11: 0000000000000000 x10: 0000000000000000
x9 : 0000000000000000 x8 : 0000000000000001
x7 : 0000000002db2fad x6 : 0000000000000000
x5 : 0000000000000000 x4 : ffffffffffffd590
x3 : 0000000000000001 x2 : 000000000000af3b
x1 : 0000000000000001 x0 : 0000000000000000

Process kworker/u16:0 (pid: 6, stack limit = 0xffffffc5bc4bc020)
Stack: (0xffffffc5bc4bf3d0 to 0xffffffc5bc4c0000)
f3c0:                                   ffffffc5bc4bf3f0 ffffffc000620130
f3e0: ffffffc00092f000 ffffffc0000b725c ffffffc5bc4bf440 ffffffc000620308
f400: ffffffc5bc4bc000 ffffffc5bc4bf140 ffffffc5bc4bf4c0 ffffffc5bc483a48
f420: ffffffc00094a000 ffffffc5bc483700 ffffff8000002000 ffffffc0009d8410
f440: ffffffc5bc4bf460 ffffffc0000b7338 ffffffc5bc483700 ffffffc0000b72f8
f460: ffffffc5bc4bf4d0 ffffffc0000899cc ffffffc0009c8000 0000000000000000
f480: ffffffc0007dc198 ffffffc5bc4bf620 ffffffc5bc4bc000 ffffffc5bc483700
f4a0: ffffff8000002000 ffffffc0009d8410 0000000000002000 0000000000000001
f4c0: ffffffc5bc4bf4c0 ffffffc5bc4bf4c0 ffffffc5bc4bf510 ffffffc000089a24
f4e0: ffffffc5bc4bf620 ffffffc000089a60 ffffffc5bc4bf620 ffffffc5bc4bf620
f500: 00000000a0000045 000000000000003d ffffffc5bc4bf530 ffffffc000089a7c
f520: 00000000f2000800 ffffffc0000839a8 ffffffc5bc4bf540 ffffffc0000839b8
f540: ffffffc5bc4bf570 ffffffc00008242c 00000000f2000800 ffffffc0009c0ca8
f560: 0000000000000000 ffffffc5bbdd0060 ffffffc5bc4bf740 ffffffc0000854b4
f580: ffffffc5bb443a00 ffffffbdbfff0000 ffffffc5bc4bf740 ffffffc000175f3c
f5a0: 00000000022152d0 0000000000000003 0000000000000141 00000000022152d0
f5c0: ffffffc00094a000 0000000000000003 0000000000400000 0000000000000003
f5e0: ffffffc0009c2000 0000000000000003 0000000000000138 ffffffc0009c2680
f600: 0000000000000000 0000010000000000 ffffffc0009c2680 0000010000000000
f620: 0000000000000000 0000000000000000 ffffffc5bb443a30 ffffffc03299c718
f640: ffffffc5bc401618 ffffffbdbff78000 000000000000003f 0000000000000000
f660: 0000000000000001 0000000000000001 0000000000000003 ffffffc0009c17d8
f680: ffffffc0009c17b8 00000000ffffff80 0000000000000003 ffffffbdd8105020
f6a0: 000000000000000e 0000000000000007 ffffffc000691000 ffffffc5bb443a00
f6c0: ffffffbdbfff0000 ffffffc000961980 ffffffffffffffff ffffff8000000000
f6e0: ffffffc0009d8410 ffffff8000002000 ffffffc0009d8410 0000000000002000
f700: 0000000000000001 ffffffc5bc4bf740 ffffffc000175ea0 ffffffc5bc4bf740
f720: ffffffc000175f3c 00000000a0000045 ffffffc5bc4bf740 ffffffc000175ea0
f740: ffffffc5bc4bf7c0 ffffffc0001769b0 0000000000001000 ffffffc5bb443980
f760: 0000000000000022 0000000000000001 ffffffc0003075e4 00000000024080c2
f780: ffffff8000000000 ffffffbdbfff0000 00e8000000000713 0000000000000003
f7a0: ffffff8000000000 ffffffc5bb443a00 0000000000000000 00000000001bb5c0
f7c0: ffffffc5bc4bf820 ffffffc000177140 0000000000000400 0000000000000008
f7e0: ffffffc032958000 ffffffc5bc140000 00000000ffffffff ffffffc0007fc470
f800: 00000000024080c2 0000000000000001 ffffffc032958048 ffffffc032958000
f820: ffffffc5bc4bf890 ffffffc00017753c ffffffc5bb443900 0000000000000008
f840: ffffffc032958000 ffffffc5bc140000 ffffffc0007fc4c8 ffffffc0007fc470
f860: 0000000000000000 0000000000000001 ffffffc5bc140000 ffffffc0007fc470
f880: ffffffc0003075e4 0000000000000001 ffffffc5bc4bf8a0 ffffffc0003075e4
f8a0: ffffffc5bc4bf8e0 ffffffc000306d0c ffffffc5bc140000 ffffffc032958000
f8c0: ffffffc5bc140000 ffffffc0007fc4f8 ffffffc0007fc4c8 0000000200000001
f8e0: ffffffc5bc4bf940 ffffffc0001d6afc ffffffc5bc140000 ffffffc032958000
f900: 0000000000000000 ffffffc5bc140018 0000000000000000 0000000000000001
f920: 0000000000000000 0000000000000001 ffffffc5bc140000 0000000000000003
f940: ffffffc5bc4bf9a0 ffffffc0001d6c34 ffffffc032958000 ffffffc032958070
f960: 0000000000000000 ffffffc5bc140000 ffffffc032960168 ffffffc032958080
f980: 0000000000000001 0000000000000001 ffffffc5bc4bf9b0 00000000001bb2c4
f9a0: ffffffc5bc4bfa30 ffffffc0003048c8 ffffffc032958000 ffffffc032958070
f9c0: ffffffc03295800c ffffffc5bc140000 ffffffc032960168 ffffffc032958080
f9e0: 0000000000000001 ffffffc032af0314 ffffffc00082c950 0000000000000003
fa00: ffffffc5bc4bfa10 ffffffc000303560 ffffffc5bc4bfa30 ffffffc0003048ac
fa20: ffffffc032958000 ffffffc032958070 ffffffc5bc4bfaa0 ffffffc0004ceab0
fa40: ffffffc032af0800 0000000000000003 ffffffc032af0be8 ffffffc032af0000
fa60: ffffffc032af0800 ffffffc032af0008 ffffffc032af0bb8 ffffffc5bc4bfad0
fa80: 0b300000bc4bfa90 00000000ffffffc8 ffffffc032af0800 ffffffc03295b00c
faa0: ffffffc5bc4bfad0 ffffffc0004cf098 ffffffc032af051c 0000000000000003
fac0: ffffffc032af2000 ffffffc032af0000 ffffffc5bc4bfb50 ffffffc0004c257c
fae0: ffffffc032af0008 ffffffc0009eb000 0000000000000000 ffffffc00099bb48
fb00: 0000000000000002 ffffffc0009eb000 0000000000000000 ffffffc00099b490
fb20: ffffffc00094a000 ffffffc5bc4192a0 42694720312e3932 ffffffc0003df200
fb40: 42694d2030302e34 ffffffc0003e2700 ffffffc5bc4bfb60 ffffffc0003e2808
fb60: ffffffc5bc4bfba0 ffffffc0003e2a5c ffffffc00099bb48 ffffffc5bc4bfc40
fb80: ffffffc032af0008 0000000000000001 ffffffc000988000 ffffffc0003e0ad0
fba0: ffffffc5bc4bfbd0 ffffffc0003e0ac4 0000000000000000 ffffffc5bc4bfc40
fbc0: ffffffc0003e29d0 0000000000000000 ffffffc5bc4bfc10 ffffffc0003e2580
fbe0: ffffffc032af0008 ffffffc032af0068 ffffffc00099b340 ffffffc032af0068
fc00: ffffffc5bbfd7cd0 ffffffc032b4e468 ffffffc5bc4bfc50 ffffffc0003e2bb4
fc20: ffffffc032af0018 ffffffc032af0008 ffffffc00099b340 ffffffc032b98808
fc40: ffffffc032af0008 0000000000000001 ffffffc5bc4bfc60 ffffffc0003e1bcc
fc60: ffffffc5bc4bfc90 ffffffc0003dfc48 ffffffc032af0018 ffffffc032af0008
fc80: 0000000000000000 ffffffc0003dfc40 ffffffc5bc4bfcf0 ffffffc0004c2a30
fca0: ffffffc032af0000 ffffffc032af0008 0000000000000000 ffffffc032b98800
fcc0: ffffffc032b98bd8 0000000000061a80 ffffffc0006a7938 ffffffc5bc419070
fce0: ffffffc5bc4bfcf0 ffffffc0004c2a18 ffffffc5bc4bfd10 ffffffc0004c5ce0
fd00: ffffffc032b98800 0000000000000000 ffffffc5bc4bfd40 ffffffc0004c2240
fd20: ffffffc032b987d8 ffffffc032b98b40 0000000000000000 40ff8080bc4bfc90
fd40: ffffffc5bc4bfd90 ffffffc0000c998c ffffffc5bc45a900 ffffffc032b98bd8
fd60: ffffffc5bb95d000 0000000000000000 ffffffc5bc419000 0000000000000000
fd80: ffffffc5bc419018 ffffffc0000c9980 ffffffc5bc4bfdd0 ffffffc0000c9c94
fda0: ffffffc5bc45a900 ffffffc5bc45a930 ffffffc5bc419018 ffffffc5bc419000
fdc0: ffffffc5bc4bc000 ffffffc0009c381b ffffffc5bc4bfe30 ffffffc0000cf640
fde0: ffffffc5bc425b80 ffffffc0009cc068 ffffffc0007e02e8 ffffffc5bc45a900
fe00: ffffffc0000c9b5c 0000000000000000 0000000000000000 0000000000000000
fe20: 0000000000000000 0000000000000000 0000000000000000 ffffffc000085c50
fe40: ffffffc0000cf560 ffffffc5bc425b80 0000000000000000 0000000000000000
fe60: 0000000000000000 ffffffc0000d7ad0 ffffffc0000cf560 0000000000000000
fe80: 0000000000000000 ffffffc5bc45a900 0000000000000000 0000000000000000
fea0: ffffffc5bc4bfea0 ffffffc5bc4bfea0 0000000000000001 ffffffc000010001
fec0: ffffffc5bc4bfec0 ffffffc5bc4bfec0 0000000000000000 0000000000000000
fee0: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
ff00: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
ff20: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
ff40: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
ff60: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
ff80: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
ffa0: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
ffc0: 0000000000000000 0000000000000000 0000000000000000 0000000000000005
ffe0: 0000000000000000 0000000000000000 ffffffffffffffff ffffffffffffffff
Call trace:
[<ffffffc0000cfbf4>] kthread_data+0x4/0xc
[<ffffffc000620130>] __schedule+0x41c/0x5b0
[<ffffffc000620308>] schedule+0x44/0xb0
[<ffffffc0000b7338>] do_exit+0x6d0/0x9c4
[<ffffffc0000899cc>] die+0x1a4/0x1bc
[<ffffffc000089a24>] bug_handler.part.4+0x40/0x7c
[<ffffffc000089a7c>] bug_handler+0x1c/0x2c
[<ffffffc0000839b8>] brk_handler+0x88/0xcc
[<ffffffc00008242c>] do_debug_exception+0x40/0xac
Exception stack(0xffffffc5bc4bf580 to 0xffffffc5bc4bf6a0)
f580: ffffffc5bb443a00 ffffffbdbfff0000 ffffffc5bc4bf740 ffffffc000175f3c
f5a0: 00000000022152d0 0000000000000003 0000000000000141 00000000022152d0
f5c0: ffffffc00094a000 0000000000000003 0000000000400000 0000000000000003
f5e0: ffffffc0009c2000 0000000000000003 0000000000000138 ffffffc0009c2680
f600: 0000000000000000 0000010000000000 ffffffc0009c2680 0000010000000000
f620: 0000000000000000 0000000000000000 ffffffc5bb443a30 ffffffc03299c718
f640: ffffffc5bc401618 ffffffbdbff78000 000000000000003f 0000000000000000
f660: 0000000000000001 0000000000000001 0000000000000003 ffffffc0009c17d8
f680: ffffffc0009c17b8 00000000ffffff80 0000000000000003 ffffffbdd8105020
[<ffffffc0000854b4>] el1_dbg+0x18/0x6c
[<ffffffc0001769b0>] __get_vm_area_node.isra.45+0x9c/0x170
[<ffffffc000177140>] __vmalloc_node_range+0x6c/0x26c
[<ffffffc00017753c>] vzalloc+0x40/0x4c
[<ffffffc0003075e4>] check_partition+0x4c/0x224
[<ffffffc000306d0c>] rescan_partitions+0xb4/0x294
[<ffffffc0001d6afc>] __blkdev_get+0x22c/0x320
[<ffffffc0001d6c34>] blkdev_get+0x44/0x31c
[<ffffffc0003048c8>] add_disk+0x38c/0x3fc
[<ffffffc0004ceab0>] mmc_add_disk+0x24/0x110
[<ffffffc0004cf098>] mmc_blk_probe+0x1c8/0x2c0
[<ffffffc0004c257c>] mmc_bus_probe+0x1c/0x24
[<ffffffc0003e2808>] driver_probe_device+0x1ec/0x2e8
[<ffffffc0003e2a5c>] __device_attach_driver+0x8c/0xb0
[<ffffffc0003e0ac4>] bus_for_each_drv+0x54/0x94
[<ffffffc0003e2580>] __device_attach+0xc0/0x128
[<ffffffc0003e2bb4>] device_initial_probe+0x10/0x18
[<ffffffc0003e1bcc>] bus_probe_device+0x90/0x98
[<ffffffc0003dfc48>] device_add+0x3c0/0x53c
[<ffffffc0004c2a30>] mmc_add_card+0xdc/0x25c
[<ffffffc0004c5ce0>] mmc_attach_mmc+0xa4/0x150
[<ffffffc0004c2240>] mmc_rescan+0x2b4/0x338
[<ffffffc0000c998c>] process_one_work+0x138/0x308
[<ffffffc0000c9c94>] worker_thread+0x138/0x438
[<ffffffc0000cf640>] kthread+0xe0/0xf4
[<ffffffc000085c50>] ret_from_fork+0x10/0x40
Code: 97ffff86 a8c17bfd d65f03c0 f941fc00 (f85d8000)

