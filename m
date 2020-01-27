Return-Path: <SRS0=fywD=3Q=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 918FFC2D0DB
	for <linux-ide@archiver.kernel.org>; Mon, 27 Jan 2020 19:40:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66F0B24679
	for <linux-ide@archiver.kernel.org>; Mon, 27 Jan 2020 19:40:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="SrfRReOV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725938AbgA0Tkf (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 27 Jan 2020 14:40:35 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:46748 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725845AbgA0Tkf (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 27 Jan 2020 14:40:35 -0500
Received: by mail-pf1-f196.google.com with SMTP id k29so2868143pfp.13
        for <linux-ide@vger.kernel.org>; Mon, 27 Jan 2020 11:40:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=YWzWd5oNyHrQ+b4EIW4CQVsQ8Clf8/gYTL6BPmSAspc=;
        b=SrfRReOVql/ujlQHqp33F2Y5Z8LelGKJm3Bm9XN6DQ+L5ihoBtACp2eyr6MDRzAdS2
         Dkc8Oe6Qv0kKNkpTwMPlN8ql/n9SBmwgYUu6Txz63sq6KN6SPoap5lsa/Scxc8+oiceC
         5QARpIzCZRBqKbq1NNHJ7y2RtueneZXd+rbW8mdXxEWK3tSMWuNzM7JYVzddlmw7d8tV
         sfBFmegX/856pjBi+i7qxpTNTzuQaeK3l5938bCi9r/qPd2OveghtqBXo5Cq2LctieM2
         Yfz+tXDcITYZ31MJZt0fpaahSAdmqtfOvqMnD5MV2QhtoFeRkKpAapbV/q9uk3Pf4Y/q
         vo0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=YWzWd5oNyHrQ+b4EIW4CQVsQ8Clf8/gYTL6BPmSAspc=;
        b=Ky3FDIoco/YV9KKN3K5Mmckbqh7f0IfadcEBGCC7/S3q6ksHKWuA51h6hMvw0Gp8pz
         ADa/zMLPBiJncrNiM+fc4bSEqXhRPJCGox8h/r2yC9W+qtj5sOTuePFTTsT+RT+Nbpt1
         IVLli6GW87TuWvWxT8Ajfn7mxvWruZpD5VlhrC2A0b4NDpiy4BRiKqhAt+MLy5sTRXFg
         v0nt3mDJTx4dFW7KeNxtRgBmnCOS3tM6XYwnaQ1E4/TZv8jJJ5B5yQ7F12W+c9G5UEWK
         nqmpirpAo+BcmOzhf+5dbqUCODhEiNxkH2F5iTSGRANSpWgOiEE6EV5z7gx8gwQNI/Nq
         ZA0A==
X-Gm-Message-State: APjAAAWd+ozbVfDgP4oqeTsuIhRxREgHdmHKs6j9plPiZHXqxOxg1PI2
        U5sIc9150rWxSZr7XNmOKtx/bqU0Fy0=
X-Google-Smtp-Source: APXvYqyNOLmGcIbQHQAtx1+7byBZ5FU91gzXDFwXSKRFF6dsF46fssCixxtt6G/VvBrW3B9Z6oQMqg==
X-Received: by 2002:a63:4850:: with SMTP id x16mr21938883pgk.334.1580154034004;
        Mon, 27 Jan 2020 11:40:34 -0800 (PST)
Received: from ?IPv6:2620:10d:c081:1133::11c2? ([2620:10d:c090:180::dec1])
        by smtp.gmail.com with ESMTPSA id h126sm16880679pfe.19.2020.01.27.11.40.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jan 2020 11:40:33 -0800 (PST)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     IDE/ATA development list <linux-ide@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] libata changes for 5.6-rc
Message-ID: <f0c3c353-5e99-bd39-f689-9d40635765fb@kernel.dk>
Date:   Mon, 27 Jan 2020 12:40:32 -0700
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

Here's the pull request for libata for 5.6-rc1. As usual pretty quiet,
mostly trivial fixes (or dead code removal), outside of various fixes
for ahci_bcrm.

Please pull!


  git://git.kernel.dk/linux-block.git tags/for-5.6/libata-2020-01-27


----------------------------------------------------------------
Alex Shi (1):
      ata/acard_ahci: remove unused variable n_elem

Arnd Bergmann (2):
      ata: brcm: mark PM functions as __maybe_unused
      ata: brcm: fix reset controller API usage

Chen Zhou (1):
      ata: pata_macio: fix comparing pointer to 0

Florian Fainelli (6):
      ata: ahci_brcm: Manage reset line during suspend/resume
      ata: ahci_brcm: Add a shutdown callback
      dt-bindings: ata: Document BCM7216 AHCI controller compatible
      ata: ahci_brcm: Support BCM7216 reset controller name
      ata: ahci_brcm: Perform reset after obtaining resources
      ata: ahci_brcm: BCM7216 reset is self de-asserting

 .../devicetree/bindings/ata/brcm,sata-brcm.txt     |  7 +++
 drivers/ata/acard-ahci.c                           |  4 +-
 drivers/ata/ahci_brcm.c                            | 70 +++++++++++++++++-----
 drivers/ata/pata_macio.c                           |  2 +-
 4 files changed, 65 insertions(+), 18 deletions(-)

-- 
Jens Axboe

