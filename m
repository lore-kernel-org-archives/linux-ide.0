Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63E9FC433ED
	for <linux-ide@archiver.kernel.org>; Tue, 20 Apr 2021 20:34:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2DF98613C4
	for <linux-ide@archiver.kernel.org>; Tue, 20 Apr 2021 20:34:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233899AbhDTUfJ (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 20 Apr 2021 16:35:09 -0400
Received: from gateway32.websitewelcome.com ([192.185.145.189]:36602 "EHLO
        gateway32.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233769AbhDTUfJ (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 20 Apr 2021 16:35:09 -0400
X-Greylist: delayed 1400 seconds by postgrey-1.27 at vger.kernel.org; Tue, 20 Apr 2021 16:35:08 EDT
Received: from cm12.websitewelcome.com (cm12.websitewelcome.com [100.42.49.8])
        by gateway32.websitewelcome.com (Postfix) with ESMTP id 27E3B72BA2
        for <linux-ide@vger.kernel.org>; Tue, 20 Apr 2021 15:11:14 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id YwiIldi0c1cHeYwiIllVGw; Tue, 20 Apr 2021 15:11:14 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=wgq0F5r6EdOY5Lu8nO1n/rw6S/6QFgbeo192rRuj0CI=; b=KMEWXClO2+3eYsDCzSMvzjP0da
        +ZFsvOhzjdzflDHKBkMmbco0WmmGxXghtW5pA+hKhMaaYB3R1zPaFDTp6KWvjXEqgeQs3DUUxyTr2
        xeMD0U/81bdxlKDbDd00+ply9yEKluOjkDZ7zr/hlT9m438KCh9nUiHTlW8HmVL38Rc35NwOzBkmm
        ymvfNy/EJhU13cv8rIt0k/nDMXBL9azHYxm7laoeUD6SNPhUWJjsx/fc4F2KzLafnsgXbPfB+UOo1
        h6lKIKhlEBiO2R5K+pDu87Tvk5VHwn+dYJuXqQMhsZylFfKfcgUFpRgrY9FxT8oqf2YNlL6y5Cv1t
        5RW+P6Jw==;
Received: from 187-162-31-110.static.axtel.net ([187.162.31.110]:48958 helo=[192.168.15.8])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94)
        (envelope-from <gustavo@embeddedor.com>)
        id 1lYwiF-002hY9-Qd; Tue, 20 Apr 2021 15:11:11 -0500
Subject: Re: [PATCH 092/141] libata: Fix fall-through warnings for Clang
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Jens Axboe <axboe@kernel.dk>
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
References: <cover.1605896059.git.gustavoars@kernel.org>
 <e3498b34cae37d0f93db5824e5f61b183a7293f1.1605896060.git.gustavoars@kernel.org>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Message-ID: <07757a90-7682-47e4-f6ab-a07b1658280c@embeddedor.com>
Date:   Tue, 20 Apr 2021 15:11:29 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <e3498b34cae37d0f93db5824e5f61b183a7293f1.1605896060.git.gustavoars@kernel.org>
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
X-Exim-ID: 1lYwiF-002hY9-Qd
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187-162-31-110.static.axtel.net ([192.168.15.8]) [187.162.31.110]:48958
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 71
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Hi all,

Friendly ping: who can take this, please?

Thanks
--
Gustavo

On 11/20/20 12:36, Gustavo A. R. Silva wrote:
> In preparation to enable -Wimplicit-fallthrough for Clang, fix a warning
> by explicitly adding a break statement instead of letting the code fall
> through to the next case.
> 
> Link: https://github.com/KSPP/linux/issues/115
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
>  drivers/ata/libata-eh.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
> index b6f92050e60c..2db1e9c66088 100644
> --- a/drivers/ata/libata-eh.c
> +++ b/drivers/ata/libata-eh.c
> @@ -2613,6 +2613,7 @@ int ata_eh_reset(struct ata_link *link, int classify,
>  			switch (tmp) {
>  			case -EAGAIN:
>  				rc = -EAGAIN;
> +				break;
>  			case 0:
>  				break;
>  			default:
> 
