From: Tejun Heo <htejun@gmail.com>
Subject: [PATCHSET #upstream] libata: improve ATAPI data transfer handling, take #4
Date: Wed,  2 Jan 2008 20:12:46 +0900
Message-ID: <11992723701811-git-send-email-htejun@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.176]:20183 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758262AbYABLM7 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 2 Jan 2008 06:12:59 -0500
Received: by wa-out-1112.google.com with SMTP id v27so9016555wah.23
        for <linux-ide@vger.kernel.org>; Wed, 02 Jan 2008 03:12:58 -0800 (PST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, linux-ide@vger.kernel.org


Hello,

This is the fourth take of improve-ATAPI-data-transfer patchset.
Changes from the last take [L] are

* Patches other than 8, 13, 14 and 15 have been committed to #upstream
  and thus dropped from this patchset.

* Due to merge order, pata_pcmcia is now out-of-sync with data_xfer
  prototype update.  A patch was added to convert pata_pcmcia.

* Patch 13, 14 and 15 are updated to apply on top of the current
  #upstream.

This patchset is agaisnt the current #upstream (32a03e13).

Thanks.

--
tejun

[L] http://thread.gmane.org/gmane.linux.ide/25938
