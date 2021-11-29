Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21355C433EF
	for <linux-ide@archiver.kernel.org>; Mon, 29 Nov 2021 11:39:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235315AbhK2LnB (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 29 Nov 2021 06:43:01 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:62162 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230455AbhK2LlB (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 29 Nov 2021 06:41:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1638185864; x=1669721864;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ri0ANpmOT8D2A146xSuVbycuFdeLOCvGrsJX+cx2AI0=;
  b=TgYJ9iJCqHZSYN1IJLGMHbikRFVtbOvY64isnhhBMXYvYWfDfnGDDbcz
   lrPWTxWg2yrnk9opjXUuF1nh/Un9h0EfkgV4OnjlyUI3EK5Na4t3kGZVt
   xtgczrItR0UyOKBNHkptJKRvqO2gSC7EkkWZcvg72TLzUumkrD2ge7BfK
   JjThfxa4o+64h5z95DMIbkHI3agBey1D8WawniibT7kzzanxJgYLCYOXk
   rewWmh40N+zO4xb2b4tNszN8rPU/ewIAgjB2p2Dz0Qea/hGUjpznhiQrN
   9JFfRS/ZAHe+E+6RWO9DPnTWiCFh2SYRDdh/KnKye4DfPddCEc5vSq9Wz
   A==;
X-IronPort-AV: E=Sophos;i="5.87,273,1631548800"; 
   d="scan'208";a="187958528"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 29 Nov 2021 19:37:44 +0800
IronPort-SDR: XcuSFuPy4EIUmEz8m+v5ybi63HkcWYDIxh7gbYaQ6Nll6hsQKF/QUBjP4SNwmNngRhDGqYjUwv
 HhxqIX6eaFz7iO8N5AOsOYEhSyDApFXZJnMMNCMiWxadhUTkkLtyKMfRvBwtzNG1SbYID5jomk
 qE10hGPmqMP/+/DM6GKdmjbo46pMuLixHq1VTt5TKa/PUW4rsnNLyUblUR04vKiB367FA/fNiC
 N1Mw/O/uWFkPxRh9E7ujozi8jvpHqaz15CpdszR5WmyBjbUq9DVfgFsr7GJtfEPmuJyqqZOQd2
 DsxlNVsWixvMWeCrez4ENAMy
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2021 03:10:57 -0800
IronPort-SDR: PU2ElPAPOKT1Qp0Xfrxq+ZjbAoVCfQkKYSTvFq7OMO/WCYRPTSnYceonKF4/Er525pbO9k13Mw
 4NWGTb8Bi9bgeg+DRxMH8nnVxd5Lf27Wjc9gmtGl5e6YyyM2FlIQxFNNT/Q5dSLG8u/C3dzJTc
 Xxzx/UAqmMG4aQiNONVd0bxIhNA3nx3Chdhm38Qag1hy6F8tID/mwfB2K5wto87RnN6RLMDmTQ
 nAZhoxJQeDIys0rVNmgD+GF9lL1ne/OatkqrY3KdgICtaDpN2/ZCgnAHbAKaJqy2BFe4GXbn8E
 RN0=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2021 03:37:44 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4J2jyH3xQbz1RtVm
        for <linux-ide@vger.kernel.org>; Mon, 29 Nov 2021 03:37:43 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1638185863; x=1640777864; bh=ri0ANpmOT8D2A146xSuVbycuFdeLOCvGrsJ
        X+cx2AI0=; b=YsSQ4mTThJTASrDSvV42vSacKD5X6R8ruGUL4KQu8VtDfrTKlpD
        y3DvgoELeK5UfOi0ZG9NNWGahEu6t83CLvSJX6Dz0UrBtkmjlotmdVqMyzxZZlwb
        FM2rePTlWUj13f7gI0lkQhVgbuIk9okACQMNU2Vyx5a4LbNyCLM3PnG/OAQkqqhf
        tTKS974fnDlpv8ZXTMyWfHEOO/migu2dkdPR3/ctdzUSfnHn8Cq8RRN6WCtEHOgQ
        sIOqsXHm+MHeqg/cOJehDUJUCnP0e98LFm+xWm2hlp99w1PSFHG7992wLX0TkBtK
        TfbQ/O5PKDWzatNeaDhYq/nc4nFdMfVs67w==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id A9hmROpwfJMW for <linux-ide@vger.kernel.org>;
        Mon, 29 Nov 2021 03:37:43 -0800 (PST)
Received: from [10.225.54.48] (unknown [10.225.54.48])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4J2jyG6H1Pz1RtVl;
        Mon, 29 Nov 2021 03:37:42 -0800 (PST)
Message-ID: <4c01e031-97fa-2906-556e-968c8f89ea6c@opensource.wdc.com>
Date:   Mon, 29 Nov 2021 20:37:41 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.2
Subject: Re: [PATCH] ata: pata_ali: no need to initialise statics to 0
Content-Language: en-US
To:     Jason Wang <wangborong@cdjrlc.com>
Cc:     linux-ide@vger.kernel.org
References: <20211113062614.246352-1-wangborong@cdjrlc.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital
In-Reply-To: <20211113062614.246352-1-wangborong@cdjrlc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 2021/11/13 15:26, Jason Wang wrote:
> Static variables do not need to be initialized to 0.
> 
> Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
> ---
>  drivers/ata/pata_ali.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/ata/pata_ali.c b/drivers/ata/pata_ali.c
> index b7ff63ed3bbb..ab28a6707b94 100644
> --- a/drivers/ata/pata_ali.c
> +++ b/drivers/ata/pata_ali.c
> @@ -37,7 +37,7 @@
>  #define DRV_NAME "pata_ali"
>  #define DRV_VERSION "0.7.8"
>  
> -static int ali_atapi_dma = 0;
> +static int ali_atapi_dma;
>  module_param_named(atapi_dma, ali_atapi_dma, int, 0644);
>  MODULE_PARM_DESC(atapi_dma, "Enable ATAPI DMA (0=disable, 1=enable)");

Applied to for-5.17. Thanks.


-- 
Damien Le Moal
Western Digital Research
