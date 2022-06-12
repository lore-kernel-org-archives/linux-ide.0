Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2254C43334
	for <linux-ide@archiver.kernel.org>; Sun, 12 Jun 2022 12:34:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235807AbiFLMeg (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sun, 12 Jun 2022 08:34:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231135AbiFLMef (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sun, 12 Jun 2022 08:34:35 -0400
Received: from mail.nfschina.com (unknown [IPv6:2400:dd01:100f:2:72e2:84ff:fe10:5f45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 09B714DF63;
        Sun, 12 Jun 2022 05:34:33 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id 73F091E80D89;
        Sun, 12 Jun 2022 20:33:29 +0800 (CST)
X-Virus-Scanned: amavisd-new at test.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (mail.nfschina.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id uN4wFlFO_cOW; Sun, 12 Jun 2022 20:33:26 +0800 (CST)
Received: from [172.30.21.244] (unknown [180.167.10.98])
        (Authenticated sender: liqiong@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id 3F7DD1E80C8B;
        Sun, 12 Jun 2022 20:33:26 +0800 (CST)
Subject: Re: [PATCH] ata: handle failure of devm_ioremap()
To:     Sergey Shtylyov <s.shtylyov@omp.ru>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        hukun@nfschina.com, qixu@nfschina.com, yuzhe@nfschina.com,
        renyu@nfschina.com
References: <20220612073222.18974-1-liqiong@nfschina.com>
 <dbe12afa-60c7-899b-a19a-db5a3f49a452@omp.ru>
From:   liqiong <liqiong@nfschina.com>
Message-ID: <4f22ad6a-81a2-d7e9-6fe8-baf5b42f12a9@nfschina.com>
Date:   Sun, 12 Jun 2022 20:34:29 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <dbe12afa-60c7-899b-a19a-db5a3f49a452@omp.ru>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org



在 2022年06月12日 17:06, Sergey Shtylyov 写道:
> Hello!
>
>    The subject should include the driver's name, like below:
>
> ata: pata_pxa: handle failure of devm_ioremap()
>
> On 6/12/22 10:32 AM, Li Qiong wrote:
>
>> As the possible failure of the devm_ioremap(), the return value
>> could be NULL. Therefore it should be better to check it and
>> print error message, return '-ENOMEM' error code.
>>
>> Signed-off-by: Li Qiong <liqiong@nfschina.com>
>
> Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
>
> [...]
>
> MBR, Sergey

Thanks, I will submit a v2 patch.

