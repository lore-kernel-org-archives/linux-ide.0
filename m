Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53276C54EE9
	for <linux-ide@archiver.kernel.org>; Tue, 20 Sep 2022 22:03:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbiITWDm (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 20 Sep 2022 18:03:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230139AbiITWDl (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 20 Sep 2022 18:03:41 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 848F92E6A2
        for <linux-ide@vger.kernel.org>; Tue, 20 Sep 2022 15:03:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1663711419; x=1695247419;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=+hPpgbC5aTpEknoMOIocfRrMBJmIwKssPL6d+jJ3i58=;
  b=fMd+NN2WMZS4pTdKzlS3VdwHmandiPqVQSfab5lIC/wu4cwWVDAkJXYy
   +cl6vcDT1lEkXIdHZFczx8wUzu2pJdzF8pUbAmB3zOCe/SBP7PAjjiVm9
   /OSX3OqT0FIS/hVEX/PRCsxMnRLPGqlhdOhxtHpJPlbJNdKy1KoJrOt7A
   AqHG78qRjaA8dHRnNp0SVo7rFsBqdp66HlpBTlharDowl7HePH/fcLbqI
   hEtT5GUW0Nm1p4QmONpEcwfqaWa7B2L+fw6Vm+V7Yj6DRICTkWMkpMELl
   02iU7X3bsnUaQdMiQ52DdxwAQv9eUZCzvTOzFBlfBp/Mm51OjYai1JBUe
   w==;
X-IronPort-AV: E=Sophos;i="5.93,331,1654531200"; 
   d="scan'208";a="217030192"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 21 Sep 2022 06:03:39 +0800
IronPort-SDR: Yz0xxpVcGDJN6E3tVy+HLVPu36HB5+0p9hitUBGzkn5ovmw393R6y+PFPXqVdgRWgpsinIgR0/
 gG2uruH7sg1ApMzHdHQLiIJfRgRZkhHi1GDca68MoInTmt3/MSYodPsIb1imZAd8eUaboMB9QG
 JgF0IlE2ubSNDCYyDjd4CwzsF1PXHmQC56di25bRAnE1LWUDk6+Rs5TNNCWN6Z8JT629fiHZYL
 QgsdS9ffPG9fUw+o9x21heZTRcgO2S2vuvxJft/Uf3AjUeQSsYz4auhyMC05xthWmOkloFuSGY
 WRwCpd0GrYaCJjkxoggtvt9j
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Sep 2022 14:18:15 -0700
IronPort-SDR: 1yX0FuhtLWGx9bazG3L93KkFBxWoHnhjuuuvCz6K27fsuzeXAQyfY3ORrM3Nc3qCl3XLf5YEbI
 Y+vGvij9jlS6Khu3OxBb2ifeL1o8qDQCxfvBODV8TZVl/4q1emIvYGtef41qqLaI3dHqtkFt/I
 b0LcV+6dv7Kr3dYrt9Y/wP/qF/GX/j4gguFHR0z3wbNEeiJS28Oe0mi/3C8+i6sK7aTE2Z2MIC
 R2bzjMggicZndGwhTNN6XdDyOgMtkU9U7f/9b2xj4c1SYYMsqmOiDAYLEHTVeYWxzXtjJfWXoq
 YeQ=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Sep 2022 15:03:40 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4MXFtM3KDsz1Rwtl
        for <linux-ide@vger.kernel.org>; Tue, 20 Sep 2022 15:03:39 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1663711418; x=1666303419; bh=+hPpgbC5aTpEknoMOIocfRrMBJmIwKssPL6
        d+jJ3i58=; b=RlpUBSmgP2MlKTyHdrVMvy2qbkj0Lc/Bti0ZF3d+/hbaUkGAfnk
        QjhquYKhKYvkpZeSmmUlIG4wEmXCo+09kSc1ebtRKQCxQXaF1k7twbLYAnq0Qc2Q
        kfdUPzWmLH0gNwM6cUpBiVIE5wVWUONHnJJpUMpuWhf2E2zyqV8L6KYx0kOh7OL6
        CtOudvjp1J1YV536kRmzaYiABTZdCe1jPDkscPd8RbxhzR9oqqSdfuYPXTPH45Fr
        n6FGHPzGSAjSyAAYd2Z5WpNzdKAmZb0yInrtgUxWyRzYZGtUiU1+ZDFKyTt0sfbJ
        t9eI8JWRTtPuHKhADdyiAdQamcznsN0Psdw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 43d9JOjKJvKI for <linux-ide@vger.kernel.org>;
        Tue, 20 Sep 2022 15:03:38 -0700 (PDT)
Received: from [10.149.53.254] (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4MXFtH54PRz1RvLy;
        Tue, 20 Sep 2022 15:03:35 -0700 (PDT)
Message-ID: <67b11e85-3e4e-beb7-4a2b-ef856207b227@opensource.wdc.com>
Date:   Wed, 21 Sep 2022 07:03:33 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH 1/6] scsi: core: Use SCSI_SCAN_RESCAN in
 __scsi_add_device()
Content-Language: en-US
To:     John Garry <john.garry@huawei.com>, jejb@linux.ibm.com,
        martin.petersen@oracle.com, hare@suse.de, hch@lst.de
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org, brking@us.ibm.com
References: <1663669630-21333-1-git-send-email-john.garry@huawei.com>
 <1663669630-21333-2-git-send-email-john.garry@huawei.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <1663669630-21333-2-git-send-email-john.garry@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 9/20/22 19:27, John Garry wrote:
> Instead of using hardcoded '1' as the __scsi_add_device() ->
> scsi_probe_and_add_lun() rescan arg, use proper macro SCSI_SCAN_RESCAN.
> 
> Signed-off-by: John Garry <john.garry@huawei.com>
> ---
>   drivers/scsi/scsi_scan.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/scsi/scsi_scan.c b/drivers/scsi/scsi_scan.c
> index ac6059702d13..3759b1a77504 100644
> --- a/drivers/scsi/scsi_scan.c
> +++ b/drivers/scsi/scsi_scan.c
> @@ -1588,7 +1588,8 @@ struct scsi_device *__scsi_add_device(struct Scsi_Host *shost, uint channel,
>   		scsi_complete_async_scans();
>   
>   	if (scsi_host_scan_allowed(shost) && scsi_autopm_get_host(shost) == 0) {
> -		scsi_probe_and_add_lun(starget, lun, NULL, &sdev, 1, hostdata);
> +		scsi_probe_and_add_lun(starget, lun, NULL, &sdev,
> +				       SCSI_SCAN_RESCAN, hostdata);
>   		scsi_autopm_put_host(shost);
>   	}
>   	mutex_unlock(&shost->scan_mutex);

Looks good.

Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

-- 
Damien Le Moal
Western Digital Research

