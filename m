From: Steven Scholz <steven.scholz@imc-berlin.de>
Subject: Re: Crash in ide_do_request() on card removal
Date: Thu, 18 Aug 2005 14:59:54 +0200
Message-ID: <4304864A.7050405@imc-berlin.de>
References: <42EA1AB0.6070001@imc-berlin.de> <42EF5488.9020802@imc-berlin.de>	 <20050802111302.GH22569@suse.de> <42EF5651.1040905@imc-berlin.de>	 <20050802112804.GJ22569@suse.de> <42EF594C.7090902@imc-berlin.de>	 <20050802113328.GK22569@suse.de> <42EF626B.6090103@imc-berlin.de>	 <20050802122609.GM22569@suse.de> <42EF69AD.30201@imc-berlin.de> <58cb370e05080206282af4cf0a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.imc-berlin.de ([217.110.46.186]:47114 "EHLO
	mail.imc-berlin.de") by vger.kernel.org with ESMTP id S932209AbVHRM75
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 18 Aug 2005 08:59:57 -0400
In-Reply-To: <58cb370e05080206282af4cf0a@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Jens Axboe <axboe@suse.de>, linux-ide@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:

> On 8/2/05, Steven Scholz <steven.scholz@imc-berlin.de> wrote:
> 
>>Jens Axboe wrote:
> 
> 
>>do_ide_request() could check hwif->present and/or drive->present.
>>BUT: at this point the request is already made and the low level block layer is
>>sleeping and waiting for it's completion.
>>I could not figure out how to kill a request in do_ide_request() and wake up the
>>block layer (sleeping in __wait_on_buffer()).
>>That's why I thought preventing the generation of such reuqests would be the
>>right way.
>>
>>
>>>I suggest you take it up with Bart how best to solve this. He might even
>>>already have patches.
>>
>>Bart? Are you there?
> 
> 
> IDE device unplug TODO :)
> * add ide_device_get() helper which will check for drive->present
>   + increase reference count on drive->gendev and ide_device_put()
>   helper which will decrease reference count on drive->gendev
> * propagate usage of these helpers to device drivers (ide_disk_get() etc.)
>   so there won't be _new_ requests after removal of the device
> * if !drive->present fail _old_ requests (as already mentioned by Jens)
> * add proper locking around drive->present
> * ...
> 
> first three points should be relatively easy

What's the status here?

Although patching do_ide_request() (see mail from 2.8.2005) helped a bit I've 
seen a crash in elv_queue_empty():

cardmgr[220]: shutting down socket 0
cardmgr[220]: executing: './ide stop hda'
cardmgr[220]: + umount -v /dev/hda1
Unable to handle kernel paging request at virtual address 6a202f20
pgd = c09d0000
[6a202f20] *pgd=00000000
Internal error: Oops: 0 [#1]
Modules linked in: ide_cs pcmcia at91_cf pcmcia_core imcdevif imcdevd imcevents
CPU: 0
PC is at 0x6a202f20
LR is at elv_queue_empty+0x28/0x40
...
Process umount (pid: 339, stack limit = 0xc094a194)
...
Backtrace:
(elv_queue_empty+0x0/0x40) from (__make_request+0xa4/0x50c)
(__make_request+0x0/0x50c) from [<c00f0690>] (generic_make_request+0x20c/0x228)
(generic_make_request+0x0/0x228) from [<c00f0780>] (submit_bio+0xd4/0xf4)
(submit_bio+0x0/0xf4) from [<c006c038>] (submit_bh+0x164/0x190)
(submit_bh+0x0/0x190) from [<c0069a94>] (__bread_slow+0x7c/0xc4)
(__bread_slow+0x0/0xc4) from [<c0069d98>] (__bread+0x24/0x30)
(__bread+0x0/0x30) from [<c00adf2c>] (fat_clusters_flush+0x30/0xd0)
(fat_clusters_flush+0x0/0xd0) from [<c00ac994>] (fat_put_super+0x24/0x94) 
(fat_put_super+0x0/0x94) from [<c006dfa0>] (generic_shutdown_super+0xdc/0x188) 
(generic_shutdown_super+0x0/0x188) from (kill_block_super+0x28/0x3c) 
(kill_block_super+0x0/0x3c) from (deactivate_super+0x58/0x6c)
(deactivate_super+0x0/0x6c) from (__mntput+0x2c/0x30)
(__mntput+0x0/0x30) from [<c0074e70>] (path_release_on_umount+0x4c/0x50)
(path_release_on_umount+0x0/0x50) from [<c00846b0>] (sys_umount+0x98/0xa0)
(sys_umount+0x0/0xa0) from [<c00846cc>] (sys_oldumount+0x14/0x18) 
(sys_oldumount+0x0/0x18) from [<c0019c60>] (ret_fast_syscall+0x0/0x2c)
Code: bad PC value.
  Badness in do_exit at kernel/exit.c:787
(dump_stack+0x0/0x14) from [<c0032184>] (do_exit+0x40/0x3b4)
(do_exit+0x0/0x3b4) from [<c001f090>] (die+0xf8/0x10c)
(die+0x0/0x10c) from [<c0020894>] (__do_kernel_fault+0x6c/0x7c)
(__do_kernel_fault+0x0/0x7c) from [<c0020bbc>] (do_page_fault+0x104/0x118)
(do_page_fault+0x0/0x118) from [<c0020bfc>] (do_translation_fault+0x2c/0xac)
(do_translation_fault+0x0/0xac) from [<c0020d90>] (do_PrefetchAbort+0x18/0x1c) 
(do_PrefetchAbort+0x0/0x1c) from [<c00199e0>] (__pabt_svc+0x40/0x80)
(elv_queue_empty+0x0/0x40) from [<c00efd44>] (__make_request+0xa4/0x50c)
(__make_request+0x0/0x50c) from [<c00f0690>] (generic_make_request+0x20c/0x228)
(generic_make_request+0x0/0x228) from [<c00f0780>] (submit_bio+0xd4/0xf4)
(submit_bio+0x0/0xf4) from [<c006c038>] (submit_bh+0x164/0x190)
(submit_bh+0x0/0x190) from [<c0069a94>] (__bread_slow+0x7c/0xc4)
(__bread_slow+0x0/0xc4) from [<c0069d98>] (__bread+0x24/0x30)
(__bread+0x0/0x30) from [<c00adf2c>] (fat_clusters_flush+0x30/0xd0)
(fat_clusters_flush+0x0/0xd0) from [<c00ac994>] (fat_put_super+0x24/0x94)
(fat_put_super+0x0/0x94) from [<c006dfa0>] (generic_shutdown_super+0xdc/0x188) 
(generic_shutdown_super+0x0/0x188) from (kill_block_super+0x28/0x3c)
(kill_block_super+0x0/0x3c) from [<c006de24>] (deactivate_super+0x58/0x6c)
(deactivate_super+0x0/0x6c) from [<c00840c4>] (__mntput+0x2c/0x30) 
(__mntput+0x0/0x30) from [<c0074e70>] (path_release_on_umount+0x4c/0x50)
(path_release_on_umount+0x0/0x50) from [<c00846b0>] (sys_umount+0x98/0xa0) 
(sys_umount+0x0/0xa0) from [<c00846cc>] (sys_oldumount+0x14/0x18) 
(sys_oldumount+0x0/0x18) from [<c0019c60>] (ret_fast_syscall+0x0/0x2c)
cardmgr[220]: + Segmentation fault
cardmgr[220]: stop cmd exited with status 1
cardmgr[220]: executing: 'modprobe -r ide-cs'
cardmgr[220]: BEEP_OK
