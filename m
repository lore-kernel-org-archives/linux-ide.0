Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7135EC636D6
	for <linux-ide@archiver.kernel.org>; Wed, 22 Feb 2023 21:29:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232382AbjBVV3K (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 22 Feb 2023 16:29:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231962AbjBVV3J (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 22 Feb 2023 16:29:09 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28D50457DB
        for <linux-ide@vger.kernel.org>; Wed, 22 Feb 2023 13:29:07 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id m7so11756073lfj.8
        for <linux-ide@vger.kernel.org>; Wed, 22 Feb 2023 13:29:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=HmuGktcWTpwP951tTereejjKvwPxWBwn/R5vRD0MchE=;
        b=pKZZu3HSNH37gOQAgbvdZbq1ApVyjblXaxc8ad0/uRNRuBlrpOFy7rp9fzrD1Lqq+X
         D2H2JmArQJVotRusTh3HjlTSqUQ64G+QtEMs5n2yiB+HRlg3YoeKiCdtNRwhKimtCYV4
         Ut4ZclaqIZCU2WsQ1exlGNdm4QHiznP1ra/XCOVGgZrYETa19q6Zg9vNVNnSYarBVgCQ
         k/Xu2OUgxJ59KcKFyQwC/3e5+v8XYJ8ZZbty0SetqXGEdM3fI9SjA81LE+6/HJn0LDj7
         EWDVWVU09gtGGXqsbR7Nm6IXKmpJIM1Q8PNyoeTYD7a5BlGzK8B2kpy9CTIqMATCy4Gb
         xUNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HmuGktcWTpwP951tTereejjKvwPxWBwn/R5vRD0MchE=;
        b=GAb5Q4/3PUgYbuojVyi1y8Kwc/tz7zym7azDT/LzsMrLHk2MYazRQ2yVM87sIxFzx5
         BNiALYjqBdnSvIWm8BNrewci+hXqqmuQIgM2VsuEpAFc2gnecNdQRnusvxyk7rL+Ix/+
         uHBqHV4tRcm42qp5tQcnKey6H2iIY/LrnHgCn1/QDM+sfG1AGJWvxrNdQpFR90s1nH/O
         hQnN01IsC+n6eQp3PUPQDeOmABmkd2ZcBnjLBkQl+YH1Yji/2bJz1jGkltLc2UOtjTOF
         /Inx3Qf3mfvAlFsOLq0xRBn5zz4KeqYvFrSSGS+t50IDN2+YXJsfRNwsRMIVyLu9vOPv
         8qYw==
X-Gm-Message-State: AO0yUKUYJk5mBMVOUpUihJIKhqSBSMDGYJG+M1FALdHtl09cB2JSppCY
        DHBZiBTiSKIUVYvB1wIykpqPcsecW2kpvK9lTnTnNPu3jHM=
X-Google-Smtp-Source: AK7set/EpKkL/7GQZlaR1X3o6/qNDJXKBjOKb64kqdVk8UouKT2hjeTnjfo1tMblBL485U29hRedPhs1DQaEbmgY6gE=
X-Received: by 2002:ac2:4426:0:b0:4d8:5f47:e4d3 with SMTP id
 w6-20020ac24426000000b004d85f47e4d3mr3075908lfl.8.1677101346141; Wed, 22 Feb
 2023 13:29:06 -0800 (PST)
MIME-Version: 1.0
From:   Ioannis Barkas <jnyb.de@gmail.com>
Date:   Wed, 22 Feb 2023 23:28:54 +0200
Message-ID: <CADUzMVb+JbwxiKxrxjAep8Gbom_ynM7Os67_gTEHC-dJFAVL0g@mail.gmail.com>
Subject: Re: The SATA_ini162x.
To:     linux-ide@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Hello Magnus,

I will give you more details about it since I reported the issue with
this controller many years ago.

Yes you can activate the driver but you will need to enable this
driver and build your own kernel. That is needed since the driver is
disabled by default. There is at least one underlying issue that has
got unnoticed and has not been solved yet thus the driver is
considered experimental. My PCI card has an eSATA connector routed to
port 0 and a SATA connector routed to port 1. Back then, I had tested
the SATA port and believed that the driver could only handle port 0.

Damien if you are willing to investigate this and help me fix it, I am
at your disposal. I still have the card with this controller, the
datasheet of the IC manufacturer, an AMD based PC with a PCI slot and
lots of disks for testing. What is more, I had done some tests back in
December and the issue remains. Here is what 6.1 prints:
[    1.947670] sata_inic162x 0000:05:06.0: version 0.4
[    1.947716] sata_inic162x 0000:05:06.0: inic162x support is broken
with common data corruption issues and will be disabled by default,
contact linux-ide@vger.kernel.org if in production use

Here is the problem:
[    3.285163] ata8.00: native sectors (1) is smaller than sectors (976773168)

I tested the eSATA port and it behaves exactly the same as the SATA
port. I have also performed some modifications but those were in the
wrong direction as I completely broke the driver thus it could not
detect attached devices. That brought a libata bug to the surface and
I need to send a patch about it. Back to sata_inic, I have not figured
out how it works with both channels.

Hope to get better Magnus really soon!

Best regards.
