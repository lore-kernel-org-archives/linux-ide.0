Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85263C54EE9
	for <linux-ide@archiver.kernel.org>; Tue, 20 Sep 2022 21:58:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229935AbiITV6N (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 20 Sep 2022 17:58:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229896AbiITV6M (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 20 Sep 2022 17:58:12 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CDA97332C
        for <linux-ide@vger.kernel.org>; Tue, 20 Sep 2022 14:58:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1663711091; x=1695247091;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=SryP8UGVCrAC/T9URA+bIDzzhnLRUWQZ3Z/jXtawmk0=;
  b=pgoVCH0vtwPL6dv0Y7ikaveCzThTxRKPRI4hW0KhmKoKaH5LtTcQoZzB
   cLaOtdwzmOlTlmZmUEePEYyML4tzbuNyScd3zyftNxg8VXuRtzjU/LtHR
   v1i/3/fQ8O1SeBHUClyggvGtGHma5TcJYTy+dT2+RWDsxUyM17mmbxKxb
   aNErXdTFgKDw2ti9ePWVfbsKN2+byaVMYEQFPyF9RsN93zO4ZkoSlicjn
   yPcg8ZReURbfdCoQjYP4W88eIlCQ7vurBD1C4/aPNcYbgjg3NtjcBaNaQ
   FZAWkMaoeo73pgoMy32yQrmoOO+0YFVo3H8j3SHVmSZfgEJ6YnaFRSQlR
   g==;
X-IronPort-AV: E=Sophos;i="5.93,331,1654531200"; 
   d="scan'208";a="211848113"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 21 Sep 2022 05:58:08 +0800
IronPort-SDR: ui5mjLWBlYXety1ecO1+DTWL4xd7c3ZaoVgQURnEr3lDsHrhsAHAbMbYGrTglLZeAw2D6lVv/8
 UMAyF6fOZ0k6CQDvyowWmwhcg08Ls56+TzNe4W15HVJe4PlosvzCJWsl/QbA3ig51c2RO+/00d
 i0Py1aPlISceCy9KIsqrAGwFLVXHCYiCW7W5wFxAPZwKSZ1esMcC76QkQYsoWNMHxxGTa3c4V7
 k5H6q2tThrVMlNouq4X6Vm2RtHxLKLDk4S6k7ggS2jLkM+AeIIzfd1UCQEC/sq4bhhgA9laEuT
 jUFD1c1DlGj9J5nKZVS8cdRZ
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Sep 2022 14:12:45 -0700
IronPort-SDR: wq7yz/7wTXQqS4N8Yh2DCoAWxGYYa19c9l9ZGcqhqlv5H3/tIbidPqk4MKktWIQO9cmsjuB4mk
 DIC3txO6vp7QL4mIT+PPmqWswqvAfZ+62zhjTtm565NVsa7fWEXJSqCbe6vIysD/j3bm91lMC2
 g4e+xCsAiIf7Iuhce8TwTuhqpQFh41AMOrUre6xCyuMwGcueqII/BvGDISy6wjfwsUieErkV+T
 AZKde4Xxz2bvJ8adX52+79zXY0LzE3cOCQyeaDunaPRDagG9giYWVCH74HIx+8UI83D8pOTsZd
 ML8=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Sep 2022 14:58:10 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4MXFm069lTz1Rwtm
        for <linux-ide@vger.kernel.org>; Tue, 20 Sep 2022 14:58:08 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1663711088; x=1666303089; bh=SryP8UGVCrAC/T9URA+bIDzzhnLRUWQZ3Z/
        jXtawmk0=; b=R/GsSyg49s/ykMZfJjnIw13a1Uhlbjy8CTjo5ah9My90jxHTWqK
        QLyy9Ah008twYj/EmwuFehxlcAtMpEu+9EvVvY8gaLlT7JB9YKXB+J2Zlw6Gl3C0
        R22hKx5+5p4OsU+bTlGwzjGCj9Gio3LiZtvuxhvKyjVyj+F1vHwFTcDTvBfen3zn
        n+mP0xyd4y4ANg5boS4sbrdnB2210QnXdy8YACZpIb6WE+8y6nxHhZ+mnBix8tdj
        J+ZD3LuqAC/khz79zQm3hA2KsvjK5vrmEb/gaKtB2qiQ6SxvhSfJD9hkSeXXa0T2
        qR/+lii9+8tn0fRb/N4ryB3omGvjozE0LmQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id oQpQXBun4HpQ for <linux-ide@vger.kernel.org>;
        Tue, 20 Sep 2022 14:58:08 -0700 (PDT)
Received: from [10.149.53.254] (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4MXFlw6BmPz1RvLy;
        Tue, 20 Sep 2022 14:58:04 -0700 (PDT)
Message-ID: <c444fad0-7e7f-0940-84ce-a6fdaa99c493@opensource.wdc.com>
Date:   Wed, 21 Sep 2022 06:58:02 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH RFC 3/6] scsi: core: Add scsi_get_dev()
Content-Language: en-US
To:     John Garry <john.garry@huawei.com>, jejb@linux.ibm.com,
        martin.petersen@oracle.com, hare@suse.de, hch@lst.de
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org, brking@us.ibm.com
References: <1663669630-21333-1-git-send-email-john.garry@huawei.com>
 <1663669630-21333-4-git-send-email-john.garry@huawei.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <1663669630-21333-4-git-send-email-john.garry@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 9/20/22 19:27, John Garry wrote:
> Add a function which allows use to alloc a sdev with configurable
> device parent, and channel:id:lun.
> 
> This is useful for separating adding a scsi device into separate alloc
> and scan steps.
> 
> Signed-off-by: John Garry <john.garry@huawei.com>
> ---
>   drivers/scsi/scsi_scan.c | 25 +++++++++++++++++++++++++
>   include/scsi/scsi_host.h |  3 +++
>   2 files changed, 28 insertions(+)
> 
> diff --git a/drivers/scsi/scsi_scan.c b/drivers/scsi/scsi_scan.c
> index 3759b1a77504..fd15ddac01b6 100644
> --- a/drivers/scsi/scsi_scan.c
> +++ b/drivers/scsi/scsi_scan.c
> @@ -1988,3 +1988,28 @@ void scsi_forget_host(struct Scsi_Host *shost)
>   	spin_unlock_irqrestore(shost->host_lock, flags);
>   }
>   
> +struct scsi_device *scsi_get_dev(struct device *parent, int channel, uint id, u64 lun)
> +{
> +	struct Scsi_Host *shost = dev_to_shost(parent);
> +	struct scsi_device *sdev = NULL;
> +	struct scsi_target *starget;
> +
> +	mutex_lock(&shost->scan_mutex);
> +	if (!scsi_host_scan_allowed(shost))
> +		goto out;
> +
> +	starget = scsi_alloc_target(parent, 0, id);
> +	if (!starget)
> +		goto out;
> +
> +	sdev = scsi_alloc_sdev(starget, 0, NULL);
> +	if (sdev)
> +		sdev->borken = 0;
> +	else
> +		scsi_target_reap(starget);
> +	put_device(&starget->dev);
> + out:
> +	mutex_unlock(&shost->scan_mutex);
> +	return sdev;
> +}
> +EXPORT_SYMBOL(scsi_get_dev);
> diff --git a/include/scsi/scsi_host.h b/include/scsi/scsi_host.h
> index aa7b7496c93a..5142c7df7647 100644
> --- a/include/scsi/scsi_host.h
> +++ b/include/scsi/scsi_host.h
> @@ -794,7 +794,10 @@ void scsi_host_busy_iter(struct Scsi_Host *,
>   
>   struct class_container;
>   
> +extern struct scsi_device *scsi_get_dev(struct device *parent, int channel, uint id, u64 lun);

You should not need extern here, and long line...

> +
>   /*
> +

white line change.

>    * DIF defines the exchange of protection information between
>    * initiator and SBC block device.
>    *

-- 
Damien Le Moal
Western Digital Research

