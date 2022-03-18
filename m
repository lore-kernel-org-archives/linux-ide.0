Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAC78C433EF
	for <linux-ide@archiver.kernel.org>; Fri, 18 Mar 2022 09:03:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230096AbiCRJEi (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 18 Mar 2022 05:04:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233059AbiCRJEe (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 18 Mar 2022 05:04:34 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB9EF12C6DB
        for <linux-ide@vger.kernel.org>; Fri, 18 Mar 2022 02:03:15 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id y22so9497136eds.2
        for <linux-ide@vger.kernel.org>; Fri, 18 Mar 2022 02:03:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wlQhRdLXHs9BYJqJ0EyuEA00GBGtkEUMsK9DObiszlU=;
        b=GxeGxgwCJT4nbqWB2XqnlMgtCj1001lKcG2KC6xSjBjC0y4hXa3OJqULCtqCy28b4E
         9JU07rhC95wccf6K+yGPjcNtlLD+YLTmn9ftCRwGeeqUJqo277OiNwYtFbv5AlGGtP5v
         siUvEaryETfmDL2/vN2fXO/92FwENf0FZhvZoc8pnW9bElVEK8GGjmCSfRotOIb2deYc
         qabOl/meHX7dvuS8s76djHoaC+JAkgjVIFchUPyXYUz2JCHlsB4jiuFyhyRlZiImV6pO
         bQRClC8hYeSFr1aieU56tSEVsqzenM/aw/pPvWnKe6i5XFwCpB+05Ec3c1mDpwM3cdEn
         yneg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wlQhRdLXHs9BYJqJ0EyuEA00GBGtkEUMsK9DObiszlU=;
        b=ZD4+ypB9Fm+z7Xsdrgfzax9pkWQutxSKt0Hhxex4GesddQ4+EpUf58obX0KX7jFw7j
         /CGPZ2GqSQIa3rBQRcsp/S1u0ezm9hebOUELeYjzmV4aGL43UeAc4A8GpDvFLwofwNbd
         G/GEN/NCA7n1K7/LLb6rihVdm2yvTrnJyr4nLccpikbpvOEdTsKi3Popoq5RTzV+uIWd
         T3Q+keRFFLewekuZirXDhZcSqvCzV0RYfDabL10NFMgVNzHsgLcy8sx7Jv2Oc/sw8mfk
         YuMflQ8B0QCLUPZOyj+43zUZg9e1LoxOTZYaiTJA+ogmXGfG/Y1KMaeTqDe6X5uucUu+
         Twfg==
X-Gm-Message-State: AOAM531mzSYiF4RGOvbPJGzajRmygi+WBE6SgZTYfIo6FGicCarEWCoK
        Rhc/uZPlcrf3MQYDbRl2Bvxgvr4EHLM=
X-Google-Smtp-Source: ABdhPJx4TCvyymQDwcREiCJjz8ruKjz1SkUA+FRNymyZiLpl6uSNQaMKYKBxzJbgMVOegxj5mT1WCg==
X-Received: by 2002:a05:6402:d05:b0:416:a67f:18ee with SMTP id eb5-20020a0564020d0500b00416a67f18eemr8434036edb.120.1647594194044;
        Fri, 18 Mar 2022 02:03:14 -0700 (PDT)
Received: from debian64.daheim (p5b0d7e2a.dip0.t-ipconnect.de. [91.13.126.42])
        by smtp.gmail.com with ESMTPSA id u9-20020a170906124900b006ce88a505a1sm3602293eja.179.2022.03.18.02.03.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Mar 2022 02:03:13 -0700 (PDT)
Received: from chuck by debian64.daheim with local (Exim 4.95)
        (envelope-from <chunkeey@gmail.com>)
        id 1nV8Vs-0003jD-CL;
        Fri, 18 Mar 2022 10:03:12 +0100
From:   Christian Lamparter <chunkeey@gmail.com>
To:     linux-ide@vger.kernel.org
Cc:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 2/2] ata: libata-core: Disable READ LOG DMA EXT for Samsung 840 EVOs
Date:   Fri, 18 Mar 2022 10:03:12 +0100
Message-Id: <87d0ecd21aad4760d5889b2183ad0d21a73e55c6.1647594132.git.chunkeey@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <ba068938e629eb1a8b423a54405233e685cedb78.1647594132.git.chunkeey@gmail.com>
References: <ba068938e629eb1a8b423a54405233e685cedb78.1647594132.git.chunkeey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Samsung' 840 EVO with the latest firmware (EXT0DB6Q) locks up with
the a message: "READ LOG DMA EXT failed, trying PIO" during boot.

Initially this was discovered because it caused a crash
with the sata_dwc_460ex controller on a WD MyBook Live DUO [1].

The reporter "ticerex" which has the unique opportunity that he
has two Samsung 840 EVO SSD! One with the older firmware "EXT0BB0Q"
which boots fine. But the newer/latest firmware "EXT0DB6Q" caused
the headaches.

This failure is not limited to sata_dwc_460ex, it also happens on
ahci controllers (Asmedia) as found in this forum unraid thread [2].
(This was with a "Samsung SSD 840 EVO 120GB" with firmware "EXT0BB6Q")

[1] <https://forum.openwrt.org/t/my-book-live-duo-reboot-loop/122464/11>
[2] <https://forums.unraid.net/topic/77007-disks-not-showing-up/#comment-711295>

Cc: <stable@kernel.org> # 5.10+
Reported-by: ticerex (OpenWrt Forum)
Link: https://forum.openwrt.org/t/my-book-live-duo-reboot-loop/122464
Signed-off-by: Christian Lamparter <chunkeey@gmail.com>
---
"Please use my forum nick."
<https://forum.openwrt.org/t/my-book-live-duo-reboot-loop/122464/14>

The other patch in this series addresses the drivers crash.

Note: This "READ LOG DMA EXT failed" also happens on the newer
Samsung 870 EVOs too:
<https://bugzilla.kernel.org/show_bug.cgi?id=201693#c29>.
I guess there needs to be a database maybe based on the firmware
revision? For now I've settled with the "840 EVO" since I have
found a old, but updated Samsung 840 EVO 120GB in my spare-parts
box that I can test with.
---
 drivers/ata/libata-core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 0c854aebfe0b..760c0d81d148 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -4014,6 +4014,9 @@ static const struct ata_blacklist_entry ata_device_blacklist [] = {
 						ATA_HORKAGE_ZERO_AFTER_TRIM, },
 	{ "Crucial_CT*MX100*",		"MU01",	ATA_HORKAGE_NO_NCQ_TRIM |
 						ATA_HORKAGE_ZERO_AFTER_TRIM, },
+	{ "Samsung SSD 840 EVO*",	NULL,	ATA_HORKAGE_NO_NCQ_TRIM |
+						ATA_HORKAGE_NO_DMA_LOG |
+						ATA_HORKAGE_ZERO_AFTER_TRIM, },
 	{ "Samsung SSD 840*",		NULL,	ATA_HORKAGE_NO_NCQ_TRIM |
 						ATA_HORKAGE_ZERO_AFTER_TRIM, },
 	{ "Samsung SSD 850*",		NULL,	ATA_HORKAGE_NO_NCQ_TRIM |
-- 
2.35.1

