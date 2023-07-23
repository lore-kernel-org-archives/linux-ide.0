Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D315C001B0
	for <linux-ide@archiver.kernel.org>; Sun, 23 Jul 2023 13:03:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229537AbjGWNDr (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sun, 23 Jul 2023 09:03:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjGWNDq (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sun, 23 Jul 2023 09:03:46 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A047EE4E
        for <linux-ide@vger.kernel.org>; Sun, 23 Jul 2023 06:03:44 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2b9352ff1aeso49594211fa.1
        for <linux-ide@vger.kernel.org>; Sun, 23 Jul 2023 06:03:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690117423; x=1690722223;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:dkim-signature:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JrZ1RBaQ7ERO/uodNYG2/ZWleeOHNQba2BF8cZuwJ50=;
        b=fWKCfVGQEkDPBKDGT43FUTK8L/TzupA6UbKrzhDVjYEqffOwtlAt0dcsyDBk1BzOtv
         U/goUxfL0zqT72Mx9OnT0J6fDtabrcNh+U2TzVpTm8DO58WQiixlDi/BbsXDJTKy0Gjs
         X/wpGYq00q6yDelByFPzKRrfyfdJN0zLjIFSQjwkWVecnMUjz3UGn5GJbcO95r7IeiC9
         4vrovmAVXl2fja+9HjjISRa72I5fmLxIJ4o/cc2DOw7d9b+TxD86NCc36aT4KEpTac2/
         YZICxneCKSazWli5ZMQl7AtfBHDYH4x6Jf5KXrpdH7Jj710XakTbXZaw6T2eFLuvMXGf
         Rxqw==
X-Gm-Message-State: ABy/qLYrVtHgK1Azjz8x3vcNZmjcCEzZ7mwcjpwYdAp98XfZjEKG5Ai3
        j15XCkNjffboMIpMVC0WM9xiEJsVLyI=
X-Google-Smtp-Source: APBJJlF5WnQ15NbXpjHbuuxVKBkPm3hioA+QvnBwC6TyxON7Ta2veCy0Ax9aZvWi4g+wifbcMs2IaA==
X-Received: by 2002:a2e:880a:0:b0:2b7:bb73:b6e5 with SMTP id x10-20020a2e880a000000b002b7bb73b6e5mr4325859ljh.27.1690117422758;
        Sun, 23 Jul 2023 06:03:42 -0700 (PDT)
Received: from flawful.org (c-f5f0e255.011-101-6d6c6d3.bbcust.telenor.se. [85.226.240.245])
        by smtp.gmail.com with ESMTPSA id g15-20020a2e9ccf000000b002b6e77e87fcsm2079346ljj.68.2023.07.23.06.03.42
        for <linux-ide@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jul 2023 06:03:42 -0700 (PDT)
Received: by flawful.org (Postfix, from userid 112)
        id 672CE3F3F; Sun, 23 Jul 2023 15:03:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=flawful.org; s=mail;
        t=1690117421; bh=RK4/qYrRVZG8Z3BteUsiezL5leXPy6rxpOlluYOSUxE=;
        h=From:To:Cc:Subject:Date:From;
        b=fhzUOUC/swF7nsizcOaBN5OWeig5ep8oQFkQFHDl2BkzGxShNo37zY72gjToDlA/N
         j+vjJkY2PLrtQswtb6LYEkCk4Ed/czdTAjyPeRR9+sBpxnV6Nd3DgrwvRGsOrjEBQX
         NPC+7oMcIK868U2z8vwFpsET9yUNUNeLMDRfgbQI=
Received: from x1-carbon.lan (OpenWrt.lan [192.168.1.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by flawful.org (Postfix) with ESMTPSA id 8796D3D9;
        Sun, 23 Jul 2023 15:03:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=flawful.org; s=mail;
        t=1690117404; bh=RK4/qYrRVZG8Z3BteUsiezL5leXPy6rxpOlluYOSUxE=;
        h=From:To:Cc:Subject:Date:From;
        b=SLQylyVqAAgGa6pK+W8O+7KNlkUdSdW9bBAt/ZZw9xXtnV6qmM7scUXutWtMq1zGn
         Q8Kg3cvgrETweHje3db5r6nfZfwJ3FlIVyG3esvpgUm5Wfx3kfpM1GjCB8OLHOyTGP
         U6N5jNpLyKjDNVYW3zCr9/2QJB34aw16bopzFa3Y=
From:   Niklas Cassel <nks@flawful.org>
To:     Damien Le Moal <dlemoal@kernel.org>,
        Niklas Cassel <niklas.cassel@wdc.com>,
        Hannes Reinecke <hare@suse.de>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Borislav Petkov <bp@alien8.de>, linux-ide@vger.kernel.org
Subject: [PATCH] ata: fix when to fetch sense data for successful commands
Date:   Sun, 23 Jul 2023 15:03:14 +0200
Message-ID: <20230723130315.427513-1-nks@flawful.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

From: Niklas Cassel <niklas.cassel@wdc.com>

The condition to fetch sense data was supposed to be:
ATA_SENSE set AND either
1) Command was NCQ and ATA_DFLAG_CDL_ENABLED flag set (flag
   ATA_DFLAG_CDL_ENABLED will only be set if the Successful NCQ command
   sense data supported bit is set); or
2) Command was non-NCQ and regular sense data reporting is enabled.

However the check in 2) accidentally had the negation at the wrong place,
causing it to try to fetch sense data if it was a non-NCQ command _or_
if regular sense data reporting was _not_ enabled.

Fix this by removing the extra parentheses that should not be there,
such that only the correct return (ata_is_ncq()) is negated.

Fixes: 18bd7718b5c4 ("scsi: ata: libata: Handle completion of CDL commands using policy 0xD")
Reported-by: Borislav Petkov <bp@alien8.de>
Closes: https://lore.kernel.org/linux-ide/20230722155621.GIZLv8JbURKzHtKvQE@fat_crate.local/
Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>
---
 drivers/ata/libata-core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index d37ab6087f2f..04db0f2c683a 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -4938,8 +4938,8 @@ void ata_qc_complete(struct ata_queued_cmd *qc)
 		if (qc->result_tf.status & ATA_SENSE &&
 		    ((ata_is_ncq(qc->tf.protocol) &&
 		      dev->flags & ATA_DFLAG_CDL_ENABLED) ||
-		     (!(ata_is_ncq(qc->tf.protocol) &&
-			ata_id_sense_reporting_enabled(dev->id))))) {
+		     (!ata_is_ncq(qc->tf.protocol) &&
+		      ata_id_sense_reporting_enabled(dev->id)))) {
 			/*
 			 * Tell SCSI EH to not overwrite scmd->result even if
 			 * this command is finished with result SAM_STAT_GOOD.
-- 
2.41.0

