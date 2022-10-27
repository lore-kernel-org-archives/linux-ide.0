Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FAF4C433FE
	for <linux-ide@archiver.kernel.org>; Thu, 27 Oct 2022 01:16:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233408AbiJ0BQv (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 26 Oct 2022 21:16:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233044AbiJ0BQu (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 26 Oct 2022 21:16:50 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01455543CA
        for <linux-ide@vger.kernel.org>; Wed, 26 Oct 2022 18:16:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1666833408; x=1698369408;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=4ap/kLZ0OSB6Zuig+PaHn7p6EhgNVXfGROLAu+d2tkk=;
  b=eI44aOEt3cnTHHm6KwfbPIuWtx5YJCWmVO82CPFELNnVUtUH1NZNsEQR
   Xypoe6o4J48xst+kY4BQkxrofGOCkhU1p8E09l0pgFERflz6m7dM/YzAw
   75eINSqU6FJplJ37o2IeHg+PI8c0TowUDpXoB1oSR8mzCouzpB6yvLn6Z
   iChm5SyjOcLcrZ57YmE6KpyZQI95TRPn1VZjIt/lry3qC8p5vGUywt4mV
   7cvjBhsmED4OW8PPdUBFiGKN8jQR0thlEnMUS8K8mn92025BXAxKGj3U/
   6WQ/ASJlIRaKxXCeFJWBj9weqJbDQZCpMMrMP+bsE4cyPGbfUJOMxco/h
   Q==;
X-IronPort-AV: E=Sophos;i="5.95,215,1661788800"; 
   d="scan'208";a="326936990"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 27 Oct 2022 09:16:48 +0800
IronPort-SDR: aVE6/AQPMGH+fSYT+lrWmk9mutNfh7fQUwstRatjt8leGgNJN3wqunJgh0a0hfJj/YJF1urPPv
 bCIVmtjnLZkAMq/7YgeEwK3u1z0sClVDCDW17Nr9J9e2OWBHLLbq9wOhDN+MiCmgkO9a3eKoPj
 1+ZVFu4Xb52/oJ2cOIis8GPzBxJjfYQgiqkXSXQOiihUw0ohsX4GiiaW9pA3QfhPXyx1p6MggI
 P73k+4Xp5f9OWwvbFnrgsN7g6zxkTGj5AmVQJsToFdgIbMZ1Fb+ZKdEDVeXQU2+Spy5kcR7CyJ
 Qa0JzytouLikEdtqY/cEaXMt
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 26 Oct 2022 17:30:27 -0700
IronPort-SDR: h2EY809/FVd5w26EbXs838hqEQsRttpVhwo78l4INwftndD+9p+Bwghc3sJ2q1hP3YJ5mGpZjH
 M+inIdXObLSMhhUSiY6Rfo4yeA6ywfcuEJDyY6E8aBQGREM4qmnEEHzJTjkzAmSQY9WjicTYs5
 cCgThVPmIsT81bxG645/fi2p21F74yCEx2ajFj5KJThydAZnhqhDyvYmvAdVkKSWh1gHlsxs12
 7764LrX8A8c4stPbLk+ixSuuR87yEyHCOFGgpnirmw3+KYa58uYt8eI+Kr/OQDSKLRqx0gtLJN
 2q4=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 26 Oct 2022 18:16:49 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4MySSb6Q7Hz1RwvL
        for <linux-ide@vger.kernel.org>; Wed, 26 Oct 2022 18:16:47 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1666833407; x=1669425408; bh=4ap/kLZ0OSB6Zuig+PaHn7p6EhgNVXfGROL
        Au+d2tkk=; b=cKLxzHejdmmtU3+kZrY6FomzrFFLd9xctuL5K8LMOXvpP6dfIPb
        dUyT6ATcBLj6H0FDOXG3xByzvQqRCvdjp3h5zgwlequ6W6iftbsOlv0soQCyvn9U
        THY3BsSPZ0PqGYFAm/qkc1Oh01OBxMF9h1yR6Fj0hQmnWJpJ0WncbXOheshGcGj0
        Gy5RK7U3v12OX2r9iCrbKt3gkFE9U/lCP+wdiZwafLleL3t/igYctLZ1SX3poOG9
        +YmVKo5FBAB2lK2pDOm+jYloNVRXM8fcYFLLRqKpGp/CIseI00EGF32W7Mu2YsT+
        A15NlDCOhgfy4KoN6MvdnXwyfNcyzXrFHZw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Mqv_RLOFPQYp for <linux-ide@vger.kernel.org>;
        Wed, 26 Oct 2022 18:16:47 -0700 (PDT)
Received: from [10.149.53.254] (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4MySSX3v2yz1RvLy;
        Wed, 26 Oct 2022 18:16:44 -0700 (PDT)
Message-ID: <9cd8aa6a-98be-ddba-db4e-07ed59b53f08@opensource.wdc.com>
Date:   Thu, 27 Oct 2022 10:16:43 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH RFC v3 01/22] blk-mq: Don't get budget for reserved
 requests
Content-Language: en-US
To:     John Garry <john.garry@huawei.com>, axboe@kernel.dk,
        jejb@linux.ibm.com, martin.petersen@oracle.com,
        jinpu.wang@cloud.ionos.com, hare@suse.de, bvanassche@acm.org,
        hch@lst.de, ming.lei@redhat.com, niklas.cassel@wdc.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org,
        linuxarm@huawei.com
References: <1666693096-180008-1-git-send-email-john.garry@huawei.com>
 <1666693096-180008-2-git-send-email-john.garry@huawei.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <1666693096-180008-2-git-send-email-john.garry@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 10/25/22 19:17, John Garry wrote:
> It should be possible to send reserved requests even when there is no
> budget, so don't request a budget in that case.
> 
> This comes into play when we need to allocate a reserved request from the
> target device request queue for error handling for that same device.
> 
> Signed-off-by: John Garry <john.garry@huawei.com>
> ---
>  block/blk-mq.c          | 4 +++-
>  drivers/scsi/scsi_lib.c | 3 ++-
>  2 files changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 260adeb2e455..d8baabb32ea4 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -1955,11 +1955,13 @@ bool blk_mq_dispatch_rq_list(struct blk_mq_hw_ctx *hctx, struct list_head *list,
>  	errors = queued = 0;
>  	do {
>  		struct blk_mq_queue_data bd;
> +		bool need_budget;
>  
>  		rq = list_first_entry(list, struct request, queuelist);
>  
>  		WARN_ON_ONCE(hctx != rq->mq_hctx);
> -		prep = blk_mq_prep_dispatch_rq(rq, !nr_budgets);
> +		need_budget = !nr_budgets && !blk_mq_is_reserved_rq(rq);
> +		prep = blk_mq_prep_dispatch_rq(rq, need_budget);
>  		if (prep != PREP_DISPATCH_OK)
>  			break;

Below this code, there is:

		if (nr_budgets)
			nr_budgets--;

Don't you need to change that to:

		if (need_budget && nr_budgets)
			nr_budgets--;

? Otherwise, the accounting will be off.

>  
> diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
> index fa96d3cfdfa3..39d4fd124375 100644
> --- a/drivers/scsi/scsi_lib.c
> +++ b/drivers/scsi/scsi_lib.c
> @@ -298,7 +298,8 @@ void scsi_device_unbusy(struct scsi_device *sdev, struct scsi_cmnd *cmd)
>  	if (starget->can_queue > 0)
>  		atomic_dec(&starget->target_busy);
>  
> -	sbitmap_put(&sdev->budget_map, cmd->budget_token);
> +	if (!blk_mq_is_reserved_rq(scsi_cmd_to_rq(cmd)))
> +		sbitmap_put(&sdev->budget_map, cmd->budget_token);
>  	cmd->budget_token = -1;
>  }
>  

-- 
Damien Le Moal
Western Digital Research

