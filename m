From: Tejun Heo <htejun@gmail.com>
Subject: [PATCHSET] libata: update EH speed down logic, take #2
Date: Mon,  5 Nov 2007 14:45:07 +0900
Message-ID: <1194241515653-git-send-email-htejun@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from [222.235.223.38] ([222.235.223.38]:23583 "EHLO htj.dyndns.org"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1751100AbXKEFpU (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 5 Nov 2007 00:45:20 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, linux-ide@vger.kernel.org


Hello,

This is the second take of update-EH-speed-down-logic patchset.
Changes from the last take[1] are...

* Updated to apply & build against the current linus#master.  Recently
  committed error-passthhrough-for-non-IO-command change broke build
  with this patchset applied.

This patchset is against the current linux#master (b55d1b18).

Thanks.

--
tejun

[1] http://thread.gmane.org/gmane.linux.ide/24357
