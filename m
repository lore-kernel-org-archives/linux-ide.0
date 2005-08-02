From: Jens Axboe <axboe@suse.de>
Subject: Re: Crash in ide_do_request() on card removal
Date: Tue, 2 Aug 2005 13:13:04 +0200
Message-ID: <20050802111302.GH22569@suse.de>
References: <42EA1AB0.6070001@imc-berlin.de> <42EF439C.5000903@imc-berlin.de> <20050802104859.GG22569@suse.de> <42EF5488.9020802@imc-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ns.virtualhost.dk ([195.184.98.160]:56545 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261496AbVHBLLA (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 2 Aug 2005 07:11:00 -0400
Content-Disposition: inline
In-Reply-To: <42EF5488.9020802@imc-berlin.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Steven Scholz <steven.scholz@imc-berlin.de>
Cc: linux-ide@vger.kernel.org

On Tue, Aug 02 2005, Steven Scholz wrote:
> Jens Axboe wrote:
> 
> >That's not quite true, q is not invalid after this call. It will only be
> >invalid when it is freed (which doesn't happen from here but rather from
> >the blk_cleanup_queue() call when the reference count drops to 0).
> >
> >This is still not perfect, but a lot better. Does it work for you?
> >
> >--- linux-2.6.12/drivers/ide/ide-disk.c~	2005-08-02 
> >12:48:16.000000000 +0200
> >+++ linux-2.6.12/drivers/ide/ide-disk.c	2005-08-02 
> >12:48:32.000000000 +0200
> >@@ -1054,6 +1054,7 @@
> > 	drive->driver_data = NULL;
> > 	drive->devfs_name[0] = '\0';
> > 	g->private_data = NULL;
> >+	g->disk = NULL;
> > 	put_disk(g);
> > 	kfree(idkp);
> > }
> 
> No.
> drivers/ide/ide-disk.c: In function `ide_disk_release':
> drivers/ide/ide-disk.c:1057: error: structure has no member named `disk'

Eh, typo, should be g->queue of course :-)

--- linux-2.6.12/drivers/ide/ide-disk.c~	2005-08-02 12:48:16.000000000 +0200
+++ linux-2.6.12/drivers/ide/ide-disk.c	2005-08-02 13:12:54.000000000 +0200
@@ -1054,6 +1054,7 @@
 	drive->driver_data = NULL;
 	drive->devfs_name[0] = '\0';
 	g->private_data = NULL;
+	g->queue = NULL;
 	put_disk(g);
 	kfree(idkp);
 }

-- 
Jens Axboe

