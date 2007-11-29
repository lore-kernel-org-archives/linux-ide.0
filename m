From: Tejun Heo <htejun@gmail.com>
Subject: [PATCHSET] libata: improve ATAPI data transfer handling, take #2
Date: Thu, 29 Nov 2007 23:33:23 +0900
Message-ID: <1196346817387-git-send-email-htejun@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.176]:41523 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761421AbXK2Odo (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 29 Nov 2007 09:33:44 -0500
Received: by wa-out-1112.google.com with SMTP id v27so2204916wah
        for <linux-ide@vger.kernel.org>; Thu, 29 Nov 2007 06:33:44 -0800 (PST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, linux-ide@vger.kernel.org, alan@lxorguk.ukuu.org.uk, liml@rtr.ca, albertl@mail.com, jens.axboe@oracle.com


Hello,

This is the second take of improve-ATAPI-data-transfer patchset.
Changes from the last take [L] are.

* 0005-libata-make-data_xfer-return-the-number-of-consum.patch added
  which converts ->data_xfer to return the number of consumed bytes.

* 0006-libata-improve-ATAPI-draining.patch is fixed and updated.
  Drain limit check is fixed.  Now both partial and whole chunk
  draining uses the correct byte count.  LLDs doing 32bit IO can now
  drain properly instead of draining twice as much.  Also, draining is
  done in large chunks (PAGE_SIZE at maximum).

* ata_drain_page allocation is moved to 0006 from
  0012-libata-implement-ATAPI-drain-buffer.patch.

This patchset is against

   #upstream (51a7ee37eaa85b8c35fe6090618e34ed4ce1d316)
 + improve-speed-down patchset, take #3  [1]
 + improve-timing-cod-and-fix-pata_amd, take #2 [2]

This patchset is also available as the following git tree.

master.kernel.org:/pub/scm/linux/kernel/git/tj/libata-dev.git improve-ATAPI-data-transfer

Thanks.

--
tejun

[L] http://thread.gmane.org/gmane.linux.ide/25437
[1] http://thread.gmane.org/gmane.linux.ide/25406
[2] http://thread.gmane.org/gmane.linux.ide/25416
