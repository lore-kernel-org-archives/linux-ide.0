Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 853DAC433EF
	for <linux-ide@archiver.kernel.org>; Thu, 30 Sep 2021 02:35:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 64DC061439
	for <linux-ide@archiver.kernel.org>; Thu, 30 Sep 2021 02:35:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347844AbhI3Chi (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 29 Sep 2021 22:37:38 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:47281 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347759AbhI3Chh (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 29 Sep 2021 22:37:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1632969356; x=1664505356;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=LRbPo8fUggXivqzPxLHLGxmUQo3Y/Dfms0l5MBQ5hws=;
  b=b2jsMxMNjdX22PscFq7ftjeuFSVSFnhkZgRJvY8HbbYrsGYo2zQW1EuF
   MP06R30xqq8ogXjSRZ2XxnjQKLjZtiJd7r4wms+wNn4ivDEc+XdEA8E52
   rQHtAU+Bq0IW/NLlzmHk3X2jV3rMNE9qtbiIweCJ/DgoDKfYALv/KdJcq
   u7S3c96Gq4w/EXCrJL6oeDMh+Hvz+8VRFYKh3IpnShh5hHFvjmolCISNJ
   cXRVw0gbrLwDmwQZrcP014pvKlQSCSb3YGHZpl2LLkVp1Hqos5aQk1jRl
   UEx/dmuncsRHutbj0ZvEWiCT/mDXsVedoSaUps/ok8HUwih5Z5RPPdwCo
   g==;
X-IronPort-AV: E=Sophos;i="5.85,334,1624291200"; 
   d="scan'208";a="285182820"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 30 Sep 2021 10:35:55 +0800
IronPort-SDR: 8mEzQANnin4uNJlWXpG2zw3+HZUzV4iNRWnwigcjXpOdUIjriMVooXqO2GN+dOu1l4I8lfUZul
 kH/5S3FqJmmjTmKCgE7DTP6ryS9/4xb2PHqMH7bCcJm7DQIryXBvm43YG1gPvuk03vvqGpMeHU
 qtAQu08kzdAQ0svXuIV7Wb/jelVv9mjLXUF3aTvjZrANSM+GPk6Wz41gd+aV6Kl0OX4yQ5KnRc
 VEGoNPQ+63fbmaJIjY/uWfU5CLOkjojy9l9df41AhTHSfhbJJenDdwIIdEbzODZhVe7aHbdMzE
 hbysrEERR/OP6Aj7gTSUBJOj
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2021 19:11:58 -0700
IronPort-SDR: mC8AENaHaGtY4HPAD9jc09vZ9spou48InCU4nBZknsdLJkgShJshh7bKaccXbU0Vb45qtwMoJ3
 cH+5GtknX97zQaHzB2kUXIwizjGfe3SCzZf9buN/tNCvnDk2XoQspY1ImPbfTkuPXcaAPEt1Vj
 MW5ChSV/RbxGMMVQyYNCumaJOrEm0fP4KPSssFa2g1tPMvpFonm14Y+oLOXHvPxK0rTp9+J3c0
 ChvmSezB/52Pi9TmSrOKsdInv5pjlkxDsIZlDT5REKvU+p5/Hv5ny/82oPKU3cBhnh6Et3Txhx
 MM0=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2021 19:35:56 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4HKcmq4WVmz1RvlP
        for <linux-ide@vger.kernel.org>; Wed, 29 Sep 2021 19:35:55 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1632969354; x=1635561355; bh=LRbPo8fUggXivqzPxLHLGxmUQo3Y/Dfms0l
        5MBQ5hws=; b=iJVgE74EN0V1YXr+uPXw7fo7kaufdhlW7ji+Nq6ghWYz7mB8F+5
        8BceerXH0CElkE4XZwvAcF6LLunnVmOWZ0wXdJSL/dpE6Q/TV7ASxpZykg4WrJpI
        WeCZwPjUuu7miVmgCGBkJHV0i/O80L+VtUIMCRJBzcAKZbDSdUOoOTU/4txCseKt
        qyLlkSxUJIKu18eAKIPtLvwAcGeT+FqxJMvRqxINKTBxpbEH+fBq15PoOu10dUiZ
        F2Knu3fMjP2uqSJy5rNAQeZEfE3k0ZRdmIhPAniN9P4hkJIzQm8mcSRUSeZeiIp1
        mqcwVbt6S1XmTFVMu0OaQm/xRrd2MKAy+og==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id jeLNJ0pM_PpG for <linux-ide@vger.kernel.org>;
        Wed, 29 Sep 2021 19:35:54 -0700 (PDT)
Received: from [10.225.54.48] (unknown [10.225.54.48])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4HKcmp3wDLz1RvlM;
        Wed, 29 Sep 2021 19:35:54 -0700 (PDT)
Message-ID: <265805eb-162e-4d2d-1e56-39aa16c87934@opensource.wdc.com>
Date:   Thu, 30 Sep 2021 11:35:53 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.1.2
Subject: Re: [PATCH] drivers/ata: Fix kernel pointer leak
Content-Language: en-US
To:     Guo Zhi <qtxuning1999@sjtu.edu.cn>
Cc:     linux-ide@vger.kernel.org
References: <20210929121618.1157415-1-qtxuning1999@sjtu.edu.cn>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital
In-Reply-To: <20210929121618.1157415-1-qtxuning1999@sjtu.edu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 2021/09/29 21:16, Guo Zhi wrote:
> Pointers should be printed with %p or %px rather than cast to
> 'unsigned long' and pinted with %lx

s/pinted/printed

> Change %lx to %p to print the secured pointer.
> 
> Signed-off-by: Guo Zhi <qtxuning1999@sjtu.edu.cn>
> ---
>  drivers/ata/pata_atp867x.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/ata/pata_atp867x.c b/drivers/ata/pata_atp867x.c
> index 2bc5fc81efe3..c32b95f48e50 100644
> --- a/drivers/ata/pata_atp867x.c
> +++ b/drivers/ata/pata_atp867x.c
> @@ -447,11 +447,11 @@ static int atp867x_ata_pci_sff_init_host(struct ata_host *host)
>  #ifdef	ATP867X_DEBUG
>  		atp867x_check_ports(ap, i);
>  #endif
> -		ata_port_desc(ap, "cmd 0x%lx ctl 0x%lx",
> -			(unsigned long)ioaddr->cmd_addr,
> -			(unsigned long)ioaddr->ctl_addr);
> -		ata_port_desc(ap, "bmdma 0x%lx",
> -			(unsigned long)ioaddr->bmdma_addr);
> +		ata_port_desc(ap, "cmd 0x%p ctl 0x%p",
> +			ioaddr->cmd_addr,
> +			ioaddr->ctl_addr);
> +		ata_port_desc(ap, "bmdma 0x%p",
> +			ioaddr->bmdma_addr);
>  
>  		mask |= 1 << i;
>  	}
> 

Looks OK to me. But please fix the commit title to:

"ata: atp867x: Fix pointer value print"

"pointer leak" is too scary for what is only a simple printk problem.

-- 
Damien Le Moal
Western Digital Research
