Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC628FA3742
	for <linux-ide@archiver.kernel.org>; Mon, 31 Oct 2022 01:53:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229719AbiJaBxg (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sun, 30 Oct 2022 21:53:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbiJaBxf (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sun, 30 Oct 2022 21:53:35 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C65EE95AF
        for <linux-ide@vger.kernel.org>; Sun, 30 Oct 2022 18:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1667181214; x=1698717214;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=X5zEpX6SMAZQugAJoTV81VehZ+el5Q+3olqpJdDoQEM=;
  b=H/qMSDYJaAoz7E88hB7YyR/86MYvnnUQWQCZKxsHVURZdBxbBIpZR10B
   Cj6PmCLa9DotKFMLpJ0PZeQMRRw0DRgk4Rkijo4uw1COdv4CBy0hOdygI
   b2bpecEMq0Ihtv0VbPrFaOMlP9qRBt35LAPsFb5r29dyCvSursuh2vGE5
   i6fVax2WgnYEzW35wtVoHQvm2t4h12nNGfPRmsoF3v/VxfQuPpK9HeL3E
   2Jp0jtW72o2buqxkwwcI3db/AHcpPgDEUh7bpHyFmCdlhdMCbe+eWWM2G
   uA6+Cs7SnpYAi3VpKxTAJbtTaTE3EMSka5XgmleHR9Y8rotK6er7uwD1t
   g==;
X-IronPort-AV: E=Sophos;i="5.95,227,1661788800"; 
   d="scan'208";a="220246015"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 31 Oct 2022 09:53:33 +0800
IronPort-SDR: 1l0KZhd/nYSML/u1KPLZhVKa9lJGbvzJPUavl7fZOvDuqmVNA7Zj+qa33NLIFg7GBglfJ5JXQA
 TtkCSdZeZ3TutOB4uj5ii5YjoVzwpZsdP4HGgy3GqrY4byhxL4UktGAIWCO4HNUNKfkPJXGBZz
 RmYBbkAf+Ycrmvw9M1r+M6GT3bFcWdh6tAGrS0gFx3e2I0lFFm0+D0w9Vh1KphI7tt2ELU334s
 xxZILFC61HaTxKf2rIr87JT5tPj3H5BmiS+NraGS2rRxcAhPvnxm6BSPWLopHB6bcv/kfpeb+y
 D0VCgGvAVxUS2AelRPz+cfpq
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Oct 2022 18:07:06 -0700
IronPort-SDR: GmWdmj2FiZL7QmCFVpQ95hSvvC4lRpulEgg0a+O0vZWSlluTq1lh6MFc3Y5a3I0LkrIQUmWFP/
 YuSVJR6Ijotk5JjMA3mL/BhHNpWRvDNW4SXYVRQ/qNdt5DOpkNHfA769bluFe4aCd9YFTLvdl4
 Y/5gjf904NJ+tgYrF9oTqPxVyMhOKBfn01S9Y8IvWPMB4j/eFstfi/H4ErkA0D7olTwIKfP+m/
 BagNJ91uv4S7OZift+ujwL2GFUlZIKcwGiH5787ABelfnn9BQzxtFlH/bDb59gWIUiwiyWnmdT
 JsE=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Oct 2022 18:53:34 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4N0x586rddz1Rwrq
        for <linux-ide@vger.kernel.org>; Sun, 30 Oct 2022 18:53:32 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :x-mailer:message-id:date:subject:to:from; s=dkim; t=1667181212;
         x=1669773213; bh=X5zEpX6SMAZQugAJoTV81VehZ+el5Q+3olqpJdDoQEM=; b=
        sTVLSidPt1Z/gAxxlLa4bRTPqZbgdV37A6eSVzTt38taLgNrhdl60ypH9CJxwkrQ
        7NMzLX2izJTDlliBO6XRqWVgG3/JyrKcnegg/54jaitdRvwF+JFIpgQ1maninTSD
        MSiX8OHZGWbPBYielm2Fk7YcsuSoOyauteHZ6xVODMec9kRR0DIn5/8fZA8TOe8y
        bZKDh1Madaame0dr70jiKSEufaaAeRMfO6Az0Gq99SEn6D1IeKEaUTq3OozobpfM
        9VwA/4IvPOvjGGiR1+tXAonGxQSHRFM7kiJK0vegWbcJryB0iltJ+oINHnKTbTa+
        yI7qJgjS0oqRSF+favvPCg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id lq64EaVgmT5D for <linux-ide@vger.kernel.org>;
        Sun, 30 Oct 2022 18:53:32 -0700 (PDT)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4N0x573JZfz1RvLy;
        Sun, 30 Oct 2022 18:53:31 -0700 (PDT)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     linux-ide@vger.kernel.org, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
Cc:     "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Hannes Reinecke <hare@suse.de>
Subject: [PATCH v4 0/7] 
Date:   Mon, 31 Oct 2022 10:53:22 +0900
Message-Id: <20221031015329.141954-1-damien.lemoal@opensource.wdc.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

These patches cleanup and improve libata support for the FUA device
feature. Patch 6 enables FUA support by default for any drive that
reports supporting the feature as well as NCQ.

Changes from v3:
- Added patch 1 to prevent any block device user from issuing a
  REQ_FUA read.
- Changed patch 5 to remove the check for REQ_FUA read and also remove=20
  support for ATA_CMD_WRITE_MULTI_FUA_EXT as this command is obsolete
  in recent ACS specifications.

Changes from v2:
 - Added patch 1 and 2 as preparatory patches
 - Added patch 4 to fix FUA writes handling for the non-ncq case. Note
   that it is possible that the drives blacklisted in patch 5 are
   actually OK since the code back in 2012 had the issue with the wrong
   use of LBA 28 commands for FUA writes.

Changes from v1:
 - Removed Maciej's patch 2. Instead, blacklist drives which are known
   to have a buggy FUA support.

Damien Le Moal (7):
  block: Prevent the use of REQ_FUA with read operations
  ata: libata: Introduce ata_ncq_supported()
  ata: libata: Rename and cleanup ata_rwcmd_protocol()
  ata: libata: cleanup fua support detection
  ata: libata: Fix FUA handling in ata_build_rw_tf()
  ata: libata: blacklist FUA support for known buggy drives
  ata: libata: Enable fua support by default

 .../admin-guide/kernel-parameters.txt         |  3 +
 block/blk-flush.c                             | 12 +++
 drivers/ata/libata-core.c                     | 77 ++++++++++++++-----
 drivers/ata/libata-scsi.c                     | 30 +-------
 include/linux/libata.h                        | 34 +++++---
 5 files changed, 100 insertions(+), 56 deletions(-)

--=20
2.38.1

