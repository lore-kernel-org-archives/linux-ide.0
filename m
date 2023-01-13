Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2971C54EBD
	for <linux-ide@archiver.kernel.org>; Fri, 13 Jan 2023 04:37:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231416AbjAMEhZ (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 12 Jan 2023 23:37:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231154AbjAMEhT (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 12 Jan 2023 23:37:19 -0500
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28B852F3
        for <linux-ide@vger.kernel.org>; Thu, 12 Jan 2023 20:37:18 -0800 (PST)
Received: by mail-qv1-xf2a.google.com with SMTP id q10so14108714qvt.10
        for <linux-ide@vger.kernel.org>; Thu, 12 Jan 2023 20:37:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pefoley.com; s=google;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lPm2cDob64PHi+nW3IeZECmXVT/SwFopaoWwfdNRye0=;
        b=BLpRYQgjOeaSOzpLq9w9Aze82Npz+TR8bofK5jRsT9mhfJ2LbAp3rKHZT8MpUwcWJx
         clCtjEksgGfakcqxrG3QZC4vDzfZnzxPYBPo5rw5lWh4sTIdVopQ671T9TgwR+h0Z4EC
         U/zNKX4YnNopUciFbKh1SGt5uYz7Ub1sVPGs8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lPm2cDob64PHi+nW3IeZECmXVT/SwFopaoWwfdNRye0=;
        b=ItdgwC4HrCX77YCsSWg5/Wf35W+qcdDMXdRSrw4cUy6DSoa0b+w1LE5h+MqHER7zfR
         tLrFeF4p4alwV27FEsAbLBkKR7Xsik4a7AsvwHL4Th8ezwvwwxeVTWqv1YrJDb3vie2V
         04r+JqPGwqXNBE+o4NGf41T9HUz/2xcrJ2B+atBlDd56y2wv7Ei/WrR0EAeKFnDHpYUA
         2Z/dWbO7RVZCZWL0I8WDzNpE4fcGJjCrgrqQto4CuW822f0zImJUwRgdXiDlmCsivUc9
         Ne0z/89RbRE4mtk2iv/wsAd79qfxA0qMbPhQBcsoq3HE7n8JYUpcTP+yyfmEkg9+ILkA
         NnoA==
X-Gm-Message-State: AFqh2kqGpN5eakWUwiqbZaN/hp76mLxZhxdvkMx1upUG4+kge4FvmDGh
        zx5zMcp3XffbG5VUHG2F7RFJNmWAuagh63zTKQc=
X-Google-Smtp-Source: AMrXdXvZC03LqMiePLnWj6MotTeke3pWqpdvKcBQhpkVjCmlrhc4na1nxCifEG61lNj8bV4498iejg==
X-Received: by 2002:a0c:cdcd:0:b0:532:f87:753c with SMTP id a13-20020a0ccdcd000000b005320f87753cmr43721182qvn.4.1673584636690;
        Thu, 12 Jan 2023 20:37:16 -0800 (PST)
Received: from [192.168.1.3] ([2600:4040:29fb:d300:887b:7eff:fe74:68b2])
        by smtp.gmail.com with ESMTPSA id q5-20020a05620a0d8500b006eee3a09ff3sm12087761qkl.69.2023.01.12.20.37.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jan 2023 20:37:16 -0800 (PST)
From:   Peter Foley <pefoley2@pefoley.com>
Date:   Thu, 12 Jan 2023 23:37:06 -0500
Subject: [PATCH] ata: Don't build PATA_CS5535 on UML
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230112-umide-v1-1-78742026a3f1@pefoley.com>
X-B4-Tracking: v=1; b=H4sIAPLfwGMC/x2NQQqAMAwEvyI5WzAVRPyKeKg12hyskqgIxb9bP
 c7swCZQEiaFrkggdLHyFjNgWYAPLi5keMoMtrJ1hWjNufJEBluP2GAWtYXcjk7JjOKiD1+9Oj1I
 vmEXmvn+D/rheV6HLd/UcAAAAA==
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Foley <pefoley2@pefoley.com>
X-Mailer: b4 0.11.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1673584636; l=1936;
 i=pefoley2@pefoley.com; s=20230111; h=from:subject:message-id;
 bh=2wIRUjf5hTGwjbx7HQnUhS+/nYxNZeMVIcHB4lIPfKc=;
 b=fdUZlUPj5Ky5rwzT8s0TyDCN3U6SNivmS/z/aZYkVxKo4o8KhkaJyqXYOoxRVArndWAHSa2oa8+z
 SVZCKixsCpAwYBm/oCP/ORTmYT8esrrttvb+4EX4iz90pSmUQ75k
X-Developer-Key: i=pefoley2@pefoley.com; a=ed25519;
 pk=DCQqIdN6rHnvfQH58WQiQzJFfGUo1HyWSvdYG8vnO5o=
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

This driver uses MSR functions that aren't implemented under UML.
Avoid building it to prevent tripping up allyesconfig.

e.g.
/usr/lib/gcc/x86_64-pc-linux-gnu/12/../../../../x86_64-pc-linux-gnu/bin/ld: pata_cs5535.c:(.text+0x3a3): undefined reference to `__tracepoint_read_msr'
/usr/lib/gcc/x86_64-pc-linux-gnu/12/../../../../x86_64-pc-linux-gnu/bin/ld: pata_cs5535.c:(.text+0x3d2): undefined reference to `__tracepoint_write_msr'
/usr/lib/gcc/x86_64-pc-linux-gnu/12/../../../../x86_64-pc-linux-gnu/bin/ld: pata_cs5535.c:(.text+0x457): undefined reference to `__tracepoint_write_msr'
/usr/lib/gcc/x86_64-pc-linux-gnu/12/../../../../x86_64-pc-linux-gnu/bin/ld: pata_cs5535.c:(.text+0x481): undefined reference to `do_trace_write_msr'
/usr/lib/gcc/x86_64-pc-linux-gnu/12/../../../../x86_64-pc-linux-gnu/bin/ld: pata_cs5535.c:(.text+0x4d5): undefined reference to `do_trace_write_msr'
/usr/lib/gcc/x86_64-pc-linux-gnu/12/../../../../x86_64-pc-linux-gnu/bin/ld: pata_cs5535.c:(.text+0x4f5): undefined reference to `do_trace_read_msr'
/usr/lib/gcc/x86_64-pc-linux-gnu/12/../../../../x86_64-pc-linux-gnu/bin/ld: pata_cs5535.c:(.text+0x51c): undefined reference to `do_trace_write_msr'

Signed-off-by: Peter Foley <pefoley2@pefoley.com>
---
 drivers/ata/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
index eceaec33af65..9695c4404e26 100644
--- a/drivers/ata/Kconfig
+++ b/drivers/ata/Kconfig
@@ -640,6 +640,7 @@ config PATA_CS5530
 config PATA_CS5535
 	tristate "CS5535 PATA support (Experimental)"
 	depends on PCI && (X86_32 || (X86_64 && COMPILE_TEST))
+	depends on !UML
 	help
 	  This option enables support for the NatSemi/AMD CS5535
 	  companion chip used with the Geode processor family.

---
base-commit: 1b929c02afd37871d5afb9d498426f83432e71c2
change-id: 20230112-umide-18c116111232

Best regards,
-- 
Peter Foley <pefoley2@pefoley.com>
