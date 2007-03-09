From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: Bugs in kernels 2.6.20 plus 2.6.21 rc1 and 2
Date: Fri, 9 Mar 2007 23:04:36 +0100
Message-ID: <200703092304.37080.bzolnier@gmail.com>
References: <20070309140908.286450@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.175]:7041 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933405AbXCIV5k (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 9 Mar 2007 16:57:40 -0500
Received: by ug-out-1314.google.com with SMTP id 44so1486605uga
        for <linux-ide@vger.kernel.org>; Fri, 09 Mar 2007 13:57:39 -0800 (PST)
In-Reply-To: <20070309140908.286450@gmx.net>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Uwe Bugla <uwe.bugla@gmx.de>
Cc: torvalds@linux-foundation.org, akpm@linux-foundation.org, linux-kernel@vger.kernel.org, Alan <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org


Hi,

On Friday 09 March 2007, Uwe Bugla wrote:
> Hello Bart, hello everybody,
> 
> As requested I applied the following patch with parameter -R against 2.6.20:
> http://kernel.org/pub/linux/kernel/people/bart/ide-2.6.20.patch
> 
> Result: incompilable kernel! Reason is the following hunk:
> 
> 99,113d98
> < diff --git a/drivers/ide/ide-probe.c b/drivers/ide/ide-probe.c
> < index dad9c47..5a5c565 100644
> < --- a/drivers/ide/ide-probe.c
> < +++ b/drivers/ide/ide-probe.c
> < @@ -1000,10 +1000,6 @@ static int ide_init_queue(ide_drive_t *drive)
> <  	/* needs drive->queue to be set */
> <  	ide_toggle_bounce(drive, 1);
> <  
> < -	/* enable led activity for disk drives only */
> < -	if (drive->media == ide_disk && hwif->led_act)
> < -		blk_queue_activity_fn(q, hwif->led_act, drive);
> < -
> <  	return 0;
> <  }
> <  
> 
> Would you please care for proper patch sets in future, just for efficiency reasons?

Doh, I missed the chunk of the block layer patch, sorry for that.

> Side note: One diode of my TEAC CDRW54 (/dev/hdd) flickers every 2 seconds.
> That's normal and it does not do any harm.
> 
> 
> I ripped out this hunk and applied the resulting patch
> collection with parameter -R against 2.6.20.
> Results:
> a. compilable kernel 
> b. SUCCESS after endless hours of testing!

2.6.20 "good" kernel has newer build date then the "bad" 2.6.20.1
test kernel (with the IDE patchset reversed)?

> 3 conclusions from that:
> 
> 1. The buggy code responsible for the horrible reinitialization
> and drive seek errors with my TEAC CDRW54 as /dev/hdd
> is proven to reside in the patch collection mentioned above.

Nope, unfortunately this only proves that all 2.6.20 changes modulo IDE
changes doesn't seem to cause the problems.  "Unfortunately" because it
would be much easier for me to just find guilty change in the patchset,
take the blame and fix it :-) but...

There are only 6 changes in the patchset which influence the _code_ that
is used by your hardware/driver configuration and none seems to actually
influence the driver _behavior_ on your system:

* [PATCH] ide-cd: Handle strange interrupt on the Intel ESB2

	the quirk code is not executed on ICH4 chipset

* [PATCH] PIIX: remove check for broken MW DMA mode 0

	dead code removal

* [PATCH] PIIX/SLC90E66: PIO mode fallback fix

	not used on your hardware as both hdc and hdd use DMA modes

* [PATCH] remove blk_queue_activity_fn

	dead code removal

* ide: unregister idepnp driver on unload

	ide-pnp is not used on this system

* [PATCH] lockdep: fix ide/proc interaction

	shouldn't change anything - the code is executed only during
	device driver (ide-cd etc.) removal

Besides the PCI configuration for IDE chipset is the same for both kernels.

Something really fishy is going on here... I'm out of ideas for the moment.
Maybe except retesting 2.6.19 + ide-2.6.20.patch applied...

Thanks,
Bart
