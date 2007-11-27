From: Tejun Heo <htejun@gmail.com>
Subject: [PATCHSET] libata: improve EH speed down logic, take #3
Date: Tue, 27 Nov 2007 19:28:51 +0900
Message-ID: <11961593392491-git-send-email-htejun@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.179]:11782 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752313AbXK0K3L (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 27 Nov 2007 05:29:11 -0500
Received: by wa-out-1112.google.com with SMTP id v27so1179628wah
        for <linux-ide@vger.kernel.org>; Tue, 27 Nov 2007 02:29:10 -0800 (PST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, linux-ide@vger.kernel.org
Cc: bzolnier@gmail.com


Hello,

This is the third take of improve-EH-speed-down-logic patchset.
Changes from the last take[1] are...

* 0002-add-protocol-data-transfer-tests is replaced with
  0002-implement-protocol-tests which is more efficient and generic.
  The patch also replaces is_atapi_taskfile() and other open coded
  protocol tests with new test functions.

This patchset is against the current libata-dev#upstream (51a7ee37)
and available from the following git tree.

master.kernel.org:/pub/scm/linux/kernel/git/tj/libata-dev.git improve-speed-down

Thanks.

--
tejun

[1] http://thread.gmane.org/gmane.linux.ide/24497
