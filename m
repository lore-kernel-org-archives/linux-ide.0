Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA76EC2B9F4
	for <linux-ide@archiver.kernel.org>; Thu, 17 Jun 2021 09:50:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B052E6113C
	for <linux-ide@archiver.kernel.org>; Thu, 17 Jun 2021 09:50:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229872AbhFQJwL (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 17 Jun 2021 05:52:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231881AbhFQJwL (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 17 Jun 2021 05:52:11 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41022C06175F
        for <linux-ide@vger.kernel.org>; Thu, 17 Jun 2021 02:50:03 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id a11so6002757wrt.13
        for <linux-ide@vger.kernel.org>; Thu, 17 Jun 2021 02:50:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=+H6wKF7xQqNDFdYl9az7WY1nv2FLyIYMEfN7sgkUEiY=;
        b=hF8XnvEXgLP2ROnnuJGuHofsPQsTcvxklfJnozKtQ8v0kfdn3LQMQnUyx52IkmJs48
         28av2eC5sXu/LuF5QawXFF3a0GYNEOLjTGA+UeIPqH9eelnaCqHDaypRq+R18b3d+yv2
         byhBC0Asb1jBvCaz2ycl7FcQCw12oUsM/sVx7Y2jVAWO/vlZk715TyaXc+EVaa7czF30
         gJshpjuCG1CnYThSBeDCy5znZoIl+PkntuqTUXVj7Npv2OwYXxCRIp8zBft5EWd7TzS4
         8osbHqBFdqwa6qBd6vr6L3UwrqQpLdzOkOKhF0php4qDQ+w+kH4qxvOV3zZDfbqj3T2k
         DKDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=+H6wKF7xQqNDFdYl9az7WY1nv2FLyIYMEfN7sgkUEiY=;
        b=njGZfezAXR6XlAvb1JAKCNRRfeBwY8b+YId8ne4e7c2VdNdzmTe2AE6YQLhP0YitwB
         aOkYy5ZbzKq1gAeVp75flkR7i7kROB2t1TgzwmJdhvsm5D9xc6j1kM2hT4+LS/XaM84z
         0DcAKVauvVu/v231fDexzIBzZJWdt0g367N2ee/1Yft2QckjFRZMU1NxVEw8h52BzY0g
         XnhGB2yZIdmxBcZQoUyynJPJ16j84Qw11Vxz1F7n7PHMNQMEkDF/Tg+2DGYHE2tuOjat
         IE8UFgwZC5MQNyPPkR+z5NxmBd+a7v9J3YB+DomYLaYAd4+whwHSNhtvt7gBvfHz+Mti
         7T7g==
X-Gm-Message-State: AOAM532JgV3X63Xh1SZEdAMDzjPn81kJjmX8d4rQi0GZSN7yfnzWuF8N
        t7PjCLseFP+hcNhXI733gWnvOQ==
X-Google-Smtp-Source: ABdhPJzbnOjdea5+8A1wqVqc/KbTUeYF9C+JRetN46EbNO3fLfhkVr94LppHFXoFPVqUNzu8ZJI25g==
X-Received: by 2002:adf:d1cb:: with SMTP id b11mr4555597wrd.186.1623923401873;
        Thu, 17 Jun 2021 02:50:01 -0700 (PDT)
Received: from dell ([91.110.221.170])
        by smtp.gmail.com with ESMTPSA id a1sm6390704wra.63.2021.06.17.02.50.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jun 2021 02:50:01 -0700 (PDT)
Date:   Thu, 17 Jun 2021 10:49:59 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        ALWAYS copy <linux-ide@vger.kernel.org>,
        Andre Hedrick <andre@linux-ide.org>, ATI Inc <hyu@ati.com>,
        benh@kernel.crashing.org, Mark Lord <mlord@pobox.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 00/11] Rid W=1 warnings from ATA
Message-ID: <YMsaxwTWvbABmA1c@dell>
References: <20210528090502.1799866-1-lee.jones@linaro.org>
 <463f14c8-c597-2b29-88ff-2929df55acdd@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <463f14c8-c597-2b29-88ff-2929df55acdd@kernel.dk>
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On Wed, 16 Jun 2021, Jens Axboe wrote:

> On 5/28/21 3:04 AM, Lee Jones wrote:
> > This set is part of a larger effort attempting to clean-up W=1
> > kernel builds, which are currently overwhelmingly riddled with
> > niggly little warnings.
> 
> Queued up for 5.14, thanks.

Ideal.  Thanks a bunch Jens.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
