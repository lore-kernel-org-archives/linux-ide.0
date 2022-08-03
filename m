Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63CC0C19F28
	for <linux-ide@archiver.kernel.org>; Wed,  3 Aug 2022 06:38:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235211AbiHCGie (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 3 Aug 2022 02:38:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234832AbiHCGia (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 3 Aug 2022 02:38:30 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F43E57258
        for <linux-ide@vger.kernel.org>; Tue,  2 Aug 2022 23:38:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1659508709; x=1691044709;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=FSv8P2lFFKYpQaKJy/OXz4qqH1HsC/GIQOr7oPVWQYg=;
  b=JXJcApAvJL/OHSFdRg2leE8wzZ0+x5fI+gX4mtbpCSklqtC0QUlevNMC
   IWbNlPrxakl3YsK8IJ91rj+95fkiTyfMWvtu/ZWekYb5fZBE1MO3PbLhr
   XIoldcyYCO+1BD+9BUNkR7MgmcGxs8pvno4g6bBtZC6QOexY198Rw8ore
   I1gvuZZLtcYlOCVC7R9fxNQ2bhRoKuni2X7M5XOWwwnJ3m7c6UV9OHHqz
   39Mq3oD5X/v4bHGIL+bAZaQ/EkEJeW/TU5GN7EE9lgPdj+jqMO0Pwgnip
   +k1ltZo94KC6T9kXIGI0YNQAR5QorqyD8plBo1km/es1caVDsKenryAYW
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,213,1654531200"; 
   d="scan'208";a="208254348"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 03 Aug 2022 14:38:28 +0800
IronPort-SDR: BrRcnsOVHcJXFeZeBAEnM2gbEci1oKAqA02YMCfTzvlUytl3+BiUs98Va0JU+N1XfqUIO1JKMl
 f+rQnejm9Y+/IBbN5ZC52zvWDyVL+uwbn6neuppcLP9mdkKmugXr5D8RbYLPUcf6Rt+PDYAUsM
 9RvfN5GpI3IX0XoGUFq+UqBa93lMcx81FFS3XO1f1W81xNroLtv6BnbVE05sEzjiVpMFzN8Pxx
 Ug/Lvr3kVPRofb0DSEUZBxodi70fgqAbsxEhQIXnh962XOEK+3A8uuh3ypiz/+70Ck9vDAfYzx
 K+HIBEYBlNOw1zTm32LTKiTM
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 02 Aug 2022 22:59:31 -0700
IronPort-SDR: F55njYoPVFc/O3WwuDo3/ek2BMqPOWaz6l3v/I2ikcnt3PcUuDTBviSrZZAFeN8pxB4URtk8W0
 u+NZf1F0tK8/wX290UF9+XFwhP9rGOReuQ1D1pWSZRv+1vOmO48dTIdM7j87KTe/+ysZca/rR9
 q6xDkf3seB59FdoRnqu/28KbA5dV4qZm/9weys1iFPZsQyrN3W8e78Hr4Tpz6UmfCgftIUPhp8
 F6xXnCNLYegTxyE4FOiNUHinFM65c9RzRU1AwpYeEZzlmzoM+A9bNvrFqkyMwW1dddYs49VLmg
 PoU=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 02 Aug 2022 23:38:28 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4LyMcz5n2vz1Rw4L
        for <linux-ide@vger.kernel.org>; Tue,  2 Aug 2022 23:38:27 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :x-mailer:message-id:date:subject:to:from; s=dkim; t=1659508707;
         x=1662100708; bh=FSv8P2lFFKYpQaKJy/OXz4qqH1HsC/GIQOr7oPVWQYg=; b=
        BtfuLqJK5W5p5kQo1MTKYIaejSL2/xG2Poq1PB2namrLTLwVbjdx2hb3mk9CNMxU
        n2Tc8ZktnBA99ldW/ioXM0ueVg836vb67qOCh3DAct2AUPNJEDLLh1ZhtAzoY107
        035lKAUqpgW4WuPkFgANlHy5tzmSM4Ojk/e+Ds3npp431268tfWEsL1YoBLtx2jT
        SL1Z8MUDJY0SRHS4g1ZfoVy82nx4ZU5pN+KbTBy9RH+ZKeuAs0kLT9T2/4NhGb4K
        ME//dJCJkxnCFZNoIM9ReLgl5Cg3/fL6K3KbwNhNqDR6N6pq9CbtmcUyFQI21e5S
        ZZPaDX6oPzwKc3Ajp8+ImQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id aCX7BbQGqipc for <linux-ide@vger.kernel.org>;
        Tue,  2 Aug 2022 23:38:27 -0700 (PDT)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4LyMcz09MDz1RtVk;
        Tue,  2 Aug 2022 23:38:26 -0700 (PDT)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-ide@vger.kernel.org
Subject: [GIT PULL] ata changes for 5.20-rc1
Date:   Wed,  3 Aug 2022 15:38:25 +0900
Message-Id: <20220803063825.986717-1-damien.lemoal@opensource.wdc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Linus,

The following changes since commit b13baccc3850ca8b8cccbf8ed9912dbaa0fdf7=
f3:

  Linux 5.19-rc2 (2022-06-12 16:11:37 -0700)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/dlemoal/libata t=
ags/ata-5.20-rc1

for you to fetch changes up to b3b2bec9646eb1d3f43c85f6d0d2211d6f8af42b:

  ata: sata_mv: Fixes expected number of resources now IRQs are gone (202=
2-08-03 07:59:12 +0900)

----------------------------------------------------------------
ATA changes for 5.20-rc1

* Some code refactoring for the pata_hpt37x and pata_hpt3x2n drivers,
  from Sergei.

* Several patches to cleanup in libata-core, libata-scsi and libata-eh
  code: fixes arguments and variables types, change some functions
  declaration to static and fix for a typo in a comment. From Sergey and
  Xiang.

* Fix a compilation warning in the pata_macio driver, from me.

* A fix for the expected number of resources in the sata_mv driver fix,
  from Andrew.

----------------------------------------------------------------
Andrew Lunn (1):
      ata: sata_mv: Fixes expected number of resources now IRQs are gone

Damien Le Moal (1):
      ata: pata_macio: Fix compilation warning

Sergey Shtylyov (13):
      ata: pata_hpt37x: move claculating PCI clock from hpt37x_clock_slot=
()
      ata: pata_hpt37x: factor out hpt37x_pci_clock()
      ata: pata_hpt37x: merge hpt374_read_freq() to hpt37x_pci_clock()
      ata: pata_hpt3x2n: pass base DPLL frequency to hpt3x2n_pci_clock()
      ata: libata-core: fix sloppy typing in ata_id_n_sectors()
      ata: libata-core: get rid of *else* branches in ata_id_n_sectors()
      ata: make transfer mode masks *unsigned int*
      ata: libata-core: make ata_exec_internal_sg() *static*
      ata: libata-eh: fix sloppy result type of ata_eh_nr_in_flight()
      ata: make ata_port::fastdrain_cnt *unsigned int*
      ata: libata-core: fix sloppy parameter type in ata_exec_internal[_s=
g]()
      ata: libata-eh: fix sloppy result type of ata_internal_cmd_timeout(=
)
      ata: libata-scsi: fix result type of ata_ioc32()

Xiang wangx (1):
      ata: libata: Fix syntax errors in comments

 drivers/ata/libata-acpi.c      |   8 +--
 drivers/ata/libata-core.c      |  68 +++++++++++------------
 drivers/ata/libata-eh.c        |  30 +++++------
 drivers/ata/libata-scsi.c      |   8 +--
 drivers/ata/libata-transport.c |   2 +-
 drivers/ata/libata.h           |   8 +--
 drivers/ata/pata_acpi.c        |   2 +-
 drivers/ata/pata_ali.c         |   2 +-
 drivers/ata/pata_amd.c         |  14 ++---
 drivers/ata/pata_hpt366.c      |   2 +-
 drivers/ata/pata_hpt37x.c      | 119 +++++++++++++++++++++--------------=
------
 drivers/ata/pata_hpt3x2n.c     |  21 ++++----
 drivers/ata/pata_macio.c       |   2 +-
 drivers/ata/pata_pdc2027x.c    |   4 +-
 drivers/ata/pata_serverworks.c |   4 +-
 drivers/ata/pata_sis.c         |   2 +-
 drivers/ata/pata_via.c         |   2 +-
 drivers/ata/sata_mv.c          |   2 +-
 include/linux/libata.h         |  51 +++++++++---------
 19 files changed, 177 insertions(+), 174 deletions(-)
