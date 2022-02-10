Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F0D5C433F5
	for <linux-ide@archiver.kernel.org>; Thu, 10 Feb 2022 03:09:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232226AbiBJDJF (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 9 Feb 2022 22:09:05 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232158AbiBJDI7 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 9 Feb 2022 22:08:59 -0500
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C04531EAD3
        for <linux-ide@vger.kernel.org>; Wed,  9 Feb 2022 19:09:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1644462541; x=1675998541;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=Zx+5r49Mvd+BcH6BMfJ2OFzVRRNi9qudvNhQIonoz34=;
  b=CkA9NTnKKUCoXJD5yfdPLfBv1WPV2TpgO9ohpWPdRBB5V6joRWilFoOz
   nJ+N/QTMe2bfdttLPnMN8Wkfse3az3kjiLQDxeXdjfWXf+RtQ+B1P9N5E
   15JlELLNIL8jSNUngSF2TUEp64lQks1OAtzkjbj1xepNC7tR+oWts7Nja
   Jv8x76oTVRm6O6WHNWHmBooxVe7k4LFa6XcoK2jiPuKig5nEvSifHcc7q
   NgQEfjedcsDHZ0VusJ+P8OHuKpXdvKpQV4Oq/SRg6+WU/BmSSle3lxoJM
   jUMt6lWhmwu4GngpTddBCEofQ5ozE3kYB3Pq79TybpNjqym1PTtfCuy/U
   g==;
X-IronPort-AV: E=Sophos;i="5.88,357,1635177600"; 
   d="scan'208";a="296661348"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 10 Feb 2022 11:07:58 +0800
IronPort-SDR: 58qKO0GQChStpU0ZVyKpa6RbBWf41XUn+kd0Vg9c8biKSG+4IOTEFr31KS3QBDixxmCPLpLwJI
 q99s76dwfhK940lKNFgz1wORL/VH5Tktfr73Vboju2aldaQpp2huWpw9afcLk9fnUVveSJwrFQ
 8iyt/BZlGlBFQI/1d6AI/OFWKJxTN0eFtjEnEk+pE/M9EO8clILgTKcRRWmaFJJ9LneMLB+P/B
 RehFaSYwX1FliUR1T+rW3+OLVI6ShCQIPR1kMMlTVACBmcZg5E2Wa92qF8eBvRFpfhj1lg9Qv2
 f0sz/rrW96ZPkkXoDAhhCn7q
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2022 18:39:46 -0800
IronPort-SDR: FVZhHhVdlkfojEMWZvuDFaye7YAm6pe6U32sqy5XbzQGvMv3beAukYvCcIQ0xnBggiXyyNOcRb
 WWIsw8U58PS8/mZ9lm1NeAlLLQJqsX6OAkF8qu4/yGq5aK35E1lD0juRs8TvsEfZZ8V7POb42g
 YpKRipiUxVXiGDe+hTq2+9gskHBi3hbRtgM+HniSRddb7pfaMePJtRRUa0KLbRZxHnYQvI20T0
 zeWApFyc2ylYP2LOxArJQStBY8IvVgDPPTRVdhbBD9TW2F811KSRqx5NhSyDR7GjeOYdI6xknx
 g9Y=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2022 19:07:59 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4JvMBQ5MtPz1SHwl
        for <linux-ide@vger.kernel.org>; Wed,  9 Feb 2022 19:07:58 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1644462478; x=1647054479; bh=Zx+5r49Mvd+BcH6BMfJ2OFzVRRNi9qudvNh
        QIonoz34=; b=N1bX44Xv62Jt57jC2KGsjHkQ25/RqEzBHklv6AvF/tywpY2nId7
        Fd8NLPfuSdf0iu2qU7MibI0wdvSPrtYJo7aGlEDmNpbxqbAxHfwLcQhI/8uceYSO
        f3s9p3FB/2yr9kOFdeFFbjPHfZrj+Aacur+NzkhCCKs6axX1pY8XrZdphBBtmjOu
        uLbElm+THK8/5Jmvav/btb4qUxdkXZSi7Zq8dm8q2w3bhWHTQqvaYsFHYrjJqMMs
        EV4CTp+YRun9/chpWMIs7xY7GXaHJuQU5vhoox9ezjGdZoXg5aAeuAci6SmI8zcw
        kt8SZz6HIc9M8KsX7eFp4PbgovbiQYT1t7g==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id RIEApVjhazae for <linux-ide@vger.kernel.org>;
        Wed,  9 Feb 2022 19:07:58 -0800 (PST)
Received: from [10.225.163.67] (unknown [10.225.163.67])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4JvMBQ13CKz1Rwrw;
        Wed,  9 Feb 2022 19:07:58 -0800 (PST)
Message-ID: <a02b1a7e-3d0c-f8ff-b316-1d6ead4f8513@opensource.wdc.com>
Date:   Thu, 10 Feb 2022 12:07:57 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 0/2] Drop unused declarations from HPT3x2N PATA driver
Content-Language: en-US
To:     Sergey Shtylyov <s.shtylyov@omp.ru>, linux-ide@vger.kernel.org
References: <20220209205351.10912-1-s.shtylyov@omp.ru>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220209205351.10912-1-s.shtylyov@omp.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 2/10/22 05:53, Sergey Shtylyov wrote:
> Here are 2 patches against the 'for-next' branch of Damien Le Moal's
> 'libata.git' repo. The HPT3x2Nd PATA driver has some declarations from
> the time it was first merged that have never been actually used...
> 
> Sergey Shtylyov (2):
>   ata: pata_hpt3x2n: drop unused HPT_PCI_FAST
>   ata: pata_hpt3x2n: drop unused 'struct hpt_chip'
> 
>  drivers/ata/pata_hpt3x2n.c | 6 ------
>  1 file changed, 6 deletions(-)
> 

Applied to for-5.18. Thanks !

-- 
Damien Le Moal
Western Digital Research
