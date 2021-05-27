Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E453CC4707F
	for <linux-ide@archiver.kernel.org>; Thu, 27 May 2021 15:08:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C54E7606A5
	for <linux-ide@archiver.kernel.org>; Thu, 27 May 2021 15:08:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236774AbhE0PKR (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 27 May 2021 11:10:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236971AbhE0PJh (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 27 May 2021 11:09:37 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09834C06134D;
        Thu, 27 May 2021 08:07:09 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id f8so646380pjh.0;
        Thu, 27 May 2021 08:07:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=DsmQRSLFrUSZxqcKbkEnQMBrnQRQAv8R26xRKRJJilY=;
        b=qoSa+AbN9WLtARHUmlTOrqw2x99fMMhB1nkyNGG2KfGw0H84CMonF0EVywuwFNALYM
         ubHSNKBQITTlVJRxyOfCnMYYxKwIrsh1xkYJkDhN+fqkYVsYAC9zr+cR8+1LzZDAUmBG
         l248eqwYEz1u/vijVmtayuFal9a7GLw+/jgvcWQzhXKZ9G61FAP1Qe+rd7oi6YdJzJXQ
         rvmRqn/kL3Mo8xknFGREcTG0wy+EvwbuJSH/fQdDlqNOqXg7lix2Oa3uwyhhQIU7UF41
         shkzU3/DYwkNlSYKA3eKl3FmCssfsz2xZna8ykg22NZhbOtschASTZzJS8aec1ArY/bG
         pA+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=DsmQRSLFrUSZxqcKbkEnQMBrnQRQAv8R26xRKRJJilY=;
        b=ZO+yL/IuOSLlU9QvptdUfxWoVs4N9gQ6CkR64zILGC2fe+qbJxuZQ9dnl5zg7zIYVv
         J/R3qOHeWyluGqyiDGGgV2kaJH66Gi3ckSQ+Y/YNMcg50VQvv5YCY9+LF41Xm+qDvbBo
         yLAcElGglfW5kbDvcmnk4+qO/SvHfBcS0/ZlZu2JusjpmkFHBy80uoaqKF1a8ZoOblNa
         x/LcWVMnjzgyhdoll38WaXSy+wfGC7QrA3XBAv6pkJeq70/2436ec65wM9w/Xw3hUgSl
         3dZ6//ByFCJCeE74vQG5vZPyzAqxgMa07xCb0Mt/cbtF4tvIhynBlZ/xMgHeMgiqqYbu
         ac3w==
X-Gm-Message-State: AOAM5316RbJHJFik4NUwa8IPK/QIVznvIS3HdwsCU1VusDNSnNz9juVB
        omrjMXlAEvowLEHS/ue5y1bfSNeNQpxJlQ==
X-Google-Smtp-Source: ABdhPJyqZySAX9jJtRBKb7ZU3mKaT0PexN6hIru3i/iGeXPTZbCohLiM4SYM4aXGsfCiBHWkgGnIBA==
X-Received: by 2002:a17:90b:687:: with SMTP id m7mr4095712pjz.133.1622128028555;
        Thu, 27 May 2021 08:07:08 -0700 (PDT)
Received: from hyeyoo ([183.99.11.150])
        by smtp.gmail.com with ESMTPSA id a12sm2468568pfg.102.2021.05.27.08.07.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 May 2021 08:07:08 -0700 (PDT)
Date:   Fri, 28 May 2021 00:07:03 +0900
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     "David S. Miller" <davem@davemloft.net>
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ide: Remove unused variable ide_media_proc_fops
Message-ID: <20210527150703.GA125782@hyeyoo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

When compiled with option W=1, compiler complained that
ide_media_proc_fops is unused.

in commit ec7d9c9ce897 ("ide: replace ->proc_fops with ->proc_show"),
changed proc_fops to proc_show. So this is not needed anymore.

Also remove function ide_media_proc_open that is only referenced
by ide_media_proc_fops.

Fixes: ec7d9c9ce897("ide: replace ->proc_fops with ->proc_show")
Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
---
 drivers/ide/ide-proc.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/drivers/ide/ide-proc.c b/drivers/ide/ide-proc.c
index 15c17f3781ee..34bed14f88c7 100644
--- a/drivers/ide/ide-proc.c
+++ b/drivers/ide/ide-proc.c
@@ -449,19 +449,6 @@ static int ide_media_proc_show(struct seq_file *m, void *v)
 	return 0;
 }
 
-static int ide_media_proc_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, ide_media_proc_show, PDE_DATA(inode));
-}
-
-static const struct file_operations ide_media_proc_fops = {
-	.owner		= THIS_MODULE,
-	.open		= ide_media_proc_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-};
-
 static ide_proc_entry_t generic_drive_entries[] = {
 	{ "driver",	S_IFREG|S_IRUGO,	 ide_driver_proc_show	},
 	{ "identify",	S_IFREG|S_IRUSR,	 ide_identify_proc_show	},
-- 
2.25.1

