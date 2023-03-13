Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF6B1C6FD1F
	for <linux-ide@archiver.kernel.org>; Mon, 13 Mar 2023 00:07:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229743AbjCMAHZ (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sun, 12 Mar 2023 20:07:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbjCMAHY (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sun, 12 Mar 2023 20:07:24 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C1E835277
        for <linux-ide@vger.kernel.org>; Sun, 12 Mar 2023 17:07:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1678666043; x=1710202043;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=r9VZpfYxoyk1rMUrZi/rwjzuzmC5Z2gPyDhCfbA35qk=;
  b=ZQ+nwUsARJs0Fckdk1ywvctGt1yw5M7dKNiAaGnWSB6Yynf8eP5m7RRz
   wsqRSJKbOL3cHDRXehkl9uaE0XoUhtH9DWxvhWavY2zKiPLs1zfYxPziP
   L60FST9FI6Ip/UpTj07MGyynRDPei4X4OHtkeU+o9PSS50ti4o8XOasDA
   vyvUviMxPILxI5fvKmCJikIi/Vc3+8N32NSQah9mrzNJAJ0aeXuaGYhPe
   tMyJenxaa0D/ZFAjeG2LzVdukca3g0c4N3UJxNGwU9NF1YQhizVj+nwsB
   NncsC7J4HasfKRrUR99pKoEtqiwTf76YvNL4cU5A20kZL/HVAqdXlFa8n
   A==;
X-IronPort-AV: E=Sophos;i="5.98,254,1673884800"; 
   d="scan'208";a="225238757"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 13 Mar 2023 08:07:20 +0800
IronPort-SDR: 3X+ldbmYQ2aikmNUKaIkkF7QyIt9N+lEV2DCnEC0sxYZvm3QjNfl9DJCNeIAjlN2GcHIuV8rZo
 dVbwqxxdZ6DE28SvNVD6gZ2q5T5OwAeRF83irwnQYVrBoxFCKWDUl6tzsBnO1QC6NkVZ5ypVff
 wUABHeLuBcraNMPJ/615/XJUB9ovNzsY4tZSsL7S/uHfLyqZD+fyBC2DOPtDN9AKbR9iu+uCtI
 biopKQEFcyHlP/eWVsg+b7HjBtNK6sFnEWYuJqc3u9Xwz7ngw6yqA831X56AetC8/EjQtYdQSR
 hfY=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 12 Mar 2023 16:23:50 -0700
IronPort-SDR: axRvCjxTEg8wl308OYhGU0QkeXT1hjtOGwSHMJSpVtfdZ8xVtoL+gtp8O9j95Itnb7CoILxfmB
 +bDS1Lf4BM31w/Y+X4TDajqr6BX6H9HAOEoezSGe+uY3vm68iWT4/QiPigd98i6NLswkfR4QKP
 4XEaOM+aBfnmnxaaCBf8jD5DLDRU3RRww2sEZAHgdFvBgxdf/MIEwAW03ZSDIfFxE70TZckDtf
 wQRFUFdTlMc+B6MBal3qgEs5woqflXr4f5IAqNDrurA+fDoxkN6/oOQedSrUbbb8hMptMSRtm9
 Gpk=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 12 Mar 2023 17:07:20 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4PZcRD38c3z1Rwt8
        for <linux-ide@vger.kernel.org>; Sun, 12 Mar 2023 17:07:20 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1678666039; x=1681258040; bh=r9VZpfYxoyk1rMUrZi/rwjzuzmC5Z2gPyDh
        CfbA35qk=; b=FGgbAWvs/JxXYPnGwZKSEjkEaMjOhp+Rgja6vDvhHMuOrEDrahZ
        dGDtzAFpO1Lqa1Hh3PQuxLsKQ8M6muTr0Dc2d0f8Z8VzDbj+neIL3MOVF2oUoSLo
        mEFyxpGSfqW5SVMxq8BSinuxnB/ldCyUvAeNVDwYQLAbd/xgrxH5ysMpqHLCT4vs
        w4mskBHSQx7PE2lGEhtkGLJjXw+5NKkt53w3igmuhqePV2CkozbSONVxj0erDsQ+
        PMN6d29gr8jRj2CIt4Z3r+Ua9ynndZd0o/UUcR1slzUi6ZZ00VMSncjRdKdzYYg7
        ZSiGkh/fiQRxhbDLlePdDSSSTsruprT3/Uw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id X6wWXrQ2MoyG for <linux-ide@vger.kernel.org>;
        Sun, 12 Mar 2023 17:07:19 -0700 (PDT)
Received: from [10.225.163.79] (unknown [10.225.163.79])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4PZcRB3ZGRz1RvLy;
        Sun, 12 Mar 2023 17:07:18 -0700 (PDT)
Message-ID: <ea20a9bf-62ac-d307-4f3a-47b8d3e8a962@opensource.wdc.com>
Date:   Mon, 13 Mar 2023 09:07:16 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2] UML: pata_cs5536: fix build for X86_32 UML with
 TRACEPOINTS
Content-Language: en-US
To:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc:     Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-ide@vger.kernel.org, linux-um@lists.infradead.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
References: <20230312235553.26298-1-rdunlap@infradead.org>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20230312235553.26298-1-rdunlap@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 3/13/23 08:55, Randy Dunlap wrote:
> Current build of pata_cs5536 for i386 UML fails with:
> 
> ERROR: modpost: "__tracepoint_write_msr" [drivers/ata/pata_cs5536.ko] undefined!
> ERROR: modpost: "do_trace_write_msr" [drivers/ata/pata_cs5536.ko] undefined!
> ERROR: modpost: "__tracepoint_read_msr" [drivers/ata/pata_cs5536.ko] undefined!
> ERROR: modpost: "do_trace_read_msr" [drivers/ata/pata_cs5536.ko] undefined!
> 
> Add the arch/x86/lib/msr.o binary to resolve these undefined symbols.
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Richard Weinberger <richard@nod.at>
> Cc: Anton Ivanov <anton.ivanov@cambridgegreys.com>
> Cc: Johannes Berg <johannes@sipsolutions.net>
> Cc: Damien Le Moal <damien.lemoal@opensource.wdc.com>
> Cc: linux-ide@vger.kernel.org
> Cc: linux-um@lists.infradead.org
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> ---
>  arch/x86/um/Makefile |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff -- a/arch/x86/um/Makefile b/arch/x86/um/Makefile
> --- a/arch/x86/um/Makefile
> +++ b/arch/x86/um/Makefile
> @@ -21,7 +21,7 @@ obj-y += checksum_32.o syscalls_32.o
>  obj-$(CONFIG_ELF_CORE) += elfcore.o
>  
>  subarch-y = ../lib/string_32.o ../lib/atomic64_32.o ../lib/atomic64_cx8_32.o
> -subarch-y += ../lib/cmpxchg8b_emu.o ../lib/atomic64_386_32.o
> +subarch-y += ../lib/cmpxchg8b_emu.o ../lib/atomic64_386_32.o ../lib/msr.o
>  subarch-y += ../kernel/sys_ia32.o
>  
>  else

Looks OK to me.

Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

-- 
Damien Le Moal
Western Digital Research

