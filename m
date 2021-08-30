Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D48EC4320E
	for <linux-ide@archiver.kernel.org>; Mon, 30 Aug 2021 14:43:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F7816023E
	for <linux-ide@archiver.kernel.org>; Mon, 30 Aug 2021 14:43:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237046AbhH3OoO (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 30 Aug 2021 10:44:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233798AbhH3OoN (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 30 Aug 2021 10:44:13 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0D63C061575
        for <linux-ide@vger.kernel.org>; Mon, 30 Aug 2021 07:43:19 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id i13so16326752ilm.4
        for <linux-ide@vger.kernel.org>; Mon, 30 Aug 2021 07:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=lHOJycOEm6G1FJCFPrTMFzx9dmiVcg5vnIQcA7ovDlU=;
        b=wW/KchiniumZFEd1QEb6sN50Z0s+zY4obOF59abjDC/Rg4+NLaO26n6+KlT3Kftqg5
         LQnZ2uX3VX9nls67Tgf39n4c/W6MxqmcR/zDVsbEMIwOrIPENYs1M+E3YCklPvyAP5Vo
         2N/Y2uIZ2yxgKxjJ9e2UaNsDQtguqnqn6b2pl26WIa/0yW1KVACGa5y2sAWCGqnCp15V
         ZpVvFhNx2jUjbkM/1XcNlqJXSBXgwNa5PYpzQJNvVg7iYh6gTZcjZSbyC3A8KF+vxwkZ
         1xwWIJYi54GsX42akf5HYuUjFkx9xwkGhAUJ6xzJVjoP9iVnTVUJoxMPOSlRz2oyu+Y9
         bPvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=lHOJycOEm6G1FJCFPrTMFzx9dmiVcg5vnIQcA7ovDlU=;
        b=CP9i8Sa+PNazLN+Nt28uc4gaLvwnjquEqoDs0AoFWioTCcIsmlX8mhNmPBfsof71Yq
         alzuGlxgzTqvMDDXUOO1vv65bLj0JvmEquXcKem6yjR4Nj0N9lWCpHauTHwYUkea/qkZ
         Z0OjFmUz4cdo6fIQCuHeBOu3or2QwPIj2e8Hqq9KcR78kdDhz8nw2ilDcddNse0BmuJp
         RyH+vx0tj4CtEot9EqZxXqAUOOI7Ftme/LZ2bRE2fx9DlAD/X65u+8UxIRwyoXJJZ94U
         W8ijSmSD4lzYAEQkhB/rLcM7wV6qOFLjwHUHlhxDZhVsCLsbXrMczAtj5PNTXcGDY4VI
         hddw==
X-Gm-Message-State: AOAM532XHElPaASBUBi4JvsUvyCmtiPo1mFQnCpyBk6VwZZDXKcXgoqD
        ka7OentqsZOu3jJx0VotGhV4vaXJUTF0hg==
X-Google-Smtp-Source: ABdhPJw6t5jTIRSaup3lnzf4VCTJ+eH/HzAmymRgqyNIYQqcdBfudXryena/hT+AZBXzZkgxFiFoDg==
X-Received: by 2002:a92:194b:: with SMTP id e11mr16598970ilm.200.1630334599120;
        Mon, 30 Aug 2021 07:43:19 -0700 (PDT)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id p15sm9300365ilc.12.2021.08.30.07.43.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Aug 2021 07:43:18 -0700 (PDT)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     ALWAYS copy <linux-ide@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] libata changes for 5.15-rc1
Message-ID: <25e33a98-25ad-1db1-98c8-ea74c0b3809e@kernel.dk>
Date:   Mon, 30 Aug 2021 08:43:18 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Hi Linus,

libata changes for the 5.15 release:

- NCQ priority improvements (Damien, Niklas)

- coccinelle warning fix (Jing)

- dwc_460ex phy fix (Andy)

Please pull!


The following changes since commit 7d549995d4e0d99b68e8a7793a0d23da6fc40fe8:

  Merge tag 'for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma (2021-07-27 14:13:33 -0700)

are available in the Git repository at:

  git://git.kernel.dk/linux-block.git tags/for-5.15/libata-2021-08-30

for you to fetch changes up to 62283c6c9d4c1018badcd0b9c5b6ca66d978fa0d:

  include:libata: fix boolreturn.cocci warnings (2021-08-24 10:11:21 -0600)

----------------------------------------------------------------
for-5.15/libata-2021-08-30

----------------------------------------------------------------
Andy Shevchenko (1):
      ata: sata_dwc_460ex: No need to call phy_exit() befre phy_init()

Damien Le Moal (9):
      libata: fix ata_host_start()
      libata: simplify ata_scsi_rbuf_fill()
      libata: cleanup device sleep capability detection
      libata: cleanup ata_dev_configure()
      libata: cleanup NCQ priority handling
      libata: fix ata_read_log_page() warning
      libata: print feature list on device scan
      libata: Introduce ncq_prio_supported sysfs sttribute
      docs: sysfs-block-device: document ncq_prio_supported

Jing Yangyang (1):
      include:libata: fix boolreturn.cocci warnings

Niklas Cassel (1):
      docs: sysfs-block-device: improve ncq_prio_enable documentation

 Documentation/ABI/testing/sysfs-block-device |  43 ++++-
 drivers/ata/libahci.c                        |   1 +
 drivers/ata/libata-core.c                    | 272 ++++++++++++++-------------
 drivers/ata/libata-sata.c                    |  62 +++---
 drivers/ata/libata-scsi.c                    |  60 +-----
 drivers/ata/sata_dwc_460ex.c                 |  12 +-
 include/linux/libata.h                       |   7 +-
 7 files changed, 243 insertions(+), 214 deletions(-)

-- 
Jens Axboe

