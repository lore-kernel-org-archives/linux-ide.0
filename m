Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34D84C433B4
	for <linux-ide@archiver.kernel.org>; Tue,  6 Apr 2021 15:25:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E6B40613CA
	for <linux-ide@archiver.kernel.org>; Tue,  6 Apr 2021 15:25:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345619AbhDFPZ0 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 6 Apr 2021 11:25:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345617AbhDFPZ0 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 6 Apr 2021 11:25:26 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C60E1C061756
        for <linux-ide@vger.kernel.org>; Tue,  6 Apr 2021 08:25:14 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id k23-20020a17090a5917b02901043e35ad4aso9857065pji.3
        for <linux-ide@vger.kernel.org>; Tue, 06 Apr 2021 08:25:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=eAGmN/IP1sbbvp9GcvrDEjCal2kH3z1B8m1lH1SKGHQ=;
        b=KXPvmU31dtnRnJHnw0lFVAf/R1G+7kBjCZQ+LxBmomBYnx1AkcTO/bx0DwiUH+eyde
         ghbElRjaPwXnZSHMJKLhOweclkqVQFmEvIS1aY1mhTv8iguO5kNaSqpXXvuuQP4XOLs1
         dl9fwfrBuqZbBN+9U/twVDw7PbQWc4C1KfAUV+zxPx5aE4CI6bYmBFKZ4lsbarugd3am
         +fg6iA2Tl20BFTzLv1Uidau4yizxj2XWLIgMgVHJFm2lCG5+GYKUaC7j4WmG/tcSpfuY
         GVaTUqmkNkPK2QugcYELYMj3pmOyCab+2Umxan8an8D9NZ1RBVLVAVskWRNp78sagStv
         LzFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=eAGmN/IP1sbbvp9GcvrDEjCal2kH3z1B8m1lH1SKGHQ=;
        b=tbv0dzBvPNzCKN+odOuLbu7UdpnfVkLmT4ZNhiNu+0LxTjMBak66+kL35INbp0IKTk
         rq4Y7ojzZhD1Z/99XL36ddl1RyYYjkpcr31olCAZRIyCaamwZQHjQKE2hVo7DPWwL0XQ
         L/XrbV04ml4TpTqVII1gEAfVFdUafOTmIZttrQgOyDYukRP4si268eoPOL/AF8DImH1P
         reLNO778xFHbtW8gSH89KqHxkOb2MBG+ygvXxHWJ8IbQMgpRzTICG4khnX3DtoIbncR+
         xFvOttzwU6AybhrtslELRK3NLcsrMEYLEKGxXnI+Ffvj38S6qM14tTzKy8kbzXyz2Fjt
         UYUw==
X-Gm-Message-State: AOAM5317SPek7p3cGhPb3kEuXIIKorETNMAOv6FM8wD/FXGTuYqkCUEO
        pA/OgByVbAonGnx1n2aZM+yA85zBD7EOag==
X-Google-Smtp-Source: ABdhPJxGY52WpxrenfGYJu+3epgVuioinc7x0bsvZEgfwshCOF0GFITdIvHt6zJyQ8WUYUj72kBF1Q==
X-Received: by 2002:a17:90a:5d10:: with SMTP id s16mr4784671pji.204.1617722714358;
        Tue, 06 Apr 2021 08:25:14 -0700 (PDT)
Received: from [192.168.4.41] (cpe-72-132-29-68.dc.res.rr.com. [72.132.29.68])
        by smtp.gmail.com with ESMTPSA id w26sm18345866pfn.33.2021.04.06.08.25.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Apr 2021 08:25:13 -0700 (PDT)
Subject: Re: [PATCH V2] ata: ahci: ceva: Updated code by using dev_err_probe()
To:     Piyush Mehta <piyush.mehta@xilinx.com>
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        git@xilinx.com, sgoud@xilinx.com, michal.simek@xilinx.com
References: <20210305091029.23378-1-piyush.mehta@xilinx.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <f52a947e-75d3-2d88-6ef6-4d2d08bbba7a@kernel.dk>
Date:   Tue, 6 Apr 2021 09:25:15 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210305091029.23378-1-piyush.mehta@xilinx.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 3/5/21 2:10 AM, Piyush Mehta wrote:
> Updated code with already prepared dev_err_probe(). It reduces code size
> and simplifies EPROBE_DEFER handling.

Applied, thanks.

-- 
Jens Axboe

