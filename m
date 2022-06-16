Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 434A7C43334
	for <linux-ide@archiver.kernel.org>; Thu, 16 Jun 2022 02:55:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229693AbiFPCzY (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 15 Jun 2022 22:55:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350745AbiFPCzV (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 15 Jun 2022 22:55:21 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D04F41332
        for <linux-ide@vger.kernel.org>; Wed, 15 Jun 2022 19:55:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1655348121; x=1686884121;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=whBk6OqEJVjH50l2UWE70391U8KntltEh8+laXVL4cg=;
  b=d/3finrWdepWNH8+i00EwHkD/rPflEajC2hSHnIpIRgi1WRvyuhyGi/W
   GoZ1R8VKnm1NLpXp5ZL0wObWLhsfMdgfQrO8sKFIAlWk+fchp9Cpdl6Yl
   PO/f2lPJ09+2KcLM1K02e4UXbN0ctKfccydNWnzbivHgYJXpZU3sxSZCM
   FF6lN69uLMNerw7dFJRib5cHoo+cAxDIlT6mh94VnXK8343tqfwmICxwG
   k4a095YepkX1Og2EY12VJF1QAphAqHTitRObJUOQhHkWQTp2I4z5VE0ql
   1L8qFjJMPrsnoAom273L5VliBa7Y+e+q1AldSEaqw976pKCN7rtlS0NRV
   A==;
X-IronPort-AV: E=Sophos;i="5.91,302,1647273600"; 
   d="scan'208";a="204048586"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 16 Jun 2022 10:55:20 +0800
IronPort-SDR: MpqXFopemp8MUIpXkL1fe/Xiu79R2eTYQP+pxMy7XRIVhIZWrXozU6DewgjJQGs4WbyTH1Vex0
 E9dvkfsdYgjJJbhfJns4QicdMyLsdZZEbM5RqBlPhyaVFbHuB3re214S+ES1kMdTCIisUC+AXl
 njIFgRH1Hywwr3a7LwatWMQEUp7HZSwVpeh9d18OT8vf28co/JoVcYcaQ3maBopBE5qOgfAQ3p
 dd4sPOY9HewyKntV3HAwIo0nQTu9CrNOaOqCkMd5AeTC0avlZQu6rrrWEW1W9DF8v38Yg5CFtg
 2nKuYj9ZuU2vw8pzf1sagdIk
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Jun 2022 19:13:42 -0700
IronPort-SDR: z1BF15JxtcGthMVmKKxDBibhEzkIOKTh806P9bW3gToCJKKfLTEGhbgXapZ4zd63yXeSvZzTE6
 lGGvhYARn6Z6haiSn4s+ydAye4/jGPnZ4L6bU/VvuwBpOxEXDB7ULb8sgp19aIHnTXL8bBnTgO
 Prz+kcU83ZV5JMl2UO1MGa1F0R3kT+ISVF+uyySOb30X2Zt/ipwsK/kYJm5FhcVLRWBlIAYrBO
 vVRUHSbSQi0wOQOk1bu9Fi70jF8WiyhMd/iMOzBEH2ysgYK4gInTE9ZefJqgXz02et24eMtzPV
 Tvs=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Jun 2022 19:55:20 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4LNmxf5nxdz1SHwl
        for <linux-ide@vger.kernel.org>; Wed, 15 Jun 2022 19:55:18 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1655348118; x=1657940119; bh=whBk6OqEJVjH50l2UWE70391U8KntltEh8+
        laXVL4cg=; b=ruHml7RsiFb+anBTZjwc9CftHEwOtkVm0aCXSW5B6jRH7nhtART
        wQ91xN+5Py5nQqihh+LDPzkSgXIHPP3nt0/+1zbdG8AMq0yf5eZTeeS62vq7fwc+
        rNNos5DbR9dMq9zLY6sQcWzwlj/1AoBFBRK6kjjDUdeyk9NIIAR3uVe8xiXmbS/9
        GOpIa4Hxv7+eYGSqlAzaVgR3nD8asPXY81Eb+FP9SvmaoJZJB4MmgW2nuhEP5xvx
        CKkv1W0/mk436NaaEWApYHITPXkkmCN8D1fMZh1IlkbaJEKP0pBEDtv9dmtr7Fbo
        8nVneO67H+XB4Xg4OVwTjyP3ghxgIT8JnlA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id D3X1on2GnuKO for <linux-ide@vger.kernel.org>;
        Wed, 15 Jun 2022 19:55:18 -0700 (PDT)
Received: from [10.149.53.254] (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4LNmxd1Nzfz1Rvlc;
        Wed, 15 Jun 2022 19:55:16 -0700 (PDT)
Message-ID: <bcd06ab1-6ead-985b-eff8-cbc526a8aa84@opensource.wdc.com>
Date:   Thu, 16 Jun 2022 11:55:15 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2] ata: libata: add qc->flags in ata_qc_complete_template
 tracepoint
Content-Language: en-US
To:     Edward Wu <edwardwu@realtek.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, Hannes Reinecke <hare@suse.de>,
        Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220616001615.11636-1-edwardwu@realtek.com>
 <20220616004803.12145-1-edwardwu@realtek.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220616004803.12145-1-edwardwu@realtek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 6/16/22 09:48, Edward Wu wrote:
> Add flags value to check the result of ata completion
> 
> Fixes: 255c03d15a29 ("libata: Add tracepoints")
> Link: https://lkml.kernel.org/r/20220616001615.11636-1-edwardwu@realtek.com

What is this Link tag for ? I do not think it is needed.
And please add:

Cc: stable@vger.kernel.org

> Signed-off-by: Edward Wu <edwardwu@realtek.com>
> ---
> v2:
> - Add Fixes tag
> 
>   include/trace/events/libata.h | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/include/trace/events/libata.h b/include/trace/events/libata.h
> index d4e631aa976f..6025dd8ba4aa 100644
> --- a/include/trace/events/libata.h
> +++ b/include/trace/events/libata.h
> @@ -288,6 +288,7 @@ DECLARE_EVENT_CLASS(ata_qc_complete_template,
>   		__entry->hob_feature	= qc->result_tf.hob_feature;
>   		__entry->nsect		= qc->result_tf.nsect;
>   		__entry->hob_nsect	= qc->result_tf.hob_nsect;
> +		__entry->flags		= qc->flags;
>   	),
>   
>   	TP_printk("ata_port=%u ata_dev=%u tag=%d flags=%s status=%s " \


-- 
Damien Le Moal
Western Digital Research
