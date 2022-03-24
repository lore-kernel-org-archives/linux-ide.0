Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0674C433F5
	for <linux-ide@archiver.kernel.org>; Thu, 24 Mar 2022 01:40:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345786AbiCXBmQ (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 23 Mar 2022 21:42:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345753AbiCXBmP (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 23 Mar 2022 21:42:15 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4564292D3E
        for <linux-ide@vger.kernel.org>; Wed, 23 Mar 2022 18:40:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1648086045; x=1679622045;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=4QEMOUcjYeQg6k3oG5z4tHQPgW+dlh1g2Hbu+B/waMM=;
  b=XO+H4H6DYt2BbpZnn2Ya2Bcqk6Nr5f8PXToxt0TfeHBAlPFC4PctmbGz
   n3lSM/9CuCwNV6254PE1EWfuuFWISKnUsaoxul4/zgDiGvlTPbESGSz7e
   fRTWNlB6bA+4cc1Mn0bgV0ODPwk7S8e//pRj90rOvMnpX7/dSgjOhwzLV
   gAptQOJTcQ4GaFxJF5qC7V2MxvIqMFo7tEGb4IG5xrzuRr5tJ2fh2587o
   DXjkqNcmYu69+zhfY+x0r/s/OOsvmDgCdM1t8BHrfRM1mKc5PdyBdwWXn
   8Q58OtWwV5fZE8GNPqwufEgWTyL/pgAZ5QQ9YkQz9DHc4if83CyL04Z7k
   w==;
X-IronPort-AV: E=Sophos;i="5.90,206,1643644800"; 
   d="scan'208";a="195019840"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 24 Mar 2022 09:40:44 +0800
IronPort-SDR: yXU4uECg6QcOhgkFhhzurWgGRVa4mlbgYT+LgWdFOC1FWbeGn2LfIp0mHXogYaK62BqHldVm/L
 9CEgjp9vmBnNnYfblkWnv9vQpK4kOZARV389ZQhoMjf2V/UP+1VouCfzKkLJbU7QYKKdqsDw4R
 KmI0HibR/OVhsrfjzjf9vmIGEzJ+3Z/3DqdXtEuex5iwnQVO4QeVnVO/sNb4AKdDfKBFPGR9kp
 v2qNLzkOxiv13CaYEivFavyRpCkZcnRug4o7M3pkCxUXMKq2AiBfUaeRrlJlMSo0iiCoga56nH
 gcrEi98osaG7N5xSLb8UWlW3
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2022 18:12:37 -0700
IronPort-SDR: kqEKGi+F+F7uJKlOsmgL2kR5fZ19AOY0GsMcLXXTO86CU3lGEIMfyT858K41f+HIIueBwEZgEm
 R86f8XJP7P2x9//NVD2ihxGAKpZw8QncLHoaD7r9enciu3VSxDNIJUYJwEWdcSTm9Y5gd5YFlv
 BTq4q1mEKS8NsvAD7BjdaUDSbddIjTZ6VGM7GWf4Jp/F8m+Oc4YXwb9lSHcTTHAVpw8UQDmntg
 EHPdtngvUo+nFIhxRx5+fnlAuOP93q4iwh65GWTl3yffSbychnq44NdJb4LCxaVU/kl4HYSK08
 ggc=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2022 18:40:44 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4KP7GM41w1z1SVp4
        for <linux-ide@vger.kernel.org>; Wed, 23 Mar 2022 18:40:43 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1648086042; x=1650678043; bh=4QEMOUcjYeQg6k3oG5z4tHQPgW+dlh1g2Hb
        u+B/waMM=; b=pbihkB93tzJAeclaFNW5UkmpnyuQLhw10d2p+tvDoXWCvmRO1C2
        PjZ2bYMDHWtG7STDyf69s12NCUEqA00h14Fe0k94ITUa4nzk2daWAKas1P68w85S
        Dm0pAArRoYTcIbWNMo9bQttyBPg/Z1AZrlP+0c0K/g52ZQvsfvCaz1WptKASSjRV
        dJPFJ2q40Y7w5bo6rN7PRlVMpXslfD4u4RtQmshnAGn6JGdQjLXqSJAhhnGZ5Dza
        tmoxl9PAWx4oPIA0XUcf948Ht8vqGTGH1kWJZyE2dI79VHCuwhMM7YS4hQb1F4rx
        t0NPAIT2hgXL8Rho6HY0eo62GsEIKYty9gA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id ixe7hlOHQsx6 for <linux-ide@vger.kernel.org>;
        Wed, 23 Mar 2022 18:40:42 -0700 (PDT)
Received: from [10.225.163.114] (unknown [10.225.163.114])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4KP7GK1GLMz1Rvlx;
        Wed, 23 Mar 2022 18:40:41 -0700 (PDT)
Message-ID: <ab7f2a2e-0ca9-ed97-e4ed-bf8ef0ed69a5@opensource.wdc.com>
Date:   Thu, 24 Mar 2022 10:40:40 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH 07/21] ata: libahci_platform: Sanity check the DT child
 nodes number
Content-Language: en-US
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>
Cc:     Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Rob Herring <robh+dt@kernel.org>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20220324001628.13028-1-Sergey.Semin@baikalelectronics.ru>
 <20220324001628.13028-8-Sergey.Semin@baikalelectronics.ru>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220324001628.13028-8-Sergey.Semin@baikalelectronics.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 3/24/22 09:16, Serge Semin wrote:
> Having greater than (AHCI_MAX_PORTS = 32) ports detected isn't that
> critical from the further AHCI-platform initialization point of view since
> exceeding the ports upper limit will cause allocating more resources than
> will be used afterwards. But detecting too many child DT-nodes doesn't
> seem right since it's very unlikely to have it on an ordinary platform. In
> accordance with the AHCI specification there can't be more than 32 ports
> implemented at least due to having the CAP.NP field of 4 bits wide and the
> PI register of dword size. Thus if such situation is found the DTB must
> have been corrupted and the data read from it shouldn't be reliable. Let's
> consider that as an erroneous situation and halt further resources
> allocation.
> 
> Note it's logically more correct to have the nports set only after the
> initialization value is checked for being sane. So while at it let's make
> sure nports is assigned with a correct value.
> 
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> ---
>  drivers/ata/libahci_platform.c | 16 +++++++++++-----
>  1 file changed, 11 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/ata/libahci_platform.c b/drivers/ata/libahci_platform.c
> index 4fb9629c03ab..845042295b97 100644
> --- a/drivers/ata/libahci_platform.c
> +++ b/drivers/ata/libahci_platform.c
> @@ -470,15 +470,21 @@ struct ahci_host_priv *ahci_platform_get_resources(struct platform_device *pdev,
>  		}
>  	}
>  
> -	hpriv->nports = child_nodes = of_get_child_count(dev->of_node);
> -
>  	/*
> -	 * If no sub-node was found, we still need to set nports to
> -	 * one in order to be able to use the
> +	 * Too many sub-nodes most likely means having something wrong with
> +	 * firmware. If no sub-node was found, we still need to set nports
> +	 * to one in order to be able to use the
>  	 * ahci_platform_[en|dis]able_[phys|regulators] functions.
>  	 */
> -	if (!child_nodes)
> +	child_nodes = of_get_child_count(dev->of_node);
> +	if (child_nodes > AHCI_MAX_PORTS) {
> +		rc = -EINVAL;
> +		goto err_out;
> +	} else if (!child_nodes) {

No need for "else" after a return.

>  		hpriv->nports = 1;
> +	} else {
> +		hpriv->nports = child_nodes;
> +	}
>  
>  	hpriv->phys = devm_kcalloc(dev, hpriv->nports, sizeof(*hpriv->phys), GFP_KERNEL);
>  	if (!hpriv->phys) {


-- 
Damien Le Moal
Western Digital Research
