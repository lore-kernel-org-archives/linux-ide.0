Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14A86C433EF
	for <linux-ide@archiver.kernel.org>; Thu,  9 Dec 2021 01:14:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235218AbhLIBS2 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 8 Dec 2021 20:18:28 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:3471 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239056AbhLIBS2 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 8 Dec 2021 20:18:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1639012495; x=1670548495;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=RM+YGIceZDScI1RzMCFP/BaaqUDkkPZ4ySgCRK2N7fk=;
  b=WPp02XJXM2tsn6zsAAP1W9jLkfeYr9dyPZBRG+TtNHy8I1T81rrfcBTq
   DP0yAMcTyow0IualHLP1mQFLg8HZJixaUlgHfTuRK2/JET+lLXIgbtdFx
   duFyKfx7TIS4/RkX4P41VmR/4N9+Ns7f/4h3Mmg4VGTLGQRNkgcdJNQ+c
   N0BmObF/RD97DVK+3FuChCd+wMFXaAinQplzpzr9tupqFURakDtBugS7F
   RXpQdDjnwWUldi31HEMR/LC072eprDdhXLMJiCcbDAUTu4ZSOGKNeO1tj
   4u4suiGtVPWEQed/rl6joH09etBiSh9Dm8sOTwecctiPNW6cNat6yJf8j
   Q==;
X-IronPort-AV: E=Sophos;i="5.88,190,1635177600"; 
   d="scan'208";a="192576498"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 09 Dec 2021 09:14:54 +0800
IronPort-SDR: Si8kUWm1sB9MCCSPEcyEduqWM76D3ZREbOPbVRcn9RFVk+4CpslI4rk0UASt76koo+TsnQlm8N
 StxGw9/+emf/NI11QbZBX1e8edE47sqGeIVKXmE7upH+viPiq5ItscDp9A1QLKr4/j+moPsLEy
 NfO7NgAhdDhR63uwCVePe1ati33hvD9heFvjSaGRbKaOiY9hKJ/loihB6wojZqrKQ29XCOXv9y
 HuwmaXPRPIK0dyu8MALrNMUxNXF9PJoZAQDM3VDL5AdwZC/2pcuuYlSR+YTOkND6GhWSHxJedz
 ZWQebw8ktFC9cUProqqDrHb4
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2021 16:49:29 -0800
IronPort-SDR: kIQLzuQMHB13lHPUuoe70Oye1vswfWYBEOHUM+LcBp7nAcKsGimIM1b5cQFNn4UVbIrFqwXBbk
 GF/8hi3ghIJYMI6rpAimezwWRYxtKUTwhoegP9/DG54pGUrlktL7J/cOM3g7c2plw+YLbVgHBg
 UEJKxj2T79V03qJCGpCEa722I2kVVwqfxcY8D6+Ex6ds+qPGbYMO0B8Dj55k3rfWrwUNQKbhOs
 /KW8ucBb4rq7CiuSKpRPPN07Gxx3x3Q5vlkv3rLfPQqaXA/GebMRH0qrWxi0fUXnlatmhmkPle
 VpU=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2021 17:14:56 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4J8bg342QXz1Rvlf
        for <linux-ide@vger.kernel.org>; Wed,  8 Dec 2021 17:14:55 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1639012495; x=1641604496; bh=RM+YGIceZDScI1RzMCFP/BaaqUDkkPZ4ySg
        CRK2N7fk=; b=AcjsvtOqPFK4gjKLxQhTU3nA31oq1q27jD5xHsZhBvd77mlu6dv
        2FXEUVV9RF1i1jWOuHgcQt6UhXiq6u2Ic2Pedb+pJclgJ+p0SGi2sJrRB2QHxeMD
        WrgBt33Y5pg7qKh7o8NPFNqOKAv1YYfKFE3sIEWsS/Ov9ZkWSwNklrgPAOyV1YHs
        cGtdGC3JR2YehjTeKHqm6nHCAAlswECjJZhgNg44IwwCA/SDB6lqACmi9ABMuhve
        ylHNFRUyAjlT1QJN1MnJKzbqkh/lFwO30rJiP2c2yKR4Xy7og8M5P7nYCGy/r6xD
        OiMvxbU4OzUBmGArjtFKTMo2P0z1ulBoqtA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id ow5OJWapWVwa for <linux-ide@vger.kernel.org>;
        Wed,  8 Dec 2021 17:14:55 -0800 (PST)
Received: from [10.225.54.48] (unknown [10.225.54.48])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4J8bg26RRtz1RtVG;
        Wed,  8 Dec 2021 17:14:54 -0800 (PST)
Message-ID: <cce0f055-66ca-2de8-8ac9-349ad69b1a86@opensource.wdc.com>
Date:   Thu, 9 Dec 2021 10:14:53 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.2
Subject: Re: [PATCH 72/73] pata_hpt366: convert pr_warn() calls
Content-Language: en-US
To:     Hannes Reinecke <hare@suse.de>
Cc:     linux-ide@vger.kernel.org
References: <20211208163255.114660-1-hare@suse.de>
 <20211208163255.114660-73-hare@suse.de>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital
In-Reply-To: <20211208163255.114660-73-hare@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 2021/12/09 1:32, Hannes Reinecke wrote:
> Convert pr_warn() calls to ata_dev_warn()
> 
> Signed-off-by: Hannes Reinecke <hare@suse.de>
> ---
>  drivers/ata/pata_hpt366.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/ata/pata_hpt366.c b/drivers/ata/pata_hpt366.c
> index 06b7c4a9ec95..c29863038428 100644
> --- a/drivers/ata/pata_hpt366.c
> +++ b/drivers/ata/pata_hpt366.c
> @@ -15,8 +15,6 @@
>   *	Look into engine reset on timeout errors. Should not be required.
>   */
>  

Remove the above blank line.

> -#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> -
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/pci.h>
> @@ -183,7 +181,7 @@ static int hpt_dma_blacklisted(const struct ata_device *dev, char *modestr,
>  
>  	i = match_string(list, -1, model_num);
>  	if (i >= 0) {
> -		pr_warn("%s is not supported for %s\n", modestr, list[i]);
> +		ata_dev_warn(dev, "%s is not supported for %s\n", modestr, list[i]);
>  		return 1;
>  	}
>  	return 0;
> 


-- 
Damien Le Moal
Western Digital Research
