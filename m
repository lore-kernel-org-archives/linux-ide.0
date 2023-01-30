Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADE10C54EED
	for <linux-ide@archiver.kernel.org>; Mon, 30 Jan 2023 12:24:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236675AbjA3MYd (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 30 Jan 2023 07:24:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229965AbjA3MYb (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 30 Jan 2023 07:24:31 -0500
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A54F123C4F
        for <linux-ide@vger.kernel.org>; Mon, 30 Jan 2023 04:24:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1675081470; x=1706617470;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=JTYu9uYI56oV3Y8kJ78x5dyvRBcrgLhJI0xMXQhasGM=;
  b=N22Ozzi+I1EfOuPnmsC2iGdAMxnXd5xcVYcLFweHfZmeY0PG9IOsPFcS
   svYEcCMDAhg4oD5blNq1kuWNi8Dzp+NdNJG25JPqjxsVGMjGkY5GcLsvr
   2rhwKgJB81ymQLPn0yTdVQ5mmb+iSM2IJ1O1/AyC+/8+yw3zwmgF/3tGR
   kwg2n5ZhH/UOtzyU1vDFn/F9Z0Bv9TbbUpxyXZFcoyLY/kvjifFymLXxe
   y+ltwKhXRwk9UxW+vo//JNf+xa+4JBiqEzmelKIoqEUzywKXUbnfaFs1U
   wX9emtjvrzQtPTmi2DzVygj1gENQ7upVmTRSWy+VksCupNLzTbEOpqOJL
   Q==;
X-IronPort-AV: E=Sophos;i="5.97,257,1669046400"; 
   d="scan'208";a="222132965"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 30 Jan 2023 20:24:29 +0800
IronPort-SDR: n5Rqk80eVuQPlxrUboV+UXwnSNTvlB9Bz63Zo9h2cq9pUMvfmocURVKxCh+TJv7Wh9xghxm0w6
 yYiRSEvnFAQ0MFh1IdKOd/1xj78SXaNgly5y3rMf2cfFqC7g8sMaVllPkot3ZHjqYEGh27PBDV
 hPSx8KOb9azeE4K6Qa7n/LnT6wPukmdhnu7H7Onjp+2cWy99rMOi0EfuvDMxtFbfpOonwHCSgS
 FzEXgyrR55v6Okms9Q4P7VfPOlEJdy+TEJwW55WKyfv6JXeyTrJ7EkGEVHJ5/kub6wSm4sNH+B
 T7o=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Jan 2023 03:36:11 -0800
IronPort-SDR: qYVehwhdXAaYT4fJYu4yl5clQC5dhZj9vwvLMdPtKYYqU7PQvFKYbsDOt7j812QmyrdBREXdvl
 4NsynH/Zu/Ji1VsFCKfayVyUPeQchc/awzgEgclmg+pJYgkwotTkU4gbS3uiipGZBvdmnBqaz3
 IRV/y9E08wemQdJFAKNoxzagNYvMnzBdx/jPGz5TPMIpgK1nJ98QJfoVfWQ0GgIWqTsC4thmpS
 a1m+pkUYrG5e8PwAf0FxwIZdcn9LHIfujjSalxg7xc6KfWmkau0TjvxIxrncQgPNBx9QH27W9D
 da8=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Jan 2023 04:24:28 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4P56n9755nz1RvTr
        for <linux-ide@vger.kernel.org>; Mon, 30 Jan 2023 04:24:29 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :x-mailer:message-id:date:subject:to:from; s=dkim; t=1675081469;
         x=1677673470; bh=JTYu9uYI56oV3Y8kJ78x5dyvRBcrgLhJI0xMXQhasGM=; b=
        VkwddJ7sdpCSr8MoX3FK6shSKGoZCJpB2QD9bihAsm5PONGybhmcQK4eGdj7FQ8H
        Fy1rJBRAa2YgcxpG2uWYJE6A0OX7oesC/7zc3NBaSidC0i+OkbTASVbcO6zL76WS
        9MQOvwPIhSDF2N+cTK4P7UREYRGtRT2ofAuarpmo+/6vLDGs7/w3Xfj5ydhPvm0y
        5zXolkhGufScH2kS3EvH3pzSRhkQOGENx3CXDskm7H4/8gK3plPJEnfk+g0GmVyc
        BG9iZc2LIET3M0fPs/OAz7xK/1lqyCWvU7XLsFuQRdDwB1GEUVSpJqHpHe4RMXBw
        X8O3zXiTBc+Pui3offRzEA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id pgppSZa74n_J for <linux-ide@vger.kernel.org>;
        Mon, 30 Jan 2023 04:24:29 -0800 (PST)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4P56n9095Vz1RvLy;
        Mon, 30 Jan 2023 04:24:28 -0800 (PST)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     linux-ide@vger.kernel.org
Cc:     Marius Dinu <marius@psihoexpert.ro>,
        David Milburn <dmilburn@redhat.com>
Subject: [PATCH v2] ata: libata: Fix sata_down_spd_limit() when no link speed is reported
Date:   Mon, 30 Jan 2023 21:24:27 +0900
Message-Id: <20230130122427.113156-1-damien.lemoal@opensource.wdc.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Commit 2dc0b46b5ea3 ("libata: sata_down_spd_limit should return if
driver has not recorded sstatus speed") changed the behavior of
sata_down_spd_limit() to return doing nothing if a drive does not report
a current link speed, to avoid reducing the link speed to the lowest 1.5
Gbps speed.

However, the change assumed that a speed was recorded before probing
(e.g. before a suspend/resume) and set in link->sata_spd. This causes
problems with adapters/drives combination failing to establish a link
speed during probe autonegotiation. One example reported of this problem
is an mvebu adapter with a 3Gbps port-multiplier box: autonegotiation
fails, leaving no recorded link speed and no reported current link
speed. Probe retries also fail as no action is taken by sata_set_spd()
after each retry.

Fix this by returning early in sata_down_spd_limit() only if we do have
a recorded link speed, that is, if link->sata_spd is not 0. With this
fix, a failed probe not leading to a recorded link speed is retried at
the lower 1.5 Gbps speed, with the link speed potentially increased
later on the second revalidate of the device if the device reports
that it supports higher link speeds.

Reported-by: Marius Dinu <marius@psihoexpert.ro>
Fixes: 2dc0b46b5ea3 ("libata: sata_down_spd_limit should return if driver=
 has not recorded sstatus speed")
Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
---

Changes from v1:
 * Fixed commit message typos

 drivers/ata/libata-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 884ae73b11ea..2ea572628b1c 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -3109,7 +3109,7 @@ int sata_down_spd_limit(struct ata_link *link, u32 =
spd_limit)
 	 */
 	if (spd > 1)
 		mask &=3D (1 << (spd - 1)) - 1;
-	else
+	else if (link->sata_spd)
 		return -EINVAL;
=20
 	/* were we already at the bottom? */
--=20
2.39.1

