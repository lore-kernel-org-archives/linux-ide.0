Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87ADEC433F5
	for <linux-ide@archiver.kernel.org>; Thu, 10 Feb 2022 03:08:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232118AbiBJDIM (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 9 Feb 2022 22:08:12 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231760AbiBJDIK (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 9 Feb 2022 22:08:10 -0500
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D24AB1EACE
        for <linux-ide@vger.kernel.org>; Wed,  9 Feb 2022 19:08:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1644462491; x=1675998491;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=lZWgOJTtzHCMCTQlvuv8nsB7aIKH//sNTjX8h7bnNzM=;
  b=jMN9e6ENKt7MF2CDLd/zpMmXVPXnEr+SjkDcpPS0EqOZllZP1DfbgPH6
   E7SXefzpfsi54UZkv38Btn1aeqPRCvaMcQLcIeEqNzCqaXhV6OH+aYp13
   AOy8I4apuNvYNYqzad8n0RLz+C20uvySkkZ9ct75w+IZxv9yJxQbXfQp6
   1XLmPsQIG34ufiqykGTiteib8uSmVYK+cGHhPT91C5ChgrPMcmkcnvdd+
   CpFkvihQ3BsMlreAdyvl3GIGSYSPhrGD0sAjFHqwP84KvBeTNL/rJhJhr
   U5UfZ4zgAAplscjnjJgfwUdr1LpXkGEwTnJCNsAfCDiwpNXWKw5nFmc1e
   A==;
X-IronPort-AV: E=Sophos;i="5.88,357,1635177600"; 
   d="scan'208";a="197379434"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 10 Feb 2022 11:08:11 +0800
IronPort-SDR: 0+Tc5FNy2af5V0QOVUjpYcWPvH4E+BviAyodYgsDa4m3ayWOdarE3V+J72WrSiiz6i6uBX0bSL
 ORbRxMaBjCNFwYHOiU6suedn2Hf3ydSfyuzk7Teb9vKl+4gVS0qqURgHCuqYclT7ihlMEeUxvv
 boD6kONXJtWl0yn86ZrJqSNjOR6ww2SQ443TV2EVEA5n6ak7y/uC6xsZx+ItXdAljGLcFh3usr
 becR6mwMHEDfOWGC6VuVUwj7C2Zn3UL2b/5nElmdEv+udoURBVogKecfoBHW1k6hRPwSvo7BNb
 c4awptcvjb49kA8F6Dr/VoMf
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2022 18:39:59 -0800
IronPort-SDR: z8Q7fFYg321rORiyF3J2hOBacr5w2J1ZcsAWe2PPPrVLGBHb7xxlADXRhzKk8TYYcUDDd3tQhc
 s6ChhZRWtC9hSkfMq/7P/B9/GlLKpMvaOQa4AHD1GxL/F1eF51jHikkFaeN9dqqrr8FnjzIAmZ
 NE5408G3iQT4vZnPij6oDBKJJHJNGu5l9Vgpw+XmVV023g81UniAYPp1Vt1BOUkVh8RYb30iJQ
 IqELd8F9Re7NV1zeK1GlzSv9rTcNckwHkytkeiZqfhnsLBAqcBwEVJIACwQllc85Ynf0ObH3ge
 PNI=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2022 19:08:12 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4JvMBg6f32z1SVnx
        for <linux-ide@vger.kernel.org>; Wed,  9 Feb 2022 19:08:11 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1644462491; x=1647054492; bh=lZWgOJTtzHCMCTQlvuv8nsB7aIKH//sNTjX
        8h7bnNzM=; b=I3gwDvFg2GpY3vMZMdZ+nvAxNjf+YMBsSkoWewZeQBEL+BGsKCF
        oUR5t15SuYCUsVWVpoIMrYEk9Osvg+ns3/EZRyO+eWtUd5uXd3rSukmNVQowAwYR
        XouYcTigc8MHAunAS8GMamU4C82gqbvJPvCRhWjhg3fYx9s98r+NetfmJtS0+F6P
        f28YOOsFsNiH1g2wvTLCLROpN3c/PIgXtOUOQ3C4SIXkUBqoTtw3rur2Aip76jm5
        Lg/FY4MIUxTEuJlvrDOQby51EQa60k1DnPs5QIdyIXzVAHEho3LmzAzAwP1n8pUt
        m8Q842/Na6XC5wifMF3SA+8kW1thbGT3RyQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id cAvTYcAeX2iK for <linux-ide@vger.kernel.org>;
        Wed,  9 Feb 2022 19:08:11 -0800 (PST)
Received: from [10.225.163.67] (unknown [10.225.163.67])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4JvMBg2LQdz1Rwrw;
        Wed,  9 Feb 2022 19:08:11 -0800 (PST)
Message-ID: <f1c8a0ad-5540-7602-cfb1-23709514a79f@opensource.wdc.com>
Date:   Thu, 10 Feb 2022 12:08:10 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 0/3] Make all the devchk() functions return 'bool`
Content-Language: en-US
To:     Sergey Shtylyov <s.shtylyov@omp.ru>, linux-ide@vger.kernel.org
References: <20220209214630.13340-1-s.shtylyov@omp.ru>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220209214630.13340-1-s.shtylyov@omp.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 2/10/22 06:46, Sergey Shtylyov wrote:
> Here are 3 patches against the 'for-next' branch of Damien Le Moal's
> 'libata.git' repo. Make all the devchk() functions return 'bool` inbstead
> of 'unsigned int'.
> 
> Sergey Shtylyov (3):
>   ata: libata-sff: make ata_devchk() return 'bool'
>   ata: pata_samsung_cf: make pata_s3c_devchk() return 'bool'
>   ata: sata_rcar: make sata_rcar_ata_devchk() return 'bool'
> 
>  drivers/ata/libata-sff.c      | 9 ++++++---
>  drivers/ata/pata_samsung_cf.c | 7 +++----
>  drivers/ata/sata_rcar.c       | 7 +++----
>  3 files changed, 12 insertions(+), 11 deletions(-)
> 

Applied to for-5.18. Thanks !

-- 
Damien Le Moal
Western Digital Research
