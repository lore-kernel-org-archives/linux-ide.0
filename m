Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDDC6C433EF
	for <linux-ide@archiver.kernel.org>; Sat, 19 Feb 2022 02:22:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241085AbiBSCWZ (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 18 Feb 2022 21:22:25 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240107AbiBSCWY (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 18 Feb 2022 21:22:24 -0500
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E69E91D1790
        for <linux-ide@vger.kernel.org>; Fri, 18 Feb 2022 18:22:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1645237327; x=1676773327;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=GtkkEGiBXNnn7UHzcNwGZPnkLNxr1dF0AlF/z74R0Yo=;
  b=YLHouuAAq8L+7LtwWkvwNgRpcgAG77pHcUItXCxLBrVjPCGJ+0hK3Xo/
   iG3voU+y6MzUlfRvEOtfNmKuhM/DFWAO1or4jP304pNVLN6i+jN2y2uaY
   TDJJr/7ewy9lcUQALEL/VcOrKG5dkYK2yBaqQDzm+6LaIVCicW1iIt2zQ
   7hBn499d0wS2hrsevkEHE2FLOMWY6i83fLtudNdK03E7D2yyFqwc+uPBL
   aPYdH0b913NN/NTJa/WcIOMnpORt1+gFtErXxwIAmJliLgrdIjAm9EKkw
   cfxgVYQ+W+Rm85IT+3gjW8xrN9wko5Os+/b33/EztIAz0pONfUGZcvEm4
   A==;
X-IronPort-AV: E=Sophos;i="5.88,380,1635177600"; 
   d="scan'208";a="194307603"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 19 Feb 2022 10:22:06 +0800
IronPort-SDR: 4y0AghteBvlTp1L30YWNwOMaFK33MkBbwvxTztZRofRW0AgH3yn0Vqvd/ktJFdwQm4mIY9TdIF
 X/ikrm7ukeY1ajTHLCfHZNX25Ik2WJ+U5h7FcGBqa2cXfA5fJMSclHljG77rb4X/C5cnJ5x/7i
 vPCcrCbtcfLqrMIDuMJVmkWc6kiEWCL+szSSuM0GyRxGFi2/vlD+XuD7FB+7oyEhhU6MhYFetX
 G99MLNMfeTcKE8pafsbaB21be6qWOsp6ppngAsxzLHYPK1x/fvnlPxFSYl4WYy/v2bCMqLdEc7
 9FkMenEoUxux6Mh6jiF9mFg/
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2022 17:53:41 -0800
IronPort-SDR: xvt+Ds1Yuwm3FUlKQCgh7QxcnDZdY/8J9ZNzwBiFlcB+VRENUw3gSzsVT4i6NpTm6HHKNmtAr+
 N7d9OnoU8k0L2tQ+l8WYFWM/xBQdcF6y+SbgtHIxOD34Tf6jJAqed8M3PnZgqm1sWPYSWzVbn1
 anCIrnTUm9KTmVFHde3FO83RVaeVmyVbesBuTI+xOVZCbtDB5+lCbO62trPd7jx9Aie+th60YW
 ELW8pQ5oE7ALWieNdZOfEc0VN6GPWSjF1itf1j1AK6HuH4Hw0/1h8ZAIti/A1aqA+vXWtBbL9E
 I4k=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2022 18:22:05 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4K0slJ5vFlz1Rwrw
        for <linux-ide@vger.kernel.org>; Fri, 18 Feb 2022 18:22:04 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1645237324; x=1647829325; bh=GtkkEGiBXNnn7UHzcNwGZPnkLNxr1dF0AlF
        /z74R0Yo=; b=PuQV373e4Z12CZFxJtb0DvAwn2EujNKZUCE8Eofr+79Vt60dFBs
        bxWs5HK8ge+Dv0aJGwfbcFrzH0LsyOTBTUA8s5ITi4hWkgbJH32xbyZLcydbQdRW
        2Tq9aGmcVRAHDUvDi4DH2xA4MYUZUxnmrhfv8ASzRvvPcOCsCAcY/t0ScAmBX9kc
        7WQTUMC2mZAAmxrwJgi1JPwvAW18iDbkNi4N1RyeiAhmTsMLsLx/CGb8ctLFQUaG
        t/FivzLnlbmZogo8/SMuPzY1IDyx+v+tf89krWHkxC/KBiVZQJU9eBqFBElCdfpG
        2dVf9drcISW6CGPfp2pXa7dozpelgVvJd0g==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id DEIaeb_MdNnC for <linux-ide@vger.kernel.org>;
        Fri, 18 Feb 2022 18:22:04 -0800 (PST)
Received: from [10.225.163.78] (unknown [10.225.163.78])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4K0slJ1NnSz1Rvlx;
        Fri, 18 Feb 2022 18:22:04 -0800 (PST)
Message-ID: <17712956-d47f-30a0-bafa-7351d7c453bc@opensource.wdc.com>
Date:   Sat, 19 Feb 2022 11:22:03 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2] ata: pata_hpt37x: merge transfer mode setting methods
Content-Language: en-US
To:     Sergey Shtylyov <s.shtylyov@omp.ru>, linux-ide@vger.kernel.org
References: <e3a09b84-1285-fd2c-689b-26c9c013dc0b@omp.ru>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <e3a09b84-1285-fd2c-689b-26c9c013dc0b@omp.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 2/18/22 19:06, Sergey Shtylyov wrote:
> After commit e0afcf140e6e ("ata: pata_hpt37x: disable fast interrupts in
> prereset() method") HPT370's and HPT372+'s PIO/DMA mode setting functions
> have become identical -- merge them.
> 
> Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>

Applied to for-5.18. Thanks !


-- 
Damien Le Moal
Western Digital Research
