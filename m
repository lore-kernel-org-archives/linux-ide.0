From: Dan Carpenter <error27@gmail.com>
Subject: potential null deref in drivers/ide/ide-io.c start_request().
Date: Sun, 19 Jul 2009 14:43:49 +0300 (EAT)
Message-ID: <alpine.DEB.2.00.0907171322100.12306@bicker>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yx0-f184.google.com ([209.85.210.184]:47523 "EHLO
	mail-yx0-f184.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753417AbZGSMmQ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 19 Jul 2009 08:42:16 -0400
Received: by yxe14 with SMTP id 14so2909002yxe.33
        for <linux-ide@vger.kernel.org>; Sun, 19 Jul 2009 05:42:15 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hello,

I am testing a code checker (http://repo.or.cz/w/smatch.git) and it found 
an issue in ide-io.c

The case where rq->rq_disk is null and blk_special_request(rq) returns 
zero on line 356 would cause an oops on line 367.

drivers/ide/ide-io.c
   356                  } else if (!rq->rq_disk && blk_special_request(rq))
   357                          /*
   358                           * TODO: Once all ULDs have been modified to
   359                           * check for specific op codes rather than
   360                           * blindly accepting any special request, the
   361                           * check for ->rq_disk above may be replaced
   362                           * by a more suitable mechanism or even
   363                           * dropped entirely.
   364                           */
   365                          return ide_special_rq(drive, rq);
   366  
   367                  drv = *(struct ide_driver **)rq->rq_disk->private_data;

regards,
dan carpenter
