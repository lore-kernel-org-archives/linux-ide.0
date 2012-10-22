From: Wei Yongjun <weiyj.lk@gmail.com>
Subject: [PATCH] sata_sil24: remove unused variable from sata_sil24.c
Date: Mon, 22 Oct 2012 17:17:33 +0800
Message-ID: <CAPgLHd8WfEeeh1aih16RRspbt24cofLd2h+YSFEoBKhTL-Ozaw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qc0-f174.google.com ([209.85.216.174]:64483 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751979Ab2JVJRe (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 22 Oct 2012 05:17:34 -0400
Received: by mail-qc0-f174.google.com with SMTP id o22so1313124qcr.19
        for <linux-ide@vger.kernel.org>; Mon, 22 Oct 2012 02:17:33 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: yongjun_wei@trendmicro.com.cn, linux-ide@vger.kernel.org

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

The variable addr is initialized but never used
otherwise, so remove the unused variable.

dpatch engine is used to auto generate this patch.
(https://github.com/weiyj/dpatch)

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 drivers/ata/sata_sil24.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/ata/sata_sil24.c b/drivers/ata/sata_sil24.c
index a5f2a56..59f0d63 100644
--- a/drivers/ata/sata_sil24.c
+++ b/drivers/ata/sata_sil24.c
@@ -506,8 +506,6 @@ static int sil24_scr_read(struct ata_link *link, unsigned sc_reg, u32 *val)
 	void __iomem *scr_addr = sil24_port_base(link->ap) + PORT_SCONTROL;
 
 	if (sc_reg < ARRAY_SIZE(sil24_scr_map)) {
-		void __iomem *addr;
-		addr = scr_addr + sil24_scr_map[sc_reg] * 4;
 		*val = readl(scr_addr + sil24_scr_map[sc_reg] * 4);
 		return 0;
 	}
@@ -519,8 +517,6 @@ static int sil24_scr_write(struct ata_link *link, unsigned sc_reg, u32 val)
 	void __iomem *scr_addr = sil24_port_base(link->ap) + PORT_SCONTROL;
 
 	if (sc_reg < ARRAY_SIZE(sil24_scr_map)) {
-		void __iomem *addr;
-		addr = scr_addr + sil24_scr_map[sc_reg] * 4;
 		writel(val, scr_addr + sil24_scr_map[sc_reg] * 4);
 		return 0;
 	}


