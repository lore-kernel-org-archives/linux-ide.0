Return-Path: <SRS0=vZIR=4C=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F290C2BA83
	for <linux-ide@archiver.kernel.org>; Fri, 14 Feb 2020 17:23:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CAD52082F
	for <linux-ide@archiver.kernel.org>; Fri, 14 Feb 2020 17:23:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581701016;
	bh=tKutHQzqUEtlGwZgT4t3m5DF0mw5khkEEf3otkXuA88=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=RIR4xFRIbsvv3tIEusmuClUjPXhojbCPeqGKc1AY5t6ynVD2t0w2QuY9xF8RoqrDu
	 10pezy1NegUpnb6zGTQaG3GqGrBNmkSG7p8YdRW107i7z+WgOeZZhlKn8D5zkd+q7E
	 SDZo64tqqcYxsuqlFhzVTtrVjljq1ARccLn0ePQM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388344AbgBNRXf (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 14 Feb 2020 12:23:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:33824 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390601AbgBNQJ0 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Fri, 14 Feb 2020 11:09:26 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8F8232468C;
        Fri, 14 Feb 2020 16:09:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581696566;
        bh=tKutHQzqUEtlGwZgT4t3m5DF0mw5khkEEf3otkXuA88=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JEnkZxbsEo/ADrCLGX4V6hWbNQX3Dnco4LG6c8Qqm71UkFbeDIm3wosRRSiPjERKP
         tyWtJX/0Zfgem++Ip71pSh/nPZBVNUhtgyumr4DTUNK8ZYsl+jnL9lr+vIS4OuheVp
         TJlTUh6xazlv0HH6fx5XMJEPSAK0VELSmeE4dv08=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, linux-ide@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 356/459] ide: serverworks: potential overflow in svwks_set_pio_mode()
Date:   Fri, 14 Feb 2020 11:00:06 -0500
Message-Id: <20200214160149.11681-356-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214160149.11681-1-sashal@kernel.org>
References: <20200214160149.11681-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

From: Dan Carpenter <dan.carpenter@oracle.com>

[ Upstream commit ce1f31b4c0b9551dd51874dd5364654ed4ca13ae ]

The "drive->dn" variable is a u8 controlled by root.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/ide/serverworks.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/ide/serverworks.c b/drivers/ide/serverworks.c
index ac6fc3fffa0de..458e72e034b09 100644
--- a/drivers/ide/serverworks.c
+++ b/drivers/ide/serverworks.c
@@ -115,6 +115,9 @@ static void svwks_set_pio_mode(ide_hwif_t *hwif, ide_drive_t *drive)
 	struct pci_dev *dev = to_pci_dev(hwif->dev);
 	const u8 pio = drive->pio_mode - XFER_PIO_0;
 
+	if (drive->dn >= ARRAY_SIZE(drive_pci))
+		return;
+
 	pci_write_config_byte(dev, drive_pci[drive->dn], pio_modes[pio]);
 
 	if (svwks_csb_check(dev)) {
@@ -141,6 +144,9 @@ static void svwks_set_dma_mode(ide_hwif_t *hwif, ide_drive_t *drive)
 
 	u8 ultra_enable	 = 0, ultra_timing = 0, dma_timing = 0;
 
+	if (drive->dn >= ARRAY_SIZE(drive_pci2))
+		return;
+
 	pci_read_config_byte(dev, (0x56|hwif->channel), &ultra_timing);
 	pci_read_config_byte(dev, 0x54, &ultra_enable);
 
-- 
2.20.1

