From: Wei Yongjun <weiyj.lk@gmail.com>
Subject: [PATCH] sata_inic162x: remove unused variable in inic_scr_read()
Date: Mon, 22 Oct 2012 16:58:30 +0800
Message-ID: <CAPgLHd8hwg_Ts44OtHF5CqbUZfCM4ZahUrt65cgja-tj3FG16Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qa0-f53.google.com ([209.85.216.53]:62574 "EHLO
	mail-qa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751724Ab2JVI6a (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 22 Oct 2012 04:58:30 -0400
Received: by mail-qa0-f53.google.com with SMTP id s11so1076191qaa.19
        for <linux-ide@vger.kernel.org>; Mon, 22 Oct 2012 01:58:30 -0700 (PDT)
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
 drivers/ata/sata_inic162x.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/ata/sata_inic162x.c b/drivers/ata/sata_inic162x.c
index dc35f4d..1e6827c 100644
--- a/drivers/ata/sata_inic162x.c
+++ b/drivers/ata/sata_inic162x.c
@@ -273,12 +273,10 @@ static void inic_reset_port(void __iomem *port_base)
 static int inic_scr_read(struct ata_link *link, unsigned sc_reg, u32 *val)
 {
 	void __iomem *scr_addr = inic_port_base(link->ap) + PORT_SCR;
-	void __iomem *addr;
 
 	if (unlikely(sc_reg >= ARRAY_SIZE(scr_map)))
 		return -EINVAL;
 
-	addr = scr_addr + scr_map[sc_reg] * 4;
 	*val = readl(scr_addr + scr_map[sc_reg] * 4);
 
 	/* this controller has stuck DIAG.N, ignore it */


