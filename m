Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21432C433EF
	for <linux-ide@archiver.kernel.org>; Sun,  5 Sep 2021 18:57:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED99960E76
	for <linux-ide@archiver.kernel.org>; Sun,  5 Sep 2021 18:57:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232251AbhIES6g (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sun, 5 Sep 2021 14:58:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229865AbhIES6f (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sun, 5 Sep 2021 14:58:35 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54C16C061575
        for <linux-ide@vger.kernel.org>; Sun,  5 Sep 2021 11:57:32 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id u13-20020a17090abb0db0290177e1d9b3f7so2952483pjr.1
        for <linux-ide@vger.kernel.org>; Sun, 05 Sep 2021 11:57:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=pXwPjfHoq1GXZ9zwhTd/cXTI4zRRV42g9B4xvXby1Qk=;
        b=UDV3GulVCgKCE2dfDNheu5iduHJbl7OQaYGGOlZt3yceEExlNAzSDrHaVX7WVgDPxZ
         2vDCalswUVZSfNmY9X1itXeVUCmWSAwU80iC3NjvAd/aQaFgQfQ5LNSYdl81BfayDUF8
         np0ysrxrdD7EZWwV5SfiBB0kfcQt95+TWGOTfIgVnzhFHQS4bJGHP9hIZrvYjivn3w9r
         7Kmo4l5IOOrKMEkYNSXORrM64gVl2tl4kgqR3nniWRnGa96gwNWHeack3DeXq6+UCE0D
         e72dF0os7DEvkVTRkTZ2lRCviKrTWW7jWiyF+OhBkUqOom2Qgpj1rOzMsp/2PDfmLMJO
         SH6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=pXwPjfHoq1GXZ9zwhTd/cXTI4zRRV42g9B4xvXby1Qk=;
        b=V3iY9bymd2FoZTAQWPa4E/CGogXFiJMYg/DfFolBta0qdBqxJhdr9dGuWLE6DO+NEo
         Y7T9xbwI4gRg4VG4gNb7JjNSDaJbkLUAXCjBvDsjrdg94ItfD+1TgJUmAgQx4GFT8Xmi
         Aeyf7MpsdS7MfEk80obnCER3Tnm5qJMi4ZlxuyElotLvGNdrn6pXT8e9PZdVswLOMAIs
         RqzXQwghGKt9vu+2gme6BrIj1GNPY6crpbMZ0yp9BIab/qmpRDSKmm7cN7on1VTRT/w8
         InxfiNmp8iXOOADU274Rv3K11/zgeth/arqdu4i9JJ7Ub4m5GSmrzYTzIN+hv80t3bCV
         H+2w==
X-Gm-Message-State: AOAM531XN/Mw7jyY7Te/8e7WRhu77UZ4rA5vzJ18+9m5OtLz8nfBGgkv
        lolc7IqmBmyEdwKXkW1teUVKgkZqUUi9bQ==
X-Google-Smtp-Source: ABdhPJwnGb2KdIQ3FhLRcsHxZaWMgtcesLs+73Kkmwkx0ZJAbQjKOJAMd0XSYi0b7xFRayH8AwWuCQ==
X-Received: by 2002:a17:90b:224a:: with SMTP id hk10mr10136150pjb.235.1630868251290;
        Sun, 05 Sep 2021 11:57:31 -0700 (PDT)
Received: from [192.168.4.41] (cpe-72-132-29-68.dc.res.rr.com. [72.132.29.68])
        by smtp.gmail.com with ESMTPSA id d22sm3425420pfv.196.2021.09.05.11.57.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Sep 2021 11:57:30 -0700 (PDT)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     ALWAYS copy <linux-ide@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] libata fixes for 5.15-rc1
Message-ID: <9004cd72-d5a7-da36-10c0-7ef80d222950@kernel.dk>
Date:   Sun, 5 Sep 2021 12:57:29 -0600
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

Fixes for queued trim on certain Samsung SSDs, in conjunction with
certain ATI controllers. Please pull!


The following changes since commit a9c9a6f741cdaa2fa9ba24a790db8d07295761e3:

  Merge tag 'scsi-misc' of git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi (2021-09-02 15:09:46 -0700)

are available in the Git repository at:

  git://git.kernel.dk/linux-block.git tags/libata-5.15-2021-09-05

for you to fetch changes up to 7a8526a5cd51cf5f070310c6c37dd7293334ac49:

  libata: Add ATA_HORKAGE_NO_NCQ_ON_ATI for Samsung 860 and 870 SSD. (2021-09-03 08:06:02 -0600)

----------------------------------------------------------------
libata-5.15-2021-09-05

----------------------------------------------------------------
Hans de Goede (1):
      libata: add ATA_HORKAGE_NO_NCQ_TRIM for Samsung 860 and 870 SSDs

Kate Hsuan (1):
      libata: Add ATA_HORKAGE_NO_NCQ_ON_ATI for Samsung 860 and 870 SSD.

 drivers/ata/libata-core.c | 34 ++++++++++++++++++++++++++++++++++
 include/linux/libata.h    |  1 +
 2 files changed, 35 insertions(+)

-- 
Jens Axboe

