From: Jens Axboe <axboe@suse.de>
Subject: [PATCH] 2.5.34 IDE
Date: Wed, 11 Sep 2002 10:01:07 +0200
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <20020911080107.GA6444@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from brick.kernel.dk ([195.249.94.204] helo=burns.home.kernel.dk)
	by virtualhost.dk with esmtp (Exim 3.35 #1)
	id 17p2R6-0004Qn-00
	for linux-ide@vger.kernel.org; Wed, 11 Sep 2002 10:01:20 +0200
Received: from axboe by burns.home.kernel.dk with local (Exim 4.10)
	id 17p2Qt-0001gY-00
	for linux-ide@vger.kernel.org; Wed, 11 Sep 2002 10:01:07 +0200
Content-Disposition: inline
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

----- Forwarded message from Jens Axboe <axboe@suse.de> -----

From: Jens Axboe <axboe@suse.de>
Date: Wed, 11 Sep 2002 10:00:36 +0200
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] 2.5.34 IDE

Hi,

I've updated 2.5 IDE code to match what is currently in 2.4.20-pre5-ac4,
since is much nicer and better structured. There have also been some
cleanups along the way, all of which have been passed back to Alan for
the 2.4 tree.

If you feel adventorous, please try:

*.kernel.org:/pub/linux/kernel/people/axboe/patches/v2.5/2.5.34/ide-2.5.34-4.gz

Note that the patch is _huge_ because it moves files around! I've also
got this in a bk tree with proper file moving etc (and patch split in a
million pieces), but that's mainly for Linus to pull (ie its on
master right now, and I'm not inclined to move it). If someone wants to
see it though, I can probably put it somewhere public.

If you apply against 2.5.34-BK (instead of 2.5.34 virgin), note that
some parts are already in. In that case, remove the parts of the diff
that update:

arch/i386/pci/common.c
arch/i386/pci/i386.c
arch/i386/pci/pci.h
arch/i386/pci/visws.c
drivers/pci/pci.c
include/linux/blkdev.h
include/linux/hdreg.h
include/linux/pci.h
include/linux/pci_ids.h

-- 
Jens Axboe


----- End forwarded message -----

-- 
Jens Axboe

