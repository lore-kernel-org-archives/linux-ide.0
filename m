From: Mark Lord <liml@rtr.ca>
Subject: Re: Playing with SATA NCQ
Date: Thu, 26 May 2005 17:50:16 -0400
Message-ID: <42964498.9080909@rtr.ca>
References: <20050526140058.GR1419@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cpu1185.adsl.bellglobal.com ([207.236.110.166]:31752 "EHLO
	mail.rtr.ca") by vger.kernel.org with ESMTP id S261804AbVEZVuV
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 26 May 2005 17:50:21 -0400
In-Reply-To: <20050526140058.GR1419@suse.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jens Axboe <axboe@suse.de>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

I also saw a good boost from NCQ on the qstor driver (full version,
not the libata subset) last year.  Very good for busy servers
and RAID arrays.

Jens Axboe wrote:
+	do {
+		/*
+		 * we rely on the FIFO order of the exclusive waitqueues
+		 */
+		prepare_to_wait_exclusive(&ap->cmd_wait_queue, &wait,
+					  TASK_UNINTERRUPTIBLE);
+
+		if (!ata_qc_issue_ok(ap, qc, 1)) {
+			spin_unlock_irq(&ap->host_set->lock);
+			schedule();
+			spin_lock_irq(&ap->host_set->lock);
+		}
+
+		finish_wait(&ap->cmd_wait_queue, &wait);
+
+	} while (!ata_qc_issue_ok(ap, qc, 1));

In this bit (above), is it possible for this code to ever
be invoked from a SCHED_RR or SCHED_FIFO context?

If so, it will lock out all lower-priority processes
for the duration of the polling interval.

Cheers
