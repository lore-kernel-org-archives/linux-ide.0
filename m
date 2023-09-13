Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5740EE0210
	for <linux-ide@archiver.kernel.org>; Wed, 13 Sep 2023 22:20:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232889AbjIMWUt (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 13 Sep 2023 18:20:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229918AbjIMWUs (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 13 Sep 2023 18:20:48 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9939DD
        for <linux-ide@vger.kernel.org>; Wed, 13 Sep 2023 15:20:43 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-502d9ce31cbso448324e87.3
        for <linux-ide@vger.kernel.org>; Wed, 13 Sep 2023 15:20:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694643642; x=1695248442;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:dkim-signature
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oK0TugvzfqHrF5+GTEpZwdvsoVZovDU1BwrXit1xgcI=;
        b=vmarHfAOVloO3U4RzqYIh9WyCzsXASwUGQC6XS6PO8n1wnOvPfUo9cHYPcoURTZd/b
         3b26EX3asMFDP8vRlLws/3j9c1KnlAxOQvoDddk7Zh6eRoRuc9+7Z64rwvL2ParBDAAU
         utPCxQyKGWzYqRzVFz6dxMGXzFHpNny1ok1Mmh8p7wzrjTJ1UM54J1xQ9ju9JiHl/0XH
         gPOJ8nd96SNWe/ezEp+sNIUFJlPzEK0vJlorcJAygvZWUkiGaHA6b0d7AG35Ag89QhWU
         xXbCLagiETbjKnDOSHCb/+gjHj0jgxEPxMNFYB3DfFXLd0FeaeasXoJ6v/VUrLJ29ctj
         JSFw==
X-Gm-Message-State: AOJu0Yx8D9RkxDgqE/CWy0b7+wLX001ic8HaHgalq3Cg7KtUCFQquTbf
        9GbKcO38UL9K2G7vloTLnaoysKacgkpXTDCU
X-Google-Smtp-Source: AGHT+IGFnTLi2rz1tLnpUNYBLgs/LnD0T2c0BwEiVG96dsqs+/81rd0Dow+xpWEnm5w/vdrW/Mi6Cg==
X-Received: by 2002:a05:6512:39cc:b0:502:b1b9:88c5 with SMTP id k12-20020a05651239cc00b00502b1b988c5mr3617597lfu.26.1694643641865;
        Wed, 13 Sep 2023 15:20:41 -0700 (PDT)
Received: from flawful.org (c-f5f0e255.011-101-6d6c6d3.bbcust.telenor.se. [85.226.240.245])
        by smtp.gmail.com with ESMTPSA id d21-20020ac24c95000000b00502c6dc612fsm19415lfl.219.2023.09.13.15.20.41
        for <linux-ide@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Sep 2023 15:20:41 -0700 (PDT)
Received: by flawful.org (Postfix, from userid 112)
        id B2375B9C2; Thu, 14 Sep 2023 00:20:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=flawful.org; s=mail;
        t=1694643640; bh=0TdKeFpDuCj0YXMFZ6RRpYhUyB2ufo+za7+FjH7o+E0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Zl55mgtGGvyrnqRFquw2k6BD4gXO5mCRttu7Bm33i+5ph3gjixUQdY2yU2gtJHQbN
         CQwo79l2SRGnXiZU7kzX4L73gDARBDQtl5sgKncHe9UBkcG6UcGz+/tfNpF8piTa89
         0M3n38tEC2n23M2k7gHAlikIReRodZ0YAPtQgG9A=
Received: from x1-carbon.wdc.com (unknown [129.253.182.62])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by flawful.org (Postfix) with ESMTPSA id 64EFFB964;
        Thu, 14 Sep 2023 00:19:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=flawful.org; s=mail;
        t=1694643603; bh=0TdKeFpDuCj0YXMFZ6RRpYhUyB2ufo+za7+FjH7o+E0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rU9evv+9dxPniqvHTurgGdmIwRtscM8t6+db5QNfuC1RDGoIWv+4B7oGdm4z0x8oK
         9WY8RK6D5rIBT0DAV7DDcXY3NW9PXv/hZJOEXhwQYXvIMQgNcZUKhZ2HEc4WLXT2ov
         Y/pdys5xNwXILtMZjW7vbUdk6b5aQzBJH0Qo0I04=
From:   Niklas Cassel <nks@flawful.org>
To:     Damien Le Moal <dlemoal@kernel.org>
Cc:     Li Nan <linan122@huawei.com>, Li Nan <linan666@huaweicloud.com>,
        linux-ide@vger.kernel.org, Niklas Cassel <niklas.cassel@wdc.com>
Subject: [PATCH 2/2] ata: libata-eh: do not thaw the port twice in ata_eh_reset()
Date:   Thu, 14 Sep 2023 00:19:17 +0200
Message-ID: <20230913221917.1217856-2-nks@flawful.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230913221917.1217856-1-nks@flawful.org>
References: <20230913221917.1217856-1-nks@flawful.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

From: Niklas Cassel <niklas.cassel@wdc.com>

commit 1e641060c4b5 ("libata: clear eh_info on reset completion") added
a workaround that broke the retry mechanism in ATA EH.

Tejun himself suggested to remove this workaround when it was identified
to cause additional problems:
https://lore.kernel.org/linux-ide/20110426135027.GI878@htj.dyndns.org/

He and even said:
"Hmm... it seems I wasn't thinking straight when I added that work around."
https://lore.kernel.org/linux-ide/20110426155229.GM878@htj.dyndns.org/

While removing the workaround solved the issue, however, the workaround was
kept to avoid "spurious hotplug events during reset", and instead another
workaround was added on top of the existing workaround in commit
8c56cacc724c ("libata: fix unexpectedly frozen port after ata_eh_reset()").

Because these IRQs happened when the port was frozen, we know that they
were actually a side effect of PxIS and IS.IPS(x) not being cleared before
the COMRESET. This is now done in commit 94152042eaa9 ("ata: libahci: clear
pending interrupt status"), so these workarounds can now be removed.

Since commit 1e641060c4b5 ("libata: clear eh_info on reset completion") has
now been reverted, the ATA EH retry mechanism is functional again, so there
is once again no need to thaw the port more than once in ata_eh_reset().

This reverts "the workaround on top of the workaround" introduced in commit
8c56cacc724c ("libata: fix unexpectedly frozen port after ata_eh_reset()").

Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>
---
 drivers/ata/libata-eh.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index 5c493b6316eb..4cf4f57e57b8 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -2803,9 +2803,6 @@ int ata_eh_reset(struct ata_link *link, int classify,
 		slave->eh_info.serror = 0;
 	spin_unlock_irqrestore(link->ap->lock, flags);
 
-	if (ata_port_is_frozen(ap))
-		ata_eh_thaw_port(ap);
-
 	/*
 	 * Make sure onlineness and classification result correspond.
 	 * Hotplug could have happened during reset and some
-- 
2.41.0

