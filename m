From: Tejun Heo <htejun@gmail.com>
Subject: [PATCHSET] libata: update EH speed down logic
Date: Fri,  2 Nov 2007 00:51:36 +0900
Message-ID: <11939323042554-git-send-email-htejun@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from [222.235.223.38] ([222.235.223.38]:20822 "EHLO htj.dyndns.org"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1754092AbXKAPvr (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 1 Nov 2007 11:51:47 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, linux-ide@vger.kernel.org


Hello,

This patchset updates EH speed down logic such that...

* Speed down rules are less conservative.  For example, falling back
  to PIO was triggered if there have been more than 10 ATA_BUS,
  TOUT_HSM or UNK_DEV in 5 minutes.  However, 11 timeouts can't happen
  in five minutes as each timeout is 30 secs long.

* Consecutive errors occurring right after data transfer mode (NCQ
  on/off and xfermode) has been changed trigger fast back-to-back
  speed downs.  This helps libata EH find the correct transfer mode
  faster such that the user is bored less and higher level probing
  (partition scanning) doesn't fail.

This patchset contains 8 patches.  The first five prepare for speed
down logic update.  The 6th one relaxes existing speed down rules.
The last two implement fast speed down after transfer mode change.

This patchset is on top of update-EH-configurat-behavior patchset[1].

Thanks.

--
tejun

[1] http://thread.gmane.org/gmane.linux.ide/24281
