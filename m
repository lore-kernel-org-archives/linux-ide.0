Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C06BEC71140
	for <linux-ide@archiver.kernel.org>; Fri, 18 Aug 2023 07:15:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358128AbjHRHOp (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 18 Aug 2023 03:14:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358095AbjHRHOP (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 18 Aug 2023 03:14:15 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A44130D6;
        Fri, 18 Aug 2023 00:14:14 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id 98e67ed59e1d1-26b67b38b61so460960a91.0;
        Fri, 18 Aug 2023 00:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692342853; x=1692947653;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=OsNAOjMPs6W5o5PXzHV9cWMtIz8YuQ5vDN9CHwvmKIo=;
        b=jaiF56W15MzZltA+aH0r65qODXUJF/X8A19XV7wYt+SAoiiy5dB/KPBFQktZVNSCmi
         ETbYm1PhzZeFc2oi80uTSQERDcMMkR9SE1T6zFgj4iakGV80pQQebMlygXRv722iSt3j
         4/rf3zD0vsxKAxAQruMDYCUmQhKuJqHt/OdSgG84N+GZEIjfcVWXzIr0wFk/xbT+DiU9
         kaYsBwTPm5r0un8bxGdedzAbTIIl+qoD0KXGomhJmyA/nucqo5p+w3vKUWuiMsnZ+Dza
         yMeI+r9tQG3Jc0PqFbNPkfXO5pVWpr6cw3E9mhENhsho8e+1aF9g1NnOfhf9GYwxtVZz
         IkuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692342853; x=1692947653;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OsNAOjMPs6W5o5PXzHV9cWMtIz8YuQ5vDN9CHwvmKIo=;
        b=XhVdfCwp9w6gT8ET42bBo4EU7W/k/gtaQOK4itEwgYcEjUcytYMepCWdnmiu8+0hCl
         tBhbnrTj2iUUTS5ijJfyqVm1i7WiRRRaXgCMlIinPXlE3nHTaT1wSvv+HYYK0MQWEHaB
         4Z+s1RhfTRMd4WA8M+MoJITMnW1bcChE2Wwt6C2tdTpKgD7kYUQslPHEfsbDyAjvCUYe
         SgXROEJFLmWTgzlJopNAAVoL7Z6abApTkuzbxM5gpS7SUXoRWG5d7WHMs1YUwXyliqKa
         bBA3WouF3PHyXTlx1mpi0HRkaI1NMS7J23+6fyjpX4l32mbwyqqtX8gPqqD2Cr0ndBHC
         AFnw==
X-Gm-Message-State: AOJu0Yz2p/nXB8gzrddcKBwZ0sNgjW5R7r8Q/gYMrTqNcs3f5mIrVVxD
        RQxeRCy3v8NLkjcsZY7WBvElw/AT0Mk=
X-Google-Smtp-Source: AGHT+IEjyEc4YFLJVBaKZDLjP0+YrWFtUvyg0yJ5VOk5ow/R9IP7UrZzHhjkBCf5rT/7tJA3tajJMA==
X-Received: by 2002:a17:90a:b017:b0:259:466:940f with SMTP id x23-20020a17090ab01700b002590466940fmr1514172pjq.22.1692342853643;
        Fri, 18 Aug 2023 00:14:13 -0700 (PDT)
Received: from xplor.waratah.dyndns.org (122-62-141-252-fibre.sparkbb.co.nz. [122.62.141.252])
        by smtp.gmail.com with ESMTPSA id mm8-20020a17090b358800b0026b6b17ca5dsm882458pjb.54.2023.08.18.00.14.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Aug 2023 00:14:13 -0700 (PDT)
Received: by xplor.waratah.dyndns.org (Postfix, from userid 1000)
        id 74FC636043C; Fri, 18 Aug 2023 19:14:09 +1200 (NZST)
From:   Michael Schmitz <schmitzmic@gmail.com>
To:     dlemoal@kernel.org, linux-ide@vger.kernel.org,
        linux-m68k@vger.kernel.org
Cc:     will@sowerbutts.com, rz@linux-m68k.org, geert@linux-m68k.org,
        Michael Schmitz <schmitzmic@gmail.com>
Subject: [PATCH v2 3/3] m68k/atari: change Falcon IDE platform device to id 0
Date:   Fri, 18 Aug 2023 19:14:05 +1200
Message-Id: <20230818071405.28581-4-schmitzmic@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230818071405.28581-1-schmitzmic@gmail.com>
References: <20230818071405.28581-1-schmitzmic@gmail.com>
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

The pata_falcon data byte swapping patch relies on pdev->id
being 0 or 1. Q40 uses these IDs, but Atari used -1. Change
pdev->id to 0 for Atari Falcon IDE platform device so
selection of drive to byte-swap through pata_falcon.data_swab
can be used on Falcon as well.
Tested on ARAnyM so far.

Signed-off-by: Michael Schmitz <schmitzmic@gmail.com>
---
 arch/m68k/atari/config.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/m68k/atari/config.c b/arch/m68k/atari/config.c
index 38a7c0578105..e3e437cd0f84 100644
--- a/arch/m68k/atari/config.c
+++ b/arch/m68k/atari/config.c
@@ -925,7 +925,7 @@ int __init atari_platform_init(void)
 #endif
 
 	if (ATARIHW_PRESENT(IDE)) {
-		pdev = platform_device_register_simple("atari-falcon-ide", -1,
+		pdev = platform_device_register_simple("atari-falcon-ide", 0,
 			atari_falconide_rsrc, ARRAY_SIZE(atari_falconide_rsrc));
 		if (IS_ERR(pdev))
 			rv = PTR_ERR(pdev);
-- 
2.17.1

