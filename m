Return-Path: <SRS0=CgUK=UT=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19AB7C48BE1
	for <linux-ide@archiver.kernel.org>; Thu, 20 Jun 2019 20:47:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6BA62082C
	for <linux-ide@archiver.kernel.org>; Thu, 20 Jun 2019 20:47:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hJ6q078t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726225AbfFTUrm (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 20 Jun 2019 16:47:42 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:36742 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725913AbfFTUrm (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 20 Jun 2019 16:47:42 -0400
Received: by mail-pg1-f196.google.com with SMTP id f21so2196321pgi.3;
        Thu, 20 Jun 2019 13:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PMt7yLjdc6r9uX/+tIjfvpZhF8NQodxx8KP0lI5Lw6s=;
        b=hJ6q078tHT3sikIf05Cqna6OA61QOW3BwOA1UjoB1o+48FNdzvRmjT3sHp4EpmV6BR
         sGK3ND0D3dEO4doZNEzjI9T4IC4fST9HraK4CkGRxwIqVW+Fr41WLcTaYyvMhkZ4ZI2G
         q2EANHmuMNDLX3Hb7kPb5zoEn4A/7+twanpCLKNu3VW4HNPzNWqR+qrD0B4cOzoXCM4P
         9+o4+4hDDjyKpOTQMzn5CHVQLE/5tNjgSuuvfKsMSBbg/l21+uTsqKH6JkjuygTfvBkQ
         bUapAJqGjYA2AmglmEgtdRA/xBenj/dNnkK5qWiOKe13NqxeDZH1hme6rRtGWdO4dFsJ
         HjyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=PMt7yLjdc6r9uX/+tIjfvpZhF8NQodxx8KP0lI5Lw6s=;
        b=BbmygdktdmciNUpI+7pEhoB/ggoMNMyOcv5bB5akZ2oMb3pbjTs5E/B84YIXAz2tir
         UAc3WAWINvw/5mEDDTp/HCYuwkpUxRUPOkclylIWFGtxd3FbWegWk1xKgSSWkxENi9MU
         12lzkvqffE36pgDAFYVR4YvoRado2h/wnTfjXnHKexYD3TMWZg+R75eWSt6AMktzla11
         1h59xrKwOpIjKDUVz5ojNiqKp9D4Fz8VShpDjakBi/GIF1pnqidpn+orqTelBdm2Yvr/
         vHl4lZmFtabSHTTvbbl+mdQX0yzH0Z66t3RKfpCjQntICP9MUMrUcOjvpfq/nB/HBBUP
         /fbg==
X-Gm-Message-State: APjAAAUlJGM7r4hlopIqKd54csHmsSp1b84Pbh8kqIz4U5Q1g2oNj4Oj
        qg/lhycOeChvdPEJXgyp9F+MC8Aa
X-Google-Smtp-Source: APXvYqxnPQpD2/y5UouJJa7B8J83MFX7ZuJI+cMCbHLRex3NtFaaSvEl61TBjS1xAIKN+axGPQCh3w==
X-Received: by 2002:a17:90a:3585:: with SMTP id r5mr1686823pjb.15.1561063661718;
        Thu, 20 Jun 2019 13:47:41 -0700 (PDT)
Received: from xplor.waratah.dyndns.org (122-58-182-39-adsl.sparkbb.co.nz. [122.58.182.39])
        by smtp.gmail.com with ESMTPSA id t29sm359165pfq.156.2019.06.20.13.47.40
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Thu, 20 Jun 2019 13:47:41 -0700 (PDT)
Received: by xplor.waratah.dyndns.org (Postfix, from userid 1000)
        id 3DFC3360082; Fri, 21 Jun 2019 08:47:38 +1200 (NZST)
From:   Michael Schmitz <schmitzmic@gmail.com>
To:     linux-m68k@vger.kernel.org, linux-ide@vger.kernel.org
Cc:     geert@linux-m68k.org, b.zolnierkie@samsung.com,
        Michael Schmitz <schmitzmic@gmail.com>
Subject: [PATCH RFC 1/2] m68k/atari: add platform device for Falcon IDE port
Date:   Fri, 21 Jun 2019 08:47:21 +1200
Message-Id: <1561063642-13900-2-git-send-email-schmitzmic@gmail.com>
X-Mailer: git-send-email 1.7.0.4
In-Reply-To: <CAMuHMdUcUqWWGNngNV3EpEq5wSsf5qTVeZvTB9gX1e26Jrq1xA@mail.gmail.com>
References: <CAMuHMdUcUqWWGNngNV3EpEq5wSsf5qTVeZvTB9gX1e26Jrq1xA@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Autoloading of Falcon IDE driver modules requires converting
these drivers to platform drivers.

Add platform device for Falcon IDE interface in Atari platform
setup code in preparation for this.

Add Falcon IDE base address in Atari hardware address header.

Signed-off-by: Michael Schmitz <schmitzmic@gmail.com>
---
 arch/m68k/atari/config.c        |   20 ++++++++++++++++++++
 arch/m68k/include/asm/atarihw.h |    6 ++++++
 2 files changed, 26 insertions(+), 0 deletions(-)

diff --git a/arch/m68k/atari/config.c b/arch/m68k/atari/config.c
index ca8469e..2d7133a 100644
--- a/arch/m68k/atari/config.c
+++ b/arch/m68k/atari/config.c
@@ -896,6 +896,21 @@ static void isp1160_delay(struct device *dev, int delay)
 };
 #endif
 
+#if IS_ENABLED(CONFIG_PATA_FALCON)
+static const struct resource atari_falconide_rsrc[] __initconst = {
+	{
+		.flags = IORESOURCE_MEM,
+		.start = FALCON_IDE_BASE,
+		.end   = FALCON_IDE_BASE+0x40,
+	},
+	{
+		.flags = IORESOURCE_IRQ,
+		.start = IRQ_MFP_FSCSI,
+		.end   = IRQ_MFP_FSCSI,
+	},
+};
+#endif
+
 int __init atari_platform_init(void)
 {
 	int rv = 0;
@@ -939,6 +954,11 @@ int __init atari_platform_init(void)
 			atari_scsi_tt_rsrc, ARRAY_SIZE(atari_scsi_tt_rsrc));
 #endif
 
+#if IS_ENABLED(CONFIG_PATA_FALCON)
+	if (ATARIHW_PRESENT(IDE))
+		platform_device_register_simple("pata_falcon", -1,
+			atari_falconide_rsrc, ARRAY_SIZE(atari_falconide_rsrc));
+#endif
 	return rv;
 }
 
diff --git a/arch/m68k/include/asm/atarihw.h b/arch/m68k/include/asm/atarihw.h
index 5330082..4bea923 100644
--- a/arch/m68k/include/asm/atarihw.h
+++ b/arch/m68k/include/asm/atarihw.h
@@ -813,6 +813,12 @@ struct MSTE_RTC {
 #define mste_rtc ((*(volatile struct MSTE_RTC *)MSTE_RTC_BAS))
 
 /*
+** Falcon IDE interface
+*/
+
+#define FALCON_IDE_BASE	0xfff00000
+
+/*
 ** EtherNAT add-on card for Falcon - combined ethernet and USB adapter
 */
 
-- 
1.7.0.4

