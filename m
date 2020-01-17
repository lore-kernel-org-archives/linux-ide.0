Return-Path: <SRS0=uYUo=3G=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FFE0C33C9E
	for <linux-ide@archiver.kernel.org>; Fri, 17 Jan 2020 23:53:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0E9E208CD
	for <linux-ide@archiver.kernel.org>; Fri, 17 Jan 2020 23:53:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KWvhVXgy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730313AbgAQXx3 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 17 Jan 2020 18:53:29 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:43889 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730117AbgAQXx3 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 17 Jan 2020 18:53:29 -0500
Received: by mail-pf1-f193.google.com with SMTP id x6so12650482pfo.10;
        Fri, 17 Jan 2020 15:53:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=DOZb8sQcyGgXJspGB8IQi9vf/tsFT10FEUhfYyxLnNM=;
        b=KWvhVXgytu4/KOVTp6IHZul0HVA7fS4XjwIUmRNUqjCOm2FBzsSt7G1T+ZaIM914Cs
         YwbS3p7Ow/LZJhI15eUS/n1CAOY/a9djfIlPQ+hiIVURU9ESQouVscicV1Vcr5UOvxpa
         sS2F53lEpbdcPASP92BBJudtV5CG60SfxyH69RvWYOMfAbMW0Cs3lEMsCB8Nc0XWr/Qo
         gYvXVWPD7PSGpK3R4jU7+vfPZfDbF6lTekeoR7QX/PBk3mQNTKisCtjHRKtA2j8NFDcr
         PwytNWS+UshpAwizs8xBhA+PeRsl69q3uB+eshSSdkdlh3qQIFatCS3TgG0QMEGtfMf9
         vocQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=DOZb8sQcyGgXJspGB8IQi9vf/tsFT10FEUhfYyxLnNM=;
        b=LfBQrII3uBevnBm3YF/r2K6ZgAtgixccu+mC87g8gS8RlK6UXwWwPJRBYUchaMpm4j
         Twlzx93x6hXQfq4jSzuqj4IUHMnJ4R8XL+6TL3o6eHYpIj18A8QYjiguNb79aD3Rn3g2
         oACO/8Il34BQ1rzzAbTiP+duLqjXuWrtVMvjy89AHgkcQfSbge6aUTmUmOKETdMegGgP
         yHJbYP0Y1wbBJhgseJwz4ziP+Z83Xkk/ExjyNZhvwTySdsOjB2Ne29ClDRzcE67i8XB6
         OQsHlW0ZBfPWMLLe5qYOUTjKbf9Xcsft538P2w/Mxl6VG8MogBXexYMVJPbitKUsjDBW
         HR3g==
X-Gm-Message-State: APjAAAVuE+rQhXntt9/fwY5TIZ+fmNKMjwrEs+Ye0wSV93B9q4TkqgLD
        IEmG4u4odxcaBtxcbE1LQZGxPMaW
X-Google-Smtp-Source: APXvYqyDw8DNy4dZkpYb6sJ9TskExfUpzX/UHnbXiUHSbosoyV52Ksm4i+qjsK8bBakyzOkhstf8RQ==
X-Received: by 2002:a63:5920:: with SMTP id n32mr47258104pgb.443.1579305207989;
        Fri, 17 Jan 2020 15:53:27 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id m19sm7544146pjv.10.2020.01.17.15.53.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2020 15:53:27 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Jens Axboe <axboe@kernel.dk>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Tejun Heo <tj@kernel.org>, Jaedon Shin <jaedon.shin@gmail.com>,
        linux-ide@vger.kernel.org (open list:LIBATA SUBSYSTEM (Serial and
        Parallel ATA drivers)),
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS), bcm-kernel-feedback-list@broadcom.com
Subject: [PATCH v4 0/2] ata: ahci_brcm: Follow-up changes for BCM7216
Date:   Fri, 17 Jan 2020 15:53:11 -0800
Message-Id: <20200117235313.14202-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Hi Jens,

These three patches are a follow-up to my previous series titled: ata:
ahci_brcm: Fixes and new device support.

After submitting the BCM7216 RESCAL reset driver, Philipp the reset
controller maintained indicated that the reset line should be self
de-asserting and so reset_control_reset() should be used instead.

These three patches update the driver in that regard. It would be great if
you could apply those and get them queued up for 5.6 since they are
directly related to the previous series.

Changes in v4:

- rebase against latest ata/for-next which included some fixes from
  Arnd that corrected the reset consumer API
- dropped patch #1
- did not add Reviewed-by tags since the patches changed a bit from last
  submission

Changes in v3:
- introduced a preliminary patch making use of the proper reset control
  API in order to manage the optional reset controller line
- updated patches after introducing that preliminary patch

Changes in v2:
- updated error path after moving the reset line control

Thanks!

Florian Fainelli (2):
  ata: ahci_brcm: Perform reset after obtaining resources
  ata: ahci_brcm: BCM7216 reset is self de-asserting

 drivers/ata/ahci_brcm.c | 26 +++++++++++++++++---------
 1 file changed, 17 insertions(+), 9 deletions(-)

-- 
2.17.1

