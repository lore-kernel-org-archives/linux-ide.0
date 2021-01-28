Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B7ADC433DB
	for <linux-ide@archiver.kernel.org>; Thu, 28 Jan 2021 18:30:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 34FC364E22
	for <linux-ide@archiver.kernel.org>; Thu, 28 Jan 2021 18:30:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232070AbhA1SaN (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 28 Jan 2021 13:30:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231460AbhA1S15 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 28 Jan 2021 13:27:57 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DBB5C0613ED
        for <linux-ide@vger.kernel.org>; Thu, 28 Jan 2021 10:27:17 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id m1so2072578wml.2
        for <linux-ide@vger.kernel.org>; Thu, 28 Jan 2021 10:27:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=FHRjyjYE89qGrg3Y3Q4173ZyrozQfcKIJRYji1qkDFM=;
        b=nRD5KHmNsZcktF/igWymXoXQ/aOFphiF4N1QJKg5TLO8qOtCZ0IkUi3Y829Z4//4dc
         yFMj16HxlEFCQ6bVR34sYJaUq1DTTpNttjF8DuOoO81iBfehJOVVpHv6bYdI+K3tQiGH
         jTcYrSETFLLNcMeB2Z6/rFr3009PbTB5xWqYQOKlrlKlxV+4hf46LIRvtrclyv+KF5tg
         dfUu6RX/D3/x4wm+FXnVxm7Zuci9Mxg+KbRX4lPrcXNu01abyB7fhXbEikwCRNNXfiQf
         aNKF5PH0xIu3V0A+fYH7YldMGhrkbzYSsUSFWXC5X0P3Pbt4il4vKA8dpCWiLBdah0X1
         CSVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=FHRjyjYE89qGrg3Y3Q4173ZyrozQfcKIJRYji1qkDFM=;
        b=WT47aLfwFWfNPDEZc7e7T2owa3xWdmPeBQQBe3rO/cGZ1Vh6g+WLN78nIdKexLeJfH
         Wyi31SvASF+5HQDxcKEbLm1WYCAYoAeFmUbkrDgGaCX7LdsWr2d7Xlc8OAbmR8Tg/lwv
         9OvfYBRSlYKzSXFuUwD/1We2TtsG73MqfA0cEwz2e9CnjbfnxoT9OFmrt0rhZTtwcNR5
         EJa3SejnunNWrZnAU2f5xNMBNpnApernVJsAAHO9ph5PW/n5tN8YRK9SZHRAmYo3l5+x
         ZN/kotJnPCp4ar/S1/cXTdSkRXcoqf1qdTibPfGRXsgqc+Kz/fHhfD0MHFTTcu7/Oi5v
         +CFw==
X-Gm-Message-State: AOAM530/rOR8ve1VvwLt9oNF63enjftPCCjLnR1y622ZcrRO7U8PKW60
        PS5yUzP+X+0aSMH2bKbOtEK09w==
X-Google-Smtp-Source: ABdhPJxBSl6KKb9jx4AcBh1+S1MdD8ooOlSLI5Je5HBovcwouAW5yWRC5WCMBZBaHxfab8wvPNYfFQ==
X-Received: by 2002:a1c:a406:: with SMTP id n6mr509739wme.53.1611858435697;
        Thu, 28 Jan 2021 10:27:15 -0800 (PST)
Received: from dell ([91.110.221.188])
        by smtp.gmail.com with ESMTPSA id l84sm6827558wmf.17.2021.01.28.10.27.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jan 2021 10:27:15 -0800 (PST)
Date:   Thu, 28 Jan 2021 18:27:13 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        linux-ide@vger.kernel.org
Subject: Re: [PATCH 01/20] ata: ahci_dm816: Ignore -Woverride-init
Message-ID: <20210128182713.GM4774@dell>
References: <20210128180239.548512-1-lee.jones@linaro.org>
 <20210128180239.548512-2-lee.jones@linaro.org>
 <20210128181903.GA2099675@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210128181903.GA2099675@infradead.org>
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On Thu, 28 Jan 2021, Christoph Hellwig wrote:

> On Thu, Jan 28, 2021 at 06:02:20PM +0000, Lee Jones wrote:
> > Some ATA drivers use the SCSI host template, a series of interwoven
> > macros, to aid with initialisation.  Some of these macros conflict,
> > resulting in the over-writing of previously set values.
> 
> Please just disable this warning globally.  This is a sensible
> patter and we should not sprinkle per-file options for something
> that fundamental.

Will do.  Just as soon as I've figured out how. :)

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
