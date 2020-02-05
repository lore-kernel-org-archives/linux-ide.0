Return-Path: <SRS0=KtmC=3Z=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 528AFC35247
	for <linux-ide@archiver.kernel.org>; Wed,  5 Feb 2020 21:19:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18AD22082E
	for <linux-ide@archiver.kernel.org>; Wed,  5 Feb 2020 21:19:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="hpJv/OJ4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727143AbgBEVTW (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 5 Feb 2020 16:19:22 -0500
Received: from mail-il1-f180.google.com ([209.85.166.180]:43264 "EHLO
        mail-il1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727033AbgBEVTW (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 5 Feb 2020 16:19:22 -0500
Received: by mail-il1-f180.google.com with SMTP id o13so3142941ilg.10
        for <linux-ide@vger.kernel.org>; Wed, 05 Feb 2020 13:19:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=xPQe3mAJAqIOBNafRoq+xaJrp5nS3FabT69MWAxiV8c=;
        b=hpJv/OJ4GzMRWCrODxUh7AITdb6Wftn+AaRx01nvqoL20o39GNMxWekDTXXE0FVnbe
         sUXtTF0eOqGswAtYODhm5PpwsIMevm0q0dBQz9cmVtWRXJLY9hATRGD0C03bES44YS8l
         LWtwMgpYide15lJ9iRlH0H5WGMF1yCNsXRyQfZaFL9nIZiNHgnG4CfuOh/iVLq19qD21
         0KZY33Ww5FtSZ3oirRQBijnsxHo2JZetcrlUIs2/aq3R2eQ1H12gwHjRbCkV3hV8g/oX
         puu3AzKhFTDy4Xyot/086jKfyMf+UWFrCgtz/dut2v6+jgmbENq6FftCQ1joDyE99oiD
         UEcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=xPQe3mAJAqIOBNafRoq+xaJrp5nS3FabT69MWAxiV8c=;
        b=NB1t/PKSXAk1YangH0YbV9cEiS0MIUh/6g+1WpgMugwyypanY/DSIwNt9dwcTYrv4j
         +hPmWCfdrw97qdqSVbE7VvrQxmUduzyhijam4L+0uSPXjobuSoeG7DCs8XUipVeLliHj
         PLvRARixXfLFx17K5ABUBUxlcFM8IAUC0r1MgmZkV2IytBVsjI2z2utZPHEJA32ewaqV
         MkL3qn5ESmLcy2OTFt97ZbOFLvgTWYk5hzOyz5PUVpwyqICqORM0SYRkMDu90aRz7TIi
         yKI1BXNBej4Gk6RDviPcG1ZLw03LQDCZmEEjOZeAwitakPZc7SzowRjXftCcAbMLbG5I
         BaZA==
X-Gm-Message-State: APjAAAWm4j8it5AfM2htqAhNHNB1/4WHp1O5z+NxZgEGoV/+TZsrVT/T
        Wykoe1Tj2v3ZkVwnpFGpZl2DZ+D4GR0=
X-Google-Smtp-Source: APXvYqxRnqQMSA/wZZ8sbdVP+U2C1rSfv6P4WTWixr2vJuuPitvQFIgkS8jpLF7ew/3nRhWfVAbiiQ==
X-Received: by 2002:a92:4016:: with SMTP id n22mr159989ila.13.1580937560425;
        Wed, 05 Feb 2020 13:19:20 -0800 (PST)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id s2sm208576ioo.77.2020.02.05.13.19.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Feb 2020 13:19:19 -0800 (PST)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     IDE/ATA development list <linux-ide@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] libata changes for 5.6-rc1
Message-ID: <dac0d422-4a49-b50c-7096-2a092ee845ad@kernel.dk>
Date:   Wed, 5 Feb 2020 14:19:18 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Hi Linus,

A few minor changes for libata that should go into this merge window.
This pull request contains:

- Adding a Sandisk CF card to supported pata_pcmcia list (Christian)

- Move pata_arasan_cf away from legacy API (Peter)

- Ensure ahci DMA/ints are shut down on shutdown (Prabhakar)

Please pull!


  git://git.kernel.dk/linux-block.git tags/libata-5.6-2020-02-05


----------------------------------------------------------------
Christian Zigotzky (1):
      pata_pcmia: add SanDisk High (>8G) CF card to supported list

Peter Ujfalusi (1):
      ata: pata_arasan_cf: Use dma_request_chan() instead dma_request_slave_channel()

Prabhakar Kushwaha (1):
      ata: ahci: Add shutdown to freeze hardware resources of ahci

 drivers/ata/ahci.c           |  7 +++++++
 drivers/ata/libata-core.c    | 21 +++++++++++++++++++++
 drivers/ata/pata_arasan_cf.c |  6 ++++--
 drivers/ata/pata_pcmcia.c    |  1 +
 include/linux/libata.h       |  1 +
 5 files changed, 34 insertions(+), 2 deletions(-)

-- 
Jens Axboe

