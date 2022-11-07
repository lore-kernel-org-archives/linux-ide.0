Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 911BBC433FE
	for <linux-ide@archiver.kernel.org>; Mon,  7 Nov 2022 00:50:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230057AbiKGAu1 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sun, 6 Nov 2022 19:50:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbiKGAu0 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sun, 6 Nov 2022 19:50:26 -0500
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5977FBF5C
        for <linux-ide@vger.kernel.org>; Sun,  6 Nov 2022 16:50:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1667782225; x=1699318225;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=gHWEXtFKNdxS6ELa7tVt+4pDLu6FePb748bMwThoxNg=;
  b=dAcDFLUJChwwdd602LLeg206jCmOKIPZSZdiJE8gCyFAy/hXEtiswSyT
   TP6IFt6V6N2VZd7qXHf5OPfstn7z7bjxOb3DqQ8VN4kkFc20hIuFVz/4z
   80gBsCuH513FbIBLf1fPhdzvs+gNTER7A8+nggxVeOfjkfZREj/4H1EZB
   17Mn27eyIK2OyORwucIM/YuXVNGhYSQcEnTMrfIvI6hPh6i1SeK2LlU5D
   cv5Gz+bRFo8jtnrdbiq4EvOi3TLSDRpMmhgyYv2WI25y/npmHZlBHXLJW
   Md7X1thi2/+dOM345b3a3Z2o89i4C2/LhR81rfihupb2VfptU5Vi2vzSm
   g==;
X-IronPort-AV: E=Sophos;i="5.96,143,1665417600"; 
   d="scan'208";a="215958464"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 07 Nov 2022 08:50:24 +0800
IronPort-SDR: 34kzkwJfL+/bIZ5WYoEWd+cljFijn1MB2rbnPIkmezMF9YLPeqa0X7LBv9olVrWFzpDHKW+hJm
 zvz7lfjCq77f1AYrNVDe/N5kaIPWBvM2BHGyoNfqun4/HpYjuUWR2HyaYeCqTcCuAeIC+2OdTZ
 sSx5BL1y9N07Lsa71yhVWUejcm5qJ45YtO3EG1w2EBxUl3hLOdkQ1lvbFmn64oxkYkB/5w5Eb/
 FLXIsLh3JcGITwzhPrB5NNzKd07ZJRYx5LaPHRyMQgjEt/Wfocodh2Mq0H+k8TXro9uHmSZa+z
 q3A=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 06 Nov 2022 16:09:32 -0800
IronPort-SDR: 4LRDy+qEE3H2grwMFrLCDuozrgJEJ6+J+vew//NV6DzG+zJWBIOK87rC4+mgoRggtWW4Asf/Fi
 ppqNAXIwusaIlZHStK4CIvV1qfRxpOuL0mawCYWz/l+7b7m4m53BuXHyFZO4LWPkKrGJgapzDO
 ltIvtG2gjQ95ndJ0fP3vyDlK3msFcGEVHoTRchXKDhbc1LR1dirtqmJP6sUGtb3RTU5MshZXOz
 Qmt/1GFTjbuG8GQMwJdyoMlHsYowxx4a/ynjWVbEHq4myN94pcrweyFRCQ1i0Ko2/Z5APuCcKs
 kh4=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 06 Nov 2022 16:50:25 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4N5CM41kGNz1Rwrq
        for <linux-ide@vger.kernel.org>; Sun,  6 Nov 2022 16:50:24 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :x-mailer:message-id:date:subject:to:from; s=dkim; t=1667782223;
         x=1670374224; bh=gHWEXtFKNdxS6ELa7tVt+4pDLu6FePb748bMwThoxNg=; b=
        I2uYNJzNS89m0+nISkZBd8txEEpmUmBivOhlrcrY86206Q8ZWbZVOaS+VXf/elIl
        8sPghpOP5AyNCEBubQ1Hxo7pqn5GJTHMYan8DrTTnHKCclig7TQxTUjtvAgbqqsd
        TRMRepd07wop3jnNV7umhNxTd7KQrLbgJDJNbUgi8CL+0PnHhjLTM/JLF58mfwfT
        /QWAEzMqMQ219EBf+3TjE+c3taAUrRhQ6XtKj5G8iJadNRL2GGd0TJ2OIpVSofpS
        M87Rxj6oF4DzlB5SbtigCBs+ASS0gxBgl+YAgVEI7LyIRhYOOSXj80aPNz+f3c69
        9KOST5LbrM2HcQclCQOfZA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 1L7UdNTHEChO for <linux-ide@vger.kernel.org>;
        Sun,  6 Nov 2022 16:50:23 -0800 (PST)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4N5CM245x5z1RvLy;
        Sun,  6 Nov 2022 16:50:22 -0800 (PST)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     linux-ide@vger.kernel.org, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
Cc:     "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Subject: [PATCH v5 0/7] Improve libata support for FUA
Date:   Mon,  7 Nov 2022 09:50:14 +0900
Message-Id: <20221107005021.1327692-1-damien.lemoal@opensource.wdc.com>
X-Mailer: git-send-email 2.38.1
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

Finally, patch 7 enables FUA support by default in libata for devices
supporting this features.

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

Damien Le Moal (6):
  ata: libata: Introduce ata_ncq_supported()
  ata: libata: Rename and cleanup ata_rwcmd_protocol()
  ata: libata: cleanup fua support detection
  ata: libata: Fix FUA handling in ata_build_rw_tf()
  ata: libata: blacklist FUA support for known buggy drives
  ata: libata: Enable fua support by default

 .../admin-guide/kernel-parameters.txt         |  3 +
 block/blk-core.c                              | 13 ++--
 drivers/ata/libata-core.c                     | 77 ++++++++++++++-----
 drivers/ata/libata-scsi.c                     | 30 +-------
 include/linux/libata.h                        | 34 +++++---
 5 files changed, 96 insertions(+), 61 deletions(-)

--=20
2.38.1

