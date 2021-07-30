Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5492C4320E
	for <linux-ide@archiver.kernel.org>; Fri, 30 Jul 2021 15:00:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 86B76604D7
	for <linux-ide@archiver.kernel.org>; Fri, 30 Jul 2021 15:00:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239379AbhG3PAn (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 30 Jul 2021 11:00:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239604AbhG3O64 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 30 Jul 2021 10:58:56 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3D7EC061798
        for <linux-ide@vger.kernel.org>; Fri, 30 Jul 2021 07:58:42 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id t21so11343560plr.13
        for <linux-ide@vger.kernel.org>; Fri, 30 Jul 2021 07:58:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=ZbL0ysWatcgqKJmuJSZBD9F3c/rJJ1NTffB9zOwM4tY=;
        b=WzjMP9tDVt5QYvJOnd9gxBjYwGnEWIbei0GkZ9EHgAdz2m05v1jVwaGH7QbyaaHg8h
         SFl9sWObGEkuWgW+VBLmRWuDXzhAI2fpZetIexTFoxQ1opuQiXDY/XgfbnY+CCubk7Wh
         uFGwlN1vtODHbuCYRNBZZD/mno/Tml4Jkaxh5L+ONNxLh9JcbbKDq+3EB+o+kWEWgEuF
         4qoNDyrmR/8v3vTzeuzUB6TOxtPPUB22/HKaAGEB3iqebjeUV6C/0KCQA+KwRT9kbwWJ
         3rO3m+ROeBMgpE5sp8Xn46NBdVfuUdNYLNeJ1eoTAEOaj5Wl/obDJ60STpejyfQHqxqU
         Awww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=ZbL0ysWatcgqKJmuJSZBD9F3c/rJJ1NTffB9zOwM4tY=;
        b=d0N/L/KXtFnNfyrL+5ziK8vAAlGLBorxzCI6ldDTEGDDcv/0CUr8OLmiMAoXYAYq9K
         74vneBzpco0vQ7LLUBtO3IUEQhoi8PMcBrdDS7yGpD9Elodv/y/zIwqGkyYpEUVIB4lB
         aR0t6A7MqMktOeAQ2ZpomNz/HbD1sqAbzBERuxj9LSQYfyEqoRXXycZ2u75MdX+NXI8D
         /zk9TS4yHBnmzyuAfJvEwvdhrBSswqGYHl83fhm57abDquIbOuuObJRYwPr4bwDVDvUd
         inFB+yTzYMdxjjnU0twhDUo/AV30qYBpPE1TapyqJomc3p69sOSmj/+344eMQyZuOZva
         j1OA==
X-Gm-Message-State: AOAM531dMJcDpLmHcukEKpCNbAwAzNGtxAykgxFc6bNtgbYZfE9NVRL1
        90dVimqgldbg/lpP8qzuAEjvXptM1XayIlE5
X-Google-Smtp-Source: ABdhPJxFVvqQN9YkIZCReCTcyomkpOtCMccmaJ0b7DmUOftreWHXTke3YmsmcVuUXRm/IEVNZyW2Gg==
X-Received: by 2002:a63:5344:: with SMTP id t4mr82841pgl.372.1627657121938;
        Fri, 30 Jul 2021 07:58:41 -0700 (PDT)
Received: from [192.168.1.116] ([198.8.77.61])
        by smtp.gmail.com with ESMTPSA id x81sm2742167pfc.22.2021.07.30.07.58.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Jul 2021 07:58:41 -0700 (PDT)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     ALWAYS copy <linux-ide@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] libata updates for 5.14-rc
Message-ID: <74d44c00-40df-9376-2c2f-37881547e8fa@kernel.dk>
Date:   Fri, 30 Jul 2021 08:58:38 -0600
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

- A fix for PIO highmem (Christoph)

- Kill HAVE_IDE as it's now unused (Lukas)

Please pull!


The following changes since commit f55966571d5eb2876a11e48e798b4592fa1ffbb7:

  Merge tag 'drm-next-2021-07-08-1' of git://anongit.freedesktop.org/drm/drm (2021-07-08 12:28:15 -0700)

are available in the Git repository at:

  git://git.kernel.dk/linux-block.git tags/libata-5.14-2021-07-30

for you to fetch changes up to 094121ef815f29d9e6a01fafca365831454ce293:

  arch: Kconfig: clean up obsolete use of HAVE_IDE (2021-07-30 08:19:09 -0600)

----------------------------------------------------------------
libata-5.14-2021-07-30

----------------------------------------------------------------
Christoph Hellwig (1):
      libata: fix ata_pio_sector for CONFIG_HIGHMEM

Lukas Bulwahn (1):
      arch: Kconfig: clean up obsolete use of HAVE_IDE

 arch/alpha/Kconfig            |  1 -
 arch/arm/Kconfig              |  6 ------
 arch/arm/mach-davinci/Kconfig |  1 -
 arch/h8300/Kconfig.cpu        |  1 -
 arch/ia64/Kconfig             |  1 -
 arch/m68k/Kconfig             |  1 -
 arch/mips/Kconfig             |  1 -
 arch/parisc/Kconfig           |  1 -
 arch/powerpc/Kconfig          |  1 -
 arch/sh/Kconfig               |  1 -
 arch/sparc/Kconfig            |  1 -
 arch/x86/Kconfig              |  1 -
 arch/xtensa/Kconfig           |  1 -
 drivers/ata/libata-sff.c      | 35 +++++++++++++++++++++++++++--------
 14 files changed, 27 insertions(+), 26 deletions(-)

-- 
Jens Axboe

