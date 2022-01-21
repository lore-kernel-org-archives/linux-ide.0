Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB239C433EF
	for <linux-ide@archiver.kernel.org>; Fri, 21 Jan 2022 08:45:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349083AbiAUIo7 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 21 Jan 2022 03:44:59 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:15678 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379642AbiAUInT (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 21 Jan 2022 03:43:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1642754598; x=1674290598;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=mGsCY6kp93h2hKCHyeJMKzpZRBcoPAiiYRKVIrpmDQE=;
  b=agB1qbSt6DENFaG4oegAu2mztfIVC2U6evwKcTe2f2gnsjJHmMs1OL3o
   C4ch8mY++XzMkAEB6pGUdwE/8pTmK6JNvVUOGNjlW7O/e26KAB4a8tgUa
   2b8j6ntqW4VgDMTb/ztGhdV14KT/jPKaATV97AILX6q0rwBFzzBeTbWZh
   W8rbtzWXa3SF4ei+P/xLttkVi+s4rMO0+iNXx6l1nZSwHPxNpUYuvRg3n
   pN1MFrLWpm+d+to6pj/u11n9SfXm6SHmCvPi2NhGDBjwiS7qlne/V2tMh
   u+euTUe7yyb48skmtbxGd/xJ5j3uvY6u6Z7ig/cRWXVXLiZ3fxUtEBzqX
   w==;
X-IronPort-AV: E=Sophos;i="5.88,304,1635177600"; 
   d="scan'208";a="191026946"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 21 Jan 2022 16:43:17 +0800
IronPort-SDR: k6kAVmaI0d9hTLTVzOM908mDqTMmxH0YS4lBij/Wz4z734sugUvf9cdzz558T8UVsSCkWINSVl
 NiURaJlhWX9fEALK87Aslo4FuRTFZxrjUd7wC5PnsLa9jCzeGhJsECmyJT/3nMcwZHzAVf0r7G
 9Ez/JJ1CeaWelA9tJ3nxcCxMtfwMjB/4LxOKTKm59XB6T41YzqWSnR5aoqJgQnhpZ0CYk5X32J
 oHQWUv2kQyGsTwCkEWxyssT2e6ic62Papxezd7cJNFG9Rsna0St8fqceIlNDsB8v/PVnf9Nxn0
 0OxUwiJjDYsw4Xsuvl0YTTSh
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2022 00:16:45 -0800
IronPort-SDR: zrXzSHkTSg6JvncyPbsFS7IBYgMQDOweDMOJaTEkYyQbgXCMoNeVwDgAcC/79U6AURYlOb432f
 4dXhscFgrXGZVDxn5fTUieU4ypTq3MAZV2Dr39PL3af46DFead0YxSwNa0qY2TwT5xuTHDCPDR
 LAftjejkpX/rxv1fnkrFTToA/VmpWQTP/XFCDEBb1VDRNKLByHpjX92J5wGutZwXdHAuMuxfKM
 Ymb+fwWOQJtt9hMCxm3PGsiPSUORMftJEcIG36aKLwtyK4VisYmThh2e+OsuyDTkJ9mm/Aq0t7
 ado=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2022 00:43:18 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4JgCL85ZYhz1Rwrw
        for <linux-ide@vger.kernel.org>; Fri, 21 Jan 2022 00:32:32 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :x-mailer:message-id:date:subject:to:from; s=dkim; t=1642753952;
         x=1645345953; bh=mGsCY6kp93h2hKCHyeJMKzpZRBcoPAiiYRKVIrpmDQE=; b=
        IrvzRAO6C5RcmmqvZEHkeGaAgK7xw9r7Jih9Tgjv2Ine0SRuEVSELaU1AsvmjeNx
        ODec1isqFAHVg6FxsPBi5DOy0Df39ZQdsWih/rmItAM0pUYh5w1WmTXZJgKuKLNw
        NAE8qpuU2hLGhN1u0nlXVM3UnwQoX+lUYJsSZT85cftNXKX6fCE7x/yPXlzZZmGu
        tFMv4EZ8rN9xH4dNMM++wEAaZf2qgPO/MxWzY6zHDVYXBgZ1cyREX0wmpQwJrida
        yX4KPd4Gh/udPLrO8QvLiSP9zpHIzi6X5lNCdWlaooXr1yNGbeCupzQJPktt9jVB
        rHXZP/EAXRDauLZPeF6NFQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id KIQkm-fVPYQO for <linux-ide@vger.kernel.org>;
        Fri, 21 Jan 2022 00:32:32 -0800 (PST)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4JgCL74hsjz1RvlN;
        Fri, 21 Jan 2022 00:32:31 -0800 (PST)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     linux-ide@vger.kernel.org
Cc:     Hannes Reinecke <hare@suse.de>, linux-mips@vger.kernel.org
Subject: [PATCH] ata: pata_octeon_cf: fix call to trace_ata_bmdma_stop()
Date:   Fri, 21 Jan 2022 17:32:28 +0900
Message-Id: <20220121083228.969805-1-damien.lemoal@opensource.wdc.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

The first argument of trace_ata_bmdma_stop() must be a pointer to a
struct ata_port, not to a struct ata_queued_cmd.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
Fixes: d3e140f2b008 ("ata: pata_octeon_cf: Drop pointless VPRINTK() calls=
 and convert the remaining one")
Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
---
 drivers/ata/pata_octeon_cf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/pata_octeon_cf.c b/drivers/ata/pata_octeon_cf.c
index 0912846bc1b0..05c2ab375756 100644
--- a/drivers/ata/pata_octeon_cf.c
+++ b/drivers/ata/pata_octeon_cf.c
@@ -595,7 +595,7 @@ static unsigned int octeon_cf_dma_finished(struct ata=
_port *ap,
 	union cvmx_mio_boot_dma_intx dma_int;
 	u8 status;
=20
-	trace_ata_bmdma_stop(qc, &qc->tf, qc->tag);
+	trace_ata_bmdma_stop(ap, &qc->tf, qc->tag);
=20
 	if (ap->hsm_task_state !=3D HSM_ST_LAST)
 		return 0;
--=20
2.31.1

