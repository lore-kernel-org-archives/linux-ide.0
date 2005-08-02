From: Steven Scholz <steven.scholz@imc-berlin.de>
Subject: Re: Crash in ide_do_request() on card removal
Date: Tue, 02 Aug 2005 14:09:15 +0200
Message-ID: <42EF626B.6090103@imc-berlin.de>
References: <42EA1AB0.6070001@imc-berlin.de> <42EF439C.5000903@imc-berlin.de> <20050802104859.GG22569@suse.de> <42EF5488.9020802@imc-berlin.de> <20050802111302.GH22569@suse.de> <42EF5651.1040905@imc-berlin.de> <20050802112804.GJ22569@suse.de> <42EF594C.7090902@imc-berlin.de> <20050802113328.GK22569@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.imc-berlin.de ([217.110.46.186]:37900 "EHLO
	mail.imc-berlin.de") by vger.kernel.org with ESMTP id S261423AbVHBMJR
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 2 Aug 2005 08:09:17 -0400
In-Reply-To: <20050802113328.GK22569@suse.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jens Axboe <axboe@suse.de>
Cc: linux-ide@vger.kernel.org

Jens Axboe wrote:

> On Tue, Aug 02 2005, Steven Scholz wrote:
> 
>>Jens Axboe wrote:
>>
>>
>>>On Tue, Aug 02 2005, Steven Scholz wrote:
>>>
>>>
>>>>Jens Axboe wrote:
>>>>
>>>>
>>>>
>>>>>On Tue, Aug 02 2005, Steven Scholz wrote:
>>>>>
>>>>>
>>>>>
>>>>>>Jens Axboe wrote:
>>>>>>
>>>>>>
>>>>>>
>>>>>>
>>>>>>>That's not quite true, q is not invalid after this call. It will only 
>>>>>>>be
>>>>>>>invalid when it is freed (which doesn't happen from here but rather 
>>>>>>>from
>>>>>>>the blk_cleanup_queue() call when the reference count drops to 0).
>>>>>>>
>>>>>>>This is still not perfect, but a lot better. Does it work for you?
>>>>>>>
>>>>>>>--- linux-2.6.12/drivers/ide/ide-disk.c~	2005-08-02 
>>>>>>>12:48:16.000000000 +0200
>>>>>>>+++ linux-2.6.12/drivers/ide/ide-disk.c	2005-08-02 
>>>>>>>12:48:32.000000000 +0200
>>>>>>>@@ -1054,6 +1054,7 @@
>>>>>>>	drive->driver_data = NULL;
>>>>>>>	drive->devfs_name[0] = '\0';
>>>>>>>	g->private_data = NULL;
>>>>>>>+	g->disk = NULL;
>>>>>>>	put_disk(g);
>>>>>>>	kfree(idkp);
>>>>>>>}
>>>>>>
>>>>>>No.
>>>>>>drivers/ide/ide-disk.c: In function `ide_disk_release':
>>>>>>drivers/ide/ide-disk.c:1057: error: structure has no member named `disk'
>>>>>
>>>>>
>>>>>Eh, typo, should be g->queue of course :-)
>>>>>
>>>>>--- linux-2.6.12/drivers/ide/ide-disk.c~	2005-08-02 
>>>>>12:48:16.000000000 +0200
>>>>>+++ linux-2.6.12/drivers/ide/ide-disk.c	2005-08-02 
>>>>>13:12:54.000000000 +0200
>>>>>@@ -1054,6 +1054,7 @@
>>>>>	drive->driver_data = NULL;
>>>>>	drive->devfs_name[0] = '\0';
>>>>>	g->private_data = NULL;
>>>>>+	g->queue = NULL;
>>>>>	put_disk(g);
>>>>>	kfree(idkp);
>>>>>}
>>>>
>>>>No. That does not work:
>>>>
>>>>~ # umount /mnt/pcmcia/
>>>>generic_make_request(2859) q=c02d3040
>>>>__generic_unplug_device(1447) calling q->request_fn() @ c00f97ec
>>>>
>>>>do_ide_request(1281) HWIF=c01dee8c (0), HWGROUP=c089cea0 (1038681856), 
>>>>drive=c01def1c (0, 0), queue=c02d3040 (00000000)
>>>>do_ide_request(1287) HWIF is not present anymore!!!
>>>>do_ide_request(1291) DRIVE is not present anymore. SKIPPING REQUEST!!!
>>>>
>>>>As you can see generic_make_request() still has the pointer to that queue!
>>>>It gets it with
>>>>
>>>>	q = bdev_get_queue(bio->bi_bdev);
>>>>
>>>>So the pointer is still stored soemwhere else...
>>>
>>>
>>>Hmmm, perhaps just let ide end requests where the drive has been
>>>removed might be better. 
>>
>>I don't understand what you mean.
>>
>>If requests are issued (e.g calling umount) after the drive is gone, then I 
>>get either a kernel crash or umount hangs cause it waits in 
>>__wait_on_buffer() ...
> 
> 
> No, those waiters will be woken up when ide does an end_request for
> requests coming in for a device which no longer exists.

But that would mean generating requests for devices, drives and hwifs that no 
longer exists. But exactly there it will crash! In do_ide_request() and 
ide_do_request().

ide_unregister() restores some old hwif structure. drive and queue are set to 
NULL. When I wait "long enough" between "cardctl eject" and "umount" it looks 
like this:

~ # cardctl eject
ide_release(398)
ide_unregister(585): index=0
ide_unregister(698) old HWIF restored!
hwif=c01dee8c (0), hwgroup=c0fac2a0, drive=00000000, queue=00000000
ide_detach(164)
cardmgr[253]: shutting down socket 0
cardmgr[253]: executing: './ide stop hda'
cardmgr[253]: executing: 'modprobe -r ide-cs'
exit_ide_cs(514)

~ # umount /mnt/pcmcia/
sys_umount(494)
generic_make_request(2859) q=c02d3040
__generic_unplug_device(1447) calling q->request_fn() @ c00f97e4
do_ide_request(1279) HWIF=c01dee8c (0), HWGROUP=c0fac2a0 (738987520), 
drive=c01def1c (0, 0), queue=c02d3040 (00000000)
Assertion '(hwif->present)' failed in drivers/ide/ide-io.c:do_ide_request(1284)
Assertion '(drive->present)' failed in drivers/ide/ide-io.c:do_ide_request(1290)
ide_do_request(1133) hwgroup is busy!
ide_do_request(1135) hwif=01000406

The "738987520" above is hwgroup->busy! Obviously completly wrong. This seems to 
be a hint that an invalid pointer is dereferenced! The pointer hwif=01000406 
also does not look very healthy! drive=c01def1c is the result of

	drive = choose_drive(hwgroup);

but can't be as it was set to NULL before.

If I don't wait "long enough"  between "cardctl eject" and "umount" the kernel 
crashes with:

~ # cardctl eject; umount /mnt/pcmcia
ide_release(398)
ide_unregister(585): index=0
ide_unregister(698) old HWIF restored!
hwif=c01dee8c (0), hwgroup=c0268080, drive=00000000, queue=00000000
ide_detach(164)
cardmgr[253]: shutting down socket 0
cardmgr[253]: executing: './ide stop hda'
sys_umount(494) retval=0
generic_make_request(2859) q=c02d3040
__generic_unplug_device(1447) calling q->request_fn() @ c00f97e4
do_ide_request(1279) HWIF=c01dee8c (0), HWGROUP=c0268080 (0), drive=c01def1c (0, 
0), queue=c02d3040 (00000000)
Assertion '(hwif->present)' failed in drivers/ide/ide-io.c:do_ide_request(1284)
Assertion '(drive->present)' failed in drivers/ide/ide-io.c:do_ide_request(1290)
Assertion '(hwgroup->drive)' failed in drivers/ide/ide-io.c:ide_do_request(1124)
ide_do_request(1127) hwgroup->drive=00000000 !!!!!!!!!!!
Unable to handle kernel NULL pointer dereference at virtual address 00000010
...
Internal error: Oops: 17 [#1]
Modules linked in: ide_cs pcmcia at91_cf pcmcia_core
CPU: 0
PC is at ide_do_request+0xe0/0x4f4

It crashes in choose_drive()...

So how could you generate requests (and handle them sanely) for devices that 
where removed?

If the drive would only had a hardware failure then probably a timeout would 
occure and some error handling would take place.
But when the drive was officially unregistered then no more requests should be 
generated! I think that's why generic_make_request() checks

		q = bdev_get_queue(bio->bi_bdev);
		if (!q) {
			printk(KERN_ERR
			       "generic_make_request: Trying to access "
				"nonexistent block-device %s (%Lu)\n",
				bdevname(bio->bi_bdev, b),
				(long long) bio->bi_sector);

(You probably noted that I am not too deep into the IDE/block devices buisness...)

--
Steven

