From: Tejun Heo <htejun@gmail.com>
Subject: [PATCHSET libata-dev#upstream] libata: prefer hardreset
Date: Thu, 24 Jan 2008 00:21:36 +0900
Message-ID: <12011017011072-git-send-email-htejun@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.177]:27671 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752039AbYAWPVr (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 23 Jan 2008 10:21:47 -0500
Received: by wa-out-1112.google.com with SMTP id v27so5108030wah.23
        for <linux-ide@vger.kernel.org>; Wed, 23 Jan 2008 07:21:47 -0800 (PST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, linux-ide@vger.kernel.org

Hello, all.

This is the first take of prefer-hardreset patchset.  I've been
meaning to do this for quite some time now.  Preferring softreset over
hardreset seemed okay at the beginning but libata has been and
continue accumulating more and more quirks to promote reset to
COMRESET to avoid SRST failure.

For example, any host which supports PMP should use COMRESET because
some PMPs don't reset properly only with SRST.  Another interesting
example is PMP fan-out ports.  Depending on how the spec is read, the
fan-out ports arguably requires hardreset to begin operation.

Also, SRST doesn't reset certain aspects of device configuration and
can result in inconsistent configurations which may lead to
revalidation failure after a PHY event or resume.

I can't find any merit of preferring SRST other than the warm fuzzy
feeling of the word 'soft' in front of it, especially when preferring
SRST means libata has to carray a bunch of quirks to avoid SRST for
cases it might not work.

For more rationales, please read patch description of the first patch.

This patchset contains five patches.  The first one makes libata
prefer COMRESET and the rest four kills quirks and simplifes related
codes.

This patchset is against the current upstream (a984f58d).

 drivers/ata/ahci.c        |   16 ++----
 drivers/ata/libata-core.c |   28 ++---------
 drivers/ata/libata-eh.c   |  114 ++++++++++++++++------------------------------
 drivers/ata/libata-pmp.c  |   57 ++++++-----------------
 drivers/ata/libata-scsi.c |    7 +-
 drivers/ata/sata_fsl.c    |    4 -
 drivers/ata/sata_mv.c     |   29 ++---------
 drivers/ata/sata_nv.c     |   17 ++----
 drivers/ata/sata_sil.c    |    5 --
 drivers/ata/sata_sil24.c  |   58 ++++++++++-------------
 drivers/ata/sata_via.c    |    2 
 include/linux/libata.h    |   24 ++-------
 12 files changed, 120 insertions(+), 241 deletions(-)

Thanks.

--
tejun
