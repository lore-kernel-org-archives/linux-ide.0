From: Albert Lee <albertcc@tw.ibm.com>
Subject: [PATCH 0/2] libata: ata_pio_task() accessing 'ap->pio_task_state'
 fix
Date: Fri, 02 Sep 2005 23:48:03 +0800
Message-ID: <43187433.9080204@tw.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e32.co.us.ibm.com ([32.97.110.130]:17819 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751506AbVIBPto
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 2 Sep 2005 11:49:44 -0400
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e32.co.us.ibm.com (8.12.10/8.12.9) with ESMTP id j82FnVKL332278
	for <linux-ide@vger.kernel.org>; Fri, 2 Sep 2005 11:49:32 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay04.boulder.ibm.com (8.12.10/NCO/VERS6.7) with ESMTP id j82FmXM9364758
	for <linux-ide@vger.kernel.org>; Fri, 2 Sep 2005 09:48:33 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11/8.13.3) with ESMTP id j82FmEV9007311
	for <linux-ide@vger.kernel.org>; Fri, 2 Sep 2005 09:48:15 -0600
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Linux IDE <linux-ide@vger.kernel.org>, Doug Maxey <dwm@maxeymade.com>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Tejun Heo <htejun@gmail.com>

Jeff,

During PIO, after calling ata_poll_qc_complete(), the next command might be
running and the value of 'ap->pio_task_state' might have been changed.
Accessing 'ap->pio_task_state' is not safe at this point.

Ex.
qc 1 completed. queuing a final task with ap->pio_task_state == PIO_ST_IDLE.
qc 2 started, queuing a new task with ap->pio_task_state set to PIO_ST.
qc 1 read ap->pio_task_state as PIO_ST; not PIO_ST_IDLE as expected.
=> 2 qc running in the workqueue with pio_task_state PIO_ST.

Changes:
  1/2: Modify ata_pio_complete() and ata_pio_block() to return
       whether qc has been completed.

  2/2: Modify ata_pio_task() to check the return value. Only queue next 
step and
        access 'ap->pio_task_state' if the command is not completed.

Patch for 2.6.13 (80ac2912f846c01d702774bb6aa7100ec71e88b9).
Tested on x86 with Promise PDC20275 and LG DVD-Multi drive.
For your review and advice, thanks.

Albert

