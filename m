Return-Path: <SRS0=EzgR=BD=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EB72C433E1
	for <linux-ide@archiver.kernel.org>; Fri, 24 Jul 2020 11:12:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DCB842067D
	for <linux-ide@archiver.kernel.org>; Fri, 24 Jul 2020 11:12:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F+AfoPnU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726739AbgGXLMl (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 24 Jul 2020 07:12:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726702AbgGXLMl (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 24 Jul 2020 07:12:41 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E1C2C0619D3;
        Fri, 24 Jul 2020 04:12:41 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id n5so5043140pgf.7;
        Fri, 24 Jul 2020 04:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=eoQ/LwxD/ih1GkSzZAuNDCG4MFgTBugN1T3/2DGPiZs=;
        b=F+AfoPnUNB9t0KWm2nR//O678xJDpStefDxH/hAmjz0Fe8DSeYnEOVlz3NKIIBrVqt
         Nc3NYWGFVrJG0EgCOBmq0BcGdEOuPvewh0cdOhDVmjVArklGwPRI1H322uaEY5ZYBKTi
         S53Jo4E2403XmtftrBksW1SYnZImRWtxquqolTne9TIneBEIFsq9i/t+A/Jkp9sMTBlP
         sHPtkOi814EF4hsoFgW/tOnIg0bGiinP1xlPQvXKzslX9vl4u2B8KGevjKTVlf5HgM1w
         OFhCGA0472DLyUK0eadpyaYO/4DC4x9wgIYj7CFQzEB5ItH5TlMvZ6smIi9ZuSZHrs3k
         ug1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=eoQ/LwxD/ih1GkSzZAuNDCG4MFgTBugN1T3/2DGPiZs=;
        b=q884srQQQT8z5MZnc6pBCTg6hwcSFO8U47BcJCZE4HB+7/p0lr9hgHOrzxdXjVSmuQ
         hXiQ5BEJafjTYstA6g6dh6SHUjBvr3NJLB6cTrHwUHWf18Ca9VBUVZtlu4H/7Hi+7JKp
         r3f4P7/9jXeBOznsnDeNdh1qUlzG+2OCuunYsIxhF4Iq8Sos68oYdnJQjgXFvPcAhEUs
         hAstBaI8W1YOfjYjD8Ocb8545OTfMbNSg/5HQ3DLCvnOvLo+pIfvvHYU1uei5jIupveh
         lrfzy8Xl4q7hewNxe4Z2AvrtbmjBbIdi1CKFFP6rPxz3nql3rARjS7zglHr8KJWBI68b
         NO+Q==
X-Gm-Message-State: AOAM530QVYHpWrBiimqw514dpbNFtXkocQnOvZi42yi9gFrSTg2WfMsA
        /ucJlO5+k8Q3UA1aMormXgk=
X-Google-Smtp-Source: ABdhPJx3fJ5NMur2QabrYd8SbuDPn+ucw/Y2KQhW0ZjSvTZ4CKF894JI3odsrwCaY4K3YJtHsNHdhQ==
X-Received: by 2002:a62:1610:: with SMTP id 16mr8430154pfw.113.1595589160574;
        Fri, 24 Jul 2020 04:12:40 -0700 (PDT)
Received: from gmail.com ([103.105.153.67])
        by smtp.gmail.com with ESMTPSA id n137sm5979404pfd.194.2020.07.24.04.12.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2020 04:12:39 -0700 (PDT)
Date:   Fri, 24 Jul 2020 16:41:18 +0530
From:   Vaibhav Gupta <vaibhavgupta40@gmail.com>
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Bjorn Helgaas <bjorn@helgaas.com>,
        Vaibhav Gupta <vaibhav.varodek@gmail.com>,
        Jens Axboe <axboe@kernel.dk>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [PATCH v1] ata: use generic power management
Message-ID: <20200724110923.GA1175768@gmail.com>
References: <20200724110630.1219882-1-vaibhavgupta40@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200724110630.1219882-1-vaibhavgupta40@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

This patch is compile-tested only.

--Vaibhav Gupta
