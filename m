Return-Path: <SRS0=iOC6=5U=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 762DCC2BA15
	for <linux-ide@archiver.kernel.org>; Sat,  4 Apr 2020 19:58:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42154206E6
	for <linux-ide@archiver.kernel.org>; Sat,  4 Apr 2020 19:58:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="fxQvOM9L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726329AbgDDT6L (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sat, 4 Apr 2020 15:58:11 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:42474 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726297AbgDDT6L (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sat, 4 Apr 2020 15:58:11 -0400
Received: by mail-lf1-f68.google.com with SMTP id s13so8570961lfb.9
        for <linux-ide@vger.kernel.org>; Sat, 04 Apr 2020 12:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fteReWnRxKhJdJWjlTSPXgrS3vLMPMuiU4lJg9jIfSg=;
        b=fxQvOM9Lay46fYPKSDwRyjYD4lXBlyxEjdno5ma6bzlVNdYRGOuWf/tbaUv/55Q2lP
         EVY09E/9dAK2jBbFJeg9lDuSAWqqeksSjOU37unrtRrFJyhzd6tATm71K8eXlp2Gr+Xf
         un6AHFnxDD9q+D16pjQltDO0eaN61u+s+/mBaAdzSsY8AvFnCUZgVRf9CJetzRN4ZpVM
         bF/w1Kf5Oi7aqHjrJLTNEbsQOTHkYDaGfmER7lPy2oCVuWIJthlpUotXne6dcIlvr6NR
         w4XcTrX8P4vmYX8fYB4/ajJSYBOUTjKlTtOdGFhR2m+on9qo3p4kPeGCbzdSr+v7AFxw
         8egA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=fteReWnRxKhJdJWjlTSPXgrS3vLMPMuiU4lJg9jIfSg=;
        b=FWuhr4F3qMxHBtrrzZpn1KWVQT+4fIcqj0Rvv3t7zs3TX7/AeM1z37sAMNYz55k/Z0
         kqJzGit/XeYw3HkO3tbN/599wGwYhCulHkGEok598y9eore7qCntA0gJ4wecWFpIj8js
         UKo0KTpkLc8T9KVBJ5Iaz2HJ+Y/QW9Uf/kLeDuoQOHTExgIWnB+p8JKhYbHYq9r/zLsQ
         HlluaoYAvg1h3Cl702w5ODBhEJwHsMKF4y4HO296vkrWbXKtofPF0Adivg5nPsKMC/EN
         vQJ0kjdVTznXyvyADcYkKIBAbZM4hzaUVIoaupKZfNmdSDiaKxmOlOsdNikBkFKZwkm6
         bH8A==
X-Gm-Message-State: AGi0PuZWD10G5uWNVjthxvawaN0BCyx6m7Ik+4Zbl1wlMy7pYGEhAPg4
        NpeGP2npLex4Zvv0M3pTjGntxg==
X-Google-Smtp-Source: APiQypKdP67XgZkBynzeqRe85FshGKIefaHHc1NIHPIiUZ8B4LhIHwK14iHkq0dRQYef5S2pU2TzEA==
X-Received: by 2002:ac2:4554:: with SMTP id j20mr905472lfm.91.1586030289580;
        Sat, 04 Apr 2020 12:58:09 -0700 (PDT)
Received: from wasted.cogentembedded.com ([2a00:1fa0:44d4:5e2:6cf1:70e1:48ed:4ff5])
        by smtp.gmail.com with ESMTPSA id 64sm1352580lfh.32.2020.04.04.12.58.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 04 Apr 2020 12:58:08 -0700 (PDT)
Subject: Re: [PATCH] ata:ahci_xgene:use devm_platform_ioremap_resource() to
 simplify code
To:     =?UTF-8?B?5ZSQ5b2s?= <tangbin@cmss.chinamobile.com>,
        axboe <axboe@kernel.dk>
Cc:     linux-ide <linux-ide@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20200401084952.5828-1-tangbin@cmss.chinamobile.com>
 <c1cfde01-769d-2904-3be3-a41cc51c1519@cogentembedded.com>
 <202004011744223003066@cmss.chinamobile.com>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Organization: Cogent Embedded
Message-ID: <84628923-02d6-ae1e-fb23-373ad090d706@cogentembedded.com>
Date:   Sat, 4 Apr 2020 22:58:06 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <202004011744223003066@cmss.chinamobile.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-MW
Content-Transfer-Encoding: 8bit
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Hello!

On 04/01/2020 12:44 PM, 唐彬 wrote:

>         I think the previous code in memory resource #4 to use 'csr' maybe useless，if
> devm_ioremap_resource() failed，the function will return, the 'ctx->csr_mux = csr'  will 
> become useless。So I do the same way as the other three。This's my idea, please criticize
> and correct it。Thank you very much!

   I was unable to understand what you mean here.
   My point is that the driver happily works if the MUX registers do not exist, and your
patch makes the driver fail the probe in this case. Even if this was correct, it's usually
a bad idea to do several thing in the same patch. So, you'd need a patch changing the probing logic before you convert things to devm_platfrom_ioremap_resource()...

[...]

MBR, Sergei
