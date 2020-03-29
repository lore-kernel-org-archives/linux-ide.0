Return-Path: <SRS0=nFgX=5O=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3C87C2D0E5
	for <linux-ide@archiver.kernel.org>; Sun, 29 Mar 2020 22:45:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0A9220733
	for <linux-ide@archiver.kernel.org>; Sun, 29 Mar 2020 22:45:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="ScK3vVXJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728948AbgC2Wp5 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sun, 29 Mar 2020 18:45:57 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:34748 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727591AbgC2Wp5 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sun, 29 Mar 2020 18:45:57 -0400
Received: by mail-pl1-f196.google.com with SMTP id a23so5977054plm.1
        for <linux-ide@vger.kernel.org>; Sun, 29 Mar 2020 15:45:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=0t271x+DU0Atpe8UaNyBG8lIiHoWr2mHJuNedMwC03c=;
        b=ScK3vVXJs6qew1oyLLHQqcw27RzNAijmKHi6W3XA0kAFbzGOnLE9frpJYqMUMgPIvE
         fVKwl2GKTZZygosnXnVqSlAiExVvGw1t8S8FHc1MhH7jMCSkU8HTcX2VS2qFzinGUiBw
         zhTCRUbsrlUQ+Q402W4/3zUJXTJZ6ibp5/CThCJNSSe2y0h621hZDAmLYZuL7gL/0HMV
         Af/Z/4MF059M7SlLq4SJgBrvLypLXIskxhDCi0PAvNG+PiSwwJ516czAHzElzgFO9L6Z
         NgJGjatmSFfx0juo2MzJ6j2aMnzxx9UsxUhMsirvXMjUIHf4706x+ePRye+SuZEu6W5M
         aWfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=0t271x+DU0Atpe8UaNyBG8lIiHoWr2mHJuNedMwC03c=;
        b=ENZWqeanrDOoIc1NXLw+FQcNJm6vdKpQ8H/cNJOq2ZnBdw8MJe1yLMXyRZbMVsvyIY
         JtOLmThugNe+667vacChoNJUaxTvuNrkS7GwhHdsAR4999Jg+qBYdstOBgZFOms2UNPA
         HlCderz2ZH+zltL5jKm7mnMPCydtFTJ8QVC9QRHKxTZ1Mjl2xVSU5YUjpCIQt42S6TjY
         NqUOIcSni4yCDev+KH00ypopfJ3TTccNVGjKkjKZHpziQMgueen4nFHmd5uN51WopIpb
         g2V7sVz5A/8iLmmmMopXHaCIaa77epUQoYYiHE2y2eQUI+nTtjLksico00AE5FSdLrdg
         UQnQ==
X-Gm-Message-State: AGi0PuZii36nswc1O9ZzQcu23cuwb0SgGPXR+yU2xh+be5hQ7WJ3orKo
        rZAUauE+9tudv3Zj0rH9azZVSUc8jIxZaQ==
X-Google-Smtp-Source: APiQypLecVMbWWNlrL4dt6DJMNsMZUKkDmdVS2Cc9Ivv5ofvRZaImeatR9Cvae6Zqkowi22cH4y0DQ==
X-Received: by 2002:a17:902:59c6:: with SMTP id d6mr4586617plj.207.1585521954231;
        Sun, 29 Mar 2020 15:45:54 -0700 (PDT)
Received: from [192.168.1.188] ([66.219.217.145])
        by smtp.gmail.com with ESMTPSA id r7sm8729672pfg.38.2020.03.29.15.45.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 29 Mar 2020 15:45:53 -0700 (PDT)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     IDE/ATA development list <linux-ide@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] libata changes for 5.7-rc
Message-ID: <d5c6ff8b-f82c-f609-0257-66fb6fbeb331@kernel.dk>
Date:   Sun, 29 Mar 2020 16:45:51 -0600
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

Here are the libata changes for this merge window. This pull request
contains:

- Series from Bart, making the libata code smaller on PATA only setups.
  This is useful for smaller/embedded use cases, and will help us move
  some of those off drivers/ide.

- Kill unused BPRINTK() (Hannes)

- Add various Comet Lake ahci PCI ids (Kai-Heng, Mika)

- Fix for a double scsi_host_put() in error handling (John)

- Use scnprintf (Takashi)

- Assign OF node to the SCSI device (Linus)

Please pull!


  git://git.kernel.dk/linux-block.git tags/for-5.7/libata-2020-03-29


----------------------------------------------------------------
Bartlomiej Zolnierkiewicz (27):
      ata: remove stale maintainership information from core code
      ata: expose ncq_enable_prio sysfs attribute only on NCQ capable hosts
      ata: make SATA_PMP option selectable only if any SATA host driver is enabled
      sata_promise: use ata_cable_sata()
      ata: simplify ata_scsiop_inq_89()
      ata: use COMMAND_LINE_SIZE for ata_force_param_buf[] size
      ata: optimize struct ata_force_param size
      ata: optimize ata_scsi_rbuf[] size
      ata: move EXPORT_SYMBOL_GPL()s close to exported code
      ata: remove EXPORT_SYMBOL_GPL()s not used by modules
      ata: fix CodingStyle issues in PATA timings code
      ata: separate PATA timings code from libata-core.c
      ata: add CONFIG_SATA_HOST=n version of ata_ncq_enabled()
      ata: let compiler optimize out ata_dev_config_ncq() on non-SATA hosts
      ata: let compiler optimize out ata_eh_set_lpm() on non-SATA hosts
      ata: start separating SATA specific code from libata-core.c
      ata: move sata_scr_*() to libata-sata.c
      ata: move *sata_set_spd*() to libata-sata.c
      ata: move sata_link_{debounce,resume}() to libata-sata.c
      ata: move sata_link_hardreset() to libata-sata.c
      ata: move ata_qc_complete_multiple() to libata-sata.c
      ata: move sata_deb_timing_*() to libata-sata.c
      ata: start separating SATA specific code from libata-scsi.c
      ata: move ata_sas_*() to libata-sata.c
      ata: start separating SATA specific code from libata-eh.c
      ata: move ata_eh_analyze_ncq_error() & co. to libata-sata.c
      ata: make "libata.force" kernel parameter optional

Hannes Reinecke (1):
      libata: drop BPRINTK()

John Garry (1):
      libata: Remove extra scsi_host_put() in ata_scsi_add_hosts()

Kai-Heng Feng (1):
      ahci: Add Intel Comet Lake H RAID PCI ID

Linus Walleij (1):
      libata: Assign OF node to the SCSI device

Mika Westerberg (2):
      ahci: Add Intel Comet Lake PCH-H PCI ID
      ahci: Add Intel Comet Lake PCH-V PCI ID

Takashi Iwai (1):
      libata: transport: Use scnprintf() for avoiding potential buffer overflow

Tiezhu Yang (2):
      PCI: Add Loongson vendor ID
      AHCI: Add support for Loongson 7A1000 SATA controller

 drivers/ata/Kconfig               |   77 ++
 drivers/ata/Makefile              |    2 +
 drivers/ata/ahci.c                |   10 +
 drivers/ata/libata-core.c         | 1126 +++-------------------------
 drivers/ata/libata-eh.c           |  224 +-----
 drivers/ata/libata-pata-timings.c |  192 +++++
 drivers/ata/libata-sata.c         | 1483 +++++++++++++++++++++++++++++++++++++
 drivers/ata/libata-scsi.c         |  583 ++-------------
 drivers/ata/libata-sff.c          |    4 -
 drivers/ata/libata-transport.c    |   10 +-
 drivers/ata/libata.h              |   25 +-
 drivers/ata/sata_promise.c        |    8 +-
 drivers/scsi/Kconfig              |    1 +
 drivers/scsi/libsas/Kconfig       |    1 +
 include/linux/libata.h            |  174 +++--
 include/linux/pci_ids.h           |    2 +
 16 files changed, 2065 insertions(+), 1857 deletions(-)
 create mode 100644 drivers/ata/libata-pata-timings.c
 create mode 100644 drivers/ata/libata-sata.c

-- 
Jens Axboe

