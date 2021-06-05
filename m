Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C13EC4743E
	for <linux-ide@archiver.kernel.org>; Sat,  5 Jun 2021 22:05:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E066E613AA
	for <linux-ide@archiver.kernel.org>; Sat,  5 Jun 2021 22:05:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230022AbhFEWHU (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sat, 5 Jun 2021 18:07:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229998AbhFEWHT (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sat, 5 Jun 2021 18:07:19 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C29DFC061766;
        Sat,  5 Jun 2021 15:05:15 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id y15so10160416pfl.4;
        Sat, 05 Jun 2021 15:05:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=W1wz3zgl4oMmbHBliUTu6vhDY1pmeA+vqTUTIc/mrPg=;
        b=CmTw9Ye3cQ6LpGK4UoDMMcl4+MVMv1suBiKrWie8v34b/aOGKsFRv0oRBkWfsfkAJT
         YZjRP3ZwGjnXVsqlBSPT1NRtZVA0aKwCdxg/BflyIEdFP12kArqvDL2ywx0MuBoUNi9/
         ydxz3kSqVmSNSwhL4wMd8pM0jICUk+0UifyMACVojl0ki5HS8QvNuv07HNvKqiGn1K2A
         PZl1rQl51GLLyK6Sih3FckKvh+YVoperOE9urXxELg8jhSoBfv5l+9v9jh/7BGW7Rl13
         pTnV05+Jpx9u2v3Y2g/TDqX4w6gVQ84JbFm51ngGmNrOsrreFRyY6NYo/6Ws4RIim356
         pFmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=W1wz3zgl4oMmbHBliUTu6vhDY1pmeA+vqTUTIc/mrPg=;
        b=Ug89lYQUIhwhiuai/PK2cVSLy72POTXaUEwduMTCrdpWmFHMQmOwNuK3317YOvm23u
         Ia1zF1F1snHGj+IyDMQ+G+k+F//aRXPPLdM9Oq3AvCfg/nS8vBZYmSHH2HVqQgeI/0Ao
         RI0RC3VYuJnws3JzkWvBCw58YLOS34VDcT+C4HMAMlrclgrIQdt9tePAj2saDrHGWxXZ
         1EXcjgKBEnsob7PlM/V/QzoNNALSxjRYAVtrFMU3oEpdgWcml4Kwvyk8vT14ioMTFtAp
         qd/ABSuj8sClJaJZW++IHUk7tW6uzOMYKosfbUQbbwQIjzid47nRxbQRyzgT9ZJ70W9i
         1xAQ==
X-Gm-Message-State: AOAM533L8M5KAA807VlaKyJbsP8oxPLlN3dR47I2eNYRdREwFT8hmoOC
        R4ZwPnX/in58Hk+P7GjtB1mTPETRxlQ=
X-Google-Smtp-Source: ABdhPJxToCbF62xSTGa8L6Fn6gjWPGZzFxPJoZLO3/CfhcF9HyeCs5V9UGDvhU9XORu/BYbsMtxyjQ==
X-Received: by 2002:a63:2bd0:: with SMTP id r199mr11407177pgr.395.1622930711810;
        Sat, 05 Jun 2021 15:05:11 -0700 (PDT)
Received: from [10.1.1.25] (222-152-189-137-fibre.sparkbb.co.nz. [222.152.189.137])
        by smtp.gmail.com with ESMTPSA id k8sm4131305pfg.185.2021.06.05.15.05.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 05 Jun 2021 15:05:11 -0700 (PDT)
Subject: Re: [PATCH RFC 1/2] m68k: io_mm.h: conditionalize ISA address
 translation on Atari
To:     Brad Boyer <flar@allandria.com>
References: <CAMuHMdUskb3oicq8Kbf6MY_4mn4-Y1pJ-om4fny7k48gndscgg@mail.gmail.com>
 <1622611267-15825-1-git-send-email-schmitzmic@gmail.com>
 <1622611267-15825-2-git-send-email-schmitzmic@gmail.com>
 <25ab336d-e0e0-41a8-d468-ecbf8d83d2b@linux-m68k.org>
 <143313da-d294-f89b-d285-235230514c5a@gmail.com>
 <d7165fdd-9269-7bd2-185-c6193f864722@linux-m68k.org>
 <535b7829-f16f-4ddc-a676-dbb10c7a4a35@gmail.com>
 <20210604224955.GA12141@allandria.com>
 <eefa79e9-01d3-9179-9ca6-57500b9ab7c2@gmail.com>
 <20210605060447.GA18461@allandria.com>
Cc:     Finn Thain <fthain@linux-m68k.org>, linux-m68k@vger.kernel.org,
        geert@linux-m68k.org, linux-ide@vger.kernel.org
From:   Michael Schmitz <schmitzmic@gmail.com>
Message-ID: <b5109814-ebc3-4cef-3377-32725e0056d0@gmail.com>
Date:   Sun, 6 Jun 2021 10:05:05 +1200
User-Agent: Mozilla/5.0 (X11; Linux ppc; rv:45.0) Gecko/20100101
 Icedove/45.4.0
MIME-Version: 1.0
In-Reply-To: <20210605060447.GA18461@allandria.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Hi Brad,

Am 05.06.2021 um 18:04 schrieb Brad Boyer:
>>
>> Not sure what card socket code the APNE driver uses - must be one of the
>> generic variants from drivers/pcmcia. If your PB190 needs something not
>> already in there, we'd need to add that as well.
>
> I had to look a bit, but I found it. The apne driver doesn't use the
> normal PCMCIA infrastructure at all. There is a custom Amiga PCMCIA
> thing found in arch/m68k/amiga/pcmcia.c. This could complicate things
> if we are able to use the common PCMCIA code for trex and try to
> build a kernel with both that and amiga/pcmcia + apne.

Thanks, I had missed that one.

> At least it does sound like the io macros won't be an issue.

The arch/m68k/amiga/pcmcia.c API is different from that of the drivers 
in drivers/pcmcia/ from what I've seen, so I think adding or reusing 
trex support together with Amiga PCMCIA support will be an issue.

Cheers,

	Michael

>
> 	Brad Boyer
> 	flar@allandria.com
>
