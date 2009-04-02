From: Jeff Garzik <jeff@garzik.org>
Subject: IDE, packet commands and REQ_TYPE_SENSE?
Date: Thu, 02 Apr 2009 05:31:44 -0400
Message-ID: <49D48600.2070109@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:43418 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751545AbZDBJbt (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 2 Apr 2009 05:31:49 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Linux IDE mailing list <linux-ide@vger.kernel.org>
Cc: Jens Axboe <jens.axboe@oracle.com>, LKML <linux-kernel@vger.kernel.org>

Looking at REQ_TYPE_*, I see that REQ_TYPE_SENSE is only used once in an 
assignment, and appears to never be tested anywhere.

Furthermore, the use of REQ_TYPE_SENSE immediately follows a previous 
assignment rq->cmd_type assignment:

cdrom_queue_request_sense():
[...]
         /* stuff the sense request in front of our current request */
         blk_rq_init(NULL, rq);
         rq->cmd_type = REQ_TYPE_ATA_PC;
         rq->rq_disk = info->disk;

         rq->data = sense;
         rq->cmd[0] = GPCMD_REQUEST_SENSE;
         rq->cmd[4] = 18;
         rq->data_len = 18;

         rq->cmd_type = REQ_TYPE_SENSE;
         rq->cmd_flags |= REQ_PREEMPT;
[...]

First, the code assigns REQ_TYPE_ATA_PC, then without any intervening 
tests or branches, it assigns REQ_TYPE_SENSE.

So, some questions...

Is REQ_TYPE_ATA_PC sufficient (i.e. the first assignment)?

Can we get rid of REQ_TYPE_SENSE?

What are the differences between REQ_TYPE_ATA_PC and REQ_TYPE_BLOCK_PC? 
  Would it be possible to eliminate REQ_TYPE_ATA_PC after some work, as 
well?

	Jeff



