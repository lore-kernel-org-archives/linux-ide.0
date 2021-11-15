Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9B37C433F5
	for <linux-ide@archiver.kernel.org>; Mon, 15 Nov 2021 06:06:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A2F9161C48
	for <linux-ide@archiver.kernel.org>; Mon, 15 Nov 2021 06:06:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230017AbhKOGJB (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 15 Nov 2021 01:09:01 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:15528 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230111AbhKOGI5 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 15 Nov 2021 01:08:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1636956363; x=1668492363;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=LcEzRPgYYoxUM3gBTJ7X/fWkFD7qZQRFLRB1IyW1yJk=;
  b=S1q5UsKcfEYAHHUl+QNFpruXxiYyc+yA5Jp3AAVBqYPQ/sYiqxiqHxl9
   weI4XwXH8/IUYdCiHqsCqDQwXPz0XCpfYEB7VifHG4PAsW9YGgyG10Jfh
   by67ODZL3ohKom/XAnjtq2h0Nq8tWEOlZJexz5H+jLYnAXKFKmc5pmFqX
   0tl6MKpBNzqR9d0sFRii8Ch2BTuws6iVsulTTySUFUhn/UGGH+1KngTUA
   7p7fH8IvT9A5ROG8Zjog+IuHMIwabNKLPKeA/DwNU0eGENpDRbvyvs3kZ
   Aaw1/Ifga1trJKUez1IRZ7kEMQXEURp553j3xg2i11RHf+a5RAoclaBV9
   w==;
X-IronPort-AV: E=Sophos;i="5.87,235,1631548800"; 
   d="scan'208";a="297418914"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 15 Nov 2021 14:06:03 +0800
IronPort-SDR: 07cFVz3MpEM7uJCc/3g/0K2rheTSTIECKbVbu7Y4BKKxOlRiwryW7ichxEsliWhHNseb874h8W
 Iy5yhk0pfTPSS+4mJikwcp64RKvHrhbuEMDlVCscJH5qqy0apGHRZ8hxW/I8y+jOV21mWEGCir
 Nr5n04a5NB/hmRYU6aOuiDs2rc8kXcVC0min1/PPBNk7dBQM3EyqQzWiLuJ8nZ7px3hWDDD+47
 T8o28mKPF2ld+ihLJEpS56iz0cc3tkZITTHGiGD7SNFdfOSHR6iGVUViQnbNjrix38G9UP2yV6
 vQehny1X4J9fze7d02uNrcAU
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2021 21:39:35 -0800
IronPort-SDR: SS72n2ohoy4lDBOMBH1VcnIFrzdcvv0+QRYK9a8EuhjqvVk+eFykRIMEVGvJ94TjMojpDgOQTm
 2w0Vuc9Hq/um4ZOpGuTKPEDjdJ0Rx6qzeLCcchEAmHfrrTk52RD+ksAI4ug9gdu6HQ1wWiF93o
 PRRI8OxrrwS6reLb0ok0xhBtOpGXzXGOW737nSPyeqAEjJfSGqAPGv7PQDYAxb6HxTpZ1spyjr
 tM09bdKMspKx9xylnSvXB9zoKC8LFZUIIpz86U7K6jvbLvQq7YELpIE+cw/RCwLUAyI39qHwSu
 aVs=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2021 22:06:03 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4HszG252hCz1RtVm
        for <linux-ide@vger.kernel.org>; Sun, 14 Nov 2021 22:06:02 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:subject:to
        :from; s=dkim; t=1636956362; x=1639548363; bh=LcEzRPgYYoxUM3gBTJ
        7X/fWkFD7qZQRFLRB1IyW1yJk=; b=oj/cGZdWFOOlH5sCDl5OJn32q2kmJRI3Ar
        sfPwr6sUI7ersa4sHr9VfcpyHgjdGvFC26tTV23KxOXlMF5oFJuI6gfq+dr9pGAf
        CiuxpzNE3N6/KgHIQll0onfjMbxLW69gXv2PWX8Kf3mmy8deG1mjEai8o97BgofL
        DcGfjqjso+3n54jO8xWWYloZkhzT2bGcfTVKq1+B1GDzDwsCm8QcDlt/gGzebv9z
        Tvtj3qUTTxlrTj54As0ZZ78ufOlFC5n8joBGiXrOAwr/hujN/dKfmZuBckdYuJyg
        5YrrqTGCW80H1PGh2AgiVeirTzj1HtOlXmQCkXv5RJBm2vEtgK4g==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id k8sYo9MmoKhn for <linux-ide@vger.kernel.org>;
        Sun, 14 Nov 2021 22:06:02 -0800 (PST)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4HszG2050Gz1RtVl
        for <linux-ide@vger.kernel.org>; Sun, 14 Nov 2021 22:06:01 -0800 (PST)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     linux-ide@vger.kernel.org
Subject: [PATCH 2/2] libata: core: add missing ata_identify_page_supported() calls
Date:   Mon, 15 Nov 2021 15:05:59 +0900
Message-Id: <20211115060559.232835-3-damien.lemoal@opensource.wdc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211115060559.232835-1-damien.lemoal@opensource.wdc.com>
References: <20211115060559.232835-1-damien.lemoal@opensource.wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

ata_dev_config_ncq_prio() and ata_dev_config_devslp() both access pages
of the IDENTIFY DEVICE data log. Before calling ata_read_log_page(),
make sure to check for the existence of the IDENTIFY DEVICE data log and
of the log page accessed suing ata_identify_page_supported(). This
avoids useless error messages from ata_read_log_page().

Reported-by: Nikolay <knv418@gmail.com>
Cc: stable@kernel.org # 4.14+
Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
---
 drivers/ata/libata-core.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index edaedcd82630..59ad8c979cb3 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -2178,6 +2178,9 @@ static void ata_dev_config_ncq_prio(struct ata_devi=
ce *dev)
 	struct ata_port *ap =3D dev->link->ap;
 	unsigned int err_mask;
=20
+	if (!ata_identify_page_supported(dev, ATA_LOG_SATA_SETTINGS))
+		return;
+
 	err_mask =3D ata_read_log_page(dev,
 				     ATA_LOG_IDENTIFY_DEVICE,
 				     ATA_LOG_SATA_SETTINGS,
@@ -2454,7 +2457,8 @@ static void ata_dev_config_devslp(struct ata_device=
 *dev)
 	 * Check device sleep capability. Get DevSlp timing variables
 	 * from SATA Settings page of Identify Device Data Log.
 	 */
-	if (!ata_id_has_devslp(dev->id))
+	if (!ata_id_has_devslp(dev->id) ||
+	    !ata_identify_page_supported(dev, ATA_LOG_SATA_SETTINGS))
 		return;
=20
 	err_mask =3D ata_read_log_page(dev,
--=20
2.31.1

