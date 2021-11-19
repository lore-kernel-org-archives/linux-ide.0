Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEC3CC433F5
	for <linux-ide@archiver.kernel.org>; Fri, 19 Nov 2021 21:06:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234177AbhKSVJq (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 19 Nov 2021 16:09:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233605AbhKSVJq (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 19 Nov 2021 16:09:46 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DE97C061574
        for <linux-ide@vger.kernel.org>; Fri, 19 Nov 2021 13:06:42 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id t26so48673930lfk.9
        for <linux-ide@vger.kernel.org>; Fri, 19 Nov 2021 13:06:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=YBv3Ii7db3fp33Y1mkwxFmsLdvRV7hyFWlQt6J8LGuU=;
        b=Hb+Rh06Wam+jJLWkB6JSgb42RgcHh8TxAmZ2BcDbOb0JE4f1V9pDA9fZiSJlTZeypS
         I1iBreQrD5amoYsBIn8iOFdCg5R0D+qD4QgmBwTcr+BuDVKGtZTjZj5a6ZS3RRAVpNe/
         X2D1YJVnZ3BMrfLKtyuAlHVRStcs3aAMtZfZo61YGRYtD3CjqzzqGIOQiq4P3K2cSmk1
         7981+P+PzvA4VPc2livMyrFY0XZg5xjTQ9v+xfRvzfGUE01+Ek8Zddtm8Ppq473O+E6f
         dd4rI/kUlpGbNInCOipdPKlBtl7AFq55+8VMXEV7XV3RqSoJC2aFM9KTS/GiVtsIJJdT
         xC0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=YBv3Ii7db3fp33Y1mkwxFmsLdvRV7hyFWlQt6J8LGuU=;
        b=TCBNUOwq9CsFHuLJWl56N9ljZHcTF+6I26EOBRp/uYRqZWPJeFLz6f4e9fENil8kmO
         yZW7LGrmby0QJjpzwpcTtly6O+spcYSdNCmVIjPzWdNYV8MGyjF2xk3re/xSfK1ZROdl
         W844LtybhniDfoZWql7W/UBrJSxfOvHVqgDW5f+DCWreo26dNgBRr9mUsrkR2cdrpZUC
         ZAZSQbWz9C8Tk0NGYFcHhtaUTuLswbU5Zo3IvdY4nReNSKAB8cGSS5o07rnz3MmeMaEy
         gVJ49fodInpafc9CYTX5rwZb01vRxDgTjXRosRtoHcqVNyxkrm+NWBWBmgmNP8AhZ5ou
         2FJg==
X-Gm-Message-State: AOAM531lXoS1BKJCdvEi33mD2dIK01XqmfGt9XSFjUO4AB066FMi9lA+
        K8+t/y8ImBRuYUcXwFUb2fk=
X-Google-Smtp-Source: ABdhPJxJF5s+wr81fGOraJCL3154GibcQ+aXNWp0DFTNkq7U8V77+nXheGIVong0Uf5QS4VczxBHRg==
X-Received: by 2002:a2e:144a:: with SMTP id 10mr27919100lju.75.1637356000896;
        Fri, 19 Nov 2021 13:06:40 -0800 (PST)
Received: from [192.168.1.100] ([31.173.83.139])
        by smtp.gmail.com with ESMTPSA id u19sm72746lje.74.2021.11.19.13.06.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Nov 2021 13:06:40 -0800 (PST)
Message-ID: <344273c9-18c3-e44b-f53b-7334aec30ae9@gmail.com>
Date:   Sat, 20 Nov 2021 00:06:28 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [GIT PULL] libata fixes for 5.16-rc2
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        linux-ide@vger.kernel.org
References: <20211119084919.83906-1-damien.lemoal@opensource.wdc.com>
 <434d3413-2a58-2745-ae28-84ef3f9a7e7b@gmail.com>
 <CAHk-=wh3OuNk+3gkj-qd9CG8frCBQwpd8o+UewVuonsNXX6a+A@mail.gmail.com>
From:   Sergei Shtylyov <sergei.shtylyov@gmail.com>
Organization: Brain-dead Software
In-Reply-To: <CAHk-=wh3OuNk+3gkj-qd9CG8frCBQwpd8o+UewVuonsNXX6a+A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 19.11.2021 22:06, Linus Torvalds wrote:

>> On 19.11.2021 11:49, Damien Le Moal wrote:
>>> Baokun Li (2):
>>>         sata_fsl: fix UAF in sata_fsl_port_stop when rmmod sata_fsl
>>>         sata_fsl: fix warning in remove_proc_entry when rmmod sata_fsl
>>
>>      At least this one needs fixing! You were too fast at merging... :-/
>>      Well, I guess this will need a follow-up fix now...
> 
> Hmm. I'm missing the context, but considering this note I have skipped
 > this libata pull request.

    The patch replaced irq_of_parse_and_map() with platform_get_irq() but 
didn't update the error check from (!irq) to (irq < 0)... Quite frequent 
mistake in the past; it actually helps if you look at the function itself
before starting to use it. :-)

[...]

MBR, Sergei
