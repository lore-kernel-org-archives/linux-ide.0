From: Chuck Ebbert <cebbert@redhat.com>
Subject: Re: Kernel bug crashing in HDIO_DRIVE_TASKFILE
Date: Tue, 24 Feb 2009 17:10:44 -0500
Message-ID: <20090224171044.52e70a6b@dhcp-100-2-144.bos.redhat.com>
References: <82AA7849DFA14958B6A74CB6ED0B591B@DIAMOND8600>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx2.redhat.com ([66.187.237.31]:52001 "EHLO mx2.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752273AbZBXWK6 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 24 Feb 2009 17:10:58 -0500
In-Reply-To: <82AA7849DFA14958B6A74CB6ED0B591B@DIAMOND8600>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Norman Diamond <n0diamond@yahoo.co.jp>
Cc: linux-ide@vger.kernel.org, Jens Axboe <jens.axboe@oracle.com>

On Tue, 24 Feb 2009 20:36:52 +0900
"Norman Diamond" <n0diamond@yahoo.co.jp> wrote:

> Kernel 2.6.27.7 in Slax gets a panic or oops (I can't tell which).
> Of course I had to recompile the Slax kernel with CONFIG_IDE_TASK_IOCTL enabled.
> Kernel 2.6.19 in Knoppix handles the same HDIO_DRIVE_TASKFILE perfectly.
> In all cases /dev/hda has no mounted partitions and it is free for me to write to.
> 
> 100% reproduced in four configurations:
> (1) drive supports LBA48 and WRITE_DMA_EXT was used
> (2) drive supports LBA48 but WRITE_DMA (LBA28) was used
> (3) drive doesn't support LBA48 and WRITE_DMA was used
> (4) VMware drive probably supports LBA48 but WRITE_DMA was used
> I am trying to write 126 sectors starting at sector number 0.
> (Of course the real purpose of the program will not be to write 126 sectors starting at 0.)
> 
> kernel BUG at block/cfg-iosched.c:2001!
> invalid opcode: 0000 [#1] SMP
> Modules linked in: pcmcia pcmcia_core lp pcspkr ppdev parport_pc isp1760 pcnet32
>  psmouse serio_raw mii i2c_piix4 parport shpchp intel_agp agpgart evdev fuse auf
> s squashfs sqlzma unlzma [last unloaded: pcmcia_core]
> 
> Pid: 3634, comm: pee3en Tainted: G        W (2.6.27.7 #1)
> EIP: 0060:[<c03be1a5>] EFLAGS: 00010046 CPU: 0
> EIP is at cfq_put_request+0x45/0x50
> EAX: 00000000 EBX: dec59960 ECX: c03be160 EDX: 00000001
> ESI: defa0a50 EDI: dec3f230 EBP: 00000400 ESP: def09d5c
>  DS: 007b ES: 007b FS: 00d8 GS: 0033 SS: 0068
> Process pee3en (pid: 3634, ti=def08000 task=dec1ee00 task.ti=def08000)
> Stack: dec59960 000104c9 c03b20c0 c03b4441 dec3f230 dec59960 00000282 def09dd8
>        c03b4829 fffffffb 0000007e dec59960 c045e308 00000000 df32d850 d9000640
>        00000000 00000004 0000fc00 c045f273 0000007e 00000000 def09ea0 def09dd8
> Call Trace:
>  [<c03b20c0>] elv_put_request+0x10/0x20
>  [<c03b4441>] __blk_put_request+0x71/0x80
>  [<c03b4829>] blk_put_request+0x29/0x50
>  [<c045e308>] ide_raw_taskfile+0x78/0x90
>  [<c045f273>] ide_taskfile_ioctl+0x283/0x4c0
>  [<c0469a8d>] idedisk_ioctl+0x3d/0x150
>  [<c03b88fd>] blkdev_driver_ioctl+0x6d/0x80
>  [<c03b8b9e>] blkdev_ioctl+0x283/0x820
>  [<c0175705>] do_sync_write+0xd5/0x120
>  [<c0156517>] get_page_from_freelist+0x2c7/0x440
>  [<c01568b8>] __alloc_pages_internal+0xa8/0x430
>  [<c015f9d4>] unmap_vmas+0x364/0x560
>  [<c01593f6>] __pagevec_lru_add_active+0x96/0xb0
>  [<c016066c>] handle_mm_fault+0x46c/0x640
>  [<c01638e4>] vma_merge+0x144/0x1d0
>  [<c019c2a8>] block_ioctl+0x18/0x20
>  [<c019c290>] block_ioctl+0x0/0x20
>  [<c018178b>] vfs_ioctl+0x2b/0x90
>  [<c0181a4b>] do_vfs_ioctl+0x25b/0x2a0
>  [<c0181ae6>] sys_ioctl+0x56/0x70
>  [<c0103262>] syscall_call+0x7/0xb
>  =======================
> Code: e8 01 89 44 96 2c 8b 43 58 8b 40 10 e8 a5 90 ff ff 89 f0 c7 43 58 00 00 00
>  00 c7 43 5c 00 00 00 00 5b 5e e9 3e ff ff ff 5b 5e c3 <0f> 0b eb fe 8d b4 26 00
>  00 00 00 83 ec 08 89 1c 24 89 d3 89 74
> EIP: [<c03be1a5>] cfq_put_request+0x45/0x50 SS:ESP 0068:def09d5c
> ---[ end trace 4eaa2a86a8e2da22 ]---
> 

block/cfq-iosched.c:
/*
 * queue lock held here
 */
static void cfq_put_request(struct request *rq)
{
	struct cfq_queue *cfqq = RQ_CFQQ(rq);

	if (cfqq) {
		const int rw = rq_data_dir(rq);

		BUG_ON(!cfqq->allocated[rw]);     <================
		cfqq->allocated[rw]--;

		put_io_context(RQ_CIC(rq)->ioc);

		rq->elevator_private = NULL;
		rq->elevator_private2 = NULL;

		cfq_put_queue(cfqq);
	}
}

You should try 2.6.27.6 and 2.6.27.19 to see if they have the bug too.
