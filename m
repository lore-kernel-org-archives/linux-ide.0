Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15E0CC433EF
	for <linux-ide@archiver.kernel.org>; Wed,  2 Feb 2022 08:08:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237918AbiBBIIL (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 2 Feb 2022 03:08:11 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:47605 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239881AbiBBIII (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 2 Feb 2022 03:08:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1643789288; x=1675325288;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=L4c2he6lgl6k+wvhc9k2+V0VddjuZ/Y234PV0+WoJAg=;
  b=hi37nXO4TJ4eclpmGE20e2Fwk2+1Y+30g8bR/nIXVTx79bdIZp5s2ZrS
   AS1qtpF6y5ltfUStm5VP7r1nuw8Ag+7cDyx4d4jzpvRCXYwWWuKcswLEq
   HfVihOWFStjDDBfXTz7B1LBvWFc+1hyetekqu6wyI88UsZcYrIsNOF0Dp
   YGedIMA+zZjqUPQX8kbaAPyh7d9zqGlxQ3enE/9dbYl171ezd3AQ5R1OK
   gjtIP3PHAh+YXs4sfqEMKH+rPbQbWKyWnTLlQVp52IVZxg/CBVtqpGITC
   Hp/U7umV0wXfp3lrWFoZIMJu0ykJwoUA5Y3x2wdSuCNFq78s1276zP1bI
   w==;
X-IronPort-AV: E=Sophos;i="5.88,336,1635177600"; 
   d="scan'208";a="296042205"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 02 Feb 2022 16:08:08 +0800
IronPort-SDR: SJwqkXeHbERRJt+msPoUcjt+dxvSP9kmIVuV/FL8qsRjt7i5omkYwe8iGsmy7UyszGtoN6WD7p
 nkMkTrz7yPXAZjk/fch+t9gaUCLMTw/ehzKxo6KB4xmBvxSx28aarW9I0SC6fFJsIldKzRSCds
 7pfX3KN1hbt4LnfCSwRlSCGEpPy199k5x1cp2e78UM/qMHWgk8NdBH8taZ1/7hNNXWLXT+90SX
 LCs8CRir3wzMKcskPr/wdLDfXqyZ2ZQo/ckOxeDAVqZWN8GPiVaGx0ZBkgcVivic2HtFDMVfuD
 VkLCzzU48W7RPY0jXxOM98f4
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2022 23:40:05 -0800
IronPort-SDR: u7J1yru94p5S5TQn4vo3qIVK6uJl79q3yacbny9nUrlIlF1YWVTEWbKODich2LSdZmuvFn1F60
 SX90H0gIVizELti8znIOg1Ab5dh/oftRSOuHCLxzen/i5jLZBadzNhqANtx7gRgReF2ObmE+g/
 BfmfjNGRlcJ+/Kdk/xu+SdxG6v3PTTnISQE4p0GO2faUUnP3ACQvTMPHrQNJw3GeFmirNAdLQN
 OsXSha8NAdiC3f6C+yZt9tXtCAv2ms27gkPpg7qxwTi4rLVTRpTV6OarDtqKJZo2B4yIuXe+jq
 LS0=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2022 00:08:08 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4JpZDS1p0jz1SHwl
        for <linux-ide@vger.kernel.org>; Wed,  2 Feb 2022 00:08:08 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1643789287; x=1646381288; bh=L4c2he6lgl6k+wvhc9k2+V0VddjuZ/Y234P
        V0+WoJAg=; b=YVvBIibsyoKIpi8uLXg9gr7NmlwBSxu/K/Cw7Ho9QmKjjrGrciC
        VW+Sy5NeCnuLZqBMihgpZPzTpcN2g5vi+NJuWrZ4O6vvCAlLGRMhDmYKmfQtz0hg
        FtyUrvMlRSH+J4QbvFQ/W5vBi4fCd8nXIj6ZjrcgoTILCYxBET9gy476hC+6VQIh
        sxDI4xmnfl6DIZrf8Le91OPM3ozBZbk1cbvfRXxPW1XDbSts4JV/w0xflpAOMQOk
        9kP+JRXzk/pLm3DHh7CzBv33UYnvqU02hQvf9a+TbX5TeE3cjSkAKPL1M68YjigW
        kHhU38ePXEItOM1vOI8iZ/vLgZluPz2oefw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id QBoQDazLME0X for <linux-ide@vger.kernel.org>;
        Wed,  2 Feb 2022 00:08:07 -0800 (PST)
Received: from [10.225.163.62] (unknown [10.225.163.62])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4JpZDR3t7hz1RvlN;
        Wed,  2 Feb 2022 00:08:07 -0800 (PST)
Message-ID: <0e44d66e-6981-a243-fffb-54aab28a7d31@opensource.wdc.com>
Date:   Wed, 2 Feb 2022 17:08:06 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2] libata: kill ata_acpi_on_suspend()
Content-Language: en-US
To:     Sergey Shtylyov <s.shtylyov@omp.ru>, linux-ide@vger.kernel.org
References: <75f6ca58-3fac-9919-d7ae-39e7730e045a@omp.ru>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <75f6ca58-3fac-9919-d7ae-39e7730e045a@omp.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 2/2/22 05:50, Sergey Shtylyov wrote:
> Since the commit c05e6ff035c1b25d17364a685432 ("libata-acpi: implement
> and use ata_acpi_init_gtm()") ata_acpi_on_suspend() just returns 0, so
> its call from ata_eh_handle_port_suspend() doesn't make sense anymore.
> Remove the function completely, at last...
> 
> Found by Linux Verification Center (linuxtesting.org) with the SVACE static
> analysis tool.
> 
> Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>
> 
> ---
> This patch is against the 'for-next' branch of Damien Le Moal's 'libata.git'
> repo.
> 
> Changes in version 2:
> - added the 'drivers/ata/libata.h' file update.
> 
>  drivers/ata/libata-acpi.c |   21 ---------------------
>  drivers/ata/libata-eh.c   |    7 +------
>  drivers/ata/libata.h      |    2 --
>  3 files changed, 1 insertion(+), 29 deletions(-)

Applied to for-5.18 with a small change to the patch title:

ata: libata-ahci: kill ata_acpi_on_suspend()

Thanks !


-- 
Damien Le Moal
Western Digital Research
