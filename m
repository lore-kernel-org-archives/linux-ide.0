Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D8F3C433F5
	for <linux-ide@archiver.kernel.org>; Thu,  6 Jan 2022 02:52:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231985AbiAFCw4 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 5 Jan 2022 21:52:56 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:14316 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229949AbiAFCwx (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 5 Jan 2022 21:52:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1641437573; x=1672973573;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=98OiUdHi4swFi06EIaky9B6rH6+M+tkp9KhtFug2Fok=;
  b=cg7lu+yCANwHNK+rW8mp91g0vZC8nKebFAhQA+IC9XdlmTfwgUgOtz74
   B2QVPNWuftcWb/8fM0iDmYDlCJ0FNO/7zESaNCX/1ueN/2OhkaJ/4+FeT
   7k/UsZB+BGjY4yyfhF4tlBBA0YkYkhX1jaF+BTQA60SEnhsx0j1PYClt+
   rCryettGe8iytgXlAa/KU6HD/4H0KWs6kzY+oin/O8EatKZstKQZpjpP4
   0eflEtQWPR6wAzxzSoOtF4eCYSBndHK/R+JM2mVbEnOd/Cskll1ptgGv2
   gT1De0dLpF66So8uE3HwaG+iUidayeh3sUvEtpqewkmhC05OnfrO4S1T3
   w==;
X-IronPort-AV: E=Sophos;i="5.88,265,1635177600"; 
   d="scan'208";a="301664732"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 06 Jan 2022 10:52:52 +0800
IronPort-SDR: fAchLf3s+qYp8DoTuF3xhlgMnBJ9MvqGLiO5xDHgKlTnpRkxboI3sx4EInDalub8zVDl28uoVJ
 z5TVAxd4zpOh1Ew8XRLtt2P3q/uaYlfGnXiDS8cQZhRgdEDB14kAk5nCFIMfFqsonSJ9lPn795
 YEfYRn1DLurlgUroqgadCsHSYyDsqLVNckMobpNItiDrIJz9m4bzLr+kNqtR0GDezAzTg7LiVT
 X/6XkhV/+QTjPuHtDFpQ/wpqyUpMw+F0q4UK5hG5udgKe8u/h9MQKAxeiNjrfrDuPHqLy+GcxL
 M5G7w95py/Ud/koZTg3vRp1T
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2022 18:26:42 -0800
IronPort-SDR: vTOQOJXiD7Cg+6N1CLPg0OyYpZMiV47xuvYxg2vkNBSrVPYEASeDJTRj9D2DfjqoIvdJcO/uaN
 mggukvEEOwAc5eBulrx02BJgMKbW/b8x3JqSPM5bErP5csUDs9rW0VXXnYu7recsT6Bq+KVdvQ
 hQqntHHa+j49xytS+l2uABoYfezEKaZYhc/pQzXrK58QqE/usdkU0KJUh7biW2Onhq47+LYU5h
 NO0nCzmdeRADCLnpQ6AAwGd8Y0mlij1mOBNawwxPjsbqZSYyVssI7feTtR8pwqaYLWaL625hKH
 2Qg=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2022 18:52:53 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4JTrW76SDrz1VSkd
        for <linux-ide@vger.kernel.org>; Wed,  5 Jan 2022 18:52:51 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1641437571; x=1644029572; bh=98OiUdHi4swFi06EIaky9B6rH6+M+tkp9Kh
        tFug2Fok=; b=eNolhVbJzbZU7z20M7JO0GfuLuYaPXY5+//wbbIiTzxW9TC6mfv
        U39zcHoD3NrXlb6flJDjeaW5rrpPg+eNISEU1yOSZRw15M8jouSdVcPiOEORAL6K
        6nqATDohAlWOTED2jsYMDufccRuiuhtB5WdG73xytyJCTIw/CCxKlQFSOyzpxybH
        D4Psnr8MFUpIZqA8t9ZHtG2oQsME7h39ZgrUCcmo8s1Zyf1vQqTmF7QAj3PvdPOO
        Fm0DZH2OT8k0GhHqzXAYjeUwKZYwxlpkzH3yDDdKerYKj9gmAWAJExLRxl4RzxKS
        /l8qDKRQ/AZWu8mdyfn4T2YpgSPx7CIDkFA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id D_3NU4gWqhTc for <linux-ide@vger.kernel.org>;
        Wed,  5 Jan 2022 18:52:51 -0800 (PST)
Received: from [10.225.163.43] (unknown [10.225.163.43])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4JTrW66Xk0z1VSkV;
        Wed,  5 Jan 2022 18:52:50 -0800 (PST)
Message-ID: <d5130eed-d881-f654-3e24-b552609abce9@opensource.wdc.com>
Date:   Thu, 6 Jan 2022 11:52:49 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v4 1/2] ahci: Rename flag `ATA_LFLAG_NO_DB_DELAY` to
 `ATA_LFLAG_NO_DEBOUNCE_DELAY`
Content-Language: en-US
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220105153618.2395-1-pmenzel@molgen.mpg.de>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220105153618.2395-1-pmenzel@molgen.mpg.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 1/6/22 00:36, Paul Menzel wrote:
> The new name is longer, but clearer.

It looks like you sent an incremental change on top of your previous
patches. Please send a cleaned up series. One patch to introduce the
ATA_LFLAG_NO_DEBOUNCE_DELAY flag & msleep bypass and another to add the
AMD chipset.

The commit message of this version patch 2 should be the explanation for
the ATA_LFLAG_NO_DEBOUNCE_DELAY flag, not for adding a new chipset ID.

> 
> Signed-off-by: Paul Menzel <pmenzel@molgen.mpg.de>
> ---
>  drivers/ata/ahci_brcm.c   | 2 +-
>  drivers/ata/libata-sata.c | 2 +-
>  include/linux/libata.h    | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/ata/ahci_brcm.c b/drivers/ata/ahci_brcm.c
> index 6e9c5ade4c2ea..649815c196ed0 100644
> --- a/drivers/ata/ahci_brcm.c
> +++ b/drivers/ata/ahci_brcm.c
> @@ -333,7 +333,7 @@ static struct ata_port_operations ahci_brcm_platform_ops = {
>  
>  static const struct ata_port_info ahci_brcm_port_info = {
>  	.flags		= AHCI_FLAG_COMMON | ATA_FLAG_NO_DIPM,
> -	.link_flags	= ATA_LFLAG_NO_DB_DELAY,
> +	.link_flags	= ATA_LFLAG_NO_DEBOUNCE_DELAY,
>  	.pio_mask	= ATA_PIO4,
>  	.udma_mask	= ATA_UDMA6,
>  	.port_ops	= &ahci_brcm_platform_ops,
> diff --git a/drivers/ata/libata-sata.c b/drivers/ata/libata-sata.c
> index b9c77885b8726..67b2e7cf3cc4e 100644
> --- a/drivers/ata/libata-sata.c
> +++ b/drivers/ata/libata-sata.c
> @@ -317,7 +317,7 @@ int sata_link_resume(struct ata_link *link, const unsigned long *params,
>  		 * immediately after resuming.  Delay 200ms before
>  		 * debouncing.
>  		 */
> -		if (!(link->flags & ATA_LFLAG_NO_DB_DELAY))
> +		if (!(link->flags & ATA_LFLAG_NO_DEBOUNCE_DELAY))
>  			ata_msleep(link->ap, 200);
>  
>  		/* is SControl restored correctly? */
> diff --git a/include/linux/libata.h b/include/linux/libata.h
> index 2a8404b26083c..15802e644962d 100644
> --- a/include/linux/libata.h
> +++ b/include/linux/libata.h
> @@ -191,7 +191,7 @@ enum {
>  	ATA_LFLAG_NO_LPM	= (1 << 8), /* disable LPM on this link */
>  	ATA_LFLAG_RST_ONCE	= (1 << 9), /* limit recovery to one reset */
>  	ATA_LFLAG_CHANGED	= (1 << 10), /* LPM state changed on this link */
> -	ATA_LFLAG_NO_DB_DELAY	= (1 << 11), /* no debounce delay on link resume */
> +	ATA_LFLAG_NO_DEBOUNCE_DELAY = (1 << 11), /* no debounce delay on link resume */
>  
>  	/* struct ata_port flags */
>  	ATA_FLAG_SLAVE_POSS	= (1 << 0), /* host supports slave dev */


-- 
Damien Le Moal
Western Digital Research
