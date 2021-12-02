Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F635C4332F
	for <linux-ide@archiver.kernel.org>; Thu,  2 Dec 2021 08:37:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345414AbhLBIlP (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 2 Dec 2021 03:41:15 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:26400 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345430AbhLBIlJ (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 2 Dec 2021 03:41:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1638434267; x=1669970267;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=ANobDnqVGRKtjmPfIx8xtJVgXobho52WeWCmEq6QYS8=;
  b=ZM+I3LFtC+mEQCXNoRZG61Hp62pvtTE6ThEr1arjgRsU5pkhdVfPI3CB
   4Vfn/9OoOQTVvdM2Nez3Jf2S433I79imbDsq+o1q/ftLrsjZZ4CW9O85t
   OD808bBzzixua6Zi4lSGptTAZ5SK2QblP+CXJS4FEmTQ5p7NhAW15LiD2
   Un07pfhUmkHBtCXft0DIYRvAIR30Wyjlu1QiX8SimOFnvEYThkKbdSOTg
   B9o/qdrIjx0urSntSYowmJyZSPMqm8ANFU/x1BXmY8+V5rXFsBjbXTpoy
   BtFWwxRkJNOkyVLw47HkVIukU9yLB0J1RULQlI/FRh1HeBiyl6Hp74OIT
   g==;
X-IronPort-AV: E=Sophos;i="5.87,281,1631548800"; 
   d="scan'208";a="299105714"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 02 Dec 2021 16:37:47 +0800
IronPort-SDR: bDtb7+GnTFe4dPnz539nlfAzhMZwVrK0TaKx2mrLURxhhELRv198j7DBHnI+FwBjeYI3p0XFXV
 NDbadEXF5cw7+Wc3ZI84RWPLPFh1CIO+HkWJ7gv2u0hAHWUPSxyHRVGGRLz9LpNrtBUNR+WqjV
 DOis6Tzfd2P3KU05HTFGtSuUrCRlISVNUDdiv4vYRIHOb9o9OipDv8XsGwvgv8J4x6psnJRv/M
 M9fi19kTbisFd67eiT6a+aPP80Z4nE2P9/quZ0dWEd6Y1tdBkCI26DUvlXaG9CxsqY1sXZl3I5
 rujTXAOsR/M8dr0FgsKwMSRI
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2021 00:12:30 -0800
IronPort-SDR: JjcVY3Mj4WX5JKThEmMG6UTD/FWNgvKBJrQKwd3cH8zG6epzZIrNZXmijDfBidIuMH1w4RSLHC
 4EQqUTK4L1xFsQEssBqagWnY2lHJdv/2nikctW9B1JkGb9mdOfqcp5PcjR/ZzQ6kd71/PShIcw
 AO/l/Fyfl0w+Od9rQ4ZSmTw3B2qrgptwKVp9e0I1qsHnD2CrdgVFcZ04D3Dh+iodLgE1iBlKoS
 u4SfiA/pLjRNT/iuwIQP/zjUVbXViXEf6arfyuB1Y4fg2HNBvdbj8Y1gtFZmGFowcRcB+uEJOk
 ox4=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2021 00:37:47 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4J4TqG6Y13z1RtVv
        for <linux-ide@vger.kernel.org>; Thu,  2 Dec 2021 00:37:46 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:subject:to
        :from; s=dkim; t=1638434266; x=1641026267; bh=ANobDnqVGRKtjmPfIx
        8xtJVgXobho52WeWCmEq6QYS8=; b=dksJjltg8XFJl1QqLK75IYM25zcY2QRKLl
        r98H9UIgX2BeZjHidobcw7N5w4lF+4GQqVqrQoFeyCsfnwEQFnNBfd1osFnzQXE3
        bkp+IkXheM/eoq/wm7NbYKLHYXuhs87rGM+g40yrlcPeNVCNVMWDxM2mOkKTkn55
        hbP/FISi1avkx1SFV6GvkR5dmZx2XZ6/hDJGj49q4JenklwAyCcrDm37Ble0oz2Y
        IXtOEv9DAF5OC67Q4kpz63dHHZhVkhUudHv12HaAVHYICl+b4hmIYgt/fClWIIn5
        lMyTDnwesjJANhv1VxZBkQ6aR6m1L6yMLvDx/g9vK3wQNBTf3nNw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id QwSSEb1CHgDe for <linux-ide@vger.kernel.org>;
        Thu,  2 Dec 2021 00:37:46 -0800 (PST)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4J4TqG20DPz1RtVn
        for <linux-ide@vger.kernel.org>; Thu,  2 Dec 2021 00:37:46 -0800 (PST)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     linux-ide@vger.kernel.org
Subject: [PATCH 2/4] ata: libata-scsi: use sysfs_emit()
Date:   Thu,  2 Dec 2021 17:37:41 +0900
Message-Id: <20211202083743.645391-4-damien.lemoal@opensource.wdc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211202083743.645391-1-damien.lemoal@opensource.wdc.com>
References: <20211202083743.645391-1-damien.lemoal@opensource.wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Use sysfs_emit() instead of snprintf() in ata_scsi_park_show().

Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
---
 drivers/ata/libata-scsi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index 1b84d5526d77..0fc47b2e0c41 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -121,7 +121,7 @@ static ssize_t ata_scsi_park_show(struct device *devi=
ce,
 unlock:
 	spin_unlock_irq(ap->lock);
=20
-	return rc ? rc : snprintf(buf, 20, "%u\n", msecs);
+	return rc ? rc : sysfs_emit(buf, "%u\n", msecs);
 }
=20
 static ssize_t ata_scsi_park_store(struct device *device,
--=20
2.31.1

