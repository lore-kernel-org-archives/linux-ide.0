Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD1FFC636CD
	for <linux-ide@archiver.kernel.org>; Wed,  1 Feb 2023 14:10:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232007AbjBAOKi (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 1 Feb 2023 09:10:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjBAOKh (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 1 Feb 2023 09:10:37 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B0365C0CA;
        Wed,  1 Feb 2023 06:10:36 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id o18so7961123wrj.3;
        Wed, 01 Feb 2023 06:10:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SKmXuZrVXgZibZ9oamnZiA8Aaq512YKwBXJW47w2Phg=;
        b=m+su4BE2o3dZMeaSbh6yAdWXZVP4Rg55bJVjCYh1b8wA7qeuOJW+HAKAOd0DYYkaT0
         5znyzjmsFoySkQHoXr0U/jgXJAMq9RT9B297qPDm7vWMLkL8Q8YO+tJFtPTZPMbdRSjO
         qAYewESJbYaQUk+2DEQgLrt1T+yxmTj+MHgRYwjavPLWF9Xiyv9MctUG+rhBXtBJSTd5
         obShSFtgwwjxxbQG3qBEXEjMWleM4bmxZHjc955AqCeuIZzWEMyjagitUjyoHTBM4IPn
         zd3O2MV4ajxJAEYH9sRNE7lURPiRN2X/2WgsC90qJbNXXyi224o07afrRh2iRXMcjakz
         Zfnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SKmXuZrVXgZibZ9oamnZiA8Aaq512YKwBXJW47w2Phg=;
        b=ugeXwEdjDTAEB9B4x0Pc2YHDluoMC60HPpSi5EzH22D1Slcv2lJ9LCrfhgXi1CypUx
         HArLktJ9w1ca2/ULgZNN+9OHLd+khphMr8DqJkYzq3HeDLOrUvjqafoznqqGbanltUCr
         anU5yErcq8eBr19SMW/XGRvob3cRa8r3vxJq1gPB85SMwRWd08GO/vyyL4fMA7ZaiJpG
         IXQCodrHuz3zfPHXa+ZEaZXEcyWNpIaefkXGCKhBGjwp0l9OEzmcC6zu3mYU9+L5TjrG
         RjQ1WrlUeqRIaIRSRFofB8tAEfDzGZ5N+L9bGuMNxkjLywtIrnQDAS8WbSyGD6VgPlXO
         Xkfg==
X-Gm-Message-State: AO0yUKWppMP001fNzQ2WVVA8C6aPyll0GCD6h2t0R33WfDmyfYwVmc1S
        nQrmgbFMVNihPfylo6m1AElJkiRccAw=
X-Google-Smtp-Source: AK7set9I4d3t0TdRNbXG54iNwImlgQoDhUrJExlBESeYk+Emv0Pl3p8/ymOXCiq36684Tsf73+qvpA==
X-Received: by 2002:adf:fa06:0:b0:2bf:d2b8:8c09 with SMTP id m6-20020adffa06000000b002bfd2b88c09mr2543860wrr.61.1675260634695;
        Wed, 01 Feb 2023 06:10:34 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id j11-20020a5d464b000000b002bfd687a96dsm14391877wrs.16.2023.02.01.06.10.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Feb 2023 06:10:34 -0800 (PST)
Date:   Wed, 1 Feb 2023 17:10:30 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     Sergey Shtylyov <s.shtylyov@omp.ru>
Cc:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        linux-ide@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] ata: pata_hpt37x: fix potential forever loop
Message-ID: <Y9py1vjPW5HgRwOR@kili>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

This code accidentally reuses the "tries" iterator for both the inside
and outside loops.  It could result in a forever loop if the "tries"
variable gets reset to 0x1000 and never reaches 0x5000.

Fixes: 669a5db411d8 ("[libata] Add a bunch of PATA drivers.")
Signed-off-by: Dan Carpenter <error27@gmail.com>
---
 drivers/ata/pata_hpt37x.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/pata_hpt37x.c b/drivers/ata/pata_hpt37x.c
index ce3c5eaa7e76..35be9a095b18 100644
--- a/drivers/ata/pata_hpt37x.c
+++ b/drivers/ata/pata_hpt37x.c
@@ -621,14 +621,14 @@ static int hpt37x_calibrate_dpll(struct pci_dev *dev)
 {
 	u8 reg5b;
 	u32 reg5c;
-	int tries;
+	int tries, tries2;
 
 	for (tries = 0; tries < 0x5000; tries++) {
 		udelay(50);
 		pci_read_config_byte(dev, 0x5b, &reg5b);
 		if (reg5b & 0x80) {
 			/* See if it stays set */
-			for (tries = 0; tries < 0x1000; tries++) {
+			for (tries2 = 0; tries2 < 0x1000; tries2++) {
 				pci_read_config_byte(dev, 0x5b, &reg5b);
 				/* Failed ? */
 				if ((reg5b & 0x80) == 0)
-- 
2.35.1

