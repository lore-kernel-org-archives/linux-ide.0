Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61B4FC433EF
	for <linux-ide@archiver.kernel.org>; Thu, 17 Feb 2022 00:22:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238681AbiBQAXC (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 16 Feb 2022 19:23:02 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238690AbiBQAXB (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 16 Feb 2022 19:23:01 -0500
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF7B51390E7
        for <linux-ide@vger.kernel.org>; Wed, 16 Feb 2022 16:22:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1645057367; x=1676593367;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=1AT46h4qp04NIE7iKtH7reyqk/dcgTmOCbp755KnSio=;
  b=In32t86n+aGyor8LwYgTy0YNUcODa/xUiTU8ZNPj7GK3Fhl8j4Xa+xJ6
   5XzfSg0nieVZXhGEW3AAiHCQ59F1wniydBGn/AiV0cyls2NY1woZAhZDi
   wLUEnI3J1sfk+5yqYNJDfGsfxnmUGfwoyHWl6A6rsivp+a9Vsa2sCdH3t
   EbfBSBNFyFUduh2fW/7Pa75U2a94ofpq7lWx05yYdwi7Dz0M0QFhar2aY
   PNN+JLjzk8YnmUlnRdBVPuS64PDPFYMzTw9v8nVDS9f2bzwBw6mCi7SZF
   0TXCbamaxol6Mr+Q1vtlR21/+OfB0DB8jXOFzMqwkz2sxSvvJOPCSfpCg
   g==;
X-IronPort-AV: E=Sophos;i="5.88,374,1635177600"; 
   d="scan'208";a="193138341"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 17 Feb 2022 08:22:47 +0800
IronPort-SDR: hXTrDatYk4hFihGmnN3BhY5kozeL5EUyCtPotMDS7GCeX5dEbtEDIHWM0GlC2ceG1JcJnDmNa0
 Wqn0SSSMYLwrAUNWLw+iNIFAlMX7KrYi+IhQpalUXv+5giZjiGbotPnSmaMCcTISsodpAULShx
 yQgrjcEPcuSTG59MNlTkUBirOFgckIukrstukSxbYIBp1mB4wlvAbinDY6FQv5+6UF+sQAF262
 S5oZsD+IgzCATURrl3pE7OEnx3YH4JDqS89WG+ax6LBYO0//t8c4taic4TRGgZbu5QNS3ROMKU
 IU/fEKY/jdyEwUaR2O77PPHx
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2022 15:54:27 -0800
IronPort-SDR: 7EACIVTV1oq8p+1VkONWE0VcMWznVnSQyBzZo8SgUuPPSKJBkqbjj9p0sUuBSOHLQ18gVQiOFx
 ppfN+PffiH16ALutvTyZlcvaSbXbNj0NRim+ccAYcdeIYEYPvIvb7hrZDWg364AWFCLL9/0XiU
 sfOTWiw0a5HGoI8+OTumIMW1TOAQhkfEnzKRsSq8AQThoq+fxrgqURJdf3iJU12bATyMuTJ+sb
 tT36hAMUqsDBkxidMAMjuHjMPYDezobA1zklHNqzTN8IOR8M9ft8p7b0rsW+kLT1KMrO6y3pdM
 Mvc=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2022 16:22:48 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4JzbBc02kGz1SHwl
        for <linux-ide@vger.kernel.org>; Wed, 16 Feb 2022 16:22:48 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1645057367; x=1647649368; bh=1AT46h4qp04NIE7iKtH7reyqk/dcgTmOCbp
        755KnSio=; b=O+4bAS0GX3FR61Oz6QUIGudzrRY2A6MXkX1ER0tSqaVkQrQ+/vO
        XDR0B3ytukxoacvlOFIR6Ix81LnlTh1MPH9GecUgsUBvrY66sHaXvp18TuoVBjqH
        15xEjJhSSSahwvYY9+kRnS4ADk7rXFN3r/gN8cIKl2GIQozBRHGmCLwGMTbULShm
        HUvEnhWQcOfQUXNOQsLbO5mXXGtDoxhUHEpqvaxDIZ15OvGSioBYLg4n9LbjVmst
        bFrMGlVyD9kmDVEoDkR/qD38v4Xk4VhlHGo2g2ozKkEpKkszLvm823qP9JSAweMp
        DMijbtRjqx9PM7kMcJybnNmSO5Z7bBxK3VQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id W3ueFvf_0-ix for <linux-ide@vger.kernel.org>;
        Wed, 16 Feb 2022 16:22:47 -0800 (PST)
Received: from [10.225.163.73] (unknown [10.225.163.73])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4JzbBb2Fttz1Rwrw;
        Wed, 16 Feb 2022 16:22:47 -0800 (PST)
Message-ID: <16173ee5-00a8-4bd2-484a-d4c5953b98a9@opensource.wdc.com>
Date:   Thu, 17 Feb 2022 09:22:45 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] ata: libata-sff: use *switch* statement in
 ata_sff_dev_classify()
Content-Language: en-US
To:     Sergey Shtylyov <s.shtylyov@omp.ru>, linux-ide@vger.kernel.org
References: <b4b1d7c1-b786-358f-154a-ba755a0814fb@omp.ru>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <b4b1d7c1-b786-358f-154a-ba755a0814fb@omp.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 2/17/22 06:13, Sergey Shtylyov wrote:
> In ata_sff_dev_classify(), replace a string of the *if* statements checking
> the device's class with the *switch* statement that fits better here...
> 
> Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>
> 
> ---
> This patch is against the 'for-next' branch of Damien Le Moal's 'libata.git'
> repo.
> 
>  drivers/ata/libata-sff.c |   14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
> 
> Index: libata/drivers/ata/libata-sff.c
> ===================================================================
> --- libata.orig/drivers/ata/libata-sff.c
> +++ libata/drivers/ata/libata-sff.c
> @@ -1841,8 +1841,8 @@ unsigned int ata_sff_dev_classify(struct
>  

The err check before the hunk below could use a switch too.

>  	/* determine if device is ATA or ATAPI */

This comment is a bit weird since ATA_DEV_ATAPI is not used. Maybe
change that to something like:

	/* Check the device class */

Or just drop it... The code is clear enough I think.

>  	class = ata_port_classify(ap, &tf);
> -
> -	if (class == ATA_DEV_UNKNOWN) {
> +	switch (class) {
> +	case ATA_DEV_UNKNOWN:
>  		/* If the device failed diagnostic, it's likely to

While at it, please correct the comment style here (start with a "/*"
line). There are a ton of these style problems all over, so when
touching code around them, let's fix them :)

>  		 * have reported incorrect device signature too.
>  		 * Assume ATA device if the device seems present but
> @@ -1853,10 +1853,12 @@ unsigned int ata_sff_dev_classify(struct
>  			class = ATA_DEV_ATA;
>  		else
>  			class = ATA_DEV_NONE;
> -	} else if ((class == ATA_DEV_ATA) &&
> -		   (ap->ops->sff_check_status(ap) == 0))
> -		class = ATA_DEV_NONE;
> -
> +		break;
> +	case ATA_DEV_ATA:
> +		if (ap->ops->sff_check_status(ap) == 0)
> +			class = ATA_DEV_NONE;
> +		break;
> +	}
>  	return class;
>  }
>  EXPORT_SYMBOL_GPL(ata_sff_dev_classify);


-- 
Damien Le Moal
Western Digital Research
