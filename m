Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E5D9EE49AE
	for <linux-ide@archiver.kernel.org>; Tue, 22 Aug 2023 20:22:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230475AbjHVUWF (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 22 Aug 2023 16:22:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbjHVUWF (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 22 Aug 2023 16:22:05 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B0ACCC;
        Tue, 22 Aug 2023 13:22:02 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1c09673b006so6742505ad.1;
        Tue, 22 Aug 2023 13:22:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692735722; x=1693340522;
        h=content-transfer-encoding:in-reply-to:mime-version:user-agent:date
         :message-id:from:cc:references:to:subject:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZoKjy7F1I0Ba/uu2yUZdhOR+kh54mpLL9cfM4YSAEZ8=;
        b=gd8N9jIlvVQ4X1dUaoEBZ5JrNXWy+twcQbY9WSwcvsDcX/0nzQjg0G9yee4IDDQ6YQ
         MEsoOrOLPJm11Pta7H7AJkqtlbQgElh5SaZM7MHPeWfcB6tyfC+U+yYF9mBZKtokFJ30
         JASHlM1t+ico7lzLZ8rKEMsXRqspw5CuSoTHtNeIZCjPuUt8YcevNb3TvcHdjKjduioH
         ldtnxMPjqBNS1pw7C8tuJ6QGiBwN9lzfnMVgIP83PdPXI4FQAF95CZMwPHrG1uXuQV7J
         otvHr4DZeSWDysiFEzec33IYX5uwwa+l2KfBsCylWHEttqLg7meP+p4l8KW0x8Ym+nb6
         daTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692735722; x=1693340522;
        h=content-transfer-encoding:in-reply-to:mime-version:user-agent:date
         :message-id:from:cc:references:to:subject:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZoKjy7F1I0Ba/uu2yUZdhOR+kh54mpLL9cfM4YSAEZ8=;
        b=SYMLSs2flctoACBBcmTYw+nBMzEc5b98fgBOPePu0mYrwtE2BPbH0iilABNulVXfoy
         RHCUsMDLAhJzLp8jMR/7c1gHkef9RJcU6G8fueGa1ea4BPK8ECEI8hLNvJ0l1ZYUve3G
         4Hsz0erDpDqbmRqLneqbXfxyYN/raGWWYBr7JxBnf52rXPniex819WX67hWQFptsNN3N
         c7oWDy8ptPlBf6KaYdzZFTACvrmHj0woRUWo/1K/BeeJejQJExbNx0nUCEkZ5ttiVgRt
         3hiky1s75jy5BkBESEtkpnN5d2LloUuYfvjH5M2YrqH5tDcctn2pUUwnud9Yhf45gDjZ
         ABpA==
X-Gm-Message-State: AOJu0Yzg9f2K6B9razGkkS/OETVxXDlOdYF1x2Rh4KYhnfnyQS+APOie
        dNo3beHZuCd/NFFtiVDnE9Y=
X-Google-Smtp-Source: AGHT+IEsmIzlr4NT+4duSfdw8VV7HtDnklmJS9o0xF+vXCwoTM/uFHSnGIhEnvq3U50bdrTCxGRH2Q==
X-Received: by 2002:a17:902:e882:b0:1c0:8044:750b with SMTP id w2-20020a170902e88200b001c08044750bmr5951913plg.47.1692735721879;
        Tue, 22 Aug 2023 13:22:01 -0700 (PDT)
Received: from [10.1.1.24] (125-236-136-221-fibre.sparkbb.co.nz. [125.236.136.221])
        by smtp.gmail.com with ESMTPSA id y16-20020a170902b49000b001a5260a6e6csm9467437plr.206.2023.08.22.13.21.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Aug 2023 13:22:01 -0700 (PDT)
Subject: Re: [PATCH 2/3] m68k/q40: add data_swab option for pata_falcon to
 byte-swap disk data
To:     Sergei Shtylyov <sergei.shtylyov@gmail.com>,
        linux-ide@vger.kernel.org, linux-m68k@vger.kernel.org
References: <20230817221232.22035-1-schmitzmic@gmail.com>
 <20230817221232.22035-3-schmitzmic@gmail.com>
 <3af82526-1b8f-87bd-b936-9171e4d821df@omp.ru>
 <5e5217a4-837c-fac8-246c-15f8a2d46bfe@gmail.com>
 <7463b0e7-cc9c-c091-ab47-14d19a0daf07@gmail.com>
 <7dfabbb3-1bda-103d-d357-a6f167dab9b9@gmail.com>
Cc:     will@sowerbutts.com, rz@linux-m68k.org, geert@linux-m68k.org,
        Finn Thain <fthain@linux-m68k.org>
From:   Michael Schmitz <schmitzmic@gmail.com>
Message-ID: <d7aa2e48-bf71-5ece-87e2-aaa63fdeb567@gmail.com>
Date:   Wed, 23 Aug 2023 08:21:55 +1200
User-Agent: Mozilla/5.0 (X11; Linux ppc; rv:45.0) Gecko/20100101
 Icedove/45.4.0
MIME-Version: 1.0
In-Reply-To: <7dfabbb3-1bda-103d-d357-a6f167dab9b9@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Hi Sergey,

Am 23.08.2023 um 07:44 schrieb Sergei Shtylyov:
> On 8/22/23 10:10 PM, Sergei Shtylyov wrote:
> [...]
>
>>> thanks for reviewing - this has mostly been addressed in v2 or v3 (which I forgot to send to you, sorry). Damien asked for the patch title to be changed (now 'ata: pata_falcon: add data_swab option to byte-swap disk data) so you might have missed it on the list.
>>
>>    I didn't want to repeat such request after him. :-)
>>    I'm subscribed to linux-ide thru my Gmail account, and I'm still not seeing
>> your further patch versions on the list... :-/
>
>    Had to reply from Gmail account as the OMP server rejected my msg.
> Please be sure to always CC: me on the PATA patches!

Will do - v4 to go out shortly (afer a final boot test).

Cheers,

	Michael
