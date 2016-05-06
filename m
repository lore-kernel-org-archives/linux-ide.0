From: Joseph Salisbury <joseph.salisbury@canonical.com>
Subject: [v4.4-rc1 Regression] scsi: use host wide tags by default
Date: Fri, 6 May 2016 09:53:57 -0400
Message-ID: <572CA1F5.2040200@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:42015 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757850AbcEFNyE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 6 May 2016 09:54:04 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Hannes Reinecke <hare@suse.de>, James Bottomley <JBottomley@Odin.com>, Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

Hello Christoph,

A kernel bug report was opened against Ubuntu [0].  After a kernel
bisect, it was found that reverting the following commit resolved this bug:

commit 64d513ac31bd02a3c9b69ef04444f36c196f9a9d
Author: Christoph Hellwig <hch@lst.de>
Date:   Thu Oct 8 09:28:04 2015 +0100

    scsi: use host wide tags by default


The regression was introduced as of v4.4-rc1.

I was hoping to get your feedback, since you are the patch author.  Do
you think gathering any additional data will help diagnose this issue,
or would it be best to submit a revert request?
      

Thanks,
    
Joe

[0] http://pad.lv/1561830


