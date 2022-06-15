Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0308C433EF
	for <linux-ide@archiver.kernel.org>; Wed, 15 Jun 2022 17:09:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349832AbiFORJN (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 15 Jun 2022 13:09:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349750AbiFORJM (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 15 Jun 2022 13:09:12 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46BCA33A33
        for <linux-ide@vger.kernel.org>; Wed, 15 Jun 2022 10:09:11 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id h36so1187780lfv.9
        for <linux-ide@vger.kernel.org>; Wed, 15 Jun 2022 10:09:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:subject:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ZNI5XfscEXmGCWGmnTIZG3ITyTOlbxlxeJ5YEPdGhf8=;
        b=RZ5AYpX+VjWdTadLBT4OrJGdVDIgq0SYqgw1GQhSw+6yNZZIXNLu9HRD1VlwmHQtQ/
         QTrAT3z5to/ZAQSjjYxIEoPpyfYyditM2eXw+o+Z+z5DYmjNMb6VNticaoas24mv6Lrm
         yb9r1kz24Xmc0wFOPeBanlxGqygVgjcjjGLy9rYrGc1e5MRe5yWdzB+p5VBu/Q0UDvS1
         pvSGs2Icxm6Y2uBLri2bzvqXrjnxZY30lns/9ZxlcSdNhl870ZhST5alXnI5252xgrUR
         Sb/eOneZNxhSYb7Un8LRWtrrPe8Nkx7alaw0Q9OUR7TtsZtR25dbQP126S56/gwSXoVV
         N10w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZNI5XfscEXmGCWGmnTIZG3ITyTOlbxlxeJ5YEPdGhf8=;
        b=aW7LKXFGzkMOxmLd5Z1HEI9rNRJchx4TEWM54VH8bXw1c2/oBNhdh5AUBrcVZLvvdN
         j2KiuM7nGBNNUsnj6Gxn5kOeLdjUPhZ0SR+/ev7+OXMDfohp1BhQMBHUeGp+4EOPtQ/I
         yoYaSW22YfBmCHCdWfT86EtRZ4m3wM5h3pe0UiZ+fKxE+/bs1IeOOXnpjv22s8W5DbAt
         pmWyH0/WMAEsQuIq0IHObHDU+hiVuPLjuubt+2pkF0aMzuQPO7yGfM561gf6YZF+hR+u
         tp41M+z0wumk2QlslPPWgz07d46DXhd03zHHCD6F9ui67o+Hk0ziKQN4zi8+za2RYecQ
         y03w==
X-Gm-Message-State: AJIora+ldoWbgKzRKiYcC5vU74Pc7dw7dJ0tJuRvFzMdxJ/Z9X69B2l9
        8hup06VnfCgdRJ0zEKM4IR6ClexzNAk=
X-Google-Smtp-Source: AGRyM1vQP1QLl7+4CRxD6WaDbDnu72Ekw6xq0PXqizqvalqO0d/L74csLVWeKI2Van/neUhqQn0r+Q==
X-Received: by 2002:a05:6512:6c7:b0:47d:ae56:abb9 with SMTP id u7-20020a05651206c700b0047dae56abb9mr288983lff.562.1655312949518;
        Wed, 15 Jun 2022 10:09:09 -0700 (PDT)
Received: from [192.168.1.103] ([31.173.86.16])
        by smtp.gmail.com with ESMTPSA id l10-20020a056512110a00b0047844f5301asm1853148lfg.290.2022.06.15.10.09.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jun 2022 10:09:08 -0700 (PDT)
From:   Sergei Shtylyov <sergei.shtylyov@gmail.com>
Subject: Re: [PATCH] ata: libata-core: [_sg]fix sloppy parameter type in
 ata_exec_internal()
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        linux-ide@vger.kernel.org
Cc:     Sergey Shtylyov <s.shtylyov@omp.ru>
References: <226fc2b1-ecb9-19d9-d7f0-2c6bc0fc8edf@omp.ru>
 <de30104b-f299-ab7e-c687-06ca513aa7a7@opensource.wdc.com>
 <8b6d5cfe-a353-c894-337d-00e4bdfa67f5@omp.ru>
 <cef2c6a3-375d-c540-171a-a92474449486@opensource.wdc.com>
Message-ID: <456741a8-75d7-283d-10b8-b54b684b19f0@gmail.com>
Date:   Wed, 15 Jun 2022 20:09:07 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <cef2c6a3-375d-c540-171a-a92474449486@opensource.wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Hello!

   Replying from my Gmail address, the corporate IMAP server is still AWOL... :-(
   Not sure what happened to the subject: "[_sg]" somehow got moved before "fix"...

On 6/15/22 2:46 AM, Damien Le Moal wrote:
[...]
>>>> Make the 'timeout' parameter to ata_exec_internal_sg() *unsigned int* as
>>>> msecs_to_jiffies() that it calls takes just *unsigned int* for the time in
>>>> milliseconds. Then follow the suit with ata_exec_internal(), its only
>>>> caller; also fix up ata_dev_set_feature(), the only ata_exec_internal()'s
>>>> caller  that explicitly passes *unsigned long* variable for timeout...
>>>>
>>>> Found by Linux Verification Center (linuxtesting.org) with the SVACE static
>>>> analysis tool.
>>>
>>> Since you are changing this function signature, can you also make it
>>> static since it is only used in libata-core.c ? The declaration in
>>> drivers/ata/libata.h is useless.
>>
>>    Hopefully you don't mean I should do it in the same patch? :-)
> 
> The patch you sent is changing the function signature.

   Actually, it changes 2 function signatures...

> So yes, doing it in the same patch is fine with me.

   But not with me. Adding a "drove by" signature change doesn't go together
well with the "found by SVACE" note, to start with...
   Moreover, I've created 2 patches already, with the 1st patch making
ata_exec_internal_sg() *static*...

> I do not see the need for 2 patches for that.

   This patch as is already does enough to violate the "do one thing per
patch" rule, to add even more violations. :-)

> Instead of "fix sloppy parameter type in ata_exec_internal_sg",
> rename the patch "fix ata_exec_internal_sg signature" and then all changes
> naturally belong to the same patch.

   Thanks, no -- I'd like to keep the emphasis on "sloppy parameter type".

MBR, Sergey
