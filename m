Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41CE9C433F5
	for <linux-ide@archiver.kernel.org>; Mon, 17 Jan 2022 20:02:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242848AbiAQUCe (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 17 Jan 2022 15:02:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242633AbiAQUCd (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 17 Jan 2022 15:02:33 -0500
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2815C061574
        for <linux-ide@vger.kernel.org>; Mon, 17 Jan 2022 12:02:33 -0800 (PST)
Received: by mail-io1-xd33.google.com with SMTP id p7so22963198iod.2
        for <linux-ide@vger.kernel.org>; Mon, 17 Jan 2022 12:02:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=/tQffg8O0g/GJzttgADdaNLwAIVRs4L9Rm0ILKV/xCU=;
        b=lNsMruR99Kq7NzPnhEuAz9jea8FRtn8La98vr2vTlQgt+Qt0lRUAs0bbHk5UdVg2J8
         dzLiUQkXKMEzfLfR4mqhUZL2nNoidxshBY/0q4ez0RAfy6IRg+oLk0U08FcIQmDdgPtS
         rBXRsVpYBvhB+/VXVNCtsQYzmjH2ptd7Lflgi3nEVrIbofLrxq5F/qhQt/4Rz+izxUTf
         Qhb68QCMxcE4j1N8c8NkHfYSFVTndCwyEnk92Jq4LeKtmje8nMcAsumFZE50LdWHPBnC
         /2FVmwBzUHBVhh4quHVTf1LZ1d/xudi/Id3Any6Ar97Kh0YWzJWVsv6TY5r0RzkCQoRC
         PqLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=/tQffg8O0g/GJzttgADdaNLwAIVRs4L9Rm0ILKV/xCU=;
        b=gYhGtBxJxRYmG5kqKgUgFE1Gclwa5pipXaZl2LUbVyt9asKX3/YHOs76mStTRrMtn7
         5qpA7xdTPbXdIB4JCoPX9HGfN7HqsCPQDfV9lXlFSbKo5UonV6bLCoYBRSxNfIvyh4pA
         WTqq+1Lpf2GDLeES9Yhya2PCmyJOaEb33uRyHyibkgCFVNnAfypBGcKNPxFhsTNF4XxU
         uod8vK63Fx3MhSKoh/jfjgraelKl/UffFbxlMECxjh5R07w0Lxrs4g1hRFCBLornJQcA
         6q6589XFjXaZ7y0U3AMEZq6pv/Hk++2eoui9WZAoq3hXhVkWulaLFWoe7t3af5oZf344
         uAFQ==
X-Gm-Message-State: AOAM530k9HULaei2Sr7NvoD7KT2PDsqamZfzy0n3ubgNsWz0I36vS7BT
        4aA7F96+nuRIJFl9+9iuUyrBMFBAtlF6h50Mvw4xjTljBnY=
X-Google-Smtp-Source: ABdhPJxuqkb2S9/Y9r29UwQERCGMIJSKCvkIIv3zgwOcDtUXZVj5svDv9b1Lo0saP3SucFwr8jzdrzUdxYNx9Np/lI0=
X-Received: by 2002:a05:6638:348d:: with SMTP id t13mr2547448jal.37.1642449753077;
 Mon, 17 Jan 2022 12:02:33 -0800 (PST)
MIME-Version: 1.0
From:   Sven Hugi <hugi.sven@gmail.com>
Date:   Mon, 17 Jan 2022 21:02:22 +0100
Message-ID: <CAFrqyV5qv3K4m5m__VGfs5O_ocx0LDa=Dyiqc=rtGj9OwqsO3g@mail.gmail.com>
Subject: Samsung t5 / t7 problem with ncq trim
To:     linux-ide@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Hello

I hope, that this is the correct mailinglist... if not, pls let me know...

So, there is a problem with the samsung t5 and t7, those ssd's are
just samsung 850 with an usb-c adapter.
They should get added to the ata_device_blacklist in libata-core.c
Those 4 lines should work in theory, but i was unable to test it,
would be nice, if someone how knows what he is doing could do this.

{ "Samsung Portable SSD T5",    NULL,   ATA_HORKAGE_NO_NCQ_TRIM |
                                        ATA_HORKAGE_ZERO_AFTER_TRIM, },
{ "Samsung Portable SSD T3",    NULL,   ATA_HORKAGE_NO_NCQ_TRIM |
                                        ATA_HORKAGE_ZERO_AFTER_TRIM, },

Sorry for my poor english

I hope this helps somehow fix the problem.

Best regards

-- 
Sven Hugi
