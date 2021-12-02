Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D604BC4321E
	for <linux-ide@archiver.kernel.org>; Thu,  2 Dec 2021 08:37:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345445AbhLBIlQ (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 2 Dec 2021 03:41:16 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:26399 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230054AbhLBIlN (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 2 Dec 2021 03:41:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1638434272; x=1669970272;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=VTvbgM7ueJ9PUhFuroAYZxVunrKPPxMKphJM8if0uoU=;
  b=Dg7g5O0xlV1xd6sQLsRZouigUOedPzyDohemITqGT/jzsDKoFQL96cVF
   kfcYezofYcnzfTshsCc4hcezvDiim7s/CGm6EuK0PtBvzXEKkWG6apUgM
   GeK6hJ7bUXuldlMIgVagE9RNmCGtgDlzFIkkdLbSPFfgnYRy5r3QUboP9
   zLKPbKgxCTZEzadmw/CbWtCh8b2KRhjchrSYl+G2jAfhJrSz4T2SWzEre
   CwbR7rPdJJ4oYQiooJ7vRXch25hVPb80SnibiQIhZUFZgJoWCfZGh23aR
   bpqTX98cQWy16Ynn8LUiPzjLEydbibxSKn2DqmXIYVIVfXuEp3CTxM36m
   Q==;
X-IronPort-AV: E=Sophos;i="5.87,281,1631548800"; 
   d="scan'208";a="299105717"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 02 Dec 2021 16:37:48 +0800
IronPort-SDR: 5P0dYubzH9PG7nUCDseH/P4QLNg/D7Qk32so1UEqF+yCAA6Ml1TCG2dNO0e4hSiaC5J7Zn6G5N
 XQSVvI7bqGhUTl4YgsEV/9RF8OLJJQ9jK8WwaUeK4Nl6+mD2AbBbb1SAmtRlu7pQcM5m5wkFD7
 N28Db7ol9mzE+JXaVY9ySYOxCgPZVTDP+OHNCNiwXn5n5WbkhQ9HLQdXy+j3bs4H0zBB9DDhe8
 Sk38SwTnE54bVybeMZhuzlg3/UfsUfuEp1LbaOe8b9Z8mcxfLZgioHaLcJ8zNTx1MWuqbEzmcu
 B71VNth7Zaf6mtZr3Pc2T677
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2021 00:12:31 -0800
IronPort-SDR: LSP1W4m/PzV9Lw9uXT0NjZcAHzEiVTA+P/ZAC30ylPvotwp6Zs5XepdwHTWWmC8AyKILiTAPmY
 AoIbduScumPV1Q8R3GczRy3htnjU2kIw9ftSwqUayg15f5ynzDAvt8+VU+6e8TCjYaSIZ9GdrB
 liE7Jhe29wuplfI3PRyJa5yRGJBOIje6L/v0M26u0oBrxj0EodsEXzy6ySGSzHdB89NoF1t9OG
 fSm8FePrqD8wtQu1qXEHT09DRKQEuLt9T/C0Pf97dFwnQFGTAQ89n9bs477bnzltkaUQo86j0n
 rHs=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2021 00:37:49 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4J4TqJ15gtz1RtVm
        for <linux-ide@vger.kernel.org>; Thu,  2 Dec 2021 00:37:48 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:subject:to
        :from; s=dkim; t=1638434267; x=1641026268; bh=VTvbgM7ueJ9PUhFuro
        AYZxVunrKPPxMKphJM8if0uoU=; b=Q9AzkGIxvv/e/8dZi8mcnaFVHLJJ7e+Bns
        hSZdiH3lXyDQwRoj37+6Z9pycpGkYUnbR7rXA6l+K9Dkk9A9DegtDLZQa3AgkZsD
        0gF84dMMnubyBMzCjfwyxahUWlmopq1h1GcJjlP+hCClQBGHYzzUTg23RC2VaRkn
        QaD+wQSSeewRk9W8qwzw2mK67c4SfRDBOeNs/U7kx/hdnPTdZ5ZrMTKXEiMZbSjj
        F6nm1p8/2tLPeo2e8Enw/8tX5DOy6N2ksxnPi6WIiBVBjBtTxBcTAZIHRfLV3zhA
        CAcYAyCf0Qn7npkdM7ADiM4MonrM6S5u5jVqeCqBjbDsg+lfUelA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id pEtRFHyeIrCi for <linux-ide@vger.kernel.org>;
        Thu,  2 Dec 2021 00:37:47 -0800 (PST)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4J4TqH3Zj2z1RtVn
        for <linux-ide@vger.kernel.org>; Thu,  2 Dec 2021 00:37:47 -0800 (PST)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     linux-ide@vger.kernel.org
Subject: [PATCH 4/4] ata: sata_fsl: use sysfs_emit()
Date:   Thu,  2 Dec 2021 17:37:43 +0900
Message-Id: <20211202083743.645391-6-damien.lemoal@opensource.wdc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211202083743.645391-1-damien.lemoal@opensource.wdc.com>
References: <20211202083743.645391-1-damien.lemoal@opensource.wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Use sysfs_emit() instead of sprintf() in fsl_sata_intr_coalescing_show()
and fsl_sata_rx_watermark_show().

Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
---
 drivers/ata/sata_fsl.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/ata/sata_fsl.c b/drivers/ata/sata_fsl.c
index c5a2c1e9ed6b..ec52511ae60f 100644
--- a/drivers/ata/sata_fsl.c
+++ b/drivers/ata/sata_fsl.c
@@ -322,7 +322,7 @@ static void fsl_sata_set_irq_coalescing(struct ata_ho=
st *host,
 static ssize_t fsl_sata_intr_coalescing_show(struct device *dev,
 		struct device_attribute *attr, char *buf)
 {
-	return sprintf(buf, "%d	%d\n",
+	return sysfs_emit(buf, "%d	%d\n",
 			intr_coalescing_count, intr_coalescing_ticks);
 }
=20
@@ -357,9 +357,9 @@ static ssize_t fsl_sata_rx_watermark_show(struct devi=
ce *dev,
 	spin_lock_irqsave(&host->lock, flags);
 	rx_watermark =3D ioread32(csr_base + TRANSCFG);
 	rx_watermark &=3D 0x1f;
-
 	spin_unlock_irqrestore(&host->lock, flags);
-	return sprintf(buf, "%d\n", rx_watermark);
+
+	return sysfs_emit(buf, "%d\n", rx_watermark);
 }
=20
 static ssize_t fsl_sata_rx_watermark_store(struct device *dev,
--=20
2.31.1

