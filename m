Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34510C433EF
	for <linux-ide@archiver.kernel.org>; Fri, 10 Dec 2021 07:23:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237452AbhLJH0t (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 10 Dec 2021 02:26:49 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:13196 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237181AbhLJH0s (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 10 Dec 2021 02:26:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1639120994; x=1670656994;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=h2qQcWQINvLgjbXaJYR33Pe/ETIQwPNMPd5Bi5Bf5Ck=;
  b=YV3iXt56Odfb1nHhU2Ye4Lf3rL+CDn5p7IFJThn8vZk5yFA0jLd7p1XE
   lPBLADGp3Ht0/M78PspUroMDvtIRdlgholKSl0mbHwO4saaxlA+lG7dgQ
   r3SBWObC6WGJrLu9lE0Mka8qVs8KCSFs0o/terdDe63VfR+5LyG73scAK
   23pwL4l94j06fHrA7V8+sobHbP9YPHxZCkM/VYuTyj76ACR64DPO19LAQ
   CjZAVPqJSDsjmnEEAujVAvAzoNH9UFMj/5RWRt+dcqs1fQBFmJyVWHtbI
   wwdHLu6qFCc8GpS92yvdy0JeSfedWENe+c0TmpW/DNxLFgc+FvhIyqZoi
   g==;
X-IronPort-AV: E=Sophos;i="5.88,194,1635177600"; 
   d="scan'208";a="291903469"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 10 Dec 2021 15:23:14 +0800
IronPort-SDR: jjEaJUnaCbL0mLrOEgOXC0nYju+SmmhWfqzb1Fm5EfDvClbt6Wj5EXalam1a7mgVE0JCB1NcMI
 65QoMNLOXwDjk9g77NoLtXLtJZ0GE0DjqzwmzSr9y1XvpFFGXSja2tbWz9EIIynZlkGAeHijpH
 JGMOcXrWlM7xznqDt+/BjyStIb07j28tGLlWX0B07q8uXtWolIsLp2hoR8uC9xfM/KNAIOsPTv
 1V9jBUIkcd2y+9D6UXDTezqIQsfeiViBzmrCT7XHEDUJ7TRj7DpU7npciuzqeUbbvxWxl7papv
 dWq5vMqNLez9C7+B2WPDcU0Y
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2021 22:56:15 -0800
IronPort-SDR: sATjZPtldYcQKq7KqdExRlu4diqPItXtKZozUL0ghD3+ok6+LYVW6S5Y2RkIWGvmmSaGhfEW+X
 By49GtB2+FSwB4dp3m3M81igJdnXFdssVp0SiFq3n2fqXBCglnfnOJ5JY/O90VZRIAn0Akl3kE
 v0lTAH8NgA0N5TSvLaTfgDU33OcWVm0dx94YMLCXJ4LjnyfSZ5aAfbrRzeAIZ4EMNuijlzbPCU
 jNIV7vCADc6qoXpPWxIBAkjqR46pLpeEnkoLWkXvr62PprCEQuD3x4SkqPAhoJT+klFnQwBSkf
 g50=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2021 23:23:14 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4J9MnY5MSdz1RvTh
        for <linux-ide@vger.kernel.org>; Thu,  9 Dec 2021 23:23:13 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :x-mailer:message-id:date:subject:to:from; s=dkim; t=1639120993;
         x=1641712994; bh=h2qQcWQINvLgjbXaJYR33Pe/ETIQwPNMPd5Bi5Bf5Ck=; b=
        RUDuYybsJLv0HWHhCxgq19LtTw0+JAPBCiNeHOdSxJ3Ij41+EEmg7sftlO6FLqLt
        XWCsQQ9T2orWvFIJCq5ZM6Z7Mt/D6E62m7m3eyNh8PjUxnXSDrk4y5T0LswvzAJl
        oYy7z+ljXDfk3QFmpJcgMTRICG3v5Okf0o3n9IaN1Sjtsy6XrzzZ216m+qyeNZSd
        SiE8SKyjusMOvas6qB2UH5Tmkc9TuTKjfnq3jwH6GkyNLdSh5dyeNVkYplgY3ew0
        0kwJlVH+6RVgV5X2RsiQkzMumYbFrqUnjf0ApJW1UPoKmVH7wazmbHfuSc1Gjj7v
        8jkLXcybxBx5TbgQtwsO5Q==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id sAU6Dpr0Un7j for <linux-ide@vger.kernel.org>;
        Thu,  9 Dec 2021 23:23:13 -0800 (PST)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4J9MnX74xtz1RtVG;
        Thu,  9 Dec 2021 23:23:12 -0800 (PST)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-ide@vger.kernel.org
Subject: [GIT PULL] libata fixes for 5.16-rc5
Date:   Fri, 10 Dec 2021 16:23:09 +0900
Message-Id: <20211210072309.324363-1-damien.lemoal@opensource.wdc.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Linus,

The following changes since commit 0fcfb00b28c0b7884635dacf38e46d60bf3d4e=
b1:

  Linux 5.16-rc4 (2021-12-05 14:08:22 -0800)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/dlemoal/libata t=
ags/libata-5.16-rc5

for you to fetch changes up to a66307d473077b7aeba74e9b09c841ab3d399c2d:

  libata: add horkage for ASMedia 1092 (2021-12-09 11:20:47 +0900)

----------------------------------------------------------------
libata fixes for 5.16-rc5

* Fix a sparse warning in the ahci_ceva driver, from me
* Disable the ASMedia 1092 non-functional device, from Hannes

----------------------------------------------------------------

Damien Le Moal (1):
      ata: ahci_ceva: Fix id array access in ceva_ahci_read_id()

Hannes Reinecke (1):
      libata: add horkage for ASMedia 1092

 drivers/ata/ahci_ceva.c   | 3 ++-
 drivers/ata/libata-core.c | 2 ++
 2 files changed, 4 insertions(+), 1 deletion(-)
