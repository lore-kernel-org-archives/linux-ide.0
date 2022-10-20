Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99352C4332F
	for <linux-ide@archiver.kernel.org>; Thu, 20 Oct 2022 23:02:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230198AbiJTXC2 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 20 Oct 2022 19:02:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230201AbiJTXCO (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 20 Oct 2022 19:02:14 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FCE9226E41
        for <linux-ide@vger.kernel.org>; Thu, 20 Oct 2022 16:01:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1666306909; x=1697842909;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Bg5M7y12D4gJpMO8gsuVNutJYhINteo3qvPHqJX1v44=;
  b=j1oRUs27fm6GC/qxKB3cVKJAQHI+ld2DqTRdkdl41ScSEYyAlzWhlfu1
   56k0aEVlIsZ3m3qVSN4BPh9r/bnPDfrkKkJyaKPqWgJEyGQRlX7h4IBEA
   vxvm8UrVGuaX9CuPgJqe2ZQLVBlhPdL089pN7qCWaMZDgrsz3482P7c4r
   +U22UmDzNopvlj1wx3ZqDpRq1R+7LSpOvzX8wtMATGhLlQHFAP7iKtyJb
   vBwDgEtyPRiC+RAV5bsnOu8TxN57Fn0vcEqigKk1CjhFStHuPKA1/Q/dt
   KKzycWDynQc86JwR/UT/444dZF/xl78YcdmNzdD2IvIILKVf7ZNAyBbzn
   Q==;
X-IronPort-AV: E=Sophos;i="5.95,200,1661788800"; 
   d="scan'208";a="326488144"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 21 Oct 2022 07:01:47 +0800
IronPort-SDR: oD2YndqASCSbHut16qrmne9LjMxEvqHocVmeSKt665e7+57nzsMUtLb6hesnaviFPxMThQYOzN
 nfnAnriG9EkZmF0DMafagcQV/R/QD8yuIwrFCfnITU3up37TQcaRjpEqG7jk5ElDx+rFmmjgfy
 9kM50q/ErGIyIpgtyAZPxmFIHfvmqHMBs1Cx6oI9qPzARFEhbwPEiqOnPs0lAGiywPy6RWO+Mh
 HW4k6Ih9cuY9ccE0ZsZ6gK+Sscqbss2c9ONvyzsO78H4TAfCCAURTYbN6xUedatIC89dTlRXia
 O2hkjzUOVrTNFJsHTes/X3D6
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Oct 2022 15:21:16 -0700
IronPort-SDR: P9NCWvb/IO3jBXMYtnnVhCFttwyiVoDTLE32y/RbodxyX4QIrbkGmuGXCz9tD8JKKEmIqAGv6K
 ehOkIOomXgFWXpVoBzVVkWUj94uvTNMmAqqF7ojR9qOA0Y8QpEYoJkDdsDWWktn14grDhz/JWX
 Q8eIM3e1feklSEzGQqQbg9ywV6wIDLxzsAP9ZgBsSccZPXa4nrtzMVSqIA9lHWMcjKx9gTUafs
 XxSsZOvLz97AE5BhvTDz3bLyeyNGzPkJanXqXZSDyqfyqHnzpD+R0zS90XDdiDl6cR8WdFKVZ2
 /pc=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Oct 2022 16:01:49 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Mtjlb410wz1RvTp
        for <linux-ide@vger.kernel.org>; Thu, 20 Oct 2022 16:01:47 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1666306907; x=1668898908; bh=Bg5M7y12D4gJpMO8gsuVNutJYhINteo3qvP
        HqJX1v44=; b=C+XjP1I5SxxXO60+vLLE9eWa1brPSNt935o4Q5a1Ftp6faVCEAA
        IgM1YeJr/Wo8JVBdeNN3YyldP6HRtVnVWa//vXonhwSB0iAXBls8khRpdHiu7A0s
        vH/WAY+1qwTUGjp+dN3bM/8Fvz1HfVdBewwgfhpC0G/43F8VbA0ra4N0kU+jc6zf
        g+VzqvjBCmK3Z8n2sgTx5n+8V1pwftcYP/fpuYpE4ZbK2aVpYKdrnRrSrCppZ4n1
        rGCcuteZIWZLHrc4deEv7I8EoEgRBS/9MXzC2bUIix4SKt+cGWbeqAC5In7kgJiy
        3YdnxAVEvNH5CY9vbQjVUvVo8QTgbSnczPA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id A3TIJWOO2bcH for <linux-ide@vger.kernel.org>;
        Thu, 20 Oct 2022 16:01:47 -0700 (PDT)
Received: from [10.225.163.126] (unknown [10.225.163.126])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4MtjlZ6Sdnz1RvLy;
        Thu, 20 Oct 2022 16:01:46 -0700 (PDT)
Message-ID: <402c81f2-7ab4-ca1f-cae5-b71ec4958e43@opensource.wdc.com>
Date:   Fri, 21 Oct 2022 08:01:42 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH 1/3] ata: remove unused helper ata_id_lba48_enabled()
Content-Language: en-US
To:     Niklas Cassel <niklas.cassel@wdc.com>
Cc:     linux-ide@vger.kernel.org
References: <20221018191055.2367325-1-niklas.cassel@wdc.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20221018191055.2367325-1-niklas.cassel@wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 10/19/22 04:10, Niklas Cassel wrote:
> Not only is this function unused, but even worse, the bit it is checking
> is actually used for signaling if the feature is supported, not enabled.
> Therefore, remove the unused helper function ata_id_lba48_enabled().
> 
> ata_id_has_lba48() is left unmodified, since this extra supported bit
> (Bit 10 of word 86) is simply a copy of the bit that ata_id_has_lba48()
> already checks (Bit 10 of word 83), see ACS-5 r10:
> 7.13.6.41 Words 85..87, 120: Commands and feature sets supported or enabled
> 
> Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>

Applied with patches 2 and 3 to for-6.2. Thanks !

> ---
>  include/linux/ata.h | 9 ---------
>  1 file changed, 9 deletions(-)
> 
> diff --git a/include/linux/ata.h b/include/linux/ata.h
> index e3050e153a71..c04aca58448a 100644
> --- a/include/linux/ata.h
> +++ b/include/linux/ata.h
> @@ -698,15 +698,6 @@ static inline bool ata_id_has_lba48(const u16 *id)
>  	return id[ATA_ID_COMMAND_SET_2] & (1 << 10);
>  }
>  
> -static inline bool ata_id_lba48_enabled(const u16 *id)
> -{
> -	if (ata_id_has_lba48(id) == 0)
> -		return false;
> -	if ((id[ATA_ID_CSF_DEFAULT] & 0xC000) != 0x4000)
> -		return false;
> -	return id[ATA_ID_CFS_ENABLE_2] & (1 << 10);
> -}
> -
>  static inline bool ata_id_hpa_enabled(const u16 *id)
>  {
>  	/* Yes children, word 83 valid bits cover word 82 data */

-- 
Damien Le Moal
Western Digital Research

