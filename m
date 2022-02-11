Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3402DC433EF
	for <linux-ide@archiver.kernel.org>; Fri, 11 Feb 2022 07:43:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347746AbiBKHnG (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 11 Feb 2022 02:43:06 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347759AbiBKHnF (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 11 Feb 2022 02:43:05 -0500
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DFF9220
        for <linux-ide@vger.kernel.org>; Thu, 10 Feb 2022 23:43:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1644565383; x=1676101383;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=xV1Xt7qZuIJbKdhiwEYGnwXjYuIyIN/x/fsiGnpmYYw=;
  b=gR0CMY5xOiGsFv1MY7269WO0VyHR2C3p/fNCQm1UWgGizlARj75eQhMa
   2VrO+scOjWGgXOE9vYzsmp6RFaEJJ56oKWsNxy3DF/afOL6nmqyqeMapg
   bD0JydhIjxYSu4Wqd2Bu9JpAEzhul/OrqEmGfvAwkj0mB2tK3ky19GvDV
   myE5KTPNSEh5nt7s05LZ81Aq17bF/cF3bfkeWiI3JiUllQrbegA4Pxpwt
   xYuif8KxAOl0e+6cfl9gG3ysQm2sUS34AaqH8NJHN+d4TpTsPL7yMztYK
   f3bZJOFnBwyzEpzztduDd3YhOgBk1Qv5Om4xReDCdbZvOTgYLuPY9GSO/
   g==;
X-IronPort-AV: E=Sophos;i="5.88,359,1635177600"; 
   d="scan'208";a="192675430"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 11 Feb 2022 15:43:02 +0800
IronPort-SDR: WfexfDlTgd+LuYPHVBHPc4uQ9M+BUILLqaQoSjCI0mJzU246ukm1V0sfoW4tCYOZLvIJ+MDG0A
 KUG0HhRN5rksbPBE9RaPlfQjbxc0yDv8Oq1gCTVVVSQrJIJAQbGkiX70e3L+03rdDw8U9oYaU0
 fbsMEwQom8xNjWGBDo3uilU3oiyQP/Tptru+zaspUfUDAkhQ0fWgR64SjVm/GfVuKoUWAFuUHi
 QEeJg1FTRDtVCaUytAgAQq0OOlxqsD50kKZknSYtu0i28z5U6w6SUtzvd6/9MQZcbhFGR7TN6Q
 iWSkJKQsBFaO+C4aMW8pe1jz
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2022 23:14:50 -0800
IronPort-SDR: ByBTKoSQW/O40tnQUAYfwz4AshH0ZOMkw81a08fB+HsqkVR+INS1/2pTN/Pa7kZoKonx5Oy3cb
 fO29thDiE69s/2xh5kd57Rjr7gkHmNEP4PR0GO5guRZdvEDP0X5NPQiUU3Aq6NQdWooPUZFL+w
 q3cJY2T41SfC3gmlHwmBXx6hPbVyQyOE+a3l6BBBM4Jbs65QungEeGfcdMG3hxKWJRue0+9AZt
 PZ0Tt7nU2vBPWuBsX1gb1YyRkjXXtyeMWeDXcCr00q5dWEs6NW/XU+A/a0qT9sGAdzIgdz3zG5
 sHA=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2022 23:43:05 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Jw5FM717wz1SVp0
        for <linux-ide@vger.kernel.org>; Thu, 10 Feb 2022 23:43:03 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1644565383; x=1647157384; bh=xV1Xt7qZuIJbKdhiwEYGnwXjYuIyIN/x/fs
        iGnpmYYw=; b=JshSfVVOYE959No6nGQxRVk63PT3RmP6PQaYbL6DMAGcEbn159d
        J7fyaH3wFhG73FJZng8Cp6a2tocOx8Z8+tHXzJ8yVuW8dNbaY7DlArOW2LLzN5Ba
        dbQGF08J3JNDzSP+tnvqAwZq05WwsUH/bi/k5bzqxSklFFXoilKZttGp1S62vWE/
        WVffW6JiKk92wkwsJ7u6IqAPjormbCW/BAcYR86tjoXuPt+EmoS0SvJb9o78SYIW
        CtaHXBnTEkBurbDsWhNaLIOX08FmNqf1n16YYlbrSvB9RLcLwUmH18iNmQ1qmgPP
        qhI6xEyGfZKKEObLKgYPeRfqj379FfVaOgQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 3Ba3w02UBYr2 for <linux-ide@vger.kernel.org>;
        Thu, 10 Feb 2022 23:43:03 -0800 (PST)
Received: from [10.225.163.67] (unknown [10.225.163.67])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Jw5FL664Gz1SHwl;
        Thu, 10 Feb 2022 23:43:02 -0800 (PST)
Message-ID: <ddc1de5f-04b2-19a3-ef95-dad189a66d04@opensource.wdc.com>
Date:   Fri, 11 Feb 2022 16:43:01 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 5/9] pata_mpc52xx: use GFP_KERNEL
Content-Language: en-US
To:     Julia Lawall <Julia.Lawall@inria.fr>,
        Sergey Shtylyov <s.shtylyov@omp.ru>
Cc:     kernel-janitors@vger.kernel.org, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220210204223.104181-1-Julia.Lawall@inria.fr>
 <20220210204223.104181-6-Julia.Lawall@inria.fr>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220210204223.104181-6-Julia.Lawall@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 2/11/22 05:42, Julia Lawall wrote:
> Platform_driver probe functions aren't called with locks held
> and thus don't need GFP_ATOMIC. Use GFP_KERNEL instead.
> 
> Problem found with Coccinelle.
> 
> Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

Applied to for-5.18. Thanks !


-- 
Damien Le Moal
Western Digital Research
