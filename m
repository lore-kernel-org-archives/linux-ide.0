Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C83C4C4332F
	for <linux-ide@archiver.kernel.org>; Tue,  8 Nov 2022 05:55:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233309AbiKHFzu (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 8 Nov 2022 00:55:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232911AbiKHFzt (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 8 Nov 2022 00:55:49 -0500
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08BEF2F67D
        for <linux-ide@vger.kernel.org>; Mon,  7 Nov 2022 21:55:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1667886948; x=1699422948;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=sfrHc9qyeac6YLFKHoM/ia0SMZw70hj6ruJQojoNazA=;
  b=cz/hlhqQbrLPyh3U3Ju9th6MC8q/SieXLx8ztlWYK85QpnhqlQzRORvg
   N40flHSwRavp51ESZojA6lIoYulWmu8vTRWDHbXwmJ36kmrkELjhVXWBH
   E7GE8QddUU97kzAALA9cKe3/xmZZFflQWsLjthhnZnCnRuftZWfljZHGj
   nWCuIe4AuZsJAzOEqIMdSyF5QnM+KMTDqKu+7X6edosfzEZiovQdxP+oZ
   kV483YvLpuT6GWztT6xGK0sqvvt1eEfsHD/Ed4MVnaTdE/RHLkCVGTUgm
   M94N4o5PtJ1EkAkpJ4szQxhUwm5FyhxdPMePtSSbFzXCrUFfhAsvPAMhX
   g==;
X-IronPort-AV: E=Sophos;i="5.96,145,1665417600"; 
   d="scan'208";a="320067434"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 08 Nov 2022 13:55:48 +0800
IronPort-SDR: o0bFdVIDiA5fpqm+v6lfOana8MvlE1p2ch6pbssWkfEQGbi8CM6SxOQ6inieWP9mld63QDazf/
 5kUbxzf/17Yh3NSc+P+fAm+q86R9hh7XLPT3Z5uBLP/uAeKlX0jLT4z9ecTlxiAmqr++TGDxRg
 hNNTSWZ/j17tkJ9Fv6IMvukizuGzAkXUjI9WfO7shhvwEqwf9uiux4Ne6FR8PeknmhpDx2Oadq
 hS8+auGd9x48MDyA52O2okCJbF6XKW2H39a7rwenvHV59Yqffrn/7FF+UYc2CaHEV4ngQx2TlH
 VW0=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Nov 2022 21:09:09 -0800
IronPort-SDR: a21h52HdJXqo3Nw6YgDxSTm/ejHTAVW+2SO747McCHtO3VPXmkc5eYseuHS/wmtpJ9a/JglEl5
 zlZga9iH+I6VZKO8Njt42qMXzKsexQ0ZR2pTF+fOwkzN3xRtN1yWXtUiVad65T+nnHy7aTJK1F
 qDBT+FFiFL8hoLwU2RKO1XcZbtQ9EVJD09vFa/YyKEnH5j1ZLjPpJpKf/xzGTCUZxUOlLUl2wY
 1SsnIgV85kbGgCorBQg61RkxOJSixVStFLWpCBGXP58Oj4BETZPwdGBpSWwnAsQlGbf48FtJhd
 Asw=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Nov 2022 21:55:49 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4N5y500yqJz1RwtC
        for <linux-ide@vger.kernel.org>; Mon,  7 Nov 2022 21:55:48 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :x-mailer:message-id:date:subject:to:from; s=dkim; t=1667886947;
         x=1670478948; bh=sfrHc9qyeac6YLFKHoM/ia0SMZw70hj6ruJQojoNazA=; b=
        SX2SdkKcUQTFuZIPUwtUW4LCpimsOEk6YcvfLOZ/BNl9fX2JOHZxZxaPLGq5CjKv
        F59rjFA9RGXq9tcYkdTD524qhA0y7I9Ynx75bbX8PN0S0PvTz739GI7A3LAuo+cf
        5DS95BvP5xcDH6YXpaOY6uJm6j2IEnGzDRLrz3hBvltc52roi5y7n25DkNbnQBdX
        pVMu64xETNToXWhukvI6cZwpri9g0+5zpz5DbbN4DJhtGlRENFRqJSicP/XWefST
        oNtPVBZspp46nLoLmZ63AFW25BGtBffK92AdYkwnHStIY+VHfMMcO6JY3UCbQzrt
        fgElkYX+x4ORIhMKGS67Zg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id A5_gLK4w8HbI for <linux-ide@vger.kernel.org>;
        Mon,  7 Nov 2022 21:55:47 -0800 (PST)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4N5y4y3M07z1RvLy;
        Mon,  7 Nov 2022 21:55:46 -0800 (PST)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     linux-ide@vger.kernel.org, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
Cc:     "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Subject: [PATCH v6 0/7] Improve libata support for FUA
Date:   Tue,  8 Nov 2022 14:55:37 +0900
Message-Id: <20221108055544.1481583-1-damien.lemoal@opensource.wdc.com>
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

Damien Le Moal (6):
  ata: libata: Introduce ata_ncq_supported()
  ata: libata: Rename and cleanup ata_rwcmd_protocol()
  ata: libata: cleanup fua support detection
  ata: libata: Fix FUA handling in ata_build_rw_tf()
  ata: libata: blacklist FUA support for known buggy drives
  ata: libata: Enable fua support by default

 .../admin-guide/kernel-parameters.txt         |  3 +
 block/blk-core.c                              | 13 ++--
 drivers/ata/libata-core.c                     | 73 ++++++++++++++-----
 drivers/ata/libata-scsi.c                     | 30 +-------
 include/linux/libata.h                        | 34 ++++++---
 5 files changed, 92 insertions(+), 61 deletions(-)

--=20
2.38.1

