Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 166C9C433ED
	for <linux-ide@archiver.kernel.org>; Tue, 20 Apr 2021 20:57:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E495B613ED
	for <linux-ide@archiver.kernel.org>; Tue, 20 Apr 2021 20:57:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234019AbhDTU61 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 20 Apr 2021 16:58:27 -0400
Received: from gateway20.websitewelcome.com ([192.185.65.13]:25015 "EHLO
        gateway20.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233961AbhDTU61 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 20 Apr 2021 16:58:27 -0400
Received: from cm16.websitewelcome.com (cm16.websitewelcome.com [100.42.49.19])
        by gateway20.websitewelcome.com (Postfix) with ESMTP id 755F640173506
        for <linux-ide@vger.kernel.org>; Tue, 20 Apr 2021 15:00:30 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id YwiYlhUIxb8LyYwiYljNx4; Tue, 20 Apr 2021 15:11:30 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=MqEZ3MVN0qNXPBkb0gj5u34hSyQ5o4MMhVAkGFI6Who=; b=owIJueT+KP6/yAOKySClXCxgta
        FslpVfZCho2J/DixcNmwX6tIn8k3i0TqqEFGOPuXE5RsXmnR62gqkDF4QyYNEYvyEK0u10HsiZKsy
        ZjDLgn4mk4Udq2IThE65dAeWV3T5FBqX0OT1W+8zr02LJv/+R77EeFNHZGVpv6TiacHXrz5ovYZOJ
        imQ0OoKSAcnoNWSEu9cLlozWRkycxe7DuTmjRSE3BTKFOjvbSJipJIzAKiYmDcbQYi7GbNmEXp6z1
        PLL4hOtrICA4CkDn4lLcssmWNvg4pxxlllvTE0Yl42HHfvW6tgq5kHB1f+fMH3GThS8UDVedfb/hH
        oqfvFDfQ==;
Received: from 187-162-31-110.static.axtel.net ([187.162.31.110]:48962 helo=[192.168.15.8])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94)
        (envelope-from <gustavo@embeddedor.com>)
        id 1lYwiW-002i0G-Fn; Tue, 20 Apr 2021 15:11:28 -0500
Subject: Re: [PATCH RESEND][next] ide: Fix fall-through warnings for Clang
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        "David S. Miller" <davem@davemloft.net>
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
References: <20210305100012.GA142349@embeddedor>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Message-ID: <b09a2a2c-5a82-3c80-7f8a-868349a1efee@embeddedor.com>
Date:   Tue, 20 Apr 2021 15:11:45 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210305100012.GA142349@embeddedor>
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
X-Exim-ID: 1lYwiW-002i0G-Fn
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187-162-31-110.static.axtel.net ([192.168.15.8]) [187.162.31.110]:48962
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 76
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

On 3/5/21 04:00, Gustavo A. R. Silva wrote:
> In preparation to enable -Wimplicit-fallthrough for Clang, fix a warning
> by explicitly adding a break statement instead of letting the code fall
> through to the next case.
> 
> Link: https://github.com/KSPP/linux/issues/115
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
>  drivers/ide/siimage.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/ide/siimage.c b/drivers/ide/siimage.c
> index 198847488cc6..c190dc6dfb50 100644
> --- a/drivers/ide/siimage.c
> +++ b/drivers/ide/siimage.c
> @@ -493,6 +493,7 @@ static int init_chipset_siimage(struct pci_dev *dev)
>  	case 0x30:
>  		/* Clocking is disabled, attempt to force 133MHz clocking. */
>  		sil_iowrite8(dev, tmp & ~0x20, scsc_addr);
> +		break;
>  	case 0x10:
>  		/* On 133Mhz clocking. */
>  		break;
> 
