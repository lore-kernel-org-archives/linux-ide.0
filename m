Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7EE2C433F5
	for <linux-ide@archiver.kernel.org>; Fri, 19 Nov 2021 22:13:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234697AbhKSWQ6 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 19 Nov 2021 17:16:58 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:3829 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234683AbhKSWQ6 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 19 Nov 2021 17:16:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1637360035; x=1668896035;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=9Ne8XDu2LMYGguxmHhe70Fwy/niUri5p2XP19vODlSo=;
  b=oX3clqTyhbaeMFXw9s13uPlaMBNp5lRNVmwn/9MXtFNOOkHELjsC1Pj0
   rHDnUFvOSNMRmnbuWkTg3fLrxqupglzNUSRYP2/4QiWa+zeM0q9RNw3Ie
   8yeAS3XbZgALI1r2DlTVbY2Ktij0wIxtAix3XdzBwV+nZet1aNJU9uvjD
   Ktbn5RqqY7kAFwvOdcf1Pv7LpxsRyMHOxBRDxnSmEm/IbkmSDST3MwXIx
   EihVtyuEpc1AsMoFdrIjZe7ISdk8uFdGg7blHeO7K8Hp7c3jvOr2uWqea
   T5Wegmno49NBBPJOFLGcrCTMsDDjdKX5WnJO5R0nPEBAbS3ANQnI+cQ5x
   g==;
X-IronPort-AV: E=Sophos;i="5.87,248,1631548800"; 
   d="scan'208";a="297974920"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 20 Nov 2021 06:13:55 +0800
IronPort-SDR: v5cpgqCp0/UOZ4SGjr9IC8qzypo6w9pzIXMPi30eOeD3jCSaKA8CW4jH8sTDEVVFYOTMA1/fiD
 RRqr2I2YFqpLduoLMbzJ+Fe8MsMmw54k7mNjGpYVMhOxM7AuIbD6z9sMdK1WVZnD5a8aEyIMvx
 h1ZIVnuSmPLkfKHa95709Otm+mFP6mZPraBMJSQhBDE7+yrc8FbKhOWy56xJ5ka89Lqr45HTc2
 EYdX7Yin0q6RjeGE6W3wgNM7MY1KoYhhe3xXvvaHRiZzjeLph87bdIo+ymsPffEtwYNHyIsWFH
 9OtjK4w4W6CDdXQIyGLp1Ai/
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2021 13:48:54 -0800
IronPort-SDR: svTY32E5UcynplZkO1RzJMxrVo2GtOmWnr09nRhosSFhVjYFOVKIqDp2uPWjR98wzi/vJXAPvk
 R8+mWa1jxljvYoY2EoKmAEvyp0qVa7XdGZhSbuSNWuDrDkcSKdZ7575rWr7aAHAeqjqQX5CzRk
 TNbKQEWC1Fm/30ouuiGnGPhU4tSBN1TvtHgRvxQwZYYKUoBXA00UMXXExY1LiziEZQZyAKqrZ/
 SMPHbW0vvn/hZthAk0KOILCHYu8mB1R2rv5xczrp8U0dkcl52jMPjl74DhFwvCHSFnSkbupVkj
 m/M=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2021 14:13:53 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4HwrXv5Cpdz1RtVm
        for <linux-ide@vger.kernel.org>; Fri, 19 Nov 2021 14:13:51 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :x-mailer:message-id:date:subject:to:from; s=dkim; t=1637360031;
         x=1639952032; bh=9Ne8XDu2LMYGguxmHhe70Fwy/niUri5p2XP19vODlSo=; b=
        HfyO82MhRHz4FegMhBfG5hcdrBy+ocP9dDpFcr9BdmL+FgWd3Kjqj1MPKBgo6B4s
        y+X0kp1zqFAR7h1ZitiQAWo3SBvaKlfs0brR81gBwUY0PkIdyjp95l485CLZm2zC
        ao/DTZTIsMRDzxQlrM+Bvl7nWCI2aPQqXICqM4mWmhKL3OOfGsHxfCsNGAmtIalX
        x9/i+R/Dv3tglvUYWOtz1JZj790phjmooBDP745bzzR2Lz0gfbKO8PEFtSVdj9hG
        NEjj8cI5LNP3A5TQRNJIwHoLXlnso6YpS6DUzzmNmFwyBkH6zZ6+oAX0nM+YbxOO
        bVReCIJUZ1lko/O2jHY5Vg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id QqF1F9fJ5fLv for <linux-ide@vger.kernel.org>;
        Fri, 19 Nov 2021 14:13:51 -0800 (PST)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4HwrXt6vp2z1RtVl;
        Fri, 19 Nov 2021 14:13:50 -0800 (PST)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-ide@vger.kernel.org
Subject: [GIT PULL] libata fixes for 5.16-rc2
Date:   Sat, 20 Nov 2021 07:13:49 +0900
Message-Id: <20211119221349.130509-1-damien.lemoal@opensource.wdc.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Linus,

The following changes since commit fa55b7dcdc43c1aa1ba12bca9d2dd4318c2a0d=
bf:

  Linux 5.16-rc1 (2021-11-14 13:56:52 -0800)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/dlemoal/libata t=
ags/libata-5.16-rc2

for you to fetch changes up to cac7e8b5f5fa94e28d581fbb9e76cb1c0c7fd56a:

  ata: libata-sata: Declare ata_ncq_sdev_attrs static (2021-11-18 14:34:2=
5 +0900)

----------------------------------------------------------------
libata fixes for 5.16-rc2

* Prevent accesses to unsupported log pages as that causes device scan
  failures with LLDDs using libsas (from me).
* A couple of fixes for AMD AHCI adapters handling of low power modes
  and resume (from Mario).
* Fix a compilation warning (from me).

----------------------------------------------------------------
Damien Le Moal (3):
      ata: libata: improve ata_read_log_page() error message
      ata: libata: add missing ata_identify_page_supported() calls
      ata: libata-sata: Declare ata_ncq_sdev_attrs static

Mario Limonciello (2):
      ata: ahci: Add Green Sardine vendor ID as board_ahci_mobile
      ata: libahci: Adjust behavior when StorageD3Enable _DSD is set

 drivers/ata/ahci.c        |  1 +
 drivers/ata/libahci.c     | 15 +++++++++++++++
 drivers/ata/libata-core.c | 11 ++++++++---
 drivers/ata/libata-sata.c |  2 +-
 4 files changed, 25 insertions(+), 4 deletions(-)
