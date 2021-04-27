Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1EE7C433B4
	for <linux-ide@archiver.kernel.org>; Tue, 27 Apr 2021 19:55:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A41C60FF3
	for <linux-ide@archiver.kernel.org>; Tue, 27 Apr 2021 19:55:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235974AbhD0Tzn (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 27 Apr 2021 15:55:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235719AbhD0Tzm (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 27 Apr 2021 15:55:42 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E2D7C06175F;
        Tue, 27 Apr 2021 12:54:59 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id v191so345267pfc.8;
        Tue, 27 Apr 2021 12:54:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=afoI4FuwTfrW6Z0hEFugsdIW4PHlren6vrmAD+HRX5I=;
        b=XdmV3R4myyB0wfVtF2TSwjjYj73NP2+ZgRS6oYfw0kHGB9HC7orxGQFm2pp/bae30P
         +oPTn+Bxjdu/46Q/7nli79ONM9lpasJ1bhguHMhI/aEj+6z46RrWK4hqhaUdeDW+G62B
         JX1UrFr/GDZEmXYkRKIXiuCKxBVlEPx+b2yDb3YvKinpZ+4V2TxDswiT4tn+6FEWl87Z
         pSKCczVuvZ5imuUQfQ8ZgkE/RCWpg4oGRjymdGOGv8uFGVJWKbYoVz47B/f9p2PRn20/
         e/2Jcd+edwdtSa9ysX4myE572LIx0ophMwx1Hpbsvvc0UGvjKH/fTlkeAMYksICY9/m4
         nBhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=afoI4FuwTfrW6Z0hEFugsdIW4PHlren6vrmAD+HRX5I=;
        b=QskoJJ2FfW639s3Sk+IaBXulvvgcpHPOf533PKUGLLhlKlSA3aGQSEIkzmPuvZ8Zcq
         JgAFydGt++xfMfw6o5yaf1zA0KTJDA899S4/SboUktZBrLAhAk77YYpWbauifKLdfTNf
         SxonTFEDnvfGvGUBq40FVDe/IWcZscf6vVj8TlFQetBStYjB8FsWKTLT62u+mISxuhOo
         56qVPGkH81wnrdZCfFm0IPykYNJBCbQmdDtBhmTQXVunK5XorMni+TZxSNEYqspvQ4SH
         u5k80rDfQGxB10lJQ8tqW6clNBOVuOinxEsZJqgM9HYF+nU/yESEWiLFXhTONXgSsgKd
         7IYw==
X-Gm-Message-State: AOAM5304Wp7uXXtIEQgFGNSDhgmmtZs/+BV3vcGx5RZuvsFJCtrYXfz/
        dCvdofes617C931jaf7EECU0AxT1LHLekw==
X-Google-Smtp-Source: ABdhPJxr+Gi/fH9i5uoPwpCusU2t0LPExJAdJfmub2rirPN9/jUFKYoUKTFbKtoZkGDtFL++Bw7jwg==
X-Received: by 2002:a63:150c:: with SMTP id v12mr23654133pgl.344.1619553298674;
        Tue, 27 Apr 2021 12:54:58 -0700 (PDT)
Received: from ?IPv6:2001:df0:0:200c:2d50:30a4:47de:1dd6? ([2001:df0:0:200c:2d50:30a4:47de:1dd6])
        by smtp.gmail.com with ESMTPSA id a7sm3116794pjm.0.2021.04.27.12.54.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Apr 2021 12:54:58 -0700 (PDT)
Subject: Re: [PATCH] m68k/mac: Replace macide driver with generic platform
 driver
To:     Finn Thain <fthain@fastmail.com.au>
Cc:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Christoph Hellwig <hch@lst.de>,
        Joshua Thompson <funaho@jurai.org>,
        "David S. Miller" <davem@davemloft.net>,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        linux-ide@vger.kernel.org
References: <793432cca963b632709c4d1312baa9874d73e1d8.1619341585.git.fthain@telegraphics.com.au>
 <ba908b1d-eab5-a4e5-0c0a-2c745287d121@physik.fu-berlin.de>
 <10a08764-c138-9fe5-966c-ce68349b9b6@nippy.intranet>
 <65f01f42-31d9-522a-e690-73d286405a01@gmail.com>
 <9650358f-a789-7dbd-4495-1d39ff321ded@nippy.intranet>
From:   Michael Schmitz <schmitzmic@gmail.com>
Message-ID: <ada88dd6-f8d7-11dc-9a89-5c7e437a0981@gmail.com>
Date:   Wed, 28 Apr 2021 07:54:52 +1200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <9650358f-a789-7dbd-4495-1d39ff321ded@nippy.intranet>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Hi Finn,

On 27/04/21 3:47 pm, Finn Thain wrote:
> On Tue, 27 Apr 2021, Michael Schmitz wrote:
>
>> On 26/04/21 7:37 pm, Finn Thain wrote:
>>> Was macide the only IDE driver in Debian/m68k kernels without a libata
>>> alternative? If so, this patch would allow you to finally drop
>>> CONFIG_IDE.
>>>
>> There's still q40ide.c (ISA IDE interface, byte-swapped, so would need
>> treatment similar to Falcon IDE). Hasn't been updated to a platform
>> device yet.
>>
> AIUI, q40 support is not included in Debian/m68k kernel builds.
I see.
> I wonder whether q40 could re-use the pata_falcon driver . I suppose

I'm pretty sure it could, but there is no reason why it would have to be 
crippled in that way. Interrupts should work perfectly fine with IDE on 
Q40.

There is another reason why using the same module binary for both might 
fail - the awkward address translation code in io_mm.h. Not certain at 
all whether we can even have Q40 and Atari in the same kernel binary...

> pata_falcon_set_mode() would be undesirable on q40 (?) It could be made

Not sure what the defaults are - pata_buddha.c and pata_gayle.c use the 
same code in their _set_mode(). I suspect we'd need it for Q40, too.

Cheers,

     Michael


