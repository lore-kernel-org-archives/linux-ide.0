Return-Path: <SRS0=zodd=D7=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94FF1C2D0A3
	for <linux-ide@archiver.kernel.org>; Sat, 24 Oct 2020 15:13:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A4F6207EA
	for <linux-ide@archiver.kernel.org>; Sat, 24 Oct 2020 15:13:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="QPolDxdU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1760519AbgJXPNb (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sat, 24 Oct 2020 11:13:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1760505AbgJXPNb (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sat, 24 Oct 2020 11:13:31 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D465C0613CE
        for <linux-ide@vger.kernel.org>; Sat, 24 Oct 2020 08:13:31 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id f38so3423006pgm.2
        for <linux-ide@vger.kernel.org>; Sat, 24 Oct 2020 08:13:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:subject:to:cc:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=rrEQykDrODQkLQpiOcBsqrByU32LwK4j/pL5QR7hh7g=;
        b=QPolDxdU+BfBLuZhmBjfXiAZyYgppijxwG5/xPJLDzX8tB4l9nGNmrTZXdGf3rvGJb
         ZgyfqRctadKDx5WM/BRN4uRqjCDpwimIUlb5fF8T2Et0jvdXgiEITArcHFYpm17qkrSJ
         wcQ9hGA4FCv3cszr9FxXS3jmWoDJAAh8WsWKE/SwbTkqszspGJxuGtEmC3fF9o7pxHmW
         ABfgHoX7m57sax1ocwQ+EszVHnCr4qTRlcG/PHoSiblZPPzxo292K1Imui+PkFoT2izI
         NZ6a4zSgVmmcSEk3xAqqA9tOdoWSu4AyRCA2dK4trG+pem3HaCeOkgeLoDVV6KJbuqWs
         RS1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=rrEQykDrODQkLQpiOcBsqrByU32LwK4j/pL5QR7hh7g=;
        b=k0oiHo3W+JHIByZ4D5lQRch7k5UhNA2m4dq78onkFxkZhAyyYdgT2L9QDs71JkFrkS
         EXIY8ueG4Y+eV1t+RYsDpAVzanakAiG8TiLpuyn37YZRa+Vt1h/NAAzcNQi8ZlDKR9Vu
         T5YShHA8ll3FPitfjNqvFqOommEr4ykHp1E0G6s23n9cCdYdWKfoNmZSrYvMc1T3OJs6
         d2l4X/RhGtm9j1EZsQPXgFECdZcw0ayfWVHquXpKPVjJa/XAWnh7++/15Vx7RUStGUOz
         UJOskSE0dZoQ4gE+6GHNEY2YXNWL/pKBJ1dQ+AgUX1WirWu7AADMyEXMcIRQZs9r77aE
         bnIQ==
X-Gm-Message-State: AOAM530k+p9uvuqvYuhfIVPF9Hq9EAzkCwxU6jcfueWBfq8s+Vnolgag
        FFROb03+jvzoV00+QnCWBBgf1Q==
X-Google-Smtp-Source: ABdhPJx8SLX/yRDl+BovuhzZWsHxt7lwzWVlHqOxZn7NGHaSw0686dafC9SqX/fHfZ4IWxheYEg3qg==
X-Received: by 2002:a63:4e09:: with SMTP id c9mr7394919pgb.128.1603552410803;
        Sat, 24 Oct 2020 08:13:30 -0700 (PDT)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id mt7sm2930308pjb.5.2020.10.24.08.13.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 24 Oct 2020 08:13:30 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] libata fixes for 5.10-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     IDE/ATA development list <linux-ide@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Message-ID: <78f005fb-c35a-9120-5299-c8bd1efb1216@kernel.dk>
Date:   Sat, 24 Oct 2020 09:13:29 -0600
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

Two minor libata fixes:

- Fix a DMA boundary mask regression for sata_rcar (Geert)

- kerneldoc markup fix (Mauro)

Please pull!


The following changes since commit 9ff9b0d392ea08090cd1780fb196f36dbb586529:

  Merge tag 'net-next-5.10' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next (2020-10-15 18:42:13 -0700)

are available in the Git repository at:

  git://git.kernel.dk/linux-block.git tags/libata-5.10-2020-10-24

for you to fetch changes up to 94bd5719e491564c61ee9f121d544e23b4e51374:

  ata: fix some kernel-doc markups (2020-10-23 12:20:32 -0600)

----------------------------------------------------------------
libata-5.10-2020-10-24

----------------------------------------------------------------
Geert Uytterhoeven (1):
      ata: sata_rcar: Fix DMA boundary mask

Mauro Carvalho Chehab (1):
      ata: fix some kernel-doc markups

 drivers/ata/libata-core.c | 2 +-
 drivers/ata/libata-eh.c   | 2 +-
 drivers/ata/libata-scsi.c | 2 +-
 drivers/ata/sata_rcar.c   | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

-- 
Jens Axboe

