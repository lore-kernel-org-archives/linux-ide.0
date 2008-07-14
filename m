From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCHSET 2.6.26] block: implement extended devt, take #2
Date: Mon, 14 Jul 2008 16:15:58 +0900
Message-ID: <487AFD2E.7070400__17802.4182249375$1216019856$gmane$org@gmail.com>
References: <1216019534-29977-1-git-send-email-tj@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ti-out-0910.google.com ([209.85.142.184]:44068 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756649AbYGNHQM (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 14 Jul 2008 03:16:12 -0400
Received: by ti-out-0910.google.com with SMTP id b6so2216667tic.23
        for <linux-ide@vger.kernel.org>; Mon, 14 Jul 2008 00:16:09 -0700 (PDT)
In-Reply-To: <1216019534-29977-1-git-send-email-tj@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jens.axboe@oracle.com, James.Bottomley@HansenPartnership.com, bharrosh@panasas.com, greg.freemyer@gmail.com, linux-scsi@vger.kernel.org, brking@linux.vnet.ibm.com, liml@rtr.ca, viro@f

Oops, missed one prerequisite patch.

Tejun Heo wrote:
>   v2.6.26 (bce7f793daec3e65ec5c5705d2457b81fe7b5725)
> + [1] RCU-implement-rcu_read_[un]lock_preempt
> + [2] block-fix-block_class-iteration-locking
> + [3] block-allow-deleting-zero-lenght-partition
> + [4] block-update-add_partition-error-handling
+ [5] sd-update-index-allocation-and-use-ida

> [L] http://thread.gmane.org/gmane.linux.kernel/701825
> [1] http://article.gmane.org/gmane.linux.kernel/706149
> [2] http://article.gmane.org/gmane.linux.kernel/706152
> [3] http://article.gmane.org/gmane.linux.kernel/706153
> [4] http://article.gmane.org/gmane.linux.kernel/706154
[5] http://article.gmane.org/gmane.linux.scsi/43109

The git tree has everything included.

Thanks.

-- 
tejun
