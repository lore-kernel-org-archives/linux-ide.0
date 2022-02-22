Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71AA2C433F5
	for <linux-ide@archiver.kernel.org>; Tue, 22 Feb 2022 00:37:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237846AbiBVAhi (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 21 Feb 2022 19:37:38 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231435AbiBVAhf (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 21 Feb 2022 19:37:35 -0500
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D56824BC9
        for <linux-ide@vger.kernel.org>; Mon, 21 Feb 2022 16:37:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1645490231; x=1677026231;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=LzsOh+ZWa/GkFAE6bo1i4lLhtIeeo9K7JqL8x0qaUz8=;
  b=oycbmqbo6Qw3hBdfFDdgI5pfvzsO1NW9klLcpUTX2jk7PE55KUM2f51O
   62XLZ3zUQE8a+0gGeS9nXRW5RPbS+3jHjt30zM0Vg0lcZxUiM5lHWgIuk
   /SiYTogE0NZXC8gnpTqV2YmTvHmu2FrEFLqwgB+h0IAe1xSeA7sl/RsEU
   Rzb3x9/rj7biwoL/dsXn0kZutq1RLA3t+vMzMysH9Y0pLiXNUT+yfqwF1
   c8jc3B2ZoHcvmOSGNZxT9Ox/YLJPQnNkrv86M0BLY0H2j7tepit75K7y7
   mVJtdyLabc5JuOe+BdDZJsRcdDdk82Tv7CfI6ucX0DJNCERrX/Hf1ARyb
   A==;
X-IronPort-AV: E=Sophos;i="5.88,386,1635177600"; 
   d="scan'208";a="192515993"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 22 Feb 2022 08:37:10 +0800
IronPort-SDR: m8kw2HEMqMArnsmVRW+CGfRA6k32NHJPmDPzDuLhbzzdlSO7j7Rr9dhEQ33oOW04Nk4fK4g6+P
 j+pJZMag4kylv5gd9yUdO6uu5/nR5orC7B4I7wh1pLSMUtpmiqpkpyzreqz4pCV2u8fx8EcDSG
 R2yyO5vaVT0on9/fN5P0qDYC548lXZVBEV8FJKHf47q2J4ExlFxOKbMv7rXdmHvj09I0co548M
 UvB1mli2GFRgxzt4VKCHuRAIY1LousSSmbbttpItgLPHZtK3HMJNWr8GFqVZQKt8CUxO6zvseJ
 +gxL2IysK8lRufUNiEovNCu+
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2022 16:09:50 -0800
IronPort-SDR: gQ0K6E0+pIbd1yF/J8CGrYSDseSsAovGo09OIDplJwbJ5NDiSgutY91DXd1B///7cdURuAgPFW
 nYxSmo/jKm4NsCzGvax+e/mlr41hArgal/YazPsxReD1S8ISbwVAxYuofSpFZzZMyaTqm37C5l
 SPHqtLJHjlY4RfNLNWJWHckTEXm/lAl23XY5jJm2UvhLk1ItWoSsnp/wvfN2G8cGekehvv6wnV
 88jWvhR8g62k1yEeri1TJG+XRiuLB0yZq+lE95HqpAddiyl7dK2YZt9uimPNbrx6jgMptn9zZC
 80g=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2022 16:37:11 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4K2gGt44wkz1Rwrw
        for <linux-ide@vger.kernel.org>; Mon, 21 Feb 2022 16:37:10 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1645490229; x=1648082230; bh=LzsOh+ZWa/GkFAE6bo1i4lLhtIeeo9K7JqL
        8x0qaUz8=; b=tfZ5YC0HGMNOXtMxAS2J7FJzIZmHsoXU9efDYeHDzlz+AlqwpeU
        2PyCdnMqGAsh8gFuqeoGljg1l1VBJodI3OLymviMP5Fiu3imMj2eXsBeo8YFx651
        rC2GCfQrrz2F2g6x+hdEpcZrz3G+g/ELrF9ZtySZvYx4PYcLvrSxtoB0ooVHc6Dy
        7JISemDOPAxS1sO6qs/cUUE4GoGChJvtpwX5msdwYS+/AMpKBa2IMzt/hXM8u7N8
        PJMLkZ+0Wb3qzna4LEYvrnkmkiaikVJ85hwVT3DOTdFEahYMocplw8GFtySnYnDl
        +hCUWayggYK8b7U8zY3T/qSPl4N/GXHC6EQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id oq3KgJPboFhP for <linux-ide@vger.kernel.org>;
        Mon, 21 Feb 2022 16:37:09 -0800 (PST)
Received: from [10.225.163.81] (unknown [10.225.163.81])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4K2gGs26Mtz1Rvlx;
        Mon, 21 Feb 2022 16:37:09 -0800 (PST)
Message-ID: <feb0d6ba-baa2-6482-e6b4-eb5baed2a728@opensource.wdc.com>
Date:   Tue, 22 Feb 2022 09:37:07 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] ata: pata_hpt37x: disable primary channel on HPT371
Content-Language: en-US
To:     Sergey Shtylyov <s.shtylyov@omp.ru>, linux-ide@vger.kernel.org
References: <e398d6e3-05f2-409f-6818-812f24e325eb@omp.ru>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <e398d6e3-05f2-409f-6818-812f24e325eb@omp.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 2/20/22 02:44, Sergey Shtylyov wrote:
> HPT371 chips physically have only one channel, the secondary one, however
> the primary channel registers do exist!  Thus we have to manually disable
> the non-existing channel (if the BIOS hasn't done this already).  Alan Cox
> has only added such code to the 'pata_hpt3x2n' driver, forgetting about
> this one... :-/

No need to assign blame by name :) Something more neutral like:

"Similarly to the pata_hpt3x2n driver, always disable the primary channel."

will do. Also, do you have a fixes tag for this one ? Is it again:

Fixes: 669a5db411d8 ("[libata] Add a bunch of PATA drivers.")

?

> 
> Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>
> 
> ---
> This patch is against the 'for-next' branch of Damien Le Moal's 'libata.git'
> repo.
> 
>  drivers/ata/pata_hpt37x.c |   14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> Index: libata/drivers/ata/pata_hpt37x.c
> ===================================================================
> --- libata.orig/drivers/ata/pata_hpt37x.c
> +++ libata/drivers/ata/pata_hpt37x.c
> @@ -867,6 +867,20 @@ static int hpt37x_init_one(struct pci_de
>  	pci_write_config_byte(dev, 0x5a, irqmask);
>  
>  	/*
> +	 * HPT371 chips physically have only one channel, the secondary one,
> +	 * but the primary channel registers do exist!  Go figure...
> +	 * So,  we manually disable the non-existing channel here
> +	 * (if the BIOS hasn't done this already).
> +	 */
> +	if (dev->device == PCI_DEVICE_ID_TTI_HPT371) {
> +		u8 mcr1;
> +
> +		pci_read_config_byte(dev, 0x50, &mcr1);
> +		mcr1 &= ~0x04;
> +		pci_write_config_byte(dev, 0x50, mcr1);
> +	}
> +
> +	/*
>  	 * default to pci clock. make sure MA15/16 are set to output
>  	 * to prevent drives having problems with 40-pin cables. Needed
>  	 * for some drives such as IBM-DTLA which will not enter ready


-- 
Damien Le Moal
Western Digital Research
