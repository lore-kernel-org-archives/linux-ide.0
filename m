Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D355CC43381
	for <linux-ide@archiver.kernel.org>; Wed, 17 Feb 2021 22:29:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9EAA164DFF
	for <linux-ide@archiver.kernel.org>; Wed, 17 Feb 2021 22:29:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232887AbhBQW3E (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 17 Feb 2021 17:29:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231925AbhBQW2r (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 17 Feb 2021 17:28:47 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FDE0C061756
        for <linux-ide@vger.kernel.org>; Wed, 17 Feb 2021 14:28:06 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id m6so9380697pfk.1
        for <linux-ide@vger.kernel.org>; Wed, 17 Feb 2021 14:28:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=2lritnTFRDrDzmUeEe/JUrazWW1iIyYlZyx+TPAxq7w=;
        b=avLtq4EFFcR4w4TBkn/A6L6tzBXKx5kahbw/f5UolAhcGTpAuEh1/+C89vYcxkABr1
         KSxUp6EW69KY7aszCkgfFF2iJ6WqC5cgG7w+VHBZ1in2k6tTUXmSWZGyFX/v1CY7PbfB
         OK0Mg/UsncGLjufs31r2oiOgiYebD5fiaxuvDjAMwyI6ZaD43tD75VWMzklGXm7843Hd
         0XN+uLi7n+XXJEePz6AvQax47gZ8lbw1lUaxX42ZokGAoTk2TW2RCuZc5j0XDD/PDrsZ
         T1JsVorcL6bxGbMJZRMKz8+Dt7EfBoDpoXyK1qNHhqb44+gZD2ba1ST8MVkyXPGBImcP
         U3lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=2lritnTFRDrDzmUeEe/JUrazWW1iIyYlZyx+TPAxq7w=;
        b=qI01Qwr2wVep9UlpD7/skv58V4Y4UeijXv40TMpGU/shZVlJENMT6VsbTGF3ZUGqJp
         CC18Ni/sQDCPYrrLfYlYKS3LP8FBkYA2xf0V9avlJ6wou/TFT3ZjETGIYVoVm31HMNgA
         90dZbM1RP3fUvMS+0LE0cEXre+xJxOKA2Qsq0h5ghrBQA6E1aqhxCDhute7/m+YYOkRw
         qsfNXuIjMEr/ToN7bLKzuvvsv9kcAjXbE8SYKKIaRiO9vwmxqnB7biaiy41ejjHx5/UC
         ftwR7Arc3YoBFft+ySgN8XaSf/mzsh+2mKcRQDzSvBve5cwd1AAuNut9Vx+3bEUH5Afy
         YdCA==
X-Gm-Message-State: AOAM531DoItyClILRQNr7Z7bzGAMVKmun0vUlLbhJNo2L6B8S5B2fu8U
        nPcoNruYuys2FYGOdOzscy2GFMQc9GI5Bg==
X-Google-Smtp-Source: ABdhPJy7fCZFENeOAojU6E8cepX/gk/9+XRD7nGJkPVsvn+4pL4LZjpsf/AI2bBSro+drRw4W9qQOg==
X-Received: by 2002:a65:480c:: with SMTP id h12mr1300522pgs.169.1613600885636;
        Wed, 17 Feb 2021 14:28:05 -0800 (PST)
Received: from ?IPv6:2620:10d:c085:21e1::19db? ([2620:10d:c090:400::5:5c48])
        by smtp.gmail.com with ESMTPSA id 137sm3818852pgb.80.2021.02.17.14.28.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Feb 2021 14:28:05 -0800 (PST)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     IDE/ATA development list <linux-ide@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] libata changes for 5.12-rc
Message-ID: <91a99b47-409c-024c-8e50-ce64fa662aad@kernel.dk>
Date:   Wed, 17 Feb 2021 15:28:04 -0700
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

Regulartors management addition from Florian, and a trivial change to
avoid comma separated statements from Joe.

Please pull!


The following changes since commit 6ee1d745b7c9fd573fba142a2efdad76a9f1cb04:

  Linux 5.11-rc5 (2021-01-24 16:47:14 -0800)

are available in the Git repository at:

  git://git.kernel.dk/linux-block.git tags/for-5.12/libata-2021-02-17

for you to fetch changes up to e53d76e61ec0dbd52cf784993fde927cb9fe0fed:

  ata: Avoid comma separated statements (2021-01-31 08:05:46 -0700)

----------------------------------------------------------------
for-5.12/libata-2021-02-17

----------------------------------------------------------------
Florian Fainelli (1):
      ata: ahci_brcm: Add back regulators management

Joe Perches (1):
      ata: Avoid comma separated statements

 drivers/ata/ahci_brcm.c   | 14 +++++++++++++-
 drivers/ata/pata_icside.c | 21 +++++++++++++--------
 2 files changed, 26 insertions(+), 9 deletions(-)

-- 
Jens Axboe


-- 
Jens Axboe

