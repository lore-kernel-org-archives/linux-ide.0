Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF5E3C6FD1D
	for <linux-ide@archiver.kernel.org>; Tue, 14 Mar 2023 12:13:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231828AbjCNMNm (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 14 Mar 2023 08:13:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231783AbjCNMN3 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 14 Mar 2023 08:13:29 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2559A27C
        for <linux-ide@vger.kernel.org>; Tue, 14 Mar 2023 05:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1678795969; x=1710331969;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=AWlliTNQy/jtW/E1Q9kESrXcsNXoqskGW2n4Kz4CcNM=;
  b=psT4jPZGXx/kS/otHcqipW/m/ipAayRvSJ8zADaTuo7KrOUFTn2GFPn/
   CrwUEamMtJWwDWEHM63g13+ARkCLSXk6O2h6jx9Uls4/jeN9tXW9Hy2LN
   de3nhWryf5evp1eR0StjcQdbMp0TNk51zgC68GRaNFKnEfAjZRXk6OKHQ
   R4wzeNSoRWyLR7fM+PeEnzdgD0tqDwyYxjMOKxJaFAHB2PMMA15iYzVJx
   fnDR6Fm8S6q129Aw/T8k6Jx+Vjm9BZVL/G7fRNTZMItre0UoqCiyo2kvF
   xPZaf+iQLAn1Ar06tNkl9Ep8ACBIi39XedPQYCJoQxk3MhIG4yzq1YWYt
   A==;
X-IronPort-AV: E=Sophos;i="5.98,259,1673884800"; 
   d="scan'208";a="223879557"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 14 Mar 2023 20:12:31 +0800
IronPort-SDR: z7RjHVV2homgxidIjykOReMA1Iclk45ZJurMOxilkll+JpV9Q+fFgq7cCJZZUA+jl4zmERzcgy
 UqQwJRY1+HjrtBZEjLpEQUBqn1j/1gI59wdyQ8VrSGz3AxqFvG7TOavSKid6tVFLyBgoZ4ATDK
 n0R33O1OZFhf0cRv0y5FTvgmNa4vvF/o0rQzwk0Z7GSLuoNwuepQob6Q5Y0uA71eTjDt2HDkP7
 NYxs7OCjwsTqAoOXrvdFZyBtZAbJQ7hO/Ytac/ZG/DFSYVRL+UEcY5vSGaNc50MmJBdmA4Je0t
 eq8=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Mar 2023 04:23:18 -0700
IronPort-SDR: T4tlbIfezIcOpfCymFwSvoGtQbk/i58zzb+3V73eR7jXMeTbqiP+PF2Wbztdnf3lGAmjx8DKah
 TkFf8PD4fj/8/XBgtvfmbss8RaiabrQIbrTtcwWNkINTs/fEChBgMWqytxj97JQ/L7CJ8t4Waz
 DPoYW8c53Wk0Ol2zqUP39/9e4ShOYUYgVyoZw2yw9biPCA+vW3e3KytzMPpeAyA7d5nc2BDqZB
 pedyTLxHN8/+vJFF72HV/BcL/utrQAQPG5XAzF4MlJ1lOSIiVHPnlz4qteaQC+yn5d9GaThIuL
 CWk=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Mar 2023 05:12:32 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4PbXTV74Xvz1RtVw
        for <linux-ide@vger.kernel.org>; Tue, 14 Mar 2023 05:12:30 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:content-language:references:to
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1678795950; x=1681387951; bh=AWlliTNQy/jtW/E1Q9kESrXcsNXoqskGW2n
        4Kz4CcNM=; b=dcRlGhE9YGHu+giJbC0D0Ij4I8F+fruLSEa86H2oLB7+c0LDRAm
        nqcXES3yCK4XAMhVL2Ymg02x5uzM9e4V/kh3sXxOt69qD78k+hNqhbSHTkryVbgE
        V3JtNyGhW5i+GqmJbBF14VuvUNrUf2kn9BEhIysopzTh5KKUXYqRGz8RqKNS1ZON
        LgVkrzRXIgDQ/EDYV6IM1oSaVDvB/oFGHHCzYwCrJeCCtktlCEBOdEONjE+md9Rp
        Jjmn0vnPgYV7rC7lIFFPfKwAVlK9zHlRE172nRVLnBUM7gQ0ZpFRuBlaHooBG8aq
        Q1CyqzbDzIF3u9V3g9E3CLb08lg9G9L62KA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id dzrf_hzItePL for <linux-ide@vger.kernel.org>;
        Tue, 14 Mar 2023 05:12:30 -0700 (PDT)
Received: from [10.225.163.84] (unknown [10.225.163.84])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4PbXTT2PB0z1RtVm;
        Tue, 14 Mar 2023 05:12:29 -0700 (PDT)
Message-ID: <76456032-cc76-aede-f760-65cb999a2163@opensource.wdc.com>
Date:   Tue, 14 Mar 2023 21:12:27 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2 resend 3] ahci: qoriq: Add platform dependencies
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     linux-ide@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Li Yang <leoyang.li@nxp.com>
References: <3b6733f683c13ac02093206e76a3e30c7d045366.1678279668.git.geert+renesas@glider.be>
Content-Language: en-US
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <3b6733f683c13ac02093206e76a3e30c7d045366.1678279668.git.geert+renesas@glider.be>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 3/8/23 21:49, Geert Uytterhoeven wrote:
> The Freescale QorIQ AHCI SATA controller is only present on Freescale
> Layerscape SoCs.  Add platform dependencies to the AHCI_QORIQ config
> symbol, to avoid asking the user about it when configuring a kernel
> without Layerscape support.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> Acked-by: Li Yang <leoyang.li@nxp.com>
> ---
> v2:
>   - Add Acked-by.
> ---
>  drivers/ata/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
> index b56fba76b43f48f7..42b51c9812a0ebab 100644
> --- a/drivers/ata/Kconfig
> +++ b/drivers/ata/Kconfig
> @@ -276,6 +276,7 @@ config AHCI_XGENE
>  config AHCI_QORIQ
>  	tristate "Freescale QorIQ AHCI SATA support"
>  	depends on OF
> +	depends on SOC_LS1021A || ARCH_LAYERSCAPE || COMPILE_TEST
>  	select SATA_HOST
>  	help
>  	  This option enables support for the Freescale QorIQ AHCI SoC's

Do you want this in fixes or queuing this for 6.4 is fine ?

-- 
Damien Le Moal
Western Digital Research

