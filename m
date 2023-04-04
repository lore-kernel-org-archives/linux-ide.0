Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1612EC761A6
	for <linux-ide@archiver.kernel.org>; Tue,  4 Apr 2023 20:13:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230331AbjDDUNs (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 4 Apr 2023 16:13:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjDDUNr (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 4 Apr 2023 16:13:47 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAA982134
        for <linux-ide@vger.kernel.org>; Tue,  4 Apr 2023 13:13:46 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id ce4so9222720pfb.1
        for <linux-ide@vger.kernel.org>; Tue, 04 Apr 2023 13:13:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680639226;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9H1i+TqDmlaQLPUVoZDjq8uF1IwwyWvPsFhWyvDuuEA=;
        b=LkLe0Aapi7uqb+P1IW0VI3BHU14iLbSwdarXo1DX1AAJKc0HGZyB4p0b/kLcZRiHj2
         LErQrcw5PscMTL27EIa2osuW0gsvQGZS0hZGWBrTf10SYUYh/7eJ14mZRlYRDpKwK8kD
         uLl1qG3dHTLHba94YvwSy7O4mb3wS5O+zt3XPZg+uAlY81QVfxAnjenJxn0T+Ofj0wKR
         y4Qv7sevIW6bvKiniu/O0Nr/+jPuBgXmcpVO8P2cBtJ66fhfRD9urYlyaq3/hWmkmIgA
         g1t4IvvnP0t01L8Da9vYYZKrhyYN5ZyMGNhuXpVhIJOQw7yfEqs6dG3w6D+kspZGcHC9
         vyqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680639226;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9H1i+TqDmlaQLPUVoZDjq8uF1IwwyWvPsFhWyvDuuEA=;
        b=qJ3jeTWbCHFvA6jK4YfYyv3h+mThwwWkbDudmHVOqRR6tWSJpR/HUhrc5/jfx/MNgm
         DntzDqdaHZM+KSmZ3+9+VOoLBK8vU2Or66ggnYhKj/BFNOaKxY976xxpafKG3/V3RfLF
         56Puia1xK1DMA52hj0s+t5oxdjdqh7p+LUfoGuIjJT08UHrpInkTHtfedEW9HtdPwxyJ
         rhs+6oYFuogpki85Bbm+LXCuCOqkfz63IBjI0Az2bORfxYOYeW8Pk1SqfEm/tBvjKTSy
         JyLwHggm5Ta8w8UBD8EHtT44TY/qkJbJ4dRELkdbG9uC6rU/10FM4qKYviCS/u7FqWxM
         FVDg==
X-Gm-Message-State: AAQBX9cqyW4hBqmHelVte8Wl8yisH54P9XnAKX8JsEN+Bg9DdHVabaJb
        NQEC+O6+/fQib8PygY044a2DuVwNCcUf+VTC2xso/9cOBls=
X-Google-Smtp-Source: AKy350a670AeuTovRyljMF2rnhCD2jHpRPPj9UaTEn301ASEKSoaKyEQwCju+HSC+UO8xBslxlHk+e1cjIz+KhfBE68=
X-Received: by 2002:a05:6a00:2d87:b0:626:23a1:7b8a with SMTP id
 fb7-20020a056a002d8700b0062623a17b8amr2020023pfb.3.1680639226293; Tue, 04 Apr
 2023 13:13:46 -0700 (PDT)
MIME-Version: 1.0
From:   Ioannis Barkas <jnyb.de@gmail.com>
Date:   Tue, 4 Apr 2023 23:13:34 +0300
Message-ID: <CADUzMVb=vhCrScxZ+i9Mpq5T7jbmjZCxmUMnWcbQT3QWW0xGBg@mail.gmail.com>
Subject: Re: [ata] : SATA device speed down after multiple power reset.
To:     linux-ide@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Hello,

Since you have reported this problem, I suggest to provide some more
details in case you wish to find its root cause.

You have not provided any useful information at all! You have just
sent the error but everything else is kept in dark...

Having that in mind, please elaborate to see what goes wrong. Damien
will help you if it caused by any coding error. First of all, provide
a full dmesg so that we can see the interesting details. In detail, we
need to see the CPU, the SATA host capabilities and the IC used.
Moreover, we must see the SSD device you are using as well as the
kernel version. Are you using a custom kernel or one of the official
releases? Please provide a link to its source in the case of a custom
kernel.

To track this error, I suggest to increase the kernel buffer and
enable CONFIG_ATA_VERBOSE_ERROR. Repeat testing and provide the latest
dmesg.

Concerning the storage device, does your SSD have power loss
protection? Have you tested this configuration with an HDD? If the
controller is PCI based, please provide lspci -nnnvvvxxx for all PCI
devices run with elevated rights. Also please post hdparm and check
your SSD device health. Have you detected any filesystem related
corruption? Why do you want to power it down?

In regards to the Power Management Unit(PMU), is the system running
while the SSD is powered off or does it enter a lower power state as
well? For example S3 or S4 speaking ACPI wise.

There have been a lot of broken storage devices as well as SATA hosts
but no one will be able to help you on this unless you provide
additional information.

Kind regards.
