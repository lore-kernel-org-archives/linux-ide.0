Return-Path: <SRS0=wLrF=DJ=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79989C4363D
	for <linux-ide@archiver.kernel.org>; Fri,  2 Oct 2020 20:52:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B17C2065D
	for <linux-ide@archiver.kernel.org>; Fri,  2 Oct 2020 20:52:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="yaH38mQO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725497AbgJBUwi (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 2 Oct 2020 16:52:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725283AbgJBUwi (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 2 Oct 2020 16:52:38 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98D27C0613D0
        for <linux-ide@vger.kernel.org>; Fri,  2 Oct 2020 13:52:38 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id z5so2476423ilq.5
        for <linux-ide@vger.kernel.org>; Fri, 02 Oct 2020 13:52:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=UZyjpBmoUocxKOfQ+zvNjRm1gBOP6POpyQdGrj+HPsA=;
        b=yaH38mQO1USosTmNeZmkEN+HGWbZL/Yhp7rCaVP2z5fi0of7CzAWRKLod6ao58Et8g
         7Zabu4Kwb/YhnzXACn7AidUisbolGcmaNPnMvKEJmPcPGmOpu7TDT7e8TpWkZa4tozC2
         J9XMjiPkasfJUXoiYromOv2iNp9UHEMzV2r2uVzLutQ+OHLX+MdcXX2qlDH3WX+rNWZo
         nW5/CozzzvelGGYtJDSHF5FVtvOCgwSpNAaJAwZAmm6QC0Wk8Y+mYOBMiYkgVKoHgVo0
         4mh5EucNTkZxOfnS9ghuYLrtQqXFPDmBeU5tutm3Fooe2i/R+ZSoB1/pSWfoLSOwhioQ
         0mWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UZyjpBmoUocxKOfQ+zvNjRm1gBOP6POpyQdGrj+HPsA=;
        b=ggBswOrq80eW3KxXrniSCB40QDBX0U2x6DhvwoI5/I7TglJvOECGfhZyBwvMKlh9jG
         Jd9BWDvMHdigGQc+l5mjvKWbrk7U2nMIMlOxZqqpNBgbDLprcJpbs3Sc0Nfc94BhvOIN
         0s/nt6XJvoRt0uMb5op+QLgUGPq/wjLm5NEJbvdyIXK6Fn/de6MrY/nfZ9A1uXZSnevb
         S/bNKNuTlHvfCoyHGaG8jPp0XKQNfI0BVAjflJnP/OrKjZgmi9Ul06Fn8KOjeM8uwJoY
         EPg+V+Y4X3TOaQzCyq8byZN+OezrBhTzBj4yRP+JylppGKbehyMMNvafWjRjXYkAM2vk
         91Pg==
X-Gm-Message-State: AOAM530LTZqhfEhuvO8r56omIshJbQKwweZUkmBhKonKsNmVAi+vAnoz
        yDHY5cFSJPj5W+iX9NBUcrYSG4iQ6enpXA==
X-Google-Smtp-Source: ABdhPJwazyAixESeZXRcZDcI0ehkP8bD7q0ahZQt2I+2ZjGH+pZEorjj/yrOTlTTEQtPLIehlgoYXg==
X-Received: by 2002:a92:8e03:: with SMTP id c3mr3386781ild.16.1601671957836;
        Fri, 02 Oct 2020 13:52:37 -0700 (PDT)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id l7sm1400004ili.82.2020.10.02.13.52.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Oct 2020 13:52:37 -0700 (PDT)
Subject: Re: [PATCH] ahci: Add Intel Rocket Lake PCH-H RAID PCI IDs
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     linux-ide@vger.kernel.org
References: <20201002094035.57329-1-mika.westerberg@linux.intel.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <8d0a3d54-ea80-b0bc-1752-8e9a42bb47c2@kernel.dk>
Date:   Fri, 2 Oct 2020 14:52:36 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201002094035.57329-1-mika.westerberg@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 10/2/20 3:40 AM, Mika Westerberg wrote:
> Add Intel Rocket Lake PCH-H RAID PCI IDs to the list of supported
> controllers.

Applied, thanks.

-- 
Jens Axboe

