Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C7B5C43460
	for <linux-ide@archiver.kernel.org>; Tue, 20 Apr 2021 20:53:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9FA30613DB
	for <linux-ide@archiver.kernel.org>; Tue, 20 Apr 2021 20:53:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234011AbhDTUxf (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 20 Apr 2021 16:53:35 -0400
Received: from gateway22.websitewelcome.com ([192.185.47.79]:22203 "EHLO
        gateway22.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234012AbhDTUxf (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 20 Apr 2021 16:53:35 -0400
Received: from cm17.websitewelcome.com (cm17.websitewelcome.com [100.42.49.20])
        by gateway22.websitewelcome.com (Postfix) with ESMTP id EA81E1FA8C
        for <linux-ide@vger.kernel.org>; Tue, 20 Apr 2021 15:30:31 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id Yx0xlOfthMGeEYx0xllIGM; Tue, 20 Apr 2021 15:30:31 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=xIgk/tQP1zI2LyN43v7yXlJqm7zSlmXS7uX1Qbz5RlA=; b=aZwGL/Emls0gn5WCaEvRxG3OoQ
        bvnd4UUk6PohPvM8UratviMgFzqIAR19zx5b/2IVmbcXrN64KVqzEKBmnttexwPazY6jS24ampqfG
        Ae8P+4B3p3jBGq2JorGyepfLihxc+M5BSQdFlZw7u0CeccgwwWrkMLOiXamEWBZBaqEcOKp4I7jq1
        QhIgOzxL1qcVSEk9UGoN2xg3+zWKi08Wu6vy2hxOmVlyxFTe3eIxp75q6T/2UpnTzIQEI5Xm20iWd
        a+CKO/h5b8SshY4fgoHVzvyv+EcmnD+0JgfPkxWyoMs1SHsD0Jbyiixa9gkRlxpOGGAtDxzbmk16O
        IQHHRl2A==;
Received: from 187-162-31-110.static.axtel.net ([187.162.31.110]:49084 helo=[192.168.15.8])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94)
        (envelope-from <gustavo@embeddedor.com>)
        id 1lYx0v-003Dmc-Fu; Tue, 20 Apr 2021 15:30:29 -0500
Subject: Re: [PATCH 092/141] libata: Fix fall-through warnings for Clang
To:     Jens Axboe <axboe@kernel.dk>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
References: <cover.1605896059.git.gustavoars@kernel.org>
 <e3498b34cae37d0f93db5824e5f61b183a7293f1.1605896060.git.gustavoars@kernel.org>
 <07757a90-7682-47e4-f6ab-a07b1658280c@embeddedor.com>
 <2cb77fac-21c3-6ba9-2f8f-0ff154ad4459@kernel.dk>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Message-ID: <e8bda1d9-2ba3-2f3e-942f-35c7282ba389@embeddedor.com>
Date:   Tue, 20 Apr 2021 15:30:45 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <2cb77fac-21c3-6ba9-2f8f-0ff154ad4459@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 187.162.31.110
X-Source-L: No
X-Exim-ID: 1lYx0v-003Dmc-Fu
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187-162-31-110.static.axtel.net ([192.168.15.8]) [187.162.31.110]:49084
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 226
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org



On 4/20/21 15:23, Jens Axboe wrote:
> On 4/20/21 2:11 PM, Gustavo A. R. Silva wrote:
>> Hi all,
>>
>> Friendly ping: who can take this, please?
> 
> Applied for 5.13.
> 

Thanks, Jens.

--
Gustavo
