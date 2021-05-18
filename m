Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F8E8C433B4
	for <linux-ide@archiver.kernel.org>; Tue, 18 May 2021 00:54:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE1136139A
	for <linux-ide@archiver.kernel.org>; Tue, 18 May 2021 00:54:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238543AbhERAzZ (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 17 May 2021 20:55:25 -0400
Received: from gateway33.websitewelcome.com ([192.185.145.9]:32975 "EHLO
        gateway33.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235791AbhERAzY (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 17 May 2021 20:55:24 -0400
Received: from cm12.websitewelcome.com (cm12.websitewelcome.com [100.42.49.8])
        by gateway33.websitewelcome.com (Postfix) with ESMTP id AD8342452F
        for <linux-ide@vger.kernel.org>; Mon, 17 May 2021 19:54:06 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id inzqlpjalDedfinzql3Bfm; Mon, 17 May 2021 19:54:06 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:References:Cc:To:From:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=MGyMIu9GQK22jkoAICUtVJrFSqP2zGDq8EEVOwKTVFM=; b=lDBimvrWO1VsltFvaCP7MVpO6I
        h1ZQaFZdivF7q4G67nWKhxfzOldliwYv825wZDY+7KWgNk7zIcUmCQM0uCfoJvPGP7UN92oweVHDn
        EowAsUNmE0wvQcHR5bhs5yA4dwXRivbjSZzn59/fc9tsU+OaHHrKGvrBgQ0mStjiuf6ZyVHYPGeXJ
        8YxDlxbRjdM8paPHdczV63n1Q1n4WKlV/iUmzQRM2f9DZvVLy9MjgE8i+ibZb+lew5Cqis5npoXDB
        tIQLoD6PMPcMaQzFxQJIAymVR9NPDnzCtb3PdJz++yCsQF8hM4+6tYn2ZBwTKQE+d14o/nUdgHF15
        +PE4i8eQ==;
Received: from 187-162-31-110.static.axtel.net ([187.162.31.110]:53574 helo=[192.168.15.8])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <gustavo@embeddedor.com>)
        id 1linzo-002sXK-78; Mon, 17 May 2021 19:54:04 -0500
Subject: Re: [PATCH RESEND][next] ide: Fix fall-through warnings for Clang
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        "David S. Miller" <davem@davemloft.net>
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
References: <20210305100012.GA142349@embeddedor>
 <b09a2a2c-5a82-3c80-7f8a-868349a1efee@embeddedor.com>
Message-ID: <f6dc7620-d43a-a889-946d-6bd31c6bf413@embeddedor.com>
Date:   Mon, 17 May 2021 19:54:45 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <b09a2a2c-5a82-3c80-7f8a-868349a1efee@embeddedor.com>
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
X-Exim-ID: 1linzo-002sXK-78
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187-162-31-110.static.axtel.net ([192.168.15.8]) [187.162.31.110]:53574
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 79
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Hi all,

If you don't mind, I'm taking this in my -next[1] branch for v5.14.

Thanks
--
Gustavo

[1] https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git/log/?h=for-next/kspp

On 4/20/21 15:11, Gustavo A. R. Silva wrote:
> Hi all,
> 
> Friendly ping: who can take this, please?
> 
> Thanks
> --
> Gustavo
> 
> On 3/5/21 04:00, Gustavo A. R. Silva wrote:
>> In preparation to enable -Wimplicit-fallthrough for Clang, fix a warning
>> by explicitly adding a break statement instead of letting the code fall
>> through to the next case.
>>
>> Link: https://github.com/KSPP/linux/issues/115
>> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
>> ---
>>  drivers/ide/siimage.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/ide/siimage.c b/drivers/ide/siimage.c
>> index 198847488cc6..c190dc6dfb50 100644
>> --- a/drivers/ide/siimage.c
>> +++ b/drivers/ide/siimage.c
>> @@ -493,6 +493,7 @@ static int init_chipset_siimage(struct pci_dev *dev)
>>  	case 0x30:
>>  		/* Clocking is disabled, attempt to force 133MHz clocking. */
>>  		sil_iowrite8(dev, tmp & ~0x20, scsc_addr);
>> +		break;
>>  	case 0x10:
>>  		/* On 133Mhz clocking. */
>>  		break;
>>
