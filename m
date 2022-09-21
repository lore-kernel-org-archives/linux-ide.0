Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DFDAC32771
	for <linux-ide@archiver.kernel.org>; Wed, 21 Sep 2022 04:40:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230441AbiIUEkP (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 21 Sep 2022 00:40:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231499AbiIUEjk (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 21 Sep 2022 00:39:40 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 547D76357
        for <linux-ide@vger.kernel.org>; Tue, 20 Sep 2022 21:39:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1663735172; x=1695271172;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=xk8yyDaZspFAzE+Di7pJlp2SQFYiW5o4GxxXQYufai0=;
  b=HmHPAFELevjSbySs7mkup4YPtM/R16/7fwWApYGqcPrQ46BsDrGA/jP3
   YviQZ5y88pRxXtJAKwJBiuh36vsTmOi0moa72GqSvksAq1VpM/UWkWpS0
   uBlxc5La3UlTljCCasDBgms8AwPGHKmPG/WhfRAU7ItJucHEZHA4mEiZ6
   ziImDrK8EIJgbDCUAjrIvWVjSmvg/EUT2GStq8muCiREMwVV0AqHAMqMi
   9aIpsC5FfzOWYMyJ0CuiSarbxwZEAbZ8g+stIDszeMIUI9T826suCK+qh
   dooX0Td2Bh44ckR6P7zATNewIla1EdTWhJ8uURVoOXhuq1g/wXu7potMf
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,332,1654531200"; 
   d="scan'208";a="211873333"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 21 Sep 2022 12:39:31 +0800
IronPort-SDR: MsY0v1g8Yeit5FpYTFMy7rMKjSJMfU1fpJv83pzKdf4sUn8VlNj54uh6UlUiuhVB9bU0eiGwXS
 atcTU5Hv9itoVuWErsOebw2Haw8fPlI8D0f3xMw9TEg8BWwEe+S27/3+zVDq766gtuoHsSYWzi
 UaM/7JYUH2/bwQQo24JUcgQVLe6IQV3MX+U96VpYNYd8ow1okFW+jxdYrJTz/XU9BMeWp3Nsun
 F9ZxlYypQsardTfIr+iAkFL5qNURCIln9Wg3OlKz+4Mldp64Y1m+WqyAuzw8oStbIs/CNZ9LD6
 NW9SILTa45HLLmDCVwhz9y6I
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Sep 2022 20:59:37 -0700
IronPort-SDR: eKDzWTqrWmcjx5ibvqmDkWcYsgkyY2QAHItcI5AzPw8MyFLDF+3YViNznF9EnTpst7o0B2v6nA
 1F/mhkVusxvtxVVH+5aLCGzrOggjSRJDtkRSM8MyQOF8cd8SpqqfYrIY4O8We+Ue7Terhc/Uw6
 rsIBrtB9nXZbuKaoYk6HpCjaI7ZSwcR39C/ipK2uzjOif20p6oQVFv9M72Sz1LIKcDdelqmNqH
 kqS2PL/4YpjgkTolZG2zp5k2x+Fhmzvd0wJac8lqxjY/2GeHKBoqyyjhyu773LQZ8PGdAdqvXs
 6HE=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Sep 2022 21:39:34 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4MXQg86kL7z1Rwtm
        for <linux-ide@vger.kernel.org>; Tue, 20 Sep 2022 21:39:32 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1663735172; x=1666327173; bh=xk8yyDaZspFAzE+Di7pJlp2SQFYiW5o4Gxx
        XQYufai0=; b=QFzuDn8VoE55G7Y+r9G+jvhfFtkylOQpVPf3IZyXLg923zvOhsS
        xHcUD4o04fjTQ1VPID6olxJcD+hFh2srQ8+kIkWQOW+WVUOTfFgn4uwi1mcp9XVy
        S+5p9ZJGAt6whfzdUNtvgva702cmdtWLFxxb/IokYqha6k0ofRTYWGket2OgmIJT
        eY8wb92K1PvFisicClwQMEA/DXjupgMHMqq0UXaAqBqA1EDRdRwKmzoDtujc/C8x
        2aQgw7M9JDG0c2Tmf+5yHKqI7GFfA9uiaCKUAuHPoC2736QrNbUs71Lc3qISgf0/
        sUdteRYwny1iowX/+j4iWbPtXd1vkbOVQFQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id ajwy8QorDniD for <linux-ide@vger.kernel.org>;
        Tue, 20 Sep 2022 21:39:32 -0700 (PDT)
Received: from [10.149.53.254] (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4MXQg54pxSz1RvLy;
        Tue, 20 Sep 2022 21:39:29 -0700 (PDT)
Message-ID: <0f451727-0d99-e575-b5e0-1e0d48394a07@opensource.wdc.com>
Date:   Wed, 21 Sep 2022 13:39:27 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH 0/6] IDENTIFY DEVICE supported bit fixes
Content-Language: en-US
To:     Niklas Cassel <niklas.cassel@wdc.com>,
        Hannes Reinecke <hare@suse.de>, Tejun Heo <tj@kernel.org>,
        Aaron Lu <aaron.lwe@gmail.com>,
        Shane Huang <shane.huang@amd.com>,
        Jeff Garzik <jgarzik@redhat.com>,
        Kristen Carlson Accardi <kristen.c.accardi@intel.com>
Cc:     linux-ide@vger.kernel.org
References: <20220916122838.1190628-1-niklas.cassel@wdc.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220916122838.1190628-1-niklas.cassel@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 9/16/22 21:28, Niklas Cassel wrote:
> Hello,
> 
> This series fixes some incorrect handling of the supported bits
> in IDENTIFY DEVICE data.
> 
> As a bonus, there are two small cleanups which removes superfluous
> parameters in libata-eh.c.

Applied to for-6.1. Thanks !


> 
> 
> Kind regards,
> Niklas
> 
> Niklas Cassel (6):
>    ata: fix ata_id_sense_reporting_enabled() and
>      ata_id_has_sense_reporting()
>    ata: fix ata_id_has_devslp()
>    ata: fix ata_id_has_ncq_autosense()
>    ata: fix ata_id_has_dipm()
>    ata: libata: drop superfluous ata_eh_request_sense() parameter
>    ata: libata: drop superfluous ata_eh_analyze_tf() parameter
> 
>   drivers/ata/libata-eh.c | 14 ++++++--------
>   include/linux/ata.h     | 39 +++++++++++++++++++++------------------
>   2 files changed, 27 insertions(+), 26 deletions(-)
> 

-- 
Damien Le Moal
Western Digital Research

