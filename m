Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93242C433EF
	for <linux-ide@archiver.kernel.org>; Wed, 23 Mar 2022 05:45:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238784AbiCWFqq (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 23 Mar 2022 01:46:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231161AbiCWFqq (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 23 Mar 2022 01:46:46 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94238710C5
        for <linux-ide@vger.kernel.org>; Tue, 22 Mar 2022 22:45:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1648014317; x=1679550317;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=pmgRbLy3Prn/gIHeSN+Wt+WYfjNoUuIEjQFsIkjQP3I=;
  b=iqF1jFXAYnem2XZhUQ3KJo7x/nFsSZdW4Jc+wtOLrUaWFlyGPFYhvyES
   aSgGBFDiWNdSAWJen8cFgPbJa7t2HlSjdtKihObr1ygwMRYXOmnuJcPgG
   8yYdXEU8kfBTDVo/wdWHnWLIw3+eel1vfQdDVlTzmT5JHqoCYTAkJboWZ
   wmRmBYyLbAv9O/5pGxuEzTF+fihHQKB2Mn1wjVj450hJNJ+ArxoqOwfgG
   o7Kgu4IcJltOuwqNb3v+RXGkx5MVgw8EjZbfcmNomuaIFSdWqGeP8DLM0
   GccjQ1HJLiygZdI/ZyaW0MwQL+ySQerO+hwtR6K395reSMfRy7o2zd4q/
   A==;
X-IronPort-AV: E=Sophos;i="5.90,203,1643644800"; 
   d="scan'208";a="300181936"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 23 Mar 2022 13:45:15 +0800
IronPort-SDR: YNdRr3ZvV1RMXe/z0FOUc+hqV2cxgOQGyWfKvbBbKIFGvMyuIyWG0cUghASv5jTlyUDH/iFmS1
 D5+kgNSSLpFNSzoFyv6Z1ud7ecDIYPXAMvTzWNQVQ9omnbQqQXe61sSfRBBaGoC1N2lhsoS7Q3
 wTr9T746RMlX3gcVSZsV8tbOmXEOwcHD1OvyyJDbAvqmCOMwV42zrjVlAO7Lsw1E5TLFbCMJOn
 S4hDVXUDgr49sG1hmH3UXXWJqvtILhq0n/Er5ZVMOzzsPhAER5Bv0XRQ1jAN5mfLdqUqRa0lJ1
 Nr20jtnCI3g70bWhZwxP1urE
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2022 22:16:14 -0700
IronPort-SDR: Z1JBkh1R/h8rrpBhXRa76CPYOtxSzKJv8PmN9Iht4sjk054g1rrF8oPMCtjIZpE9418Yf1bZyu
 dZVypxbz/qZx/uK7oqAk/CNDQfWnKzPzTx0k26WoQhXsYvEYRyzlg0w5rAEx6FpmDpJoVlu4F9
 re/Bc1b6ZsmfDGCvcFfiLVYkkvJO2tz0NWIi7Sfz5+NHG8UUwBlz4ryPEcd0FYw4p+H9MYG77u
 P7Eeo19ww6oFt+9rKyG5bfUO7xHcbp0WWJJLyo+QWhqrVIPZqpiDCOhFJAyBKmXrnV936nEcFg
 q4g=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2022 22:45:16 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4KNckz1Fynz1SVp1
        for <linux-ide@vger.kernel.org>; Tue, 22 Mar 2022 22:45:15 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1648014314; x=1650606315; bh=pmgRbLy3Prn/gIHeSN+Wt+WYfjNoUuIEjQF
        sIkjQP3I=; b=RPI8U5O8rKPDUdkEiu1c7EUCRc79R09Hu5tXkiYWokfwGtJQB42
        X2UP9FxfpjN9JzFW+FaNArwoXRf0Sck/rv7qdYh+LvG6FBOqT95+lcOuoT3yDli8
        rGG+9wzTs7fVGCMQlIMgrO244OBQd+3rbbywgcbNFvIkScQ/6rIin4HKbgtcUcBd
        SOog+Hoc3oCppk97OXTXedMvfCDX5XkYwzNmh0P2gTPkQWjpGq0F39K6C3Js1LME
        A0JfQMvkrJtt1Br1+7/UpqXjQsSkO3KENDu3W3Gn9NrL2lcTsuj6Pb/8U14HeEHe
        0ZqSmpZXCKs35bITxBikNe4hAHR0iEtohjw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 8Di6EQqCcOUu for <linux-ide@vger.kernel.org>;
        Tue, 22 Mar 2022 22:45:14 -0700 (PDT)
Received: from [10.225.163.114] (unknown [10.225.163.114])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4KNcky0nKsz1Rvlx;
        Tue, 22 Mar 2022 22:45:13 -0700 (PDT)
Message-ID: <ac99cc8e-11c2-d96b-9ce1-ce5618b7b378@opensource.wdc.com>
Date:   Wed, 23 Mar 2022 14:45:12 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH] ata: libata-core: fix "it's" typos
Content-Language: en-US
To:     Diego Viola <diego.viola@gmail.com>
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        corbet@lwn.net
References: <20220323054001.17344-1-diego.viola@gmail.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220323054001.17344-1-diego.viola@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 3/23/22 14:40, Diego Viola wrote:
> Use the contraction "it's" instead of the possessive form "its".

Well, while at it, let's use proper formal written English, so:
s/it's/it is
s/isn't/is not

> 
> Signed-off-by: Diego Viola <diego.viola@gmail.com>
> ---
>  drivers/ata/libata-core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index 0c854aebfe0b..22c93589f2c4 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -1398,7 +1398,7 @@ unsigned long ata_id_xfermask(const u16 *id)
>  
>  		/* But wait.. there's more. Design your standards by
>  		 * committee and you too can get a free iordy field to
> -		 * process. However its the speeds not the modes that
> +		 * process. However it's the speeds not the modes that
>  		 * are supported... Note drivers using the timing API
>  		 * will get this right anyway
>  		 */
> @@ -5603,7 +5603,7 @@ static void ata_finalize_port_ops(struct ata_port_operations *ops)
>   *	Start and then freeze ports of @host.  Started status is
>   *	recorded in host->flags, so this function can be called
>   *	multiple times.  Ports are guaranteed to get started only
> - *	once.  If host->ops isn't initialized yet, its set to the
> + *	once.  If host->ops isn't initialized yet, it's set to the
>   *	first non-dummy port ops.
>   *
>   *	LOCKING:


-- 
Damien Le Moal
Western Digital Research
