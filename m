Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF555C433EF
	for <linux-ide@archiver.kernel.org>; Fri,  3 Jun 2022 01:31:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240728AbiFCBbO (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 2 Jun 2022 21:31:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240928AbiFCBa6 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 2 Jun 2022 21:30:58 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 747DF2E9CE
        for <linux-ide@vger.kernel.org>; Thu,  2 Jun 2022 18:30:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1654219820; x=1685755820;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=4/XRBVJlrbde9LFq9lEMFNDMZHqrnKfROAx+/nN8uZw=;
  b=f292i2+V50+6CFZGvr6fcNaV/VQfHqnTk8kHClIyIIzOQuc4ns1goAqT
   PJ6+eszEZOzlQ2YU9lbbt8uP2zbAUmcC+B628o+PITLsZB4jI+YS0SUAT
   01ZBtop1l3RiO/3I3X3vsoNyQTsKQ0V+UUToiV9g39Y4we2t9+jjZxyA9
   UwWE9xUPSlDppGqjrqy4uNnrvZUNtEC/htZk1jCZTiVZniCMvijlKdZMY
   lR8GBcRbwgRXe3KTcf9/uITLDSTbySgoVXwCwxDPLkPaOrg1jTrMbfLv2
   HosQ0VOs7ha9Ho9V1tyIYXRJGSDVne8DWIMxry9KGetSBalGHy/eP2uhw
   g==;
X-IronPort-AV: E=Sophos;i="5.91,273,1647273600"; 
   d="scan'208";a="202947956"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 03 Jun 2022 09:30:18 +0800
IronPort-SDR: EbQ3C4n2dofSDfk+0mFqak5mrfodhGPn/x2ejfs4Hc2JZECxbmpNq8em6Nd+gCi/G6wE6/6TVF
 D/Yz7iIFba9Uq2/y5UJqBZw+gMkNSWABfwwvBefiXQXBfqmNW4FiaQ/ZqaXmh2tz+WpZ2AznEX
 NWV4+TS4c3KIKMpNGWv3oSENYp9Zfv9MWb4UY7vDeMxx1jsaTO8m0QI1g/vRe1ttZT1JH3VhNn
 zZjzyUhG2fwEVOauKF0yGHbvhy7ylkPXJCJVY5FXt/ASWp5ywv36nNi0M/8MukmnF6/aJm7fpI
 ngAAjHucus/RbR1NVrpp6ghR
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 02 Jun 2022 17:53:52 -0700
IronPort-SDR: z2QM2KCu/I+ORclBdK79K8a4bOOkxTOVDD8dy9qRdqHAw6h/aQ6fkGmD3oe1vT6Q7r29Zwj9zC
 3RL18D06IfG9XONqeUc+gMyUMBJQmOKLNIp4gDn2ug02PetawzD8CN0qBdrttop57coUqSNaJl
 ky7o0eGZ0r8hxHLj7qkDIAkvZgpwaUHy2Us35f54PfvLmG729hBHrDecMru0GcmRlaaj0QrjcU
 K/DVSAQqIxJKypFCcF6GbENs5i0mxSiUXUWpounY0Yh0l889j94Qds7RcjNhVuene1P9xle54E
 h6c=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 02 Jun 2022 18:30:18 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4LDlgY1z5vz1SVnx
        for <linux-ide@vger.kernel.org>; Thu,  2 Jun 2022 18:30:17 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1654219816; x=1656811817; bh=4/XRBVJlrbde9LFq9lEMFNDMZHqrnKfROAx
        +/nN8uZw=; b=eBY8VQn1azy3OxgTB0joSiNzuxnCa56ZCh3ZD/Qab7XLle0sgEM
        TmIh/nKOxOkgDQAMwlaktPb94XXAUK982Rv0wJhPM2aygGbYtQiBT6HZnDRiPRCT
        fpSCREdQ/rlUqdPv2Id3L4NJa8jL6BCuqwbQSR1UuR8Pr2x8dSOXXANVRoqdoIuR
        09G84gMZyL0QtN4wVAQsiD+69MJA4NVHqcgqU+Q6+gfyh7xA4rQymnWmHBBn5F9W
        eoJFPZdmgTFF59YFnBaeh8kEB8ZnrQuLXq40HcsQRK5Al6mCAkLV0GBRns7GZUlk
        lV/wkMW1BWJAbpJYUnZYBfGBj7jEL4138sA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id S97PFpxqjsaM for <linux-ide@vger.kernel.org>;
        Thu,  2 Jun 2022 18:30:16 -0700 (PDT)
Received: from [10.225.163.63] (unknown [10.225.163.63])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4LDlgW4xkbz1Rvlc;
        Thu,  2 Jun 2022 18:30:15 -0700 (PDT)
Message-ID: <fcef5536-a4aa-f6f2-5e9a-c39708a74a50@opensource.wdc.com>
Date:   Fri, 3 Jun 2022 10:30:14 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2 3/3] scsi: sd: Fix interpretation of VPD B9h length
Content-Language: en-US
To:     Tyler Erickson <tyler.erickson@seagate.com>, jejb@linux.ibm.com,
        martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, linux-ide@vger.kernel.org,
        muhammad.ahmad@seagate.com, stable@vger.kernel.org
References: <20220602225113.10218-1-tyler.erickson@seagate.com>
 <20220602225113.10218-4-tyler.erickson@seagate.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220602225113.10218-4-tyler.erickson@seagate.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 6/3/22 07:51, Tyler Erickson wrote:
> Fixing the interpretation of the length of the B9h VPD page
> (concurrent positioning ranges). Adding 4 is necessary as
> the first 4 bytes of the page is the header with page number
> and length information. Adding 3 was likely a misinterpretation
> of the SBC-5 specification which sets all offsets starting at zero.
> 
> This fixes the error in dmesg:
> [ 9.014456] sd 1:0:0:0: [sda] Invalid Concurrent Positioning Ranges VPD page
> 
> Cc: stable@vger.kernel.org
> Fixes: e815d36548f0 ("scsi: sd: add concurrent positioning ranges support")
> Signed-off-by: Tyler Erickson <tyler.erickson@seagate.com>
> Reviewed-by: Muhammad Ahmad <muhammad.ahmad@seagate.com>
> Tested-by: Michael English <michael.english@seagate.com>
> ---
>  drivers/scsi/sd.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
> index 749316462075..f25b0cc5dd21 100644
> --- a/drivers/scsi/sd.c
> +++ b/drivers/scsi/sd.c
> @@ -3072,7 +3072,7 @@ static void sd_read_cpr(struct scsi_disk *sdkp)
>  		goto out;
>  
>  	/* We must have at least a 64B header and one 32B range descriptor */
> -	vpd_len = get_unaligned_be16(&buffer[2]) + 3;
> +	vpd_len = get_unaligned_be16(&buffer[2]) + 4;
>  	if (vpd_len > buf_len || vpd_len < 64 + 32 || (vpd_len & 31)) {
>  		sd_printk(KERN_ERR, sdkp,
>  			  "Invalid Concurrent Positioning Ranges VPD page\n");

Martin,

If you take this one:

Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

-- 
Damien Le Moal
Western Digital Research
