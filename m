From: Andreas Werner <andreas.werner@men.de>
Subject: [PATCH 0/2] libata: introduce ATA_FLAG_NO_LOG_PAGE
Date: Fri, 4 Dec 2015 16:52:18 +0100
Message-ID: <cover.1449243748.git.andreas.werner@men.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail1.bemta14.messagelabs.com ([193.109.254.114]:9707 "EHLO
	mail1.bemta14.messagelabs.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753385AbbLDPyR (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 4 Dec 2015 10:54:17 -0500
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-ide@vger.kernel.org, tj@kernel.org

This patchset add a new ata port flag ATA_FLAG_NO_LOG_PAGE to be able
to blacklist ports/controller which e.g. locks up on a log page read.

This flag is added to the sata_fsl driver which is the first affected
one.

The lockup was detected on Freescale P1013/P1022, T4240 using a ATP
mSATA.
The device failed during initialisation if the SATA device includes the
devslp feature.

With this patchset, we blacklist the fsl sata controller and return
a error on any attempt to read a log page. This allows us to access
the mSATA.

Andreas Werner (2):
  libata-eh.c: Introduce new ata port flag for controller which lockup
    on read log page
  ata/sata_fsl.c: add ATA_FLAG_NO_LOG_PAGE to blacklist the controller
    for log page reads

 drivers/ata/libata-eh.c | 9 +++++++++
 drivers/ata/sata_fsl.c  | 3 ++-
 include/linux/libata.h  | 1 +
 3 files changed, 12 insertions(+), 1 deletion(-)

-- 
2.6.2

