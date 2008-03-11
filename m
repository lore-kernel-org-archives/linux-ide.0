From: Tejun Heo <htejun@gmail.com>
Subject: [PATCHSET libata-dev#upstream] libata: prefer hardreset, take #2
Date: Tue, 11 Mar 2008 12:41:38 +0900
Message-ID: <12052069033338-git-send-email-htejun@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.231]:23562 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753082AbYCKDlw (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 10 Mar 2008 23:41:52 -0400
Received: by wx-out-0506.google.com with SMTP id h31so2280945wxd.4
        for <linux-ide@vger.kernel.org>; Mon, 10 Mar 2008 20:41:51 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, linux-ide@vger.kernel.org
Cc: mikpe@it.uu.se


Hello,

This is the second take of prefer-hardreset patchset.

Changes from the last take [L] are...

* Updated to the current upstream.

* Audited against code before new EH was introduced (2.6.17) to
  prevent using hardreset on controllers which don't like it.

  - Hardresets on some versions of sata_nv fail to classify devices.
    This is alrady worked around by deferring classification to SRST.
    No further workaround necessary.

  - Hardreset on sata_via vt6420 was flaky.  sata_via already has only
    SRST.  No further workaround necessary.

  - sata_sx4 doesn't have SCRs.  No further workaround necessary.

  - sata_qstor.  SRST is broken.  Already has workaround implemented.
    No further workaround necessary.

  - All variants of sata_promise preferred SRST over COMRESET.  Can't
    find out explanation why.  Unless there's known problem, I'd like
    to convert it to prefer COMRESET if Mikael acks it.

  So, sans sata_promise, things don't change too much compared against
  2.6.17.

Preferring softreset over hardreset seemed okay at the beginning but
libata has been and continue accumulating more and more quirks to
promote reset to COMRESET to avoid SRST failure.

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

This patchset is against the current upstream (bc5468f5).

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

--
tejun

[L] http://thread.gmane.org/gmane.linux.ide/27447
