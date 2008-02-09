From: Tejun Heo <htejun@gmail.com>
Subject: [PATCHSET #upstream] block/libata: update and use block layer padding and draining, take 2
Date: Sat,  9 Feb 2008 10:40:19 +0900
Message-ID: <12025212262892-git-send-email-htejun@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.187]:57403 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756214AbYBIBke (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 8 Feb 2008 20:40:34 -0500
Received: by rv-out-0910.google.com with SMTP id k20so2705689rvb.1
        for <linux-ide@vger.kernel.org>; Fri, 08 Feb 2008 17:40:33 -0800 (PST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, linux-ide@vger.kernel.org, jens.axboe@oracle.com, linux-scsi@vger.kernel.org, fujita.tomonori@lab.ntt.co.jp, James.Bottomley@HansenPartnership.com, akpm@linux-foundation.org


This is the second take of blk-layer-padding-and-draining patchset.
Changes from the last take[L] are...

* libata-update-ATAPI-overflow-draining patch added.  This patch fixes
  up ATAPI PIO handling before updating it to use block layer
  draining.  consumed accounting and atapi_qc_may_overflow() update
  will survive blk draining conversion.

* blk-clear-drain-buffer-for-writes patch added.  This patch makes
  block layer clear drain buffer before chaining it to the sg list if
  the command in question is a write.

* libata-implement-drain-buffers updated such that
  atapi_drain_needed() uses the same logic as atapi_qc_may_overflow()
  and ATAPI PIO drain logic is replaced too.

This patchset is against the current upstream
(bc5468f52b785ffa1fe0ea289baec2c51384d436).

Thanks.

--
tejun

[L] http://thread.gmane.org/gmane.linux.ide/28048
