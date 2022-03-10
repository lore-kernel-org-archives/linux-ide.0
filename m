Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15AA0C433EF
	for <linux-ide@archiver.kernel.org>; Thu, 10 Mar 2022 02:21:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236025AbiCJCWm (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 9 Mar 2022 21:22:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235139AbiCJCWl (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 9 Mar 2022 21:22:41 -0500
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28A4ED10B2
        for <linux-ide@vger.kernel.org>; Wed,  9 Mar 2022 18:21:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1646878901; x=1678414901;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=WDO4HSWRyY0O08kBCVNY2t+nO+m9kmaqPv0llFc0uSo=;
  b=hRAfO44+oYq1ig75PDnwI9ReGmirdacZIynSGDN0uGzFjWn60qWH1flT
   p7Vm9bE9V+MOrrGiLatzTMTCZORC3IOerzRwTwE3tKcR2/RsMY7H2DS+/
   BVdMmX4X1DCkaE7F9FYOE3NVcdQ+ko5ZVX0XID/69PSpUlpAfuasx21cz
   ImvwfaDAlwtL9mPNrJkVQo/jDwHQYInSQ3QEHIQQwjrr27/vh6tzK2tJG
   EmQQVGEYwF0BTYiVbyt4X2tmuraUXWO49422+p0R/LUuQqsf6Ab1+G1uU
   s33uv+KXU07GDZt6kc6kAfUuNQ2D7XaJ3WaVramud8irDg5xXa5RI6xe7
   A==;
X-IronPort-AV: E=Sophos;i="5.90,169,1643644800"; 
   d="scan'208";a="199753646"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 10 Mar 2022 10:21:40 +0800
IronPort-SDR: f6dGjbsaO6BKOu1egDfk+Qn2ZmqJj5XZSPc4+5CehnFhkvAqxnN6QymhGJ7lhj0a47l1eRObam
 KITWHrHwvhZRB0mCSY5oZb2LnABybZ5iDtAx26V623aA1G/0iag/0jSE5F/uKo/xTC/1BMYqJe
 kqm8Bh0IaDZKljvBiHX4mPYhL93IpMlZAxvA80qIdpq9OzuTe6EnnXLuhaMfpeCsMcvH5c3n5r
 Byypp9jxlkqMku+pLJ9GJxEasn+kQbWvhqEy2jB/2FXLE+Fr2ShQnE4TDjXUmHxkXFPlgo2zgT
 0Xpk45sGhT7U8ycfzc3rwB6N
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2022 17:52:54 -0800
IronPort-SDR: eB+ow4JCODhnT3Efp5amKC5i0UjMFaJ3TKOo+yLR3rTzLDc9+9/8H2KToAfIyMl1hvUmygC5vY
 A2yNC+hvwbPu/zAAnInklcUXF+Tlq/tW95Fs4Ds/YYtNNNFSfRVPBgbxNQvRNDxR+j0Hfbe/qF
 /oThSh7fXw52Br43E48Ff+8+NcYUQCWmjGf1ld+pg28UILXPBf01RTVAn4Hrnj+wjVWozhnycp
 Woo+Ytmpd88HxPmuLpu71CJ21B3B9Lz73PorZsbeZRhw6k6ds11hdtqYsiFzDG5EtLkg0ilC2s
 6GE=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2022 18:21:41 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4KDXr41Thxz1SHwl
        for <linux-ide@vger.kernel.org>; Wed,  9 Mar 2022 18:21:40 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1646878899; x=1649470900; bh=WDO4HSWRyY0O08kBCVNY2t+nO+m9kmaqPv0
        llFc0uSo=; b=X+C0kD8tUpUUUKvMksaTwHwMVC5UJiIOQ41BEcRYawnlD//4Et7
        /pdimEVj6tdYzAfp9CZDgkjcv9kBmbLRF+AXF+7mp96XQG1flzHJ63eZhtKE2NDm
        wenB48Xr0Ty2Ot0OQl+gG3zLSDLYqgfYnXbY+MuIZGrjMk5fkU6qWUjzxO/Mmti+
        Jxctgap8RiEX7Q8f6+wdgLUyQ0qWB9Yy8QyFq/EvYg2JagKQSiXCFU+WrsrRcO/E
        eWAU5TT5Ay3JVG+H3y7tI53I2all+UY7J83L6nb2Zgbju7Qn0IMPVSoZtTXaCcvO
        I1EkTh9lCMx01Mle8SGOocIZ8wewAlB8a5g==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id YHVzNGzXI9Zg for <linux-ide@vger.kernel.org>;
        Wed,  9 Mar 2022 18:21:39 -0800 (PST)
Received: from [10.225.163.91] (unknown [10.225.163.91])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4KDXr24HTmz1Rvlx;
        Wed,  9 Mar 2022 18:21:38 -0800 (PST)
Message-ID: <268d5589-fb80-b1d8-a513-69530ca2ab9e@opensource.wdc.com>
Date:   Thu, 10 Mar 2022 11:21:37 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH V3] ata: pata_pxa: Use platform_get_irq() to get the
 interrupt
Content-Language: en-US
To:     cgel.zte@gmail.com
Cc:     chi.minghao@zte.com.cn, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org, s.shtylyov@omp.ru, zealci@zte.com.cn
References: <d1dfb244-eda3-b5c6-c6bd-c0294a9a4a94@opensource.wdc.com>
 <20220309072834.2081944-1-chi.minghao@zte.com.cn>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220309072834.2081944-1-chi.minghao@zte.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 3/9/22 16:28, cgel.zte@gmail.com wrote:
> From: Minghao Chi <chi.minghao@zte.com.cn>
> 
> platform_get_resource(pdev, IORESOURCE_IRQ, ..) relies on static
> allocation of IRQ resources in DT core code, this causes an issue
> when using hierarchical interrupt domains using "interrupts" property
> in the node as this bypasses the hierarchical setup and messes up the
> irq chaining.
> 
> In preparation for removal of static setup of IRQ resource from DT core
> code use platform_get_irq().
> 
> v1->v2:
>     - Use more specific in the subject: ata: pata_pxa:
>     - Switch to returning 'irq'
> v2->v3:
>     - drop the unlikely()
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>

Applied to for-5.18 (without commit message fix). Thanks !


-- 
Damien Le Moal
Western Digital Research
