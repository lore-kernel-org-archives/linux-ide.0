Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 368D2C47095
	for <linux-ide@archiver.kernel.org>; Wed,  9 Jun 2021 08:04:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 18D8061364
	for <linux-ide@archiver.kernel.org>; Wed,  9 Jun 2021 08:04:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237692AbhFIIFz (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 9 Jun 2021 04:05:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236315AbhFIIFX (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 9 Jun 2021 04:05:23 -0400
X-Greylist: delayed 315 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 09 Jun 2021 01:03:04 PDT
Received: from mail-out.m-online.net (mail-out.m-online.net [IPv6:2001:a60:0:28:0:1:25:1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48592C06124A;
        Wed,  9 Jun 2021 01:03:03 -0700 (PDT)
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 4G0KGL5cKHz1s2CP;
        Wed,  9 Jun 2021 09:57:46 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 4G0KGL4Yqyz1qr3P;
        Wed,  9 Jun 2021 09:57:46 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id iro4N3ysXr4G; Wed,  9 Jun 2021 09:57:45 +0200 (CEST)
X-Auth-Info: LIsqKLcHwpaFlDbwS02/n04035rxGS/WPR+ibJhB4L4wRah3XaACBbxYRXjkhAYg
Received: from igel.home (ppp-46-244-166-111.dynamic.mnet-online.de [46.244.166.111])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Wed,  9 Jun 2021 09:57:45 +0200 (CEST)
Received: by igel.home (Postfix, from userid 1000)
        id 6224A2C3171; Wed,  9 Jun 2021 09:57:45 +0200 (CEST)
From:   Andreas Schwab <schwab@linux-m68k.org>
To:     Michael Schmitz <schmitzmic@gmail.com>
Cc:     linux-m68k@vger.kernel.org, geert@linux-m68k.org,
        linux-ide@vger.kernel.org, fthain@linux-m68k.org
Subject: Re: [PATCH v2] m68k: io_mm.h: conditionalize ISA address
 translation on Atari
References: <1622957313-321-1-git-send-email-schmitzmic@gmail.com>
        <1623223322-4242-1-git-send-email-schmitzmic@gmail.com>
X-Yow:  YOW!!  I am having FUN!!
Date:   Wed, 09 Jun 2021 09:57:45 +0200
In-Reply-To: <1623223322-4242-1-git-send-email-schmitzmic@gmail.com> (Michael
        Schmitz's message of "Wed, 9 Jun 2021 19:22:02 +1200")
Message-ID: <874ke71nd2.fsf@igel.home>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On Jun 09 2021, Michael Schmitz wrote:

> @@ -135,10 +139,13 @@ static inline u8 __iomem *isa_itb(unsigned long addr)
>      case ISA_TYPE_AG: return (u8 __iomem *)AG_ISA_IO_B(addr);
>  #endif
>  #ifdef CONFIG_ATARI_ROM_ISA
> -    case ISA_TYPE_ENEC: return (u8 __iomem *)ENEC_ISA_IO_B(addr);
> +    case ISA_TYPE_ENEC:
> +	if (addr < 1024)
> +		return (u8 __iomem *)ENEC_ISA_IO_B(addr);
> +	break; /* not ROM port? fallback below! */
>  #endif
> -    default: return NULL; /* avoid warnings, just in case */
>      }
> +    return (u8 __iomem *)(addr); /* avoid warnings, just in case */

I don't think the comment still fits here.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
