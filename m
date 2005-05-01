From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: IDE problems in 2.6.12-rc1-bk1 onwards (was Re: 2.6.12-rc3-mm1)
Date: Sun, 1 May 2005 20:41:03 +0200
Message-ID: <58cb370e0505011141a2b3c58@mail.gmail.com>
References: <03be01c54e77$83d86980$0f01a8c0@max>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.204]:13708 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262640AbVEASlG convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 1 May 2005 14:41:06 -0400
Received: by wproxy.gmail.com with SMTP id 68so1531883wra
        for <linux-ide@vger.kernel.org>; Sun, 01 May 2005 11:41:03 -0700 (PDT)
In-Reply-To: <03be01c54e77$83d86980$0f01a8c0@max>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Richard Purdie <rpurdie@rpsys.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Dominik Brodowski <linux@brodo.de>, Andrew Morton <akpm@osdl.org>, linux-ide@vger.kernel.org

On 5/1/05, Richard Purdie <rpurdie@rpsys.net> wrote:
> I've switched back to 2.6.12-rc3-mm1 and added some debuging to all the ide
> functions to trace the order functions are getting called. I've shown the
> result below for two different oops. There is more than one problem. The
> first problem was introduced in 2.6.12-rc1-bk1 in the ide-disk changes. The
> second has been around for a while but is showing up again.
>  
> The problem is idedisk_cleanup() gets called twice from ide_unregister().
> Once here:
> 
>  for (unit = 0; unit < MAX_DRIVES; ++unit) {
>   drive = &hwif->drives[unit];
>   if (!drive->present)
>    continue;
>   DRIVER(drive)->cleanup(drive);
>  }
> 
> and secondly in ide_unregister indirectly via:
> 
>   blk_cleanup_queue(drive->queue);
>   printk(KERN_ERR "ide_unregister4()\n");
>   device_unregister(&drive->gendev);
>   down(&drive->gendev_rel_sem);
>   spin_lock_irq(&ide_lock);
>   drive->queue = NULL;
>   printk(KERN_ERR "ide_unregister5()\n");
> 
> device_unregister()  triggers ide_drive_remove() which calls
> DRIVER(drive)->cleanup(drive);
> 
> In the first call to idedisk_cleanup(), ide_disk_put(idkp) is called which
> decreases the reference counter to zero. This triggers ide_disk_release()
> which calls kfree(idkp). Hence the second call to idedisk_cleanup() calls
> what is now a null pointer (or worse).

Thanks for excellent debugging.

Both problems should be fixed by "convert IDE device drivers to 
driver-model" patch but I need to resync it against latest kernels.

Bartlomiej
