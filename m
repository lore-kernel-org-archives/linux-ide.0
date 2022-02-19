Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CADC6C433F5
	for <linux-ide@archiver.kernel.org>; Sat, 19 Feb 2022 02:21:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237178AbiBSCVs (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 18 Feb 2022 21:21:48 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241085AbiBSCVr (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 18 Feb 2022 21:21:47 -0500
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AC80D46
        for <linux-ide@vger.kernel.org>; Fri, 18 Feb 2022 18:21:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1645237287; x=1676773287;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=lKJZQyrQLXGCASQljglNAxniAfD0E4wOu3FGK2/tpXY=;
  b=dduEEGugJbMj8LPtNHLaV6UP9AsbhJ49mZFfWMBOrzwwr8nCohNxnujs
   JbQaS2ssGge3VBK4m5AhSH4gLI/0f7uGGqBPupJAx52Rwrso4n7UeYf2r
   GJwKjir+06j3TvceG9Bb7YPLCZ68eOCn/LTrgCEaJV3uBPwP1CW/POF/L
   rm8zCHT42eRCXTwDldkgSURJL4tEJO8jGt1uBOEM0ZholuCcpJwz3NXIf
   7sZ3fwdaLBHdByHcBnxmvgSbJhdisQL+93hmsyuew/VhDxnxhmdRp6uBY
   yBvziFoHnKNyn1grNHlXtnbpIX94zTNNqmL08ZjZtw27fXbBC0vMB78as
   g==;
X-IronPort-AV: E=Sophos;i="5.88,380,1635177600"; 
   d="scan'208";a="198156879"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 19 Feb 2022 10:21:27 +0800
IronPort-SDR: Pg0vLOYEhCdKhKZw8zpcYfgr3KiGwCKVpcS043ehnahTQiPyXQIxuPTEybreeFtjy0k7HrwmAQ
 4QDhU+9xzu7LNwxOTWyzfcbvR9ZLO0W58GEVGBTg8e9jfB9Gwj9eeJDtZ/g3Na7qcsgFg7oXx4
 68ex+IK5M+wfZbKo9X8ENlYpba1KAqQ2TPRnlO6NvsMAKjOxjsrkkESbfpStRL3WlxOzoP0aPE
 H4p8QV3QneKhduhI5iWHoiow9JWRHYDnWXhzkH93O3gYzNgGsG7zck8h4o+JEvZmj818/tjtGF
 3pjLqc4u9bFAYlZhJGpt9YBt
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2022 17:54:11 -0800
IronPort-SDR: kty2SHUEMWFIm6GbOpg2Vx6Zcxozpo4RDCjx2Gd+wlO246/yfbRAt0CkY0xaOSyyG+RVVLop36
 FeCgZq4nS4vfx2k3zJ6o9eOV0bgn7gmIrXjiE0y91kIAC67MjogI+5lI8Uke+qPNsCiSI+1bdC
 ggQlWiSqDZudmbafj1PrrjtAiMuLdDha/norOuMMouwJlkCd13ZZ4SlXBj779R6Nu7rRpYfLq+
 am7up2yGAgqzfjr09rGl1T1WgxIT6c44v9atIWOVO6SlLpqypaA1LQbHXCNZoREYzk86d0vKeS
 Cas=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2022 18:21:28 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4K0skb4vgNz1SHwl
        for <linux-ide@vger.kernel.org>; Fri, 18 Feb 2022 18:21:27 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1645237287; x=1647829288; bh=lKJZQyrQLXGCASQljglNAxniAfD0E4wOu3F
        GK2/tpXY=; b=EaMIHPkWu12ARROJci3Dl0udXe/+RJWQB+5LfLK+FNLvoK2FEl8
        Y3OnVpD+LCsYiwKAV0FuZe7bxznQUe7cop+LBC1m8Q/UsGwe90+48FWCqO3TNCRi
        aVolYjCOyKWPWSo/r5uRAUmk9uTxKJ5ow/YN/aRRLdHK5/HXcHj70MJa97ENmwHa
        UrrSiR7TmaC99BOkkOfqiP0bwaKzVvrbnkARrhE7AYyai56S/00PST0eF+pbauRf
        2GIFcDxmGIHXRw9llGbNtU64LifNbN1k0MKrSCaTt+VPBQpFlB07JHhfI+Wbz+rk
        rj92cU9zVNDDvYhP9/EKbjUrm0WxyOXYpAw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 07haRu3egPqo for <linux-ide@vger.kernel.org>;
        Fri, 18 Feb 2022 18:21:27 -0800 (PST)
Received: from [10.225.163.78] (unknown [10.225.163.78])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4K0skb01QLz1Rvlx;
        Fri, 18 Feb 2022 18:21:26 -0800 (PST)
Message-ID: <1370d120-ac2d-54bc-dd33-538451897d5d@opensource.wdc.com>
Date:   Sat, 19 Feb 2022 11:21:25 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2] ata: libata-sff: use *switch* statement in
 ata_sff_dev_classify()
Content-Language: en-US
To:     Sergey Shtylyov <s.shtylyov@omp.ru>, linux-ide@vger.kernel.org
References: <201f6b13-80a0-3906-7308-d1ef2d68ad04@omp.ru>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <201f6b13-80a0-3906-7308-d1ef2d68ad04@omp.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 2/18/22 00:38, Sergey Shtylyov wrote:
> In ata_sff_dev_classify(), replace a string of the *if* statements checking
> the device's class with the *switch* statement that fits better here...
> 
> While at it, fix the multi-line comment style in the vicinity...
> 
> Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>

Applied to for-5.18. Thanks !


-- 
Damien Le Moal
Western Digital Research
