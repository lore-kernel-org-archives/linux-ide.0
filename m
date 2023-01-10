Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 345E5C46467
	for <linux-ide@archiver.kernel.org>; Tue, 10 Jan 2023 13:15:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233543AbjAJNPT (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 10 Jan 2023 08:15:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233837AbjAJNPL (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 10 Jan 2023 08:15:11 -0500
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4E5B574FD
        for <linux-ide@vger.kernel.org>; Tue, 10 Jan 2023 05:15:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1673356509; x=1704892509;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=0+q5DEKwrbEXWjH67shs/hkFDZN/kbzRl5FJwcYrOfo=;
  b=qRtBL7u9bTrd5b2QM6Xd/RXxyRZZR5qgRWeLyLPRz+NOBKCz+94v2Ayx
   se8FeCPcfO14BeT8Ti0ipQb/Gjnzam+5KFuRu7Xhe5nIhm6smMiZQtT/y
   B9/t4PzgV9z9hF1zFf8Y323BFQcw1ALG0TpTzYUOp7UWZsWR9Ugo3cXQe
   LVm/vE6EPQdd5q1cU6ZAj1xcTBxwOv6/4n5epkXY2ZsZwwPtDW1hcVZmO
   gEEzSDfT1ZZbHTFoqVCc8C6L2j1GQeVoRD9abGtSRkomq0/yqa/q5UOrD
   emBqJ9ZXiGmY2gaYCVwBlf+flkgyiFWD1ucYznpALvdfMp/5ErYaNkQyE
   w==;
X-IronPort-AV: E=Sophos;i="5.96,315,1665417600"; 
   d="scan'208";a="220320515"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 10 Jan 2023 21:15:06 +0800
IronPort-SDR: EMFxT9l2yl0o5L605d79ps6IDwcMPXO9thy1NnKCGte5oGXYduJZcAck1ZG18E3NBQpjKPIUQQ
 sSGFF7RyaLzVP1HRTTKo1fJhLVe3AtRT/3BZ5VmhhliezjPruMcn/lkXA1D8G0Mcf4NpTPatk4
 09D30xHC3gKdLrnOGtDbkXorv82XxGYoNzUZdzt7UvuXV/H3lQjjgBCSi4sQCfrcC0bXdx89LI
 RjVmURYQTYWnnI/+nmWrMZ249xZCMGJPUQt6YlmJ4RrJOLkuZu9o9zhLgQOAJzSe0Npsj3U2r+
 /Uw=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 10 Jan 2023 04:27:12 -0800
IronPort-SDR: RvbRQtuIbP2lmO6RsR3hqod0A5LGko7mJnQT/4BWkxP+sDt1fE8dMC+wZFQoiGaQLYpio0v1Ub
 QqXFUSnayibVCu8uz3ec/6UxGFX7jHj3MQu9v/VtDth6rgS0eRun661rIOXBsM9jt5mJwz8Xtx
 A71MDkIBZGmAYRC0p/+hXL3XY1e9o4EZAWy/i9ovPtJePcGLJjrWO9SNFd88zV45OaMrEIWfLy
 bJTHvlzacyoWB+0MXKlVZVmswBDcDv4kPlmE8Gx1qfK9l4qgKNZ36aFSD3bDNB7rge+DwhY7VB
 OZQ=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 10 Jan 2023 05:15:07 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Nrrrp2J01z1RwtC
        for <linux-ide@vger.kernel.org>; Tue, 10 Jan 2023 05:15:06 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :x-mailer:message-id:date:subject:to:from; s=dkim; t=1673356505;
         x=1675948506; bh=0+q5DEKwrbEXWjH67shs/hkFDZN/kbzRl5FJwcYrOfo=; b=
        RNaQK0JKEE2pqJcD1lwbZOwFlm6emvA5HtJPezm+QqRAmHJ8B+y4OSFQyNij/z5D
        GcY/GHT/wVSNyEsuAiMocAFkQf4UZfz0Z+w/kSysRSn2AYI631I59TwDXrIhrZBL
        82qdX7Xi9w6AAvkW7RxLdrQNgx7mo0ubtdwCKrdsVVORd1SRhloOYj2aUr2rOxuC
        o3b7ezq4fhcTuyD+OgrBqJqyJhugNpplR96p2sC2GPqxEvA6t+csNi7ffYmmxo9j
        R5qgaaSr68I6QvlgRKUwdJPuRmiepWRR9WoBAVPn6O2P52Nuz+s0gQca6g3JRl0s
        ECk6EDZFY4pfi3RwhCFx4Q==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id hWlJ9c_6-4j7 for <linux-ide@vger.kernel.org>;
        Tue, 10 Jan 2023 05:15:05 -0800 (PST)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Nrrrm5m7dz1RvLy;
        Tue, 10 Jan 2023 05:15:04 -0800 (PST)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     linux-ide@vger.kernel.org, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
Cc:     "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v8 0/6] Improve libata support for FUA
Date:   Tue, 10 Jan 2023 22:14:57 +0900
Message-Id: <20230110131503.251712-1-damien.lemoal@opensource.wdc.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

These patches cleanup and improve libata support for ATA devices
supporting the FUA feature.

The first patch modifies the block layer to prevent the use of REQ_FUA
with read requests. This is necessary as the block layer code expect
REQ_FUA to be used with write requests (the flush machinery cannot
enforce access to the media for FUA read commands) and FUA is not
supported with ATA devices when NCQ is not enabled (device queue depth
set to 1).

Patch 2 and 3 are libata cleanup preparatory patches. Patch 4 cleans up
the detection for FUA support. Patch 5 fixes building a taskfile for FUA
write requests. Patch 6 prevents the use of FUA with known bad drives.

Changes from v7:
 - Given that there are concerns about introducing regressions with
   older devices by enabling FUA by default, patch 7 is dropped for now.
   A more restrictive approach enabling FUA by default only for very
   recent drives will be sent later.

Changes from v6:
 - Modified patch 1 to include checks for REQ_OP_ZONE_APPEND
 - Addressed comments from Niklas (patch 2 -> return false, patch 3 ->
   commit message typo, patch 7 -> more verbose commit message)

Changes from v5:
 - Removed WARN for FUA reads in patch 5.
 - Added reviewed-by tags.

Changes from v4:
 - Changed patch 1 to the one suggested by Christoph.
 - Added Hannes review tag.

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

Christoph Hellwig (1):
  block: add a sanity check for non-write flush/fua bios

Damien Le Moal (5):
  ata: libata: Introduce ata_ncq_supported()
  ata: libata: Rename and cleanup ata_rwcmd_protocol()
  ata: libata: cleanup fua support detection
  ata: libata: Fix FUA handling in ata_build_rw_tf()
  ata: libata: blacklist FUA support for known buggy drives

 .../admin-guide/kernel-parameters.txt         |  3 +
 block/blk-core.c                              | 14 ++--
 drivers/ata/libata-core.c                     | 69 ++++++++++++++-----
 drivers/ata/libata-scsi.c                     | 30 +-------
 include/linux/libata.h                        | 36 +++++++---
 5 files changed, 92 insertions(+), 60 deletions(-)

--=20
2.39.0

