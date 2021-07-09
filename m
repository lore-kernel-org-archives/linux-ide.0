Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64C09C07E99
	for <linux-ide@archiver.kernel.org>; Fri,  9 Jul 2021 14:28:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 458276120D
	for <linux-ide@archiver.kernel.org>; Fri,  9 Jul 2021 14:28:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231942AbhGIObe (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 9 Jul 2021 10:31:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231797AbhGIObe (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 9 Jul 2021 10:31:34 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EC71C0613DD
        for <linux-ide@vger.kernel.org>; Fri,  9 Jul 2021 07:28:51 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id d9so12595678ioo.2
        for <linux-ide@vger.kernel.org>; Fri, 09 Jul 2021 07:28:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=VyEDlbEpOJeUhzC1Z+eWRe1fj1oBBaYPYIFuyTV164Q=;
        b=dVqhFY7h5WRTIaFhkwOAc9Mg4HXJBJCvu0KhBxnR1+zZT9h6UnMlG7NLxHULlv/Nk/
         3JYvrVzdDDN7uT6YePPedsKeGmDU03FX/shVt772BdjCNgcPCDTx7jsxofI1WdqFt9bl
         t1QcqQzANij7/4/PNxWksOaSK+V8mVdLwGfo1eog7NP0ZjPMSgfs9cHfCuKMqeuWqYW+
         acQaobm698Rrecxl1sivdsuPdGGKuI41pHmuXmZdwdmkpov9sAR1Kj1i/btL4iX927c3
         bST/32uVCtw/gGcxJy/xif/yG0LcILzQm/TK2VIlMHW/T6rmf4Hto2G5DbWenjma9dOq
         TUtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VyEDlbEpOJeUhzC1Z+eWRe1fj1oBBaYPYIFuyTV164Q=;
        b=rC62TppDWUS5G3T8+2HEiBFlh12UOT2taKafMNZbqvaimp7xViM5x+I14+gXv5iwxI
         6P3FiFDu1XosRRUlhM85yKTBTeN3KM9bxoG/y/igpZr1gw2IrlmFNKVpc8h5Bo89JoWi
         n+JszorbQISYn4rwzciswrZ+Q370GBltshJNfuLl8Vchxr45Agv360IXnoz3n6+7R9CS
         oHygNFRWBGTNwprfdPZokwhFQ89snsoaoAfW1wGj2KHv1y0KNeuoj5d/DCn/xXRWEKrI
         LNe/P7/yyTbsFU8xLANUr18xo4uJUVMx9YpiUMiP9G7PsU3vFYfeP0VyMia5dJLfTBGm
         RN7A==
X-Gm-Message-State: AOAM533G2GcomfxKuExGmsgYDhTVi37XKANf7I74+9RpnpBNgWBubFkA
        IX9ni5jrOA5p9Poy3NUiLC0Oig==
X-Google-Smtp-Source: ABdhPJy09vfupmSSA29QlFDJO3Z46pUWdkxKIgUzH+LXmKKeWTNJkh2Ra13rHvLwXI/Xv83R83Btag==
X-Received: by 2002:a5d:9acb:: with SMTP id x11mr29077421ion.133.1625840930583;
        Fri, 09 Jul 2021 07:28:50 -0700 (PDT)
Received: from [192.168.1.134] ([198.8.77.61])
        by smtp.gmail.com with ESMTPSA id g17sm3033373ilc.12.2021.07.09.07.28.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Jul 2021 07:28:50 -0700 (PDT)
Subject: Re: [PATCH] libata: fix ata_pio_sector for CONFIG_HIGHMEM
To:     Christoph Hellwig <hch@lst.de>
Cc:     torvalds@linux-foundation.org, linux-ide@vger.kernel.org,
        kernel test robot <oliver.sang@intel.com>
References: <20210709130237.3730959-1-hch@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <3dc3df80-c393-90c3-4bcd-79cfed291035@kernel.dk>
Date:   Fri, 9 Jul 2021 08:28:48 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210709130237.3730959-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 7/9/21 7:02 AM, Christoph Hellwig wrote:
> Data transfers are not required to be block aligned in memory, so they
> span two pages.  Fix this by splitting the call to >sff_data_xfer into
> two for that case.
> 
> This has been broken since the initial libata import before the damn
> of git, but was uncovered by the legacy ide driver removal.

Applied, thanks.

-- 
Jens Axboe

