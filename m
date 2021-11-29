Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DCBDC433EF
	for <linux-ide@archiver.kernel.org>; Mon, 29 Nov 2021 11:40:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235697AbhK2Lnv (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 29 Nov 2021 06:43:51 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:53469 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236408AbhK2Llu (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 29 Nov 2021 06:41:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1638185914; x=1669721914;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=UrCJHp+LEhvdydvmtakJJZJ0GM7ARkL5TKhWqxVUYqo=;
  b=NT9SLXGVQS07mb4iFHu3CxcVeWVTa6SlS9ww4vTRKWbwVVm9tEzr67vC
   cNz0AuTlPEjhiPWXUWEUliYKKkrGYoYCHaLz1/USBXmBwKsLF6rLF5hox
   N8bl3S9tfHvnAElgLHhzemnPyphqlVrlN2IBGHyUS2wfEVz64Y1RzN1Ow
   6R7idBW/d6oX/kByAxg90cNETFpggkYbZopoA7fQ1tV05J+6BnSn/dzE1
   Tnf9vyiIXolY7TBZfEkseQvnrBfXtsNirhcpZ+pC2YjpUB5tOjA7fMeEc
   h721fZFRWtCvfwQcCmUMJ6K1lTxytVai1Mi5DhK+1JbqTgkAqJkJW/UGs
   g==;
X-IronPort-AV: E=Sophos;i="5.87,273,1631548800"; 
   d="scan'208";a="187958563"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 29 Nov 2021 19:38:33 +0800
IronPort-SDR: Lf6sxEIS+USoXoiJLdRucJ6pKiDowEiLnbYS3sBPV+T2LF0LmoF2qmxvA724zBeD+yjeGm80XP
 HiP6l6KSYnIas4bE/SV3Nko6CeT3vUyB4d5NAp0yjNfEMcWupXmKdCkiWuqaR65FMaT2IU/QcF
 /0G2ihg6mo42zqM5kI/ww99eRDWbOZqAnBJE2E/WuCU92RbR7z87W66/xfjD+QluuFGsVBwDa3
 q18njq0k8qLr7rSigIaHs1s7t37swGDjtDwDY082AkYpu+XtkVKMA+QYtJmm622larpPbJEVXm
 /1se7k6yS+pdo9uFnY7MGX9T
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2021 03:13:20 -0800
IronPort-SDR: HTJxqRBpWKGO6vmga5WmfmNdtgBeyEk8m64YI3ptQLjDwJwhXDwKe9nEVDjCnoYfjLn3QBHsUg
 dXoACIvXi3Pd72ACwpFRImYPGAAj+qoF0S23XwMG5KtNgi+87ythcRIz1UnAiOAqjq7FQXi4pw
 KYTsslh8Rw6eySZ3gr60F5Zz/mEMRkyeCb8yhJG+1lSqPSHak37Y+f8ThBgm/u4Htg6GcdYL8E
 0okj7KMro1EcxAmC8sqCP123RE4Df2KJpK4CWjc63y58kmIoUwh8m03XnjJVtOiwoEiVJMhvI+
 ahE=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2021 03:38:33 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4J2jzF1xqqz1RtVm
        for <linux-ide@vger.kernel.org>; Mon, 29 Nov 2021 03:38:33 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1638185912; x=1640777913; bh=UrCJHp+LEhvdydvmtakJJZJ0GM7ARkL5TKh
        WqxVUYqo=; b=KwTIanqv6eWjvdpk1apEJlKuA/D0/ycTFy2CqDoY15v2ilAVkcU
        Ir0hVNO0AaOr0vbEfrSI9KosDYhMg0s9espOlq/poL6P91J6ZewbAz9A+fLtgqdR
        mBCqkPrXoUNfXk7JcteaqPm/qI1gBWBpQmmmDduaLTUpRKY8bzB23PU8NhoRfqYf
        fqB5pEtKzteZZxaso+3g50jRaqd7uEWCvTeRtxPF8eMrfPwu3IjUd/yQfLgfSQje
        yDEzOGvmSn4w+bDgxGLNzl74vC7phO/4EFXJTHnIlgAZ6gNHhXCqKkahJSdnC1vk
        oMZh3uEfBxRg+2AzCHGFsl/m9TweV5c5/pQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 93Np73d1QHpT for <linux-ide@vger.kernel.org>;
        Mon, 29 Nov 2021 03:38:32 -0800 (PST)
Received: from [10.225.54.48] (unknown [10.225.54.48])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4J2jzD0Q9hz1RtVl;
        Mon, 29 Nov 2021 03:38:31 -0800 (PST)
Message-ID: <6cbcabe8-029b-9c3d-a503-afe4293f9dbc@opensource.wdc.com>
Date:   Mon, 29 Nov 2021 20:38:30 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.2
Subject: Re: [PATCH v2] pata_falcon: Avoid type warnings from sparse
Content-Language: en-US
To:     Finn Thain <fthain@linux-m68k.org>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Michael Schmitz <schmitzmic@gmail.com>,
        Jens Axboe <axboe@kernel.dk>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <8f6a78cf7b60160ef3d22445ee1b8f2c0678f74b.1637879659.git.fthain@linux-m68k.org>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital
In-Reply-To: <8f6a78cf7b60160ef3d22445ee1b8f2c0678f74b.1637879659.git.fthain@linux-m68k.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 2021/11/26 7:34, Finn Thain wrote:
> The zero day bot reported some sparse complaints in pata_falcon.c. E.g.
> 
> drivers/ata/pata_falcon.c:58:41: warning: cast removes address space '__iomem' of expression
> drivers/ata/pata_falcon.c:58:41: warning: incorrect type in argument 1 (different address spaces)
> drivers/ata/pata_falcon.c:58:41:    expected unsigned short volatile [noderef] [usertype] __iomem *port
> drivers/ata/pata_falcon.c:58:41:    got unsigned short [usertype] *
> 
> The same thing shows up in 8 places, all told. Avoid this by removing
> unnecessary type casts.
> 
> Cc: Jens Axboe <axboe@kernel.dk>
> Cc: Michael Schmitz <schmitzmic@gmail.com>
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Reported-by: kernel test robot <lkp@intel.com>
> Suggested-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Signed-off-by: Finn Thain <fthain@linux-m68k.org>

Applied to for-5.16-fixes. Thanks.


-- 
Damien Le Moal
Western Digital Research
