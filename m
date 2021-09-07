Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-24.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A568C433EF
	for <linux-ide@archiver.kernel.org>; Tue,  7 Sep 2021 00:47:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5072060BD3
	for <linux-ide@archiver.kernel.org>; Tue,  7 Sep 2021 00:47:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234172AbhIGAs7 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 6 Sep 2021 20:48:59 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:50852 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232860AbhIGAs7 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 6 Sep 2021 20:48:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1630975673; x=1662511673;
  h=subject:to:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=8OX4r8Dp2/+QnzBAP3oMhpr4YUSaju3XowBizAdarl4=;
  b=dljIWUdI7g3DAwu34Q1N+iUkjbrN6N58K7eby9WPv0zaFEu50ADwPUj/
   l0HslWn7GadOA/rBkTijaSrLx6a3jh9tUMTQPgicCN+tBs/1o31cjHCyY
   8AIz/kTvs5aMBG0hUT8Jo4CPGWQEwxAs0e+5M81b5mcvV1B76Yl2OiM21
   ELdPnZYZSQqyzBekoLN2lFT+MPE/rPqkLwZ5KLo1Zf6m5ip/wO1LoKpoG
   GoM/QbeT5yWLS/3VF1wy7EcfkARojrcOYCBGjizqZDKCdPWN/z7VuMYT8
   KzplT1nkCrS8jWYfpNmFsbQ8QjtO4NtLuoNfSpdWcIaGbe3xFj0jy5ynT
   A==;
X-IronPort-AV: E=Sophos;i="5.85,273,1624291200"; 
   d="scan'208";a="283122378"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 07 Sep 2021 08:47:53 +0800
IronPort-SDR: f1M0yFxKYI6b+tPL3IQKbHvNuM28bzpDpyCRIH7TvedVynEcAxTnwP7ZcEE8cDr64gN+uJYq35
 2Rzb9aN+XE0ZkTWNliJDQvZrUOb2sZTyVPZbJvWcgPkD7S4UwdYhaaeyWS7SDTkqOGRVV3w6O+
 ZwqCh/R1BTT6OcI/6AhoSw4P0UmFb7CO+ie6Dx2DL/RRttAsIbjP3DilJP1qEfiVIuWVWccPfL
 dobyxiOrvGbJpyJEQGBaWC4+ZDfvIZLXa0HJpDBFJo2zEB5E5XjORJlY40ePuVWkvxK4VIxdYl
 K0+KFGZPTkY1lGfPbl/hdh/v
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2021 17:22:52 -0700
IronPort-SDR: HS7AAIPSF0UCyEkG0qFI/0sxdbS2rrB/+xu3qZJaoziA2M7NK6CqfwIDWmOx/qC0mCjBvBlYzS
 WxdbF8mR9B0cniJQTG3M8SmkAMCGfJmm4SBfOMp/AqDO55gX0mN9a4cUV5hODL2H6345NnHOQX
 LjULuIGjzVR2g+F3GPjdq1xHvr6P/rRSDmirGP4opM9EA4/uJbE7rqyWUOjgOJD4EP7wj3LdVn
 aaC837Ctr2qFp8Bd40dfMV9jRfOCZNtvycm/kIOkQ7PVr/JdZyN75tLEIC5OnbJCh0LvdGIPKf
 UME=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2021 17:47:54 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4H3RSn3hhrz1RvlV
        for <linux-ide@vger.kernel.org>; Mon,  6 Sep 2021 17:47:53 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-language
        :content-type:in-reply-to:mime-version:user-agent:date
        :message-id:organization:from:references:to:subject; s=dkim; t=
        1630975673; x=1633567674; bh=8OX4r8Dp2/+QnzBAP3oMhpr4YUSaju3XowB
        izAdarl4=; b=SBTjzLzAzqWaOjoDWlTdCbiF7NNaK5sU6lzlFQ4N2IdT2GHozwu
        Qi6eH7NeXUOgSeWmOllzpbi0HG6fKbB8LkdGQVMu+9CRVyT2CPNlxyvFSnjbfLVM
        +kqIH05wc3QxIptAowygqOWhwhOjUNYA9XuSSBvSaFpVEhuX3vxDZUQjTdJUnHsN
        wXw7Z4lVqrGPT1/IOvPuP+g7VGNTWCyZ5Hbrg6c1lHLoTF7lUmNdA+bea96Ap0Bp
        RWITW9jjVIptp5Mm2vpzZBewcX0zhS7lqWkwXq4wXWTglroq8y/JKxzAbCwLDvuk
        lHcjnHJZFMDo4PjIKqFY/4swFdt0NYo1+0g==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Fefks34sBQYV for <linux-ide@vger.kernel.org>;
        Mon,  6 Sep 2021 17:47:53 -0700 (PDT)
Received: from [10.225.48.54] (unknown [10.225.48.54])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4H3RSm66Tcz1RvlP;
        Mon,  6 Sep 2021 17:47:52 -0700 (PDT)
Subject: Re: [PATCH] libata: pass over maintainership to Damien Le Moal
To:     Jens Axboe <axboe@kernel.dk>,
        ALWAYS copy <linux-ide@vger.kernel.org>
References: <b4cafca7-ad37-ec70-7b89-9025c35902a8@kernel.dk>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital
Message-ID: <4f9b5f1d-7130-9434-8c54-23b4117bbad7@opensource.wdc.com>
Date:   Tue, 7 Sep 2021 09:47:51 +0900
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <b4cafca7-ad37-ec70-7b89-9025c35902a8@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 2021/09/07 9:45, Jens Axboe wrote:
> Damien has agreed to take over maintainership of libata, update the
> MAINTAINERS file to reflect that.
> 
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> 
> ---
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index fb1c48c34009..ed9e3770d8b5 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -10597,10 +10597,10 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git
>  F:	drivers/ata/sata_promise.*
>  
>  LIBATA SUBSYSTEM (Serial and Parallel ATA drivers)
> -M:	Jens Axboe <axboe@kernel.dk>
> +M:	Damien Le Moal <damien.lemoal@opensource.wdc.com>
>  L:	linux-ide@vger.kernel.org
>  S:	Maintained
> -T:	git git://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git
> +T:	git git://git.kernel.org/pub/scm/linux/kernel/git/dlemoal/libata.git
>  F:	Documentation/devicetree/bindings/ata/
>  F:	drivers/ata/
>  F:	include/linux/ata.h
> 

Jens,

Thanks for sending this. I did name the tree "libata" but since this includes
many drivers, would "ata" be a simpler and more general name ?

-- 
Damien Le Moal
Western Digital Research
