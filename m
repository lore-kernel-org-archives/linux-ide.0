Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E4A7C83F2C
	for <linux-ide@archiver.kernel.org>; Tue,  5 Sep 2023 16:21:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344081AbjIEQU7 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 5 Sep 2023 12:20:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354591AbjIEMuL (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 5 Sep 2023 08:50:11 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 110291A8
        for <linux-ide@vger.kernel.org>; Tue,  5 Sep 2023 05:50:07 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-500c6ff99acso4011430e87.1
        for <linux-ide@vger.kernel.org>; Tue, 05 Sep 2023 05:50:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693918205; x=1694523005;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:dkim-signature:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pOq+6iD2yCDq6yPstwNk6Mle2ruK4dj5uYmzVFcBN9Q=;
        b=l6cDrEpYOENZEEwgz7zih4lBJa6XuoswCyLt/M1oG8AublYMcegaL1QkglM+0aQhA1
         nrDuzMm7neBRB9Pwppu7NL0t51NTac8mRNWhqG5Z+OYx8WAZOpcJ5lubAmTYkb55JPXt
         GUR9m4PYaU6zQ6Ddvj1Q+fGBvJZ2Poqr10IPkVlYjAcX5D/uz3ClW0PWbVi7KWcwXFXU
         mmJnVWJCOO+Vw8CtPVQB/kyIJH6AyWg+hsy1YerKLCxa+MxLa0/hlUqa8KDMVfiJtNAk
         nuEYLUDAgcarAnraTtSwFZ4i+PHWI22c0nOEipXaxXSti1SgEQaSLw2q87opoLllgIDw
         idMA==
X-Gm-Message-State: AOJu0YzgbMw2dj5in0c3ReIIFzU1WVEwChBeYGpNAqxJkVJdVmwiI9yS
        RkuQ2NHVDJ7MoKbmobL92kLeEz6wQwBzTg==
X-Google-Smtp-Source: AGHT+IFt/0Zx54+UtLeBffnUkay985fvc3bpuxBU6enRH/W/6PArrxyHH0XH1b1yYpbapMxSbqVqog==
X-Received: by 2002:a05:6512:348e:b0:500:b890:fb3c with SMTP id v14-20020a056512348e00b00500b890fb3cmr3821382lfr.27.1693918205104;
        Tue, 05 Sep 2023 05:50:05 -0700 (PDT)
Received: from flawful.org (c-f5f0e255.011-101-6d6c6d3.bbcust.telenor.se. [85.226.240.245])
        by smtp.gmail.com with ESMTPSA id h4-20020a0565123c8400b00501c12fe522sm270837lfv.73.2023.09.05.05.50.04
        for <linux-ide@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Sep 2023 05:50:04 -0700 (PDT)
Received: by flawful.org (Postfix, from userid 112)
        id 9FC8DB98E; Tue,  5 Sep 2023 14:50:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=flawful.org; s=mail;
        t=1693918203; bh=P8VQn4H+hezwEMXsSeRWmVh60wEQxSpIT0c/iUJmdBY=;
        h=From:To:Cc:Subject:Date:From;
        b=ddlnzeP3xN3L9Rz+I8Z/Onk5uYAOz76eXcPMyqcYpGiDbWohZ+3DpTIGNHpdLKHoS
         3lZjUB2LvlNGzteazJ9isWJNNGBp89PYzlFn/N+f4vBZxnkW6uSjDUpJnoZQH+wTll
         uPgz+m3eWUVDGdE6kvkARETvBajmvpkQWliebwEk=
Received: from x1-carbon.wdc.com (unknown [129.253.182.59])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by flawful.org (Postfix) with ESMTPSA id A4B16B968;
        Tue,  5 Sep 2023 14:49:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=flawful.org; s=mail;
        t=1693918193; bh=P8VQn4H+hezwEMXsSeRWmVh60wEQxSpIT0c/iUJmdBY=;
        h=From:To:Cc:Subject:Date:From;
        b=U3Tg3jK+03EY2PWQdX3T8myGRS+ke4/3eoxsL1iHAQmf9yNzwZ6SzsaAyKxiLej7C
         c3rX7zr3/dsg1Y9Z2vFQ5Y2mktkkgMzWCIcba9yBgde/s+lubQ+ah8VcUR7aqNf1eo
         dQH/yHvXvg3VODqlE3N/TVHlvoi8OGV8JqB98zZU=
From:   Niklas Cassel <nks@flawful.org>
To:     Damien Le Moal <dlemoal@kernel.org>
Cc:     Niklas Cassel <niklas.cassel@wdc.com>, linux-ide@vger.kernel.org
Subject: [PATCH] ata: ahci: print the lpm policy on boot
Date:   Tue,  5 Sep 2023 14:49:08 +0200
Message-ID: <20230905124909.3334046-1-nks@flawful.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

From: Niklas Cassel <niklas.cassel@wdc.com>

The target LPM policy can be set using either a Kconfig or a kernel module
parameter.

However, if the board type is set to anything but board_ahci_low_power,
then the LPM policy will overridden and set to ATA_LPM_UNKNOWN.

Additionally, if the default suspend is suspend to idle, depending on the
hardware capabilities of the HBA, ahci_update_initial_lpm_policy() might
override the LPM policy to either ATA_LPM_MIN_POWER_WITH_PARTIAL or
ATA_LPM_MIN_POWER.

All this means that it is very hard to know which LPM policy a user will
actually be using on a given system.

In order to make it easier to debug LPM related issues, print the LPM
policy on boot.

One common LPM related issue is that the device fails to link up.
Because of that, we cannot add this print to ata_dev_configure(), as that
function is only called after a successful link up. Instead, add the info
using ata_port_desc(). The port description is printed once during boot.

Before changes:
ata1: SATA max UDMA/133 abar m524288@0xa5780000 port 0xa5780100 irq 170
ata2: SATA max UDMA/133 abar m524288@0xa5780000 port 0xa5780180 irq 170

After changes:
ata1: SATA max UDMA/133 abar m524288@0xa5780000 port 0xa5780100 lpm-pol 4 irq 170
ata2: SATA max UDMA/133 abar m524288@0xa5780000 port 0xa5780180 lpm-pol 4 irq 170

Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>
---
 drivers/ata/ahci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index abb5911c9d09..541f6ec7f395 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -1898,6 +1898,7 @@ static int ahci_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 			ap->em_message_type = hpriv->em_msg_type;
 
 		ahci_update_initial_lpm_policy(ap, hpriv);
+		ata_port_desc(ap, "lpm-pol %d", ap->target_lpm_policy);
 
 		/* disabled/not-implemented port */
 		if (!(hpriv->port_map & (1 << i)))
-- 
2.41.0

