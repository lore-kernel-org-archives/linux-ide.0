Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFFF7C433EF
	for <linux-ide@archiver.kernel.org>; Tue, 25 Jan 2022 07:31:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359289AbiAYHaz (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 25 Jan 2022 02:30:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1324764AbiAYDdr (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 24 Jan 2022 22:33:47 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62B07C08E6E8;
        Mon, 24 Jan 2022 15:02:41 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id c2so24024930wml.1;
        Mon, 24 Jan 2022 15:02:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=n2IrAQGH1PArIko2WtGwF2rJLBMB1heq7fXZj36R6o4=;
        b=W3sC6df7XXAKGG4jYBjOS537aHdpEpgYDYgz4k9pDfmHsg5Djlxzui5ONlhpNjw+5i
         NeeSG0sU8eQh3hzsLqFn8ap2KJO8QG/jEs9FQzJfCf5PCIyhMeaFciCDtPNlsw24C8Dl
         hyF+jlhWRG+eQWuu/P/we0fBSi3k8BAnUrh4zqmhdwN0fYt0S+vyYv3+NC/MdwbF/fje
         Aw/nDw+VuCojPuGJCS+BA3EgnWeHxlpH6B8nFv7uSye+EQoAMTGA00D7JNFdb+EBiWVB
         wMwpQZxZffaBnXA3HRHXhDinw7JyERxdzlfMOtGWqVCQPWpxw/C/SUuYJmEQqcRqtr/a
         Fc9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=n2IrAQGH1PArIko2WtGwF2rJLBMB1heq7fXZj36R6o4=;
        b=YGap5uuPu02FVumAPHbMMVAmJi6WWkbZGPVlIx1w3NZkWskl40hJubo3oOzVedDzlz
         7Bcxxt5fujDt1oqO1LkLTvj1oZOfnZHPfSI42xFaUiZbU7d0ABVqNqML87RwWmjYZRFt
         mrXx581ukdDYzdsDK3JlkM+htLwf10etNsXfRFkdOXsbXSHawG8MlKIGaF1ZTyr+s/nF
         8K72r6gkQBB21fz+G+uKYMKJ7Yc9TszjV6SdZM/6NaaRUcao6HfSPJbMitkHyE3PjIC9
         mx35UWi0lIbfWxidN4VMDL1l8sO21AXleaGuEJpN7GDsyEvKqJNvNvyUybhKCMnEFjmB
         5TRw==
X-Gm-Message-State: AOAM533x2UW0bzTU2xrQ9HeASYTq6zAeOsoHTBulUeKEegIffFAKo0/2
        HwZiAxg5VtEHzG12CjzNDTzEOaAvo2ZC1w==
X-Google-Smtp-Source: ABdhPJw76qIRylKa9jCoLOZmG21SwymRVgMwfgA54NqAG1iHt3KE8KIuIvcBx5BlWZ1PYGG/8yTv9w==
X-Received: by 2002:a05:600c:204b:: with SMTP id p11mr413645wmg.47.1643065359832;
        Mon, 24 Jan 2022 15:02:39 -0800 (PST)
Received: from [192.168.0.209] (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.googlemail.com with ESMTPSA id m6sm680164wmq.6.2022.01.24.15.02.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Jan 2022 15:02:39 -0800 (PST)
Message-ID: <f6dac007-f7d4-0152-7e42-a6b0d0c1bbb3@gmail.com>
Date:   Mon, 24 Jan 2022 23:02:38 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH] ata: pata_pdc202xx_old: make make static read-only array
 pio_timing const
Content-Language: en-US
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Sergey Shtylyov <s.shtylyov@omp.ru>, linux-ide@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org
References: <20220123222246.5801-1-colin.i.king@gmail.com>
 <312af033-20f0-0288-94cc-e3fc9dd5d6b0@omp.ru>
 <9a4c9ba0-00a3-eb1d-8cdd-f44d94f7c92a@opensource.wdc.com>
From:   "Colin King (gmail)" <colin.i.king@gmail.com>
In-Reply-To: <9a4c9ba0-00a3-eb1d-8cdd-f44d94f7c92a@opensource.wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 24/01/2022 21:37, Damien Le Moal wrote:
> On 2022/01/25 2:15, Sergey Shtylyov wrote:
>> Hello!
>>
>>     Too many verbs in the subject. :-)
> 
> Yep. I will fix that when applying. No need to resend !

Thanks for fixing this up. Much appreciated.
> 
>>
>> On 1/24/22 1:22 AM, Colin Ian King wrote:
>>
>>> The static array pio_timing is read-only so it make sense to make
>>> it const.
>>>
>>> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
>>
>>     With that fixed:
>>
>> Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
> 
> Thanks for the review.
> 
>>
>> [...]
>>
>> MBR, Sergey
> 
> 

