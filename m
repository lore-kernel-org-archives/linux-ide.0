From: Tejun Heo <htejun@gmail.com>
Subject: [PATCHSET #upstream-fixes] block/libata: update and use block layer padding and draining, take 3
Date: Tue, 11 Mar 2008 13:27:29 +0900
Message-ID: <12052096544056-git-send-email-htejun@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hs-out-0708.google.com ([64.233.178.249]:20757 "EHLO
	hs-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751192AbYCKE1l (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 11 Mar 2008 00:27:41 -0400
Received: by hs-out-0708.google.com with SMTP id 4so1686001hsl.5
        for <linux-ide@vger.kernel.org>; Mon, 10 Mar 2008 21:27:40 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, linux-ide@vger.kernel.org
Cc: mikpe@it.uu.se


Hello,

After posting the previous patchset, I realized #upstream is proper
subset of #upstream-fixes, so here's the updated version against
#upstream-fixes.  It still needs Mikael's ack regarding behavior
change on sata_promise.

Changes from the last take[L] are...

* Updated against the current #upstream-fixes.

This patchset is against the current #upstream-fixes (3db691da).

 drivers/ata/ahci.c        |   17 ++----
 drivers/ata/libata-core.c |   28 ++---------
 drivers/ata/libata-eh.c   |  114 ++++++++++++++++------------------------------
 drivers/ata/libata-pmp.c  |   57 ++++++-----------------
 drivers/ata/libata-scsi.c |    7 +-
 drivers/ata/sata_fsl.c    |    4 -
 drivers/ata/sata_mv.c     |   31 +++---------
 drivers/ata/sata_nv.c     |   17 ++----
 drivers/ata/sata_sil.c    |    5 --
 drivers/ata/sata_sil24.c  |   58 ++++++++++-------------
 drivers/ata/sata_via.c    |    2
 include/linux/libata.h    |   24 ++-------
 12 files changed, 121 insertions(+), 243 deletions(-)

[L] http://thread.gmane.org/gmane.linux.ide/29637

--
tejun
