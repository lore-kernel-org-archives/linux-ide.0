Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CEE0C433F5
	for <linux-ide@archiver.kernel.org>; Fri, 28 Jan 2022 12:10:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348337AbiA1MKM (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 28 Jan 2022 07:10:12 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:58416 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234483AbiA1MKL (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 28 Jan 2022 07:10:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1643371810; x=1674907810;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ii3W7+R+YdnPGm2CL6kcYMLb7VP2jXLh8x1Lhcp2yk4=;
  b=VgrRpJdi41KsN1WCBjYJOMIdT8x1kDfTFXMONH3wJ1SF6E0ml9984+0o
   gz2LoQp98UCMt46oBi1qFF3V9+Umfcgbt7B9fBr56lsFevpypkkY0wAtD
   ZS3RWFoV3gHt30X3bHoLBDDY/729zJyHTsFQE3S5F1tSzw8iRx37FXcAp
   4lWv48sOIW5tYworrmEtM7GlOAGwh9ieuq1AbEe6+cb6Tg0bUDlQXGQzU
   O0dMHkTmD0L1n1ls3mZ/m2ajR6Q0qGaEWJvy2a/MkYzEuc2RlVljyWu6c
   5Wy6KDkps1McVuRip/pchH1EEdyerX48LQCQ4tf/s1PbXwPjMA/A8Csh7
   w==;
X-IronPort-AV: E=Sophos;i="5.88,323,1635177600"; 
   d="scan'208";a="196431321"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 28 Jan 2022 20:10:09 +0800
IronPort-SDR: 791VGIEUIHlacRAjNT7QD/Uv97hC6vg/kVmDH9XLqCBNsB1F8UcspUXPTCZpz6Mw8aVU2ZJtt9
 kz1WNl8QMG5m1/21kO1CZKD8AVOK31J2puxfpfZuYMw07G3NOspECi4DmBlAzGEP6VO8oevVSp
 6KmTWmPeFlseNVfqO7WMpdy3HzFKzOUSOCT2gnQG3hDsoChCTKhDbfIc5ePP2/5K3MtfrjH1P7
 MNeZ8CloReUHj2fyxcDbAlfIZtWUQ3yxJdxNtFzJBmtfSvgZJ5LyLZe18fdXyr4vugr4REHYsv
 BZRGgzj9DdJFGzQ0lnKHqq18
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2022 03:42:13 -0800
IronPort-SDR: bu0sia0zVG4pMhlW6j/mj2si8N562vOPWdUpJhrMwnwNQtneoBmiz6hv2n3gGx4s+LJPIYuJxE
 eqr0U7HcvyG8CPHIiHuogNE2skivexMlACUa1IESs/4FtJ0qzgtTlVoPgyXKxXNqcFEG6k9A+/
 LxG6zE/cXZgsaXyZcNFTn+KObc0og+HSB70T3MDNY1yZWosbRzfx0p8OVvsSSsMTwSDswbMlWi
 8YdBMoTNCMdsSIBeoP/iQL1m2yZ5FjtglblGK5GMk25rBlpzTzIisGu3zAtc4M0XO/g6ntud/1
 PKU=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2022 04:10:11 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Jlbr25yPyz1SHwl
        for <linux-ide@vger.kernel.org>; Fri, 28 Jan 2022 04:10:10 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :x-mailer:message-id:date:subject:to:from; s=dkim; t=1643371810;
         x=1645963811; bh=ii3W7+R+YdnPGm2CL6kcYMLb7VP2jXLh8x1Lhcp2yk4=; b=
        J+S1q1J3GME8aaKUmSc00D5J62DE68m7S4F6LqFjtjP1MbWXA7iqygvaVzyEcfNj
        LI0aJN3/+Miec7EZ3LDOFo06WqcAQ7vcH71+9/1ofS34PiqUXETaqrAJkfVU3wcA
        sm27abRkwEeUDRbviGdWIoN0ka+eEsDl6uqdWYy9IgXpezAM6LnZcK1UIqc1Zju6
        59+x3PuOSRlNoOeiGjbpVocdJwoUVMmaUSJoI/nxRVD2ooc1mdO4mjkNPXqJnlVn
        d+n8L7aTL6jA3oJauPtMp8zsnww3Hb06IENz7krLozNquztA539eUKmQTRvmsZU7
        INHrL6025cwX7lG5Sa507A==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id b-KYuiktYCwh for <linux-ide@vger.kernel.org>;
        Fri, 28 Jan 2022 04:10:10 -0800 (PST)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Jlbr16dyWz1RvlN;
        Fri, 28 Jan 2022 04:10:09 -0800 (PST)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-ide@vger.kernel.org
Subject: [GIT PULL] Revert ata fix for 5.17-rc2
Date:   Fri, 28 Jan 2022 21:10:08 +0900
Message-Id: <20220128121008.46586-1-damien.lemoal@opensource.wdc.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Linus,

I forgot about the umn.edu situation and accepted a patch, which was the =
single
fix in my earlier pull request. This pull request reverts the patch. My
apologies for the noise.

The following changes since commit 9b6d90e2085ca2ce72ef9ea78658bf270855e6=
2e:

  ata: pata_platform: Fix a NULL pointer dereference in __pata_platform_p=
robe() (2022-01-27 11:22:43 +0900)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/dlemoal/libata t=
ags/ata-5.17-rc2-revert

for you to fetch changes up to c3c7882349b92155737a2299d616f586211bde72:

  Revert "ata: pata_platform: Fix a NULL pointer dereference in __pata_pl=
atform_probe()" (2022-01-28 20:58:38 +0900)

----------------------------------------------------------------
Revert ata fix for 5.17.0-rc2

Revert patch from umn.edu as this instituion is not allowed to
contribute to the Linux kernel until it has properly resolved its
development issues.

----------------------------------------------------------------
Damien Le Moal (1):
      Revert "ata: pata_platform: Fix a NULL pointer dereference in __pat=
a_platform_probe()"

 drivers/ata/pata_platform.c | 2 --
 1 file changed, 2 deletions(-)
