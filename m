From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: [PATCH] fix kernel oops, when IDE-Device (CF-Card) is
  removed while mounted.
Date: Wed, 14 Sep 2005 03:02:38 -0400
Message-ID: <200509140305_MC3-1-AA1F-6810@compuserve.com>
Mime-Version: 1.0
Content-Type: text/plain;
	 charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from liaag2ag.mx.compuserve.com ([149.174.40.158]:20195 "EHLO
	liaag2ag.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S932686AbVINHGM (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 14 Sep 2005 03:06:12 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Thomas Kleffel <tk@maintech.de>, linux-ide <linux-ide@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>

In-Reply-To: <58cb370e050913013677fec525@mail.gmail.com>

On Tue, 13 Sep 2005 at 10:36:42 +0200, Bartlomiej Zolnierkiewicz wrote:

> >  From your responses I read that the correct solution would be to keep
> > the old pysical device as long as the ide layer still has references to
> > it and to fail all requests in the meantime.
> > 
> > Is that correct?
> 
> Yes, we should just fail all the requests if the device is not present.
> [ What do you mean by the old physical device, old 'ide_drive_t *'? ]

 Jens Axboe posted this patch for the same problem on 2 Aug:

===========================================================================
=====
That's not quite true, q is not invalid after this call. It will only be
invalid when it is freed (which doesn't happen from here but rather from
the blk_cleanup_queue() call when the reference count drops to 0).

This is still not perfect, but a lot better. Does it work for you?

--- linux-2.6.12/drivers/ide/ide-disk.c~        2005-08-02
12:48:16.000000000 +0200
+++ linux-2.6.12/drivers/ide/ide-disk.c 2005-08-02 12:48:32.000000000 +0200
@@ -1054,6 +1054,7 @@
        drive->driver_data = NULL;
        drive->devfs_name[0] = '\0';
        g->private_data = NULL;
+       g->disk = NULL;
        put_disk(g);
        kfree(idkp);
 }
__
Chuck
