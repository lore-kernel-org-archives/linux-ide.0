Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A4B7EDEC71
	for <linux-ide@archiver.kernel.org>; Wed, 13 Sep 2023 15:05:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241074AbjIMPFc (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 13 Sep 2023 11:05:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232390AbjIMPFb (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 13 Sep 2023 11:05:31 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16D93B7
        for <linux-ide@vger.kernel.org>; Wed, 13 Sep 2023 08:05:27 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-501bd6f7d11so11379968e87.1
        for <linux-ide@vger.kernel.org>; Wed, 13 Sep 2023 08:05:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694617525; x=1695222325;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:dkim-signature:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6sFQP60tvT84gNeiWi3VivZKKOfvYTHcfR5kI25YMYQ=;
        b=kF8dr+MDb39Sip/n6Sjw+Xha3jAwTtyBOS9a9llDh1hgPms3w9PtHSLRFby+YSU0D8
         VrkS2wS+i2xkdX6aV0CNimzBzl9XKNJwO90UIIH8rjEzyKbtJo6W4i3MLqHD+LwMxedh
         TUi6g2cMBtmin2WoZ5RPwv9t/JhQRLYGw2fN8UUqHaGlOy6BdCRlTmrA7PxcmmRl6LPN
         nbHAHDgQ87wNkr81D8uJH3T0GLw+JFeVcuMks+9hXrrhRK0stgILun7XAjhTH5UNsuCH
         YIfHyDIbxeJA5bcRGJNYDYPpfwy0ly7ESgjny2jkKzFMw17/Z7nKu5F0V6reTKtAxE2h
         o1uw==
X-Gm-Message-State: AOJu0YyOHs6cyJOw9CmKw6w5KqyYUwpkw6Sae76lND5Hv6/+1h/YFAAz
        0dekyd4uAAn/UunWP/tVeUmgbEdVusPppQ==
X-Google-Smtp-Source: AGHT+IEkTxZNzo+jMe/z4gA81hsqwGjWx6nASe9UNCFM7/WbPLQmErVrdQa9I/W+TlgtvycBacSqHw==
X-Received: by 2002:a05:6512:ba9:b0:500:8fcd:c3b5 with SMTP id b41-20020a0565120ba900b005008fcdc3b5mr2880624lfv.12.1694617524935;
        Wed, 13 Sep 2023 08:05:24 -0700 (PDT)
Received: from flawful.org (c-f5f0e255.011-101-6d6c6d3.bbcust.telenor.se. [85.226.240.245])
        by smtp.gmail.com with ESMTPSA id n15-20020a19550f000000b004faa2de9877sm2159566lfe.286.2023.09.13.08.05.24
        for <linux-ide@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Sep 2023 08:05:24 -0700 (PDT)
Received: by flawful.org (Postfix, from userid 112)
        id EA15EB9CA; Wed, 13 Sep 2023 17:05:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=flawful.org; s=mail;
        t=1694617524; bh=olOc6uLzmj6Hyacch0jZRjUNnK9XPDfJ0fwwfkEorrU=;
        h=From:To:Cc:Subject:Date:From;
        b=qYuYinxhU1Be09+CiQe+AcHBcwGHjy3nd+5mVo7pQV4TGGTvXwZtPq9iOrsETZQe0
         O1/Re9WMCynD1ZEdevYwUcP6QBRvyKzA6FGESWRGKyCqlV6ILKbaR2uMV1M4owkHUv
         sLqzPzONPDJIvo7WyYkEW2UYh9KbxCqeYO3ZpQaA=
Received: from x1-carbon.wdc.com (unknown [129.253.182.60])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by flawful.org (Postfix) with ESMTPSA id 45F93B9B1;
        Wed, 13 Sep 2023 17:04:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=flawful.org; s=mail;
        t=1694617506; bh=olOc6uLzmj6Hyacch0jZRjUNnK9XPDfJ0fwwfkEorrU=;
        h=From:To:Cc:Subject:Date:From;
        b=j7+hT6CI3DAMe67Cg5kdGfVPKgJ64bjvSlAUJ3kDtmVfuWyUywDDG7l2tWA0cVnvD
         eh2FrPxT2SxTM1s8cg4ypMSZuvoY8T5VSDBvhsFkJraXnF5VRamrGj5OM6qfG4AmoZ
         3fJG5UDYUw5MivN903Wt7V+RokHK65v7Mxy+y88E=
From:   Niklas Cassel <nks@flawful.org>
To:     Damien Le Moal <dlemoal@kernel.org>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        patenteng <dimitar@daskalov.co.uk>, linux-ide@vger.kernel.org,
        Niklas Cassel <niklas.cassel@wdc.com>
Subject: [PATCH] ata: libata-core: fetch sense data for successful commands iff CDL enabled
Date:   Wed, 13 Sep 2023 17:04:43 +0200
Message-ID: <20230913150443.1200790-1-nks@flawful.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

From: Niklas Cassel <niklas.cassel@wdc.com>

Currently, we fetch sense data for a _successful_ command if either:
1) Command was NCQ and ATA_DFLAG_CDL_ENABLED flag set (flag
   ATA_DFLAG_CDL_ENABLED will only be set if the Successful NCQ command
   sense data supported bit is set); or
2) Command was non-NCQ and regular sense data reporting is enabled.

This means that case 2) will trigger for a non-NCQ command which has
ATA_SENSE bit set, regardless if CDL is enabled or not.

This decision was by design. If the device reports that it has sense data
available, it makes sense to fetch that sense data, since the sk/asc/ascq
could be important information regardless if CDL is enabled or not.

However, the fetching of sense data for a successful command is done via
ATA EH. Considering how intricate the ATA EH is, we really do not want to
invoke ATA EH unless absolutely needed.

Before commit 18bd7718b5c4 ("scsi: ata: libata: Handle completion of CDL
commands using policy 0xD") we never fetched sense data for successful
non-NCQ commands.

In order to not invoke the ATA EH unless absolutely necessary, even if the
device claims support for sense data reporting, only fetch sense data for
successful (NCQ and non-NCQ commands) if CDL is supported and enabled.

Fixes: 3ac873c76d79 ("ata: libata-core: fix when to fetch sense data for successful commands")
Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>
---
 drivers/ata/libata-core.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 74314311295f..2f7f72994cd7 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -4784,10 +4784,7 @@ void ata_qc_complete(struct ata_queued_cmd *qc)
 	 * 0xD. For these commands, invoke EH to get the command sense data.
 	 */
 	if (qc->result_tf.status & ATA_SENSE &&
-	    ((ata_is_ncq(qc->tf.protocol) &&
-	      dev->flags & ATA_DFLAG_CDL_ENABLED) ||
-	     (!ata_is_ncq(qc->tf.protocol) &&
-	      ata_id_sense_reporting_enabled(dev->id)))) {
+	    dev->flags & ATA_DFLAG_CDL_ENABLED) {
 		/*
 		 * Tell SCSI EH to not overwrite scmd->result even if this
 		 * command is finished with result SAM_STAT_GOOD.
-- 
2.41.0

