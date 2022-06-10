Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1CB9C433EF
	for <linux-ide@archiver.kernel.org>; Fri, 10 Jun 2022 11:27:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233916AbiFJL1N (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 10 Jun 2022 07:27:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349316AbiFJL1L (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 10 Jun 2022 07:27:11 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A59824CC81
        for <linux-ide@vger.kernel.org>; Fri, 10 Jun 2022 04:27:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1654860426; x=1686396426;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=5ckdIGXSG1KIByPR5vlF04MgKnReh+UddWkRmG/oJbo=;
  b=hwCJhWESmAUUs4KWoD+doeBPvptjJRbS/d4949de25bL7mj4sq6/sb71
   eVtDRs1Bq0jcMn1lQDV+gLeisSu/Jivs0iKQD1fWcIeNl4yoVwzCFCscT
   YgMRr8MMHeBsQvo1Y5qGaAZNRMFV9fFCnnNL0kmQq/hA+resub5sbL72E
   MOgPU4RQqpiAMfJpks8AALCgjzsupCMpYPUUcLqMi7F4/7ZA4hPM5ce5z
   lvCgSFLgPfUdVz/tMtGSWG9lxbFJXQ+FJbkiXTJfnK0ukCmkTG7ujQ04w
   LLLmd6NRtkdh7sDnavUlKwxLGBMmk5d2J93LwrkiDs6dHNmt7GWpEmGFn
   Q==;
X-IronPort-AV: E=Sophos;i="5.91,290,1647273600"; 
   d="scan'208";a="203569592"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 10 Jun 2022 19:27:05 +0800
IronPort-SDR: An7jfCtDB0RAQMyhCStUfFruhOmx2kUiWut84Xt+veHz05VdZk13DckOTpFnoQlhZdNdY0ydsW
 u/9PbEexPhpgTEKb3ifPe4tuWkGkggJx3K2LFuI1r3ov39TMW2/Orpn0L23/yjMCtPFtp0FJrL
 CbcmV4QD4+R4dkyI4DUYC/GzhNam2eGbqzE/Dhb/zupJl2k6EPwV1QDLAXYVKNsp1CrdXZWV3j
 oeMc2TsguLAn3ej+x92tTgzL2pGNDpaETLvFUlOM3C2GLMnb3l3mF4m9O7Kf2rYaRRVJ23k9sG
 FY/Ek3Ge9kYc4520h1IHlO+v
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 10 Jun 2022 03:50:11 -0700
IronPort-SDR: wRs4gmiKQV/ladRO5AhGoe63Ph/ayelintO90Co3YYYjvwM9FAq3WCtZtcp3oxP/+2wX+E/AlU
 mrN9asvZUaN9CQCsPUZ+umRWDeq2Q0/QaHUg0ttxmsWogBy6Z0qR8hDxEG+Wd2K4VZq/HL3Q0U
 0G80GSV8VZgBRpQJYLTqVxInuTqSPWsWNRBZMuMk8l8PJ9X3fOJUGupOs+X8WwIcXveymel1qs
 eo+GSoqQbuI33wcd89rHCOlyTDoSSFYG7B+E0jaSQVMzfxKvK5AFkq6hTtI4kCttImZoDd4+XZ
 IDM=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 10 Jun 2022 04:27:03 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4LKJZv0gzDz1Rwrw
        for <linux-ide@vger.kernel.org>; Fri, 10 Jun 2022 04:27:03 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :x-mailer:message-id:date:subject:to:from; s=dkim; t=1654860422;
         x=1657452423; bh=5ckdIGXSG1KIByPR5vlF04MgKnReh+UddWkRmG/oJbo=; b=
        jSPjcofSIVgK54lZgiZq4LDUUuhsp2eUN3LXUdHhub276OYY9CzrUNshezoo/dla
        GMQThau4c2rMq32hXOgKdng3Ie2xio9Oa9i7yDUqf0g4AKUJOzvBx6a+Y7yKgVLq
        /RX1XJU/6xDJ6sb28Z2lTWzxCzgcgERxqcsnfP5hXQTS1hSjGOvhqJnVmhAWoBci
        J5LPIuW/BSIWUsq+2a9meSINTf914oZgHr702hpQrW6N4bWep7tbdFYNAAj3uQgM
        uxRhy82k4WPi8t7cwL+iDB4UkAnpBNR2al1Ax1kinJHnbSKYbvFxxijiBgRY5OPt
        vHvUZQ+MMiyXxkS7275vlA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id lmfCCy78JX1G for <linux-ide@vger.kernel.org>;
        Fri, 10 Jun 2022 04:27:02 -0700 (PDT)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4LKJZt29l0z1Rvlc;
        Fri, 10 Jun 2022 04:27:02 -0700 (PDT)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-ide@vger.kernel.org
Subject: [GIT PULL] ata fixes for 5.19-rc2
Date:   Fri, 10 Jun 2022 20:27:00 +0900
Message-Id: <20220610112700.794521-1-damien.lemoal@opensource.wdc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Linus,

The following changes since commit f2906aa863381afb0015a9eb7fefad885d4e5a=
56:

  Linux 5.19-rc1 (2022-06-05 17:18:54 -0700)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/dlemoal/libata t=
ags/ata-5.19-rc2

for you to fetch changes up to 481f7017c37a8c722a0b09985db1a35f15749d5d:

  MAINTAINERS: add ATA sysfs file documentation to libata entry (2022-06-=
09 09:25:38 +0900)

----------------------------------------------------------------
ATA fixes for 5.19-rc2

Several small fixes for rc2:

* Remove unused field in struct ata_port, from Hannes.

* Fix a potential (very unlikely) NULL pointer dereference in
  ata_host_alloc_pinfo(), from Sergey.

* Fix a device reference leak in the pata_octeon_cf driver, from
  Miaoqian.

* Fixes for handling access to the concurrent positioning ranges log
  page used with multi-actuator HDDs, from Tyler.

* Fix the values shown by the pio_mode and dma_mode sysfs device
  attributes, from Sergey.

* Update the MAINTAINERS file to add libata sysfs ABI documentation
  file, from Sergey.

----------------------------------------------------------------
Hannes Reinecke (1):
      ata: libata: drop 'sas_last_tag'

Miaoqian Lin (1):
      ata: pata_octeon_cf: Fix refcount leak in octeon_cf_probe

Sergey Shtylyov (3):
      ata: libata-core: fix NULL pointer deref in ata_host_alloc_pinfo()
      ata: libata-transport: fix {dma|pio|xfer}_mode sysfs files
      MAINTAINERS: add ATA sysfs file documentation to libata entry

Tyler Erickson (2):
      libata: fix reading concurrent positioning ranges log
      libata: fix translation of concurrent positioning ranges

 Documentation/ABI/testing/sysfs-ata | 11 ++++++-----
 MAINTAINERS                         |  1 +
 drivers/ata/libata-core.c           | 25 +++++++++++++++----------
 drivers/ata/libata-scsi.c           |  2 +-
 drivers/ata/libata-transport.c      |  2 +-
 drivers/ata/pata_octeon_cf.c        |  3 +++
 include/linux/libata.h              |  1 -
 7 files changed, 27 insertions(+), 18 deletions(-)
