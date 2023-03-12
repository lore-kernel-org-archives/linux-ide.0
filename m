Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1F7CC61DA4
	for <linux-ide@archiver.kernel.org>; Sun, 12 Mar 2023 00:56:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229737AbjCLA4d (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sat, 11 Mar 2023 19:56:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbjCLA4c (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sat, 11 Mar 2023 19:56:32 -0500
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0967B515F6
        for <linux-ide@vger.kernel.org>; Sat, 11 Mar 2023 16:56:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1678582590; x=1710118590;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=pOlTIWs8Pc37VFuKgoNPhQMANn3Yi6ON1BgiCZV6s5U=;
  b=DMIAvtoi72/8H41lVJDQPVsJXjqaMrXNEI4fv+FJOUsLQq2tXu68Y+ZI
   biTKkf8hI1tLMjtH0QPGwINzs2XENbkdzk6LmgSYnY2P2IH/l1vkTXdxC
   KjYg1ns4OR5BD2ykrU/pPMGZYokFvOWccVZrx3lKueAjb5U5Nl/Xqlv+J
   zY1TPDN+jC1rDTd5Zq4jjruwR4qAanWFTO52QPs5/P4ZloFrCJyjMMBmX
   B0cJRiQj3HhdhSIhmnu7AnQCTTpvB2EeyZOHMNUkyqmwtQSRSiZoLkLuJ
   euAfC8DJTZR1JbH6S3RqiFbvaSSIMak5PjcDlvwLrSvlt+jUho4ZXWx4D
   Q==;
X-IronPort-AV: E=Sophos;i="5.98,253,1673884800"; 
   d="scan'208";a="329776410"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 12 Mar 2023 08:56:28 +0800
IronPort-SDR: lpqjdDb75zIKVDxAOJIPTWfBExa34MgrEDCUD2NZRi+RmmaE7CR06gaDy+CGbKnfSaYSVxHSFs
 6aiDnlJGaD9BRCLIMQYciZX/KKrsv8WWh3K5L4Dw1yyAnmHpgt3NeOX95NeRX+sw9g+JHheJf/
 +9UNa4YsB3sbTGAAZErAyNzM9iQmXjuWAXVSopkjmKq11M2Tc2lks5AGwd2gPbs1ablAUki/e8
 6yZ6QF/yVGeArQqSqDaOfJu2tMZQO+rrZuFESrzPzWj06hAatWLV2QHnegWTX+qw0VuetsxgU6
 qQE=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 11 Mar 2023 16:12:59 -0800
IronPort-SDR: 42TPvEkgabiVqyMySg+DcvF1L2TetSb/kO5BQ26KNgZduuP6nbhTxQjOUkUl0vPAqSnMu9mW+I
 KPe2Sun7SrC+PiSyMDV2pQzPVM9GbUihbv66/TvlQwJ8CWUSFAsjffs4CzoYTj9nVTbbTft1Od
 fs6zq4KaD9XYOJPuKoZsAnTdX5p5LYAhUxTToNdvCA7YFC6z6QLZOq17aFlve5GkNgp8oQ/ikL
 AkTwX2kvmnkJtnQEryJ4VrJOBp9rQP7JA/oNMKhYbOWKA47FrO8x3inRwkNSz8f0st5WX3iE+T
 S78=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 11 Mar 2023 16:56:29 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4PZ1ZN5W7fz1Rwt8
        for <linux-ide@vger.kernel.org>; Sat, 11 Mar 2023 16:56:28 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:content-language:references:to
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1678582588; x=1681174589; bh=pOlTIWs8Pc37VFuKgoNPhQMANn3Yi6ON1Bg
        iCZV6s5U=; b=tPIzIDDEcGoPcR890IKk0hS564DmRoxa8hJj/qbNEUUTY3evxHy
        t1OkpdPANN1eHQ6QIDBuSJ6JNIpMVpbTa8XRtoWTvhyAj5FbY6satskhX3SOZlsp
        GFSb7+IXDCYcSJbvnhlA43uZTI+3EiL8fXbjXdzHB2nrpEX7R8g0E1WDtawj6MoH
        aCkVdGOp+B4rXI2bYC4ooRvX423f4ZiviwPcBoCskxM4dwcpIacaZZaiGnlmlovt
        cvjQqJMVmdZS6zXkNodN1MQ9IpGCQnPzSgmPkw36+qYVxD2v5PV2+ZRuGWPJ1zb5
        Ql5/6kGXcq1/gsnbl6vifY+09uUBOETRSxQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id aaSTQoqh9ACt for <linux-ide@vger.kernel.org>;
        Sat, 11 Mar 2023 16:56:28 -0800 (PST)
Received: from [10.225.163.78] (unknown [10.225.163.78])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4PZ1ZM1CqSz1RvLy;
        Sat, 11 Mar 2023 16:56:26 -0800 (PST)
Message-ID: <8b0eb4d0-ca10-35a5-a74c-fd0f7d11713c@opensource.wdc.com>
Date:   Sun, 12 Mar 2023 09:56:25 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2] pata_parport: fix possible memory leak
To:     Ondrej Zary <linux@zary.sk>
Cc:     Christoph Hellwig <hch@lst.de>,
        Sergey Shtylyov <s.shtylyov@omp.ru>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <202303112239.21234.linux@zary.sk>
 <20230311214447.7359-1-linux@zary.sk>
Content-Language: en-US
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20230311214447.7359-1-linux@zary.sk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 3/12/23 06:44, Ondrej Zary wrote:
> When ida_alloc() fails, "pi" is not freed although the misleading
> comment says otherwise.
> Move the ida_alloc() call up so we really don't have to free it.

Certainly you meant: "so we really do free it in case of error.", no ?

> 
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <error27@gmail.com>
> Link: https://lore.kernel.org/r/202303111822.IHNchbkp-lkp@intel.com/
> Signed-off-by: Ondrej Zary <linux@zary.sk>
> ---
>  drivers/ata/pata_parport/pata_parport.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/ata/pata_parport/pata_parport.c b/drivers/ata/pata_parport/pata_parport.c
> index 6165ee9aa7da..a9eff6003098 100644
> --- a/drivers/ata/pata_parport/pata_parport.c
> +++ b/drivers/ata/pata_parport/pata_parport.c
> @@ -503,18 +503,19 @@ static struct pi_adapter *pi_init_one(struct parport *parport,
>  	if (bus_for_each_dev(&pata_parport_bus_type, NULL, &match, pi_find_dev))
>  		return NULL;
>  
> +	id = ida_alloc(&pata_parport_bus_dev_ids, GFP_KERNEL);
> +	if (id < 0)
> +		return NULL;
> +
>  	pi = kzalloc(sizeof(struct pi_adapter), GFP_KERNEL);
>  	if (!pi)
> -		return NULL;
> +		goto out_ida_free;
>  
>  	/* set up pi->dev before pi_probe_unit() so it can use dev_printk() */
>  	pi->dev.parent = &pata_parport_bus;
>  	pi->dev.bus = &pata_parport_bus_type;
>  	pi->dev.driver = &pr->driver;
>  	pi->dev.release = pata_parport_dev_release;
> -	id = ida_alloc(&pata_parport_bus_dev_ids, GFP_KERNEL);
> -	if (id < 0)
> -		return NULL; /* pata_parport_dev_release will do kfree(pi) */
>  	pi->dev.id = id;
>  	dev_set_name(&pi->dev, "pata_parport.%u", pi->dev.id);
>  	if (device_register(&pi->dev)) {
> @@ -571,7 +572,7 @@ static struct pi_adapter *pi_init_one(struct parport *parport,
>  out_unreg_dev:
>  	device_unregister(&pi->dev);

Same comment as Sergey: isn't this going to do the ida free ? So shouldn't you
return here ?

>  out_ida_free:
> -	ida_free(&pata_parport_bus_dev_ids, pi->dev.id);
> +	ida_free(&pata_parport_bus_dev_ids, id);
>  	return NULL;
>  }
>  

-- 
Damien Le Moal
Western Digital Research

