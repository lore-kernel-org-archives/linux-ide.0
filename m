From: Prarit Bhargava <prarit@sgi.com>
Subject: [PATCH]: resubmitted: Fix erroneous rq->buffer = NULL in ide-io.c:ide_dma_timeout_retry
Date: Thu, 06 Jan 2005 10:21:56 -0500
Message-ID: <41DD5794.6080804@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:7907 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262856AbVAFPV6 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 6 Jan 2005 10:21:58 -0500
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.12.11/8.12.11) with ESMTP id j06FLwVC003735
	for <linux-ide@vger.kernel.org>; Thu, 6 Jan 2005 10:21:58 -0500
Received: from mail.boston.redhat.com (mail.boston.redhat.com [172.16.76.12])
	by int-mx1.corp.redhat.com (8.11.6/8.11.6) with ESMTP id j06FLwr05360
	for <linux-ide@vger.kernel.org>; Thu, 6 Jan 2005 10:21:58 -0500
Received: from [172.16.83.37] (dhcp83-37.boston.redhat.com [172.16.83.37])
	by mail.boston.redhat.com (8.12.8/8.12.8) with ESMTP id j06FLtne008016
	for <linux-ide@vger.kernel.org>; Thu, 6 Jan 2005 10:21:55 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Colleagues,

Please see discussion related to this patch here,

http://marc.theaimsgroup.com/?l=linux-ide&m=110485007824374&w=2

Thanks,

Prarit.


--- linux-2.5.orig/drivers/ide/ide-io.c 2005-01-04 15:45:17.000000000 -0500
+++ linux-2.5/drivers/ide/ide-io.c      2005-01-04 15:45:27.000000000 -0500
@@ -1205,21 +1205,21 @@
        HWGROUP(drive)->rq = NULL;

        rq->errors = 0;

        if (!rq->bio)
                goto out;

        rq->sector = rq->bio->bi_sector;
        rq->current_nr_sectors = bio_iovec(rq->bio)->bv_len >> 9;
        rq->hard_cur_sectors = rq->current_nr_sectors;
-       rq->buffer = NULL;
+       rq->buffer = bio_data(rq->bio);
 out:
        return ret;
 }

 /**
  *     ide_timer_expiry        -       handle lack of an IDE interrupt
  *     @data: timer callback magic (hwgroup)
  *
  *     An IDE command has timed out before the expected drive return
  *     occurred. At this point we attempt to clean up the current



