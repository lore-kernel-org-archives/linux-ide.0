Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FC6DC433EF
	for <linux-ide@archiver.kernel.org>; Fri,  4 Feb 2022 07:50:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229745AbiBDHuh (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 4 Feb 2022 02:50:37 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:55874 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbiBDHuf (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 4 Feb 2022 02:50:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1643961035; x=1675497035;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ZluTvGSg/C5mXwrd3+91imBRhsaNa+fNH7GitZ/cjdc=;
  b=J7q3zMMzk91DOOzVnZnr+MSo/XzOPgSoa6ZSWGd58+lzGwFsas7Xnaka
   RohXtFtcW3T0NOwE135bIE6VJLgXBk6t9p+/0f3gxnUWsXhzKsNg16n9a
   StOjrgNF0G0ydWrzjgX8XzAgAsS4ZlpGlRy5gF5VXKcwY/YuPV7cVVtJY
   4cG0MsJFIPwM5f+dW4hyG7WAOnGuSm2S+B9bSk4Uo8qy9NnghBshTDz9w
   IU9szMpfwD3KGCqQsY6PIKj0ELXiUgAbWdlwGTKuS7dqOtPcn3KWmpakq
   lA/sRAhNvtY+T7J4Q2j0qQYosjMH9zuz+U7L5mCy4LNoS7UlTDsa18gb3
   A==;
X-IronPort-AV: E=Sophos;i="5.88,342,1635177600"; 
   d="scan'208";a="304054514"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 04 Feb 2022 15:50:35 +0800
IronPort-SDR: flgyfxHfa/D8aw9AlFF68r7kXw5iizkVV3rq5kQrKwmZ2CRiDuGC+v8JNFGDUmSDf+02/tGN36
 1orC91CJosBmEVz0p3HRjFJIuHKI5a+FTM5RcX8gWJFDloiVgddw1vho2iBtYoOAgYy2267UMD
 wgc08COZ0GX9uunia+7gUfzlNnfdbp5KtcMAVe2YNw+tRpnwGD3t92vp+GrDV5juy41OMyg4rc
 EPbpwabqrr9z5fQmH7p6rfNpuJAY8DlrfRd0rx6e0wglE1tha4T4lQNKzeThaQmfgSAgNJIaXw
 o54/F8TZDrRwHK2HBMq/EiDn
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2022 23:23:42 -0800
IronPort-SDR: tR6f4XZ7xFNPs3pLxs0/k0C609nKCC4iID50fcxqwjXr1ftq9YYXzUREjylavUYBMqoz+ZpBUC
 tWf4oHJ5DFUoqtrKqLLQBacfKitH0taPASgGjPMw1ihujtfAICD5sdGupa6UF436OYm8rrs8U8
 5lrySftCKGarWPMcXlpBGGQBQobxOpjoUTkfEXp/z1GNT//gD7e5FMj0OBCOvNTJ1GQmecCvO2
 JDA23ms9UnKW8thmO1lOoUMhprM0kOpntz0pWB51RBZxw4Fko5g0FYALVDP03RxDup3pZveCCw
 eCk=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2022 23:50:36 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4JqnlG6yBMz1SVp3
        for <linux-ide@vger.kernel.org>; Thu,  3 Feb 2022 23:50:34 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1643961034; x=1646553035; bh=ZluTvGSg/C5mXwrd3+91imBRhsaNa+fNH7G
        itZ/cjdc=; b=egqk9+a3IBAlroDsOalhlz1e275tkENpUfW9LGtL9zKXkDy8NtX
        2TfDXE5WyWcErIozei+TTaSyNfmB3obaROUyNPcrHlzr7XRI077GUK3LEVhnZCgl
        VLvqASDG17i6IGxSGJc1hSpI5c4/J6MUMEAV/8akD/Ckg/KeSdkhUCMSG+Jlqm6V
        FvuBpFK1QXecDo5+Ygp88oPwgy3CuS9glAXtXj6ohvhu33zkKLufWdC3mpzv5qR7
        bm/9G81/POqxXoWTq/r+D6vRSd/HJX+PG1nFtw/Unh8ngkXpK5d5zlCk/J4nLUXL
        XLcVcigUezzEF3L0rPhjFQnk04FnUdsryOw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id y9w_9ySeEC-3 for <linux-ide@vger.kernel.org>;
        Thu,  3 Feb 2022 23:50:34 -0800 (PST)
Received: from [10.225.163.63] (unknown [10.225.163.63])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4JqnlD4LfTz1Rwrw;
        Thu,  3 Feb 2022 23:50:32 -0800 (PST)
Message-ID: <1966d4f4-d410-419e-82fb-5c0dca2936b2@opensource.wdc.com>
Date:   Fri, 4 Feb 2022 16:50:31 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] libata: make ata_host_suspend() *void*
Content-Language: en-US
To:     Sergey Shtylyov <s.shtylyov@omp.ru>, linux-ide@vger.kernel.org
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org,
        Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>, Viresh Kumar <vireshk@kernel.org>
References: <7cb64472-9e37-704a-0b9a-52ed050c1826@omp.ru>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <7cb64472-9e37-704a-0b9a-52ed050c1826@omp.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 2/3/22 05:58, Sergey Shtylyov wrote:
> ata_host_suspend() always returns 0, so the result checks in many drivers
> look pointless.  Let's make this function return *void* instead of *int*.
> 
> Found by Linux Verification Center (linuxtesting.org) with the SVACE static
> analysis tool.
> 
> Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>

Applied to for-5.18. Thanks !

-- 
Damien Le Moal
Western Digital Research
