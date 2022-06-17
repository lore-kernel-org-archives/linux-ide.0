Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CF8FC43334
	for <linux-ide@archiver.kernel.org>; Fri, 17 Jun 2022 07:32:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229701AbiFQHcy (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 17 Jun 2022 03:32:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380297AbiFQHcx (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 17 Jun 2022 03:32:53 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECA291055C
        for <linux-ide@vger.kernel.org>; Fri, 17 Jun 2022 00:32:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1655451169; x=1686987169;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=AGN9iam9OVUBe+emJURBvw7lAJ/RYEcPsdW9ccb3QPw=;
  b=pw8sm7nFloMRnYk4V36kD7x9Kvihc2JoDNTWqqSYpGQBrH6UPCKBquyb
   10pgx4KMousgVlf+oujQjx9So6vnJRNdKYKpAF77JrHflbbSQarN9LX/L
   IPpaojquMczkIxG9Y+AWoSFUOGTcoNlTBCr8YAnQUm9a53ovIJuKFPi5C
   Fz2+FZPzljqPY66qKo/4TK5mU03ppNi8Cj5GYQ7vqFXUWnHgOBN70lS1v
   RXPALUNPCFJM7vwbmUyv1j3TqYg2f5Nqz0khx8V9xyj0duEUUFwE3B/c/
   wHXj2ZV6BroGvJPNWtvf5YpyPnA0/YPofyD6t9V6kNB7T+2fmZt4rRATT
   A==;
X-IronPort-AV: E=Sophos;i="5.92,306,1650902400"; 
   d="scan'208";a="315492918"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 17 Jun 2022 15:32:46 +0800
IronPort-SDR: fUj7vw/bSGJfcvU23DUVQN+rPHWoFEWx6U2+mWkZsYhZUkMXlJR1P24uA70meI9aO55Tsc1Avh
 H9d5/E7SWVaudSnOxCL87s1utA/+6if9L70k/ifpa+q2f2yOS2R3GCy+ksO0wNoAmOHvv/AX6R
 lDntDB7MSL7NGO10/qY//Uff7VgCsY5nFgMm+pCZmuQS+Cz6pDAUQurtqb6b2O1Lhrw6T+Kcdq
 f+SAEcib/JVAuWRwfEEsUHxs2U5DcYXg9HB5ZuET0Mnv7w7KyxH5K+AwQWBGyIfCd2OLpBeEB3
 B59gwCc+XKBm7XZq4QFFNvXv
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Jun 2022 23:55:21 -0700
IronPort-SDR: RXlPSQSSJ8HhVp5s4kXaoap71BY4uWQqmFOTRJB6zjl1gadxfgIUOi93wEDkQuKguY+HsQHTAd
 f5lrFsfUtcy2u1vdbr1bzJP2DZ1z/Utmj7CIeQmgl1+1Yx08XGzwelzcFbpe3B6dEwZM2XXnxe
 +UqcwIUOaD4QlTgWv/pUHzfrHxx7Kn/GQHuOIv+spVq3XezIUqLQG8LXI0VN0Xu2Q1ir69IxhX
 kBjwaTwTsS3dfYgxgaTyivHkuKKYr+lyayCCVacIdPF3zIU6Mw/Nc2wdimt6IQInO/Ro6JV/e3
 3iM=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 17 Jun 2022 00:32:46 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4LPW3L2T5dz1SVnx
        for <linux-ide@vger.kernel.org>; Fri, 17 Jun 2022 00:32:46 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1655451165; x=1658043166; bh=AGN9iam9OVUBe+emJURBvw7lAJ/RYEcPsdW
        9ccb3QPw=; b=nsuz0R9+VvgOjUFhD2WdHST7UJx0g5mjukF2CpQndUZwlvj1u/0
        3c9bLNKR90G6isAcA2E3GmYTOAE7Kzt7MHN4Zkp/PXQoIboF7ge3qd7PirT+dB4f
        41UNhPvYdKwKykAKObSP1e0jfwV2gNJYqR2tz/+fr58j3XamR7GxBmkD7O2Pt0DC
        hR97Rr6hKhXTyoMd5/CnkHL2s5i+u/REHXRAdDZ0yT9pTgLUvZXlaKPX/Mj/ucIX
        0GDszV8hQ27aYT1BkDQKHct8teZBZ0X613Dp2gS5uyAH4HIrh2gRJyiDdZ2nGtmo
        LjGL7/GOiisfeVyGICVVc3hUddnRHLow0dA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id DhrFWRYi6i1z for <linux-ide@vger.kernel.org>;
        Fri, 17 Jun 2022 00:32:45 -0700 (PDT)
Received: from [10.225.163.84] (unknown [10.225.163.84])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4LPW3J3r3vz1Rvlc;
        Fri, 17 Jun 2022 00:32:44 -0700 (PDT)
Message-ID: <84b454f7-3c84-541f-ff9a-4f247b178c69@opensource.wdc.com>
Date:   Fri, 17 Jun 2022 16:32:43 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v4] ata: libata: add qc->flags in ata_qc_complete_template
 tracepoint
Content-Language: en-US
To:     Edward Wu <edwardwu@realtek.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, Hannes Reinecke <hare@suse.de>,
        Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     stable@vger.kernel.org
References: <20220616001615.11636-1-edwardwu@realtek.com>
 <20220617033221.22049-1-edwardwu@realtek.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220617033221.22049-1-edwardwu@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 6/17/22 12:32, Edward Wu wrote:
> Add flags value to check the result of ata completion
> 
> Fixes: 255c03d15a29 ("libata: Add tracepoints")
> Cc: stable@vger.kernel.org
> Signed-off-by: Edward Wu <edwardwu@realtek.com>
> ---
> Fixed, thanks again
> 
>  include/trace/events/libata.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/include/trace/events/libata.h b/include/trace/events/libata.h
> index d4e631aa976f..6025dd8ba4aa 100644
> --- a/include/trace/events/libata.h
> +++ b/include/trace/events/libata.h
> @@ -288,6 +288,7 @@ DECLARE_EVENT_CLASS(ata_qc_complete_template,
>  		__entry->hob_feature	= qc->result_tf.hob_feature;
>  		__entry->nsect		= qc->result_tf.nsect;
>  		__entry->hob_nsect	= qc->result_tf.hob_nsect;
> +		__entry->flags		= qc->flags;
>  	),
>  
>  	TP_printk("ata_port=%u ata_dev=%u tag=%d flags=%s status=%s " \

Applied to for-5.19-fixes. Thanks !

-- 
Damien Le Moal
Western Digital Research
