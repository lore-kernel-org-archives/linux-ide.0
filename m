Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81BEBC433EF
	for <linux-ide@archiver.kernel.org>; Thu,  9 Dec 2021 00:51:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241588AbhLIAzB (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 8 Dec 2021 19:55:01 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:40117 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233448AbhLIAzB (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 8 Dec 2021 19:55:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1639011088; x=1670547088;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=JvExzhq/UbBfPWenDGJdmwyjlfiLRC6OQMen3m436+Q=;
  b=rAEyIat7XeGcNhyGxXk/10jM1gXFeLM5C205e2LxeCjYugSsqoJXuE4Y
   H9uBpmEUW+e4CvVHYPdwyx07klfW4dxms+IM96ln1nX2fhk2MTtHIb7UR
   1gcpdhvXEFuWT0hSes70IPCu/L8Vt8AObJtF86/8YOWH9jwYjIQl8p55K
   ezzywAzDTvFw2OIN1f6TtVsZTqg7ZfXG6atnec0Go7UcHIv38zMlFKgaQ
   ycxPKs78nM4CoHdl8/tOWFIEztDDOE1PN5c5jtUZf+UxsU4H0u4i6LT/z
   t7epFAKC7dgaVThHscagAExG+R5eibXoh5RrWa1tA7D/aB8h7ifNsO1kk
   w==;
X-IronPort-AV: E=Sophos;i="5.88,190,1635177600"; 
   d="scan'208";a="299636298"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 09 Dec 2021 08:51:28 +0800
IronPort-SDR: Hl0MeSPv5SmSzrslKErGL0qbckf7bVGxp+6yTfX1j2/UD0ICQ9FUYkgHS7IDUTJJzJ6wNTXSp7
 DHLSXbH1f4+XSOzC6qkZQTISNNiM4sJ3kQwW+ooX2218BNTfc0xIktwB4RDBRkYLx9j3otMuJQ
 1qBTy1EWH2jbs3Cl/0egfilPKg/m+gRyBlaqtZLZqpXSRKBWkMb42jZr0j9dvgSfVq/F93ZoKi
 ocVSfZcWqgyStWUT2y1jaHZhq7iF+VF229N3NB+Ul7gMfy5xt+lldRNzqfU5SS1hXopYtlkk+q
 rcERY9lcXtHqTKehbVgBlxBf
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2021 16:26:01 -0800
IronPort-SDR: IY/wwqv5C4z+I4otr2OvYMOhrt4lq91fdZpGbChzTej37MMQuUuIm1TdHx6c9ECsIY/s89/U7h
 VPuiU03D2llqZOVGZcakQLgmW/CPuqvPM/OarvpCi+KgymU72FCmyAQBTIWAgCccf9HgvfoYgv
 m97JSMBNmURS9JTCXseshfhXyKYmPg9BCuOx3gVpQmvUtQja1aehi3qwzyYbuH9r1nZM5uDDrQ
 9b+8SyGfStLaTzi9uCSL/izZMdO2Pi42VIUIbG1lwirJJUtOUBTrRxKNL7twnJcWk3sIgEVTDd
 gns=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2021 16:51:29 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4J8b7z5xJrz1Rwnv
        for <linux-ide@vger.kernel.org>; Wed,  8 Dec 2021 16:51:27 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1639011087; x=1641603088; bh=JvExzhq/UbBfPWenDGJdmwyjlfiLRC6OQMe
        n3m436+Q=; b=RFRwbL503nNcNllEYTAU6fiFQ78ZZfVRKWLacUKPAptfOlm3y5f
        +dgtK82EjIWTcIdC5LkTQpkkY3uw+K+qNa1pLoSwek4hHuY65hlmxRlokdkcFhuH
        6PG8Y0SR2C5HRdl7RIThn88K/df1Cu5fbWC/6aN6SED+Gg/H43f+m0Mgq/3rV28V
        qPUNUii7fKo/CRtL5SvYdrxsiUMEvTiA91a2O6cOmZ//H0Y1c8hh4BstSiUSp2Ul
        RabkFEp9eVA/nhGClblM54GYeG8Lg4jd1aRuR5LQJ/wG8RmPSEnPsw6IhEKIqTJ9
        xD2tDFrI7FxgOOJ+MnOM1Bq4r0OZCRMAQUQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id ef7xC7-Gs7vn for <linux-ide@vger.kernel.org>;
        Wed,  8 Dec 2021 16:51:27 -0800 (PST)
Received: from [10.225.54.48] (unknown [10.225.54.48])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4J8b7y6lPGz1RtVG;
        Wed,  8 Dec 2021 16:51:26 -0800 (PST)
Message-ID: <f6c39cb4-7ea2-95a6-54d3-96b2eff0ac01@opensource.wdc.com>
Date:   Thu, 9 Dec 2021 09:51:25 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.2
Subject: Re: [PATCH 20/73] libata-eh: remove DPRINTK() calls for request sense
Content-Language: en-US
To:     Hannes Reinecke <hare@suse.de>
Cc:     linux-ide@vger.kernel.org,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
References: <20211208163255.114660-1-hare@suse.de>
 <20211208163255.114660-21-hare@suse.de>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital
In-Reply-To: <20211208163255.114660-21-hare@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 2021/12/09 1:32, Hannes Reinecke wrote:
> The information will printed during ata_qc_issue() anyway, so

s/will/will be

> this messages can be dropped.

s/this/these

> 
> Signed-off-by: Hannes Reinecke <hare@suse.de>
> Reviewed-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> ---
>  drivers/ata/libata-eh.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
> index a0fd38260f48..69f51616d8bd 100644
> --- a/drivers/ata/libata-eh.c
> +++ b/drivers/ata/libata-eh.c
> @@ -1422,8 +1422,6 @@ static void ata_eh_request_sense(struct ata_queued_cmd *qc,
>  		return;
>  	}
>  
> -	DPRINTK("ATA request sense\n");
> -
>  	ata_tf_init(dev, &tf);
>  	tf.flags |= ATA_TFLAG_ISADDR | ATA_TFLAG_DEVICE;
>  	tf.flags |= ATA_TFLAG_LBA | ATA_TFLAG_LBA48;
> @@ -1464,8 +1462,6 @@ unsigned int atapi_eh_request_sense(struct ata_device *dev,
>  	struct ata_port *ap = dev->link->ap;
>  	struct ata_taskfile tf;
>  
> -	DPRINTK("ATAPI request sense\n");
> -
>  	memset(sense_buf, 0, SCSI_SENSE_BUFFERSIZE);
>  
>  	/* initialize sense_buf with the error register,
> 


-- 
Damien Le Moal
Western Digital Research
