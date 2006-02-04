From: Richard Purdie <rpurdie@rpsys.net>
Subject: Re: [PATCH 10/11] LED: Add IDE disk activity LED trigger
Date: Sat, 04 Feb 2006 15:29:54 +0000
Message-ID: <1139066994.8064.12.camel@localhost.localdomain>
References: <1138714918.6869.139.camel@localhost.localdomain>
	 <58cb370e0601310646y263acb96h62c422435e7016e@mail.gmail.com>
	 <1138724479.6869.201.camel@localhost.localdomain>
	 <58cb370e0601310944l421174f8j1802d94f1ae93a01@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from tim.rpsys.net ([194.106.48.114]:20124 "EHLO tim.rpsys.net")
	by vger.kernel.org with ESMTP id S932519AbWBDPaF (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 4 Feb 2006 10:30:05 -0500
In-Reply-To: <58cb370e0601310944l421174f8j1802d94f1ae93a01@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Linux-ide <linux-ide@vger.kernel.org>

Hi,

On Tue, 2006-01-31 at 18:44 +0100, Bartlomiej Zolnierkiewicz wrote: 
> > The trigger started out as just being ide-disk.c based but there is no
> > place where the IDE end request function could be hooked within it due
> > to its use of generic functions. The trigger therefore had to move into
> > more generic code. If there was a point in ide-disk where an IDE end
> > request could be hooked it, it could be confined to that file.
> 
> Isn't ->end_request hook in ide_driver_t enough?
> 
> I see no reason why the custom ->end_request function cannot
> be added to ide-disk.  All needed infrastructure is there.

Not quite as I tried that once and it didn't intercept every
->end_request call. I've just traced this to an explicit call to
ide_end_request() rather than drv->end_request() in ide-taskfile.c

The patch below might or might not be an appropriate fix. With this
applied, the led trigger simplifies to:
http://www.rpsys.net/openzaurus/patches/led_ide-r3.patch

Richard


Ensure ide-taskfile.c calls any driver specific end_request function
if present.

Signed-off-by: Richard Purdie <rpurdie@rpsys.net>

Index: linux-2.6.15/drivers/ide/ide-taskfile.c
===================================================================
--- linux-2.6.15.orig/drivers/ide/ide-taskfile.c	2006-01-03 03:21:10.000000000 +0000
+++ linux-2.6.15/drivers/ide/ide-taskfile.c	2006-02-04 14:02:23.000000000 +0000
@@ -372,7 +372,13 @@
 		}
 	}
 
-	ide_end_request(drive, 1, rq->hard_nr_sectors);
+	if (rq->rq_disk) {
+		ide_driver_t *drv;
+
+		drv = *(ide_driver_t **)rq->rq_disk->private_data;;
+		drv->end_request(drive, 1, rq->hard_nr_sectors);
+	} else
+		ide_end_request(drive, 1, rq->hard_nr_sectors);
 }
 
 /*


