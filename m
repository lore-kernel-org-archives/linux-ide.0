Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 044C7C433E0
	for <linux-ide@archiver.kernel.org>; Mon,  1 Mar 2021 10:33:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B28B3600CC
	for <linux-ide@archiver.kernel.org>; Mon,  1 Mar 2021 10:33:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234066AbhCAKc7 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 1 Mar 2021 05:32:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234493AbhCAKcp (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 1 Mar 2021 05:32:45 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B038C061756;
        Mon,  1 Mar 2021 02:32:05 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id c16so106775ply.0;
        Mon, 01 Mar 2021 02:32:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2/ii7K4CtnMMku2yGlI81G6YB1hYSHxfV70UcG0v9D4=;
        b=cifhlWedUyZA6JAWkJBiJG1dYI5BrIhpbIq9Or5VYQF5EEb+H9k5SMvppbgLP1Th9R
         rL5j9c3X2ZOvejbvztv30eZzy4E0L82SiXZWlC4ozL7ie4lrVtKeGoUxo/PLCdz9OsNV
         lTFrNAW4f065+QyRSDRBMddlk+2GjonLFq6xVlQ4mkC6yWxSieoKkWqQCFWSk74Kj5T5
         WxGHve8w27c8aBsKhLnvU4QMcdAs3kQWVP5T2Vt+PQ/PG8kmecg83UR6kGKnnFT7ecyo
         SoNwG2Jum9bXDRWWYWDQNdZqQsoUXjIHKU2L9u4oSCfWqae58dZDxKqrpVkqEb7Rk0Vf
         InRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2/ii7K4CtnMMku2yGlI81G6YB1hYSHxfV70UcG0v9D4=;
        b=LtxnpFDcqybTuGxhTBU4ElzI6VYG5Z06aJmheI57vewTk0hfdSR24+JAI+sw2cIVPN
         Vbz9Upxdx7hQR1NOeDPcby3ryOIcyXa+YZpbDhKin2eSarAh075crg1KxvGUBpL4NmZ4
         cegOBIOrKYWGAuQ0z98wKzO3a37jC8OtuUBQB7wCqMKkZGWBSfFt9Uz4YtzNma7HNBfq
         DfhyOrqQvOS0jhcZ0yIWHd1w85mKa5nfeECoWClecc9AGxV5M2xyb32r2ZdN+chA75SH
         3JkzefJOvgG6SmRFBGqU50XwYoq+EAiwC3R5KMrkQb6lnIny2x7aapxYRFlWpYIaUz50
         quRQ==
X-Gm-Message-State: AOAM530M490w7gz3pcwexsMU4WsRRz8x/HmJ4QsabO+RT96ZAG5k2uqH
        ycrQSui8gQbQ9K4B/ExLCTgnHxlA4o0LQI0JivM=
X-Google-Smtp-Source: ABdhPJzVJb6SyjfdSoi7rETajnG42z5KdYFGUeV0JMxuElC4Wu4CDbtdcpXu58LQgFjzZalJv1eYHhSRo0VYfnz3o2s=
X-Received: by 2002:a17:90a:4fc1:: with SMTP id q59mr17543267pjh.129.1614594724659;
 Mon, 01 Mar 2021 02:32:04 -0800 (PST)
MIME-Version: 1.0
References: <20210301072842.7410-1-dinghao.liu@zju.edu.cn>
In-Reply-To: <20210301072842.7410-1-dinghao.liu@zju.edu.cn>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 1 Mar 2021 12:31:48 +0200
Message-ID: <CAHp75Vf86_Ccs7wqzbpWbLDZSSJLbMwZ1TX3dwru9JvXUTMR_Q@mail.gmail.com>
Subject: Re: [PATCH] sata_dwc_460ex: Fix missing check in sata_dwc_isr
To:     Dinghao Liu <dinghao.liu@zju.edu.cn>
Cc:     Kangjie Lu <kjlu@umn.edu>, Jens Axboe <axboe@kernel.dk>,
        linux-ide@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On Mon, Mar 1, 2021 at 9:44 AM Dinghao Liu <dinghao.liu@zju.edu.cn> wrote:
>
> ata_qc_from_tag() may return a null pointer and further lead to
> null-pointer-dereference. Add a return value check to avoid such case.

Can you elaborate more on this? Is it a real case?
I have a hardware, how can I reproduce this?

-- 
With Best Regards,
Andy Shevchenko
