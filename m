Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF4E0C433F5
	for <linux-ide@archiver.kernel.org>; Mon, 10 Jan 2022 23:58:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345779AbiAJX6U (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 10 Jan 2022 18:58:20 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:56048 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345782AbiAJX6U (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 10 Jan 2022 18:58:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1641859100; x=1673395100;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=vjU4XCqmIM5l4vO0SUmreGGleE6WeT5PamKl8gATroY=;
  b=qonbbeOcpp2THiRQLeifCvs13DzN+QoOVvJPLr+iSivpCFuxGJiewwwi
   dOpQ7xhRb4vCgpQ3u2Nfe/WpUPem3+/OXhNzzI1sTpCXAnABl/mAU0DEw
   8fZKb7xApyHygobARVE4qsupQJ6ngdffta9Fj96Izbqxlyx4xzIdDPq12
   fTY8kfWTklSM9WnDM/pJcQLUXgVfEXi/bSH3I7WPsoLwzs7fxR74Q6nyW
   Nu3laUhsTqyToebfh5hhYZKHnSIyHHm5cGUN3H9Y8amdsxdManq9G809c
   jvkZ24Wcvuh0pHRYFHrcc+ClwXl8FEdTJiTYkEeyyqD+6Q7sc6QzdCyeK
   g==;
X-IronPort-AV: E=Sophos;i="5.88,278,1635177600"; 
   d="scan'208";a="294186831"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 11 Jan 2022 07:58:19 +0800
IronPort-SDR: kBg3K1MdehvHBXmXLNC0i0cnjm5Q6wqULQMU5MVr4RsBgMnwkK4ZAmBPAoZTbPKcPiP9JkxV3+
 rck+l2P2TWynOX/r6CN3lRH3CRwAYsxcNA7cKFp9afL6bSEcBKaGjxsR6agT8SNM4mefzpAJGr
 +vfjrlvKRNySZGCnxl7wghYk++ph2IukKfOvj8uNP7brNzUhcPY/EWo/BsvzlcSPLUAVID8pdQ
 CMxqrJK1zIQlXmtWo2PA/I4qzxGQwypbnudaYlPOmYCdMVrE3J+cX2cZ53V5gJpl20e1mz+Du5
 TiN7kPfCl5bTYq+c9oukZZhi
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2022 15:32:02 -0800
IronPort-SDR: y/MPtdbXlSgo6h3l3iwqBHfEwO25BJwSsFiQ74yREiYOrHS6heo4CzkJZVKn/V3NzzOoBVmNeb
 fhEyFO6dQlCKrtc+Ci91XBWF0x3TNDdApUbGD69jUaBFL1q0EnKjTuajFR7Nw6hp2CHpl5efE6
 s1g/NSyRsPduUvHnDqcl0go6NZEiFbNwunz22u16Sdfz0E6b3JtYEPuezG5sfEfepTBTmP5oAg
 I7y/+1NGA3NYzZDp1R6P+KAiFdAnmwFSUebRtPZRKpCoKjEwzEe5Jm+ubhbAGsQbgTcTB9R0Rx
 NtM=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2022 15:58:20 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4JXrPQ5QCLz1VSkf
        for <linux-ide@vger.kernel.org>; Mon, 10 Jan 2022 15:58:18 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1641859097; x=1644451098; bh=vjU4XCqmIM5l4vO0SUmreGGleE6WeT5PamK
        l8gATroY=; b=kH+WVED3m4bVWVV+N4ua//W328k5iR1fkSdQzmEsZHC5JMm8G8L
        Fh14oAWxD3Z183XGW7e+UitwQsh9BLrtYbA9PSngqGR1AV5zuq2JIf8jKNEnWF+Y
        ekMVGDetiknjQ0iiz1LliXeqssjMt/oa8yxvS4Q28arjjfJq+w1160Tqhq0Pv/LD
        HHRik67li1rgOEGQLYuLepwALxL7P6y/kTsUjmzF6x3tBICDRYns31ABviSru4Xz
        easzkHlQTwD7LEiMvpuuZ8puu0nrKMC+vlkhZdvpqtAhDxtA/xLHQNQlMgT63Q0E
        xTPKI7StjO2LgMwr8VQsZzSgLaQOHObPeuw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 6ZoFreTEOIsI for <linux-ide@vger.kernel.org>;
        Mon, 10 Jan 2022 15:58:17 -0800 (PST)
Received: from [10.225.163.46] (unknown [10.225.163.46])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4JXrPN6g3Bz1VSkV;
        Mon, 10 Jan 2022 15:58:16 -0800 (PST)
Message-ID: <4419b25f-dd71-9c14-5de2-4425f9367e29@opensource.wdc.com>
Date:   Tue, 11 Jan 2022 08:58:15 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v5] ata: pata_of_platform: Use platform_get_irq_optional()
 to get the interrupt
Content-Language: en-US
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Prabhakar <prabhakar.csengg@gmail.com>,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220105181721.13087-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220105181721.13087-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 1/6/22 03:17, Lad Prabhakar wrote:
> platform_get_resource(pdev, IORESOURCE_IRQ, ..) relies on static
> allocation of IRQ resources in DT core code, this causes an issue
> when using hierarchical interrupt domains using "interrupts" property
> in the node as this bypasses the hierarchical setup and messes up the
> irq chaining.
> 
> In preparation for removal of static setup of IRQ resource from DT core
> code use platform_get_irq_optional().
> 
> Note the code does not set the IRQ flags as this is handled automatically
> for DT.
> 
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
> Hi All,
> 
> This patch is part of series [1]. I'll re-visit merging of pata_of_platform
> into pata_platform at later point. As my primary focus is removal of static
> setup of IRQ resource from DT core code.
> 
> [1] https://patchwork.ozlabs.org/project/linux-ide/list/?series=278349
> 
> v4->v5
> * Set end member of IRQ resource
> * Clear irq_res un-conditionally.
> 
> Cheers,
> Prabhakar

Applied to for-5.17. Thanks !


-- 
Damien Le Moal
Western Digital Research
