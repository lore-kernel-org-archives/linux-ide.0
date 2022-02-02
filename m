Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32EB8C433F5
	for <linux-ide@archiver.kernel.org>; Wed,  2 Feb 2022 23:59:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348215AbiBBX7U (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 2 Feb 2022 18:59:20 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:49724 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237715AbiBBX7T (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 2 Feb 2022 18:59:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1643846360; x=1675382360;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=6IF4rZAMsjlqA6054YRskctrA5vMy2AoOfxr6RnDIqs=;
  b=AswEEH0eRw+iYMr2kRKDeZQ0nRUnx3SYywbPWYDe6QNAHr34oAj2moV2
   BLW2PgoCb8iq+7/AOFOt50zwycPPmVKA+Lb8/4MI1bXhmeoblEW2Fn6oA
   Ihprx/M5T0IKT9NWKkaF6dTfryealxNrEhkCWSsa/3Q7cQUhUtGg7txSp
   ukeRc4ek6kgSHXXK4eEWtXCCgajTYWUpC0Lh+Coe093gtErXflosdvN/y
   gJnZtK4u2w+uPTVTeKd4tHLrNDcH2SKFyK+jg6B6qe+r3vK52UFqJZ5yP
   EUeTtUDe3sSJ1HucTQjlh2lwj82yAngYh9U5hHqJ2IhDynGh8+4FWOiwL
   w==;
X-IronPort-AV: E=Sophos;i="5.88,338,1635177600"; 
   d="scan'208";a="193007330"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 03 Feb 2022 07:59:20 +0800
IronPort-SDR: 6uf5csTVxeVzfWBxfB+kLennvBflDjHpjZ0Repr5p8kc049tnEGrhp0jGqNhnyHyfeklq4VYN/
 QNI7SzfOLtlQvUDNo7TyP49zHqYBEBuFrjtVM8KzR+oMvU+qArVehB8z+q6gvKPFJjxa+FGH7Z
 Eiz5ILaelCi9+DYPknn6BfBTQafL9tXSgEQtzRCxWOUC9fvRqBxaqmDDyO1IxoOguB99qC8+ab
 PLFdeUBYFsdQecsPa8NoTFctrARk2uZpwGsgzWB0yMzbt5lMxbMU795ygSDE5I73XMGiFnVtYT
 5SbPivMNj2OSz+3vLI97jyMk
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2022 15:32:27 -0800
IronPort-SDR: bmAk6igb+pwDi9hyp8KjlLOwx9HP12nNXnJX+3b21AmuCZ7G3EuP6Jxyy9iR/VBXkHECqOMtz7
 PBMuFohY7m8N54obeEGlvo3OKNJuVzuTXcqj0LNVVuz8zWoKbGMehsewq/SFHz4IJJzA9Sx2NY
 hYPln36EEMxxdan5ga41T29tOs6r4GugFBh0JmSC5af6k2dbvYSvKDBZSK1ZxSA4TA2DEZ8I3e
 zhxCP8FVn0WUCGf+ePfDMcbTil9X0prroV1Plb54ffBT3gA9got8wULJPsUAYo5dOj2XwYg5JQ
 3tM=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2022 15:59:19 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4JpzKy5ZJQz1SHwl
        for <linux-ide@vger.kernel.org>; Wed,  2 Feb 2022 15:59:18 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1643846358; x=1646438359; bh=6IF4rZAMsjlqA6054YRskctrA5vMy2AoOfx
        r6RnDIqs=; b=SIuUVM4lZbXCp7Ro/uh8CYB7FpaRUHqGwhNt58WDQP9bSSkRHSD
        w45+4ieEFa6O9r9nmhVWVjQ5GiiA79tlM4gbTJrVSHQ+Oqee6/cVEmibl9FXjtlR
        xOAVXwrPeweao/TiJtZPZV1eMwRRWyOlEPR2fFv30VMUVIGDD4gqfq2SdrNv7Yol
        DDJc7u+hIbF6EICdBLr/lb4Sdw/JSVkaCDWU+veBRSCuuZ5yjP1hsvCstktKj/Y4
        m6Kb2Uq5v6GPDWbUDuCNeoGtMcDhdMUjtX6YmDQnlpUEV8kdN7AdPLxFckJKV5Id
        Ls9jQPTItCzDlKl0zdowlv6Njp7XRagbrnQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 8ob09l2fMikW for <linux-ide@vger.kernel.org>;
        Wed,  2 Feb 2022 15:59:18 -0800 (PST)
Received: from [10.225.163.63] (unknown [10.225.163.63])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4JpzKx6cL8z1Rwrw;
        Wed,  2 Feb 2022 15:59:17 -0800 (PST)
Message-ID: <fb19cd3c-3969-032b-1f2d-fb0a02907f4c@opensource.wdc.com>
Date:   Thu, 3 Feb 2022 08:59:16 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] MAINTAINERS: add myself as PATA drivers reviewer
Content-Language: en-US
To:     Sergey Shtylyov <s.shtylyov@omp.ru>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <f0c50df2-c7a1-7037-9c5f-c74cbcb987ac@omp.ru>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <f0c50df2-c7a1-7037-9c5f-c74cbcb987ac@omp.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 2/3/22 06:30, Sergey Shtylyov wrote:
> Add myself as a reviewer for the libata PATA drivers -- there has been some
> activity in this area still... 8-)
> Having been hacking on ATA from the early 90s, I think I deserved this
> highly responsible position, at last! :-)
> 
> Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>
> 
> ---
> This patch is against the 'master' branch of Damien Le Moal's 'libata.git'
> repo.
> 
>  MAINTAINERS |    6 ++++++
>  1 file changed, 6 insertions(+)
> 
> Index: libata/MAINTAINERS
> ===================================================================
> --- libata.orig/MAINTAINERS
> +++ libata/MAINTAINERS
> @@ -10880,6 +10880,12 @@ T:	git git://git.kernel.org/pub/scm/linu
>  F:	drivers/ata/pata_arasan_cf.c
>  F:	include/linux/pata_arasan_cf_data.h
>  
> +LIBATA PATA DRIVERS
> +R:	Sergey Shtylyov <s.shtylyov@omp.ru>
> +L:	linux-ide@vger.kernel.org
> +F:	drivers/ata/ata_*.c
> +F:	drivers/ata/pata_*.c
> +
>  LIBATA PATA FARADAY FTIDE010 AND GEMINI SATA BRIDGE DRIVERS
>  M:	Linus Walleij <linus.walleij@linaro.org>
>  L:	linux-ide@vger.kernel.org

Applied to for-5.17-fixes. Thanks !

-- 
Damien Le Moal
Western Digital Research
