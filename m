Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44F98C48BCD
	for <linux-ide@archiver.kernel.org>; Wed,  9 Jun 2021 08:04:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E34A6128A
	for <linux-ide@archiver.kernel.org>; Wed,  9 Jun 2021 08:04:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236756AbhFIIGo (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 9 Jun 2021 04:06:44 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:48335 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237731AbhFIIGL (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 9 Jun 2021 04:06:11 -0400
X-Greylist: delayed 376 seconds by postgrey-1.27 at vger.kernel.org; Wed, 09 Jun 2021 04:06:08 EDT
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 4G0KPf68ylz1qv9X;
        Wed,  9 Jun 2021 10:04:06 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 4G0KPf5ZrLz1qr3M;
        Wed,  9 Jun 2021 10:04:06 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id XIir5Iq8mtuX; Wed,  9 Jun 2021 10:04:06 +0200 (CEST)
X-Auth-Info: beSZl78YBRusfkLRKiXWhp6fn9LTGos5iAQUrB1J9rwAc1BOD8SWeFC+9mELCpxl
Received: from igel.home (ppp-46-244-166-111.dynamic.mnet-online.de [46.244.166.111])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Wed,  9 Jun 2021 10:04:06 +0200 (CEST)
Received: by igel.home (Postfix, from userid 1000)
        id 9202D2C3171; Wed,  9 Jun 2021 10:04:05 +0200 (CEST)
From:   Andreas Schwab <schwab@linux-m68k.org>
To:     Michael Schmitz <schmitzmic@gmail.com>
Cc:     linux-m68k@vger.kernel.org, geert@linux-m68k.org,
        linux-ide@vger.kernel.org, fthain@linux-m68k.org, alex@kazik.de
Subject: Re: [PATCH v1 1/2] m68k: io_mm.h - add APNE 100 MBit support
References: <1622958877-2026-1-git-send-email-schmitzmic@gmail.com>
        <1623224214-4836-1-git-send-email-schmitzmic@gmail.com>
        <1623224214-4836-2-git-send-email-schmitzmic@gmail.com>
X-Yow:  Why was I BORN?
Date:   Wed, 09 Jun 2021 10:04:05 +0200
In-Reply-To: <1623224214-4836-2-git-send-email-schmitzmic@gmail.com> (Michael
        Schmitz's message of "Wed, 9 Jun 2021 19:36:53 +1200")
Message-ID: <87zgvzzcp6.fsf@igel.home>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On Jun 09 2021, Michael Schmitz wrote:

> @@ -136,6 +141,9 @@ static inline u8 __iomem *isa_itb(unsigned long addr)
>      case ISA_TYPE_Q40: return (u8 __iomem *)Q40_ISA_IO_B(addr);
>  #endif
>  #ifdef CONFIG_AMIGA_PCMCIA
> +#ifdef CONFIG_APNE100MBIT
> +    case ISA_TYPE_AG16: fallthrough;
> +#endif
>      case ISA_TYPE_AG: return (u8 __iomem *)AG_ISA_IO_B(addr);

Is the fallthrough annotation really needed?

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
