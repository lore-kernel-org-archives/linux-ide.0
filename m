Return-Path: <SRS0=CP2c=XK=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2F4BC4CECF
	for <linux-ide@archiver.kernel.org>; Sun, 15 Sep 2019 23:59:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9894A20873
	for <linux-ide@archiver.kernel.org>; Sun, 15 Sep 2019 23:59:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="UPipIqYI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726222AbfIOX7N (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sun, 15 Sep 2019 19:59:13 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:32990 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726944AbfIOX7N (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sun, 15 Sep 2019 19:59:13 -0400
Received: by mail-pg1-f195.google.com with SMTP id n190so18654836pgn.0
        for <linux-ide@vger.kernel.org>; Sun, 15 Sep 2019 16:59:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=cXDDDu+PS8xkBbqEAA3e4lUFknC6KZMJH1Tbc0l3e/I=;
        b=UPipIqYIibATGshI3RO/Gf/+7sdMFKCmXlS2VowLusS3C3/zFHXKfWLbH8hy6s8vXB
         Bl+v0/Td46uC8/Ty49kU7u5zrGdELzwN8nngTryQi2uAcedTastQc0e+hNxgcF4I6CIy
         i+SgweLvbpNEXL/UXwYquWhYtNEfQ65VcOmeU6P1dSwAU/amOwlSibDkV5l02xcjmR9R
         k0r7VTEV2OpPTYIB+e/b24qjzEmMOSlsqysWD7plDYWf6FkZvAzfFaOTAfGM1UK4g6eu
         EXKr6Z4QDnfhkVVB7n0LB6Gnl0UnyVanA5GI90wlDM1UTjCFFD+6m8hZVh2uVhZAagvg
         Z9fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=cXDDDu+PS8xkBbqEAA3e4lUFknC6KZMJH1Tbc0l3e/I=;
        b=Q4Adldd2CanGbFSdC5GSh1rxSDCXMDp5O1J6flFg4vSFAHkoddc1odMWjoFpcVe6Bj
         4mX1DbH1APC73mLqoLVyMcaf1rmxEl5a4M2BS1uoCfXk3joS96KQtb/uyncQyYlGVw3h
         o8Is2RsAEiVBvbr37ZumIwsDsOzYoS2vuSgUt7bafa43zp6hvaTKZYX8wT2Fu7FQy8j7
         oHuC2X6AOxhCLYt0/GAx2E49N9qwD8943GKGhDjGms4s0XGHyMeVmB2qtitwIzY4wMVb
         KVYLG6pOE/AaHi3QPMBhxu1XC2VDMYdfwqXFy+pO1xR5lHSY84kQWYP98kHxfO8DyyrS
         Gl2w==
X-Gm-Message-State: APjAAAW1aviwmQtC4PkI8XNSux73bl7ukA7WGMBP0YQx/AS3P69Ol4T7
        gptrvvcJJQsFaVwqef/xJHSrepe47cM5TA==
X-Google-Smtp-Source: APXvYqxQZTP5l1HRErpy3pdX83QTEjM3tyIh7FnJhavvmkrmxPpeByKeTiqb/fpUJTWOArK1eL4SLw==
X-Received: by 2002:a63:4956:: with SMTP id y22mr4113695pgk.398.1568591950927;
        Sun, 15 Sep 2019 16:59:10 -0700 (PDT)
Received: from ?IPv6:2605:e000:100e:83a1:edde:3241:ce2f:af1c? ([2605:e000:100e:83a1:edde:3241:ce2f:af1c])
        by smtp.gmail.com with ESMTPSA id d20sm51316522pfq.88.2019.09.15.16.59.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 15 Sep 2019 16:59:10 -0700 (PDT)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        IDE/ATA development list <linux-ide@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] libata changes for 5.4
Message-ID: <565dc49a-4bd5-d25c-d859-1c3b103e1e22@kernel.dk>
Date:   Sun, 15 Sep 2019 17:59:08 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Hi Linus,

Here are the libata changes for 5.4. This pull request contains:

- Kill unused export (Andy)

- Use dma_set_mask_and_coherent() throughout (Christoph)

- Drop PCS quirk on Denverton, which has different register layout (Dan)

- Support non-boot time detection for pata_buddha (Max)

Please pull!


  git://git.kernel.dk/linux-block.git tags/for-5.4/libata-2019-09-15


----------------------------------------------------------------
Andy Shevchenko (1):
      ahci: Do not export local variable ahci_em_messages

Christoph Hellwig (8):
      acard_ahci: use dma_set_mask_and_coherent
      ahci: use dma_set_mask_and_coherent
      pdc_adma: use dma_set_mask_and_coherent
      sata_mv: use dma_set_mask_and_coherent
      sata_nv: use dma_set_mask_and_coherent
      sata_qstor: use dma_set_mask_and_coherent
      sata_sil24: use dma_set_mask_and_coherent
      libata: switch remaining drivers to use dma_set_mask_and_coherent

Dan Williams (1):
      libata/ahci: Drop PCS quirk for Denverton and beyond

Max Staudt (1):
      ata/pata_buddha: Probe via modalias instead of initcall

 drivers/ata/acard-ahci.c    |  38 +-------
 drivers/ata/ahci.c          | 149 +++++++++++++++--------------
 drivers/ata/ahci.h          |   2 +
 drivers/ata/libahci.c       |   1 -
 drivers/ata/libata-sff.c    |   8 +-
 drivers/ata/pata_atp867x.c  |   7 +-
 drivers/ata/pata_buddha.c   | 228 ++++++++++++++++++++++++++------------------
 drivers/ata/pata_cs5520.c   |   6 +-
 drivers/ata/pata_hpt3x3.c   |   5 +-
 drivers/ata/pata_ninja32.c  |   5 +-
 drivers/ata/pata_pdc2027x.c |   6 +-
 drivers/ata/pata_sil680.c   |   5 +-
 drivers/ata/pdc_adma.c      |  23 +----
 drivers/ata/sata_inic162x.c |   8 +-
 drivers/ata/sata_mv.c       |  38 +-------
 drivers/ata/sata_nv.c       |  10 +-
 drivers/ata/sata_promise.c  |   5 +-
 drivers/ata/sata_qstor.c    |  34 ++-----
 drivers/ata/sata_sil.c      |   5 +-
 drivers/ata/sata_sil24.c    |  26 +----
 drivers/ata/sata_svw.c      |   5 +-
 drivers/ata/sata_sx4.c      |   5 +-
 drivers/ata/sata_via.c      |   9 +-
 drivers/ata/sata_vsc.c      |   5 +-
 24 files changed, 255 insertions(+), 378 deletions(-)

-- 
Jens Axboe

