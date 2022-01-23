Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98662C433EF
	for <linux-ide@archiver.kernel.org>; Sun, 23 Jan 2022 22:22:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230156AbiAWWWt (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sun, 23 Jan 2022 17:22:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230019AbiAWWWs (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sun, 23 Jan 2022 17:22:48 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D340C06173B;
        Sun, 23 Jan 2022 14:22:48 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id f17so10248050wrx.1;
        Sun, 23 Jan 2022 14:22:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=O3v5uwB/XqoZye4bhwmXdGCHA74bTpbhxCtsFP1wkqk=;
        b=TLbPoRKj0iYZXA9sHWj1ZAF1UOrJZt0V0GvBsNaK/G8dhIB3xqPdjWJqaYL18sxOvt
         ZymXqzKnDaRL0a0AMgCyNQjoPQtTnIzj0AM1YpzvdwSjLAEhVAcuQWxe9ZguTzP0cUVM
         ws/OB95oPta6AOv9MwjanVKFbwoBNr0CjlhKMfKaD+aV4mt5HT4LhymbxceBM8tEJKoj
         h+25vZ1WazqSHZn9Z1u7jYOH2Y7+j7lWmYOo00KD+mwTDr4BdVKTiil/jaq82DBCZHLM
         Ym5fwM3cxGiOGqvTuxAf2fUqLUcPo4CFt/DiLLHXvtCGO/6M/SvzaBDJuBh6KbEhRuZ0
         AHXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=O3v5uwB/XqoZye4bhwmXdGCHA74bTpbhxCtsFP1wkqk=;
        b=VsMoJRG1+SVain5dWzXi7xTeY1Yv8NankXsvNu4cQURz1Vxu5RwPmmXgWRNPLnj+UG
         KVLAwT7WOo4TzZQplGZkV7yYsR5qnKvlL9ZafrzAtxX9JIY9u7JeitoO1I6WnzYrl4Vd
         aaYC/iKvE/nj7OuiDqX13Yt7Ekn5N3UJGHhu8wbLqSPJ/ENhKjAKkgMypmsx5Q/Xiy6w
         1JSNDWQh5ZahN2jZFB3njx+WGaqKL5jI1UcVwkPRQwMib8KOzTz8cv0i0Hf/abLZzzTT
         LoVKt8zV87D8vp56hvWhhby8xPQqyRdQqmVu66a2YsNAsCHabUhgpMpc17XPKafMdcvZ
         qZCQ==
X-Gm-Message-State: AOAM532zQdwNZx1sfHabtMxvqWsdZfQuoveFXmI37zVunoo5GnANObJA
        RrFP48ZpwS0ArOA6gz0Cr/Ml5DbiWbEefw==
X-Google-Smtp-Source: ABdhPJywRT1dbxGkbq9H2v8AofH1SETZMi3wap5MSHeOEK56EbKWuSMorSIBlrXNsVRIzDEPIUWdEA==
X-Received: by 2002:adf:9dce:: with SMTP id q14mr10857339wre.193.1642976566975;
        Sun, 23 Jan 2022 14:22:46 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id h127sm19066369wmh.2.2022.01.23.14.22.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jan 2022 14:22:46 -0800 (PST)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        linux-ide@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org
Subject: [PATCH] ata: pata_pdc202xx_old: make make static read-only array pio_timing const
Date:   Sun, 23 Jan 2022 22:22:46 +0000
Message-Id: <20220123222246.5801-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

The static array pio_timing is read-only so it make sense to make
it const.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/ata/pata_pdc202xx_old.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/pata_pdc202xx_old.c b/drivers/ata/pata_pdc202xx_old.c
index b99849095853..f894ff2de0a9 100644
--- a/drivers/ata/pata_pdc202xx_old.c
+++ b/drivers/ata/pata_pdc202xx_old.c
@@ -78,7 +78,7 @@ static void pdc202xx_configure_piomode(struct ata_port *ap, struct ata_device *a
 {
 	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
 	int port = 0x60 + 8 * ap->port_no + 4 * adev->devno;
-	static u16 pio_timing[5] = {
+	static const u16 pio_timing[5] = {
 		0x0913, 0x050C , 0x0308, 0x0206, 0x0104
 	};
 	u8 r_ap, r_bp;
-- 
2.33.1

