Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CDB2C433EF
	for <linux-ide@archiver.kernel.org>; Mon, 11 Oct 2021 20:36:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2278260273
	for <linux-ide@archiver.kernel.org>; Mon, 11 Oct 2021 20:36:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229964AbhJKUiV (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 11 Oct 2021 16:38:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbhJKUiV (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 11 Oct 2021 16:38:21 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD573C061570
        for <linux-ide@vger.kernel.org>; Mon, 11 Oct 2021 13:36:20 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id i12so47250909wrb.7
        for <linux-ide@vger.kernel.org>; Mon, 11 Oct 2021 13:36:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VaiVS6D7a5h6zw87aEfKmy0BLLKYGU9u2ORgppxMylc=;
        b=HyDOWh/sBVf3MfqHS5zl3573jj/ctgnTt0JTADHXIJWkmMvIv/MZ43qiF9PyyXbVqd
         UuNcAgAfrnDhE3Sz3CQKKVWQw4r/FIfhHCZIDN213nEna15glq3qAhN3Jb0QiNmpREZv
         5BlqpfebEOyslagjo6fUQoFwze/4a7LO64oYshOAeV0KMYlgP6OCHJHfWWiit6P0SfGN
         95UOOMGXRw3vNV7ZcQ/kzqdPKVEdjfvbBn1tQX9ZAEy+wRuGuPphBjqht5mb+DVrhkNq
         g8Xj3PaIkV1dUQyR4DeaDGAPzmd0RwwwZ35az49zzR+DJsc99fV/YOJ33u1tO79nkf2h
         4NIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VaiVS6D7a5h6zw87aEfKmy0BLLKYGU9u2ORgppxMylc=;
        b=H9yP1sLw//epAdTU82S7i1zzDAzU5yWiXW46zJjmNXmOq+ZwBxTmehs+z3CXdfuXwz
         PemqgR/UVhzAhGVbUGtqON0eyAUJei2oORi2gYGXUDES3rl6jxAiikL3VSw7t3Amwejn
         oORkhn5DQj+tIRtShIAqISvWP+3PJavgi5vTCJw8U6/3ezoDBM1jso/PRD1CWVeTA4Ie
         mtE6H3SaOba2h3fS8gqQ90+1Szj/1NB8UHC+KanE0GxtGKz5KCzrDH14/FcbJQFtsTHQ
         GOzfIYICzPH+M+PqbVmP6ySz6Uegb4pHZtQVg96zVt2CTzer906ansXMi2ryuSBmWEu2
         DG8A==
X-Gm-Message-State: AOAM530gVhQQwyEj0HxrYpdTMb78loOxU8ZUKmfxgGjOjyw/jaLrG70I
        UhCs/kwf3kqaqmWigDAryvDNv66XKMI=
X-Google-Smtp-Source: ABdhPJwd+7fFW26ki8wmNACw3qqZ5TzRBNJUpK7EfP9Dk5vialCzZQuiwjn0qbk+fuKi+FEF4kbZCw==
X-Received: by 2002:a5d:64cf:: with SMTP id f15mr5930216wri.40.1633984579304;
        Mon, 11 Oct 2021 13:36:19 -0700 (PDT)
Received: from hal9001.startit.hu (hal9001.startit.hu. [213.134.5.39])
        by smtp.googlemail.com with ESMTPSA id b2sm755640wrv.67.2021.10.11.13.36.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Oct 2021 13:36:18 -0700 (PDT)
From:   =?UTF-8?q?Istv=C3=A1n=20Pongr=C3=A1cz?= <pongracz.istvan@gmail.com>
To:     linux-ide@vger.kernel.org, damien.lemoal@opensource.wdc.com
Cc:     =?UTF-8?q?Istv=C3=A1n=20Pongr=C3=A1cz?= <pongracz.istvan@gmail.com>
Subject: [PATCH] Add AHCI support for ASM1062+JBM575 cards
Date:   Mon, 11 Oct 2021 22:36:12 +0200
Message-Id: <20211011203612.25504-1-pongracz.istvan@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Signed-off-by: István Pongrácz <pongracz.istvan@gmail.com>

Add support for PCIe SATA expander cards based on ASMedia 1062 + JBM575
controllers.
These cards could provide up to 10 or more SATA ports on one PCIe card.
---
 drivers/ata/ahci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 186cbf90c8ea..97fd96b67731 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -592,6 +592,7 @@ static const struct pci_device_id ahci_pci_tbl[] = {
 	{ PCI_VDEVICE(ASMEDIA, 0x0612), board_ahci },	/* ASM1062 */
 	{ PCI_VDEVICE(ASMEDIA, 0x0621), board_ahci },   /* ASM1061R */
 	{ PCI_VDEVICE(ASMEDIA, 0x0622), board_ahci },   /* ASM1062R */
+	{ PCI_VDEVICE(ASMEDIA, 0x0624), board_ahci },   /* ASM1062+JMB575 */
 
 	/*
 	 * Samsung SSDs found on some macbooks.  NCQ times out if MSI is
-- 
2.20.1

