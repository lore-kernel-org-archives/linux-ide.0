Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31060C6FD1F
	for <linux-ide@archiver.kernel.org>; Thu, 23 Mar 2023 03:38:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbjCWDio (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 22 Mar 2023 23:38:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjCWDin (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 22 Mar 2023 23:38:43 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8707C10CF
        for <linux-ide@vger.kernel.org>; Wed, 22 Mar 2023 20:38:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1679542721; x=1711078721;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Px16p23wXqJMKZWZc0V9PUVcUhAmE/EvKDYZf7J1liM=;
  b=ZlGhQ732m+QieqYeHkUzhE7XLMRNVjMCAx1Q8hvG2P3CkfiNU9gv69w3
   hSzGMSx/IOeD1uRGjgcq3kvVccq/4abMAfePkJAghqB1dnk6rBf0heTZV
   FtTwONu3dXTaO1AlU87qO1/VFAjTInbuxw64wlbTmOv5cOZ5IwiWH22Qe
   XpIzCS9L2tYKGKxXg2wsv6A2UHpykOzKFEADGk9oh6in9rZi/Tpn7mQou
   0cmAapyndOSYH0K9OM1OKSDWt22yLmjUSubsY5RmvXi3mJ6laDqXKD4kr
   puwC/HT9dGzAortPqnnn63Hy9p4U/xzokpO9G9uPOW6mWKQuw/dqpfarX
   Q==;
X-IronPort-AV: E=Sophos;i="5.98,283,1673884800"; 
   d="scan'208";a="330711518"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 23 Mar 2023 11:38:39 +0800
IronPort-SDR: u1PLM0ER0IUktEzx4k+SdtRDHrLLbu29hg93JFuC6sSoxY8RYNrjzIvtj410ykqTcqpKuPbkGG
 3mEVihlj6Dm3uppEMztVZSK7k7mYdhH158w83Njqvkhn88MUTx4Kj/of1QsdsqKqmFF6W2w/tT
 QdK9oDMlrQBIFXEXl+iiXA63kKjDEcgNs3NeA/Iatn+r9FfujBxuPWHI7ffqEDrcsShMweads4
 bPN9rPw6KSDriQjqgeSeY0fK8eDWc9w4KxdEVVCwVF/URVzosk0G3X5G+maZmBFyqYGljAfjC7
 o50=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 22 Mar 2023 19:49:15 -0700
IronPort-SDR: YgEbNHXy4BlWcfeKaKSzBtzQxMQWNfSzUIwocHBpfGo73RCy+CeXP72qpDU6+Ys7mUkBINKvZ0
 LViSJjIJERMGC0p7q3VoG244MzkVfMD75YkHnQ7co+q3z8w8LYlaPVaJtcLaAT47ttzHD2eyZS
 jq32D52LTxhWaX0vD49ti08gstsxAOOYtySPRFdAeL54rzDzbbB2qom1FXELpTtSeK4YcMFb97
 8AUyJxZmUXupMvObQOrewnfN+1plO4pBFbTye1CCjQG842JsJ2o7c1VOAgfeA2nXWncNuhW2jt
 hrM=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 22 Mar 2023 20:38:39 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4PhrfR07rzz1RtVt
        for <linux-ide@vger.kernel.org>; Wed, 22 Mar 2023 20:38:38 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :x-mailer:message-id:date:subject:to:from; s=dkim; t=1679542718;
         x=1682134719; bh=Px16p23wXqJMKZWZc0V9PUVcUhAmE/EvKDYZf7J1liM=; b=
        oOpFPC6nY+ibHokl+KQPwELm1hG/7+HdnWa8vvqDWCVStOH60qsRtIFeSN86GIzo
        PR6tCk46k0dC1dlm+nfES9XLKLnCIPXtUuMa7QpPagBbGLXePsJHlfiWVfsisoUE
        xHwWVj3o8xdM1aaSyDW8s7q+fAZpfr3F6sbgbKoulz5bg6Sq2sX+BqZsQX76Ucdu
        mp53vfWFe/y8y6rffMz8qxTCHO7d0CmuPnRfqr4HOdSiLWpl+tVAb5RIQlhEfzNC
        QrnFqoDwlhEx3fDeSiEOBW4CGg3E2KGXY69Q8ZqbYmzJI/F5ScIYqn5mxJsrSqrA
        D9gj0eCw2GcQF5YBiBhazA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id JR1qi2kk8sSZ for <linux-ide@vger.kernel.org>;
        Wed, 22 Mar 2023 20:38:38 -0700 (PDT)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4PhrfP6NtVz1RtVm;
        Wed, 22 Mar 2023 20:38:37 -0700 (PDT)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     linux-ide@vger.kernel.org, Ondrej Zary <linux@zary.sk>
Cc:     Sergey Shtylyov <s.shtylyov@omp.ru>
Subject: [PATCH 0/2] Fixes for pata parport bpck6 protocol driver
Date:   Thu, 23 Mar 2023 12:38:34 +0900
Message-Id: <20230323033836.352672-1-damien.lemoal@opensource.wdc.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

A couple of improvements, no functional changes.

Damien Le Moal (2):
  ata: pata_parport-bpck6: Remove dependency on 64BIT
  ata: pata_parport-bpck6: Declare mode_map as static

 drivers/ata/pata_parport/Kconfig | 2 +-
 drivers/ata/pata_parport/bpck6.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

--=20
2.39.2

