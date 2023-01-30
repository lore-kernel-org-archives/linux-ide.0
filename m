Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A1CDC54EAA
	for <linux-ide@archiver.kernel.org>; Mon, 30 Jan 2023 11:08:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236524AbjA3LIK (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 30 Jan 2023 06:08:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235600AbjA3LHh (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 30 Jan 2023 06:07:37 -0500
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 169776EAC
        for <linux-ide@vger.kernel.org>; Mon, 30 Jan 2023 03:07:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1675076845; x=1706612845;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=f4d72vUy9Vr3QkqNqMj2UE79B6Vs68Ud+SpOERjeolI=;
  b=fyzHsQi7OG6oXPUf/LKxu08h4LzIKv7FrlEn1Gg39RkiHqmd7s+nJ5xd
   lT3Tr7YbSA9pQPm1uMNlg43jaGo7UHUxdNO9/fTKCqGs4pdIU2umQ2tiV
   rMu9IdiFQtJv+Pt28+O7NIHUAmLYmsSnyJLjRGGYCAcZcGj6PYbmwNjAL
   T0LSmAL4VF1oKzZQ8wAuG2ME1OfzJSdE+gVAF/Ht9fekGGJY/C473yPda
   dvDI4CamsNml7TcDCfTk7G2m9fJlYbUyFhM6XHs9Rtu0c11M7U/9uTlJg
   4Q2lK8Y2S2YxiQ9Lf47U1MxqIPD3Ra7+ayc1hfSYfN2iV61pSaAhgM/1v
   A==;
X-IronPort-AV: E=Sophos;i="5.97,257,1669046400"; 
   d="scan'208";a="326364728"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 30 Jan 2023 19:07:24 +0800
IronPort-SDR: AAYlcGT6Cmde5ZfIujuKjiY+1sRuj4gKS3HCQBlPZEhkC89/l3/W5pUj6Ng2bxkCZTyxm7oJiQ
 sMjoWudlhxHgSeYe4g4vaiR+wjnCYfr3CR+0DIr6SGzanHVXxUzdfGWg3b+ttzmAoE6onNlwbR
 cZQ4UUV4sbSVA+5icitYRJRw+b+r98CoGQwoECYcAFHv5OPSNSIgDt6f1kIY5CjHcXX8XCDqPd
 AxQUQ6q4dxzqvqZEBK63JeBPX1LLN8HKtaAWObgtqC9wTeXnhtySNHvOzNpYttvJ0Da/pAW03S
 0s8=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Jan 2023 02:24:50 -0800
IronPort-SDR: xOkG+CaU+1wvPjCS2YRIXPumlG9jJxASPK5b1BnU3vbkhJNiA/OhaOqwrfKmHCfzf/ZNQ0Je/h
 Ypi7Z5lHb+EUeOCQlP+nu6Jt2Va5cig+4asdGYD8SwRD6ERRW8Am3n7P3phKWFRpKoYlm2UY+u
 7xw7PdOwe4HlRRI5MisREH7sRdxZ8+SXnWvvqVdgfHv0jy6uAAhbwedUfo9vR7aPPVgKjoRBg8
 InvPTsN05TgVL6PZ3ZGGXAAGDxWhddhxtoUnU0D14otTYLA+y48wAL4CibHVoIfprPh+Hax5PC
 HrM=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Jan 2023 03:07:24 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4P554D0xHCz1RvTr
        for <linux-ide@vger.kernel.org>; Mon, 30 Jan 2023 03:07:24 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :x-mailer:message-id:date:subject:to:from; s=dkim; t=1675076843;
         x=1677668844; bh=f4d72vUy9Vr3QkqNqMj2UE79B6Vs68Ud+SpOERjeolI=; b=
        iH9gsrcVuo5+dL6JMo+Qxf2sfTVmGXBzQ0R/jJGpojml6NeiniceDnXNCwoMl22D
        rKNNvm8/PQ1O689Owrwxv7pXjaMPpMLRZz4TiqTojkBtQ83hYxdFPuVsKr2EfOme
        cEUBX/JjyRMu+RrNjcD5qd/jn1ltozMVw3DxXuZn83zUTZRaoTE4enWa+PcsGXw9
        2/Av7JwjnhfjMdHmGGwNhV/AXig/zRLRRrRlEj9D2UZBqfUb8xZC+G3VzDffC3oS
        LQ2+D1hF4rkaTg7AfrJbnEEp04vosQYX9A21crSVr/Sxz2qWZSSQVR+O6h4vJTno
        V0f5jhYqZeFPu6i81eh+BQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id SSPmQ7XEXrlQ for <linux-ide@vger.kernel.org>;
        Mon, 30 Jan 2023 03:07:23 -0800 (PST)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4P554C2MpPz1RvLy;
        Mon, 30 Jan 2023 03:07:23 -0800 (PST)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     linux-ide@vger.kernel.org
Cc:     Marius Dinu <marius@psihoexpert.ro>
Subject: [PATCH] ata: libata: Fix sata_down_spd_limit() when no link speed is reported
Date:   Mon, 30 Jan 2023 20:07:21 +0900
Message-Id: <20230130110721.111776-1-damien.lemoal@opensource.wdc.com>
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
speed during probe autonegotiation. One exampe reported of this problem
is an mvebu adapter with a 3Gbps port-multiplier box: autonegotiation
fails, leaving no recorded link speed and no rep@orted current link
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

