Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6B3BC4360C
	for <linux-ide@archiver.kernel.org>; Wed,  3 Mar 2021 22:06:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 96EEC64E51
	for <linux-ide@archiver.kernel.org>; Wed,  3 Mar 2021 22:06:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1390251AbhCCWBn (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 3 Mar 2021 17:01:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237139AbhCCSjF (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 3 Mar 2021 13:39:05 -0500
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 724FCC061756;
        Wed,  3 Mar 2021 10:37:19 -0800 (PST)
Received: by mail-lj1-x233.google.com with SMTP id r25so29029318ljk.11;
        Wed, 03 Mar 2021 10:37:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=pt7Qq84uJD3NGZlgPolPLzdJ6R6eL8iRHjw/6ejjjHY=;
        b=p4X5lvKDf27wpgOK3gj/2aFrVa7ILrUdNWOJa9IXI8ZMcsi3kCqTNE6PJwsCdiYZ5c
         TxwU/hjZrTPfXuDK9xR4eROq3Ag62nxq3uMZPqNT2NZ6nD0dCHOvs1HOvX7FFabbpLm+
         8WVGmI3y0+cTrG8DHNXrs5IkEL3Gc3CL8TNbW2T5fZW/+yz3Y/Nma4xMF0th4+I9lXUo
         uX8gcolDO+D5n6BGVrYewUa2ki8EGjvNYZfhMeWxD7/6V5Y6GTG9G7We/CUHnHUoGO3e
         6ISb/xL0U9Q8zpxkghTx8wO9CWlb/gEG+p2jL4HRZOKybs7i5eAsHgqTbsu0Zxa0iACn
         NdqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pt7Qq84uJD3NGZlgPolPLzdJ6R6eL8iRHjw/6ejjjHY=;
        b=tKIjty6a/t8zLOeOT4ryC32xNDyOD8Dek1WDdnVl7uo2r8aJy7wDFqjI6sarFOcUxa
         dhsqGpCY59fvTEbESkorkJODl+ywaLefZjf9u1tIuOn7LahTq5HD4sZsKb34kFEYxl3U
         xXY8FdXdph0TL3VvYkjTh4Ptx3Y2SJ2gg5mlwW6foz/OPJMc9aNa7H3WqiusQgPYdwYG
         /hDxZZDiCBS5rGFnHGFZtpN7QnNTsLRa1O3lxCCaY1q4n5YCska9QK+9dIB/eK6g5tKi
         hhBx2HLVSFGwbLsHYnAceHbVDrA8oPkxVjMdra3cVteMp6qbyBhnUEyqtAsSNUg68vEo
         r5DQ==
X-Gm-Message-State: AOAM532h0GOEzdskK7uMXyOR8tAZRKE6gk7j2SxQw14rEEGmILI0Lapg
        mo1gBlYo/l0d5OzqVhWJlB5zof8IYRM=
X-Google-Smtp-Source: ABdhPJz505TqHNlMWfMFMAWKMEVxII5n2Q4NZ2CI5tAncJnkZa1uHynNA+yYAJDm5fqRS/LCuKsL7g==
X-Received: by 2002:a2e:8596:: with SMTP id b22mr151467lji.482.1614796637760;
        Wed, 03 Mar 2021 10:37:17 -0800 (PST)
Received: from [192.168.1.101] ([178.176.73.79])
        by smtp.gmail.com with ESMTPSA id q3sm3226649ljb.64.2021.03.03.10.37.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Mar 2021 10:37:17 -0800 (PST)
Subject: Re: Toshiba TC86C001 support
To:     Christoph Hellwig <hch@lst.de>, linux-ide@vger.kernel.org,
        linux-mips@vger.kernel.org
References: <20210303072708.GA8575@lst.de>
From:   Sergei Shtylyov <sergei.shtylyov@gmail.com>
Message-ID: <98fb1689-0ae4-96a2-9e21-3d4178d5337d@gmail.com>
Date:   Wed, 3 Mar 2021 21:37:15 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210303072708.GA8575@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 3/3/21 10:27 AM, Christoph Hellwig wrote:

> a lot of te mips defconfig enable CONFIG_BLK_DEV_TC86C001, which is

   Well, grep'ping in arch/mips/configs/ gave me a surprise! TC86C001
is enabled in couple Malta configs and even in the Big Sur config, and
not enabled in any TX39 or TX49 configs... :-/

> a legacy ide driver that has no libata equivalent.  We plan to
> phase out the legacy ide driver this year, so I'm wondering if this
> hardware is still in use by anyone, and if yes how we can get a libata
> driver for it?

   There's hardly a lot of sense in using the Toshiba's PCI card on those
platforms, so I think these configs should be easy to clean up of the TC86C001
IDE option. :-)

MBR, Sergei
