Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 958D9C433EF
	for <linux-ide@archiver.kernel.org>; Thu, 16 Jun 2022 00:35:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240913AbiFPAfB (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 15 Jun 2022 20:35:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232901AbiFPAfB (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 15 Jun 2022 20:35:01 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1705B393F8
        for <linux-ide@vger.kernel.org>; Wed, 15 Jun 2022 17:35:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1655339699; x=1686875699;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=KS5uLEm7MNinRJDaJienPXh/fDbYItx8+PGMUuwNNNs=;
  b=UazQo1yaBoqiCbybKMXElh3dAsijDqEMIVA6zY3oiNECgYuJoiIKX+gy
   1DtZopHLYj/sJiI1XRZYzdD9jE0k9ddRoO+aYoQ0oB1mwHWqSX56RiC+0
   bb1vbwkwKwNymtOYnpBA5l70GfoNi9ysPZ8qp9LCOsWQzTEZFOeykqNBY
   p32u1WFadyib3L1+XgO7E1oKwUmFyq8M8Ay1ccviPNKxVhWC6NwpvomrS
   2laO6DnMo5MIZxtyD03a41yNIo9xyTGP4MEIpIghFPe6CohrYwNyBT8xn
   3VDgktCdLypyFXCDcrgLAQFV8jvDPPhyMO0gOiK5kiUWhXsbFX2NyDW1U
   g==;
X-IronPort-AV: E=Sophos;i="5.91,302,1647273600"; 
   d="scan'208";a="203274524"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 16 Jun 2022 08:34:58 +0800
IronPort-SDR: zKPKbbFz3FyjFuZJk/6hRW9mTTdxCXfAgIG/oTvVzDdNn2fVR72QnhVkVFQDfVlc5Ain4GX90E
 bgx7rBZ/L59kAnxPVhcnVkG7EjRhu7HSWOzdU0Fr4wLM9A9fbCFT8IezQTEoibSRQ+wAu3IWVx
 ITfnMIbuJLy3hpCq91TG5tryvREem+XxjzLeNQDC/fCLjWJBzvUEgVIKf8IjDqKOsPTk1Nmj53
 dAgdhhuVb5KXMstJFHKlFFQYWQVVd4s7OQn862ZYO1lbd1sRYTGFDIxDV9iOBnrOXUu17svoWl
 ymu7Mie3KGKc4A5NglvVzIDY
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Jun 2022 16:53:22 -0700
IronPort-SDR: 1Xo45/b5IkfUW8Fd8xcAr1rHpz6v+A9WiQCwmmTgZRFLMBOrQ2CGPnoSrrA7PQzdMEz0Kpi/nS
 pY56e68efHZfpY2+PJ971SZdGVB5PDW2u9MC/Na7hMrcbSaUJNrinqry1OijDyBIZhPFZ4nHkM
 F+tCtQ/38LXlqVZ3/cyU5Q1FNX/6thdkVXFYoDmQUJ8PLEjMCBa+zYtbBG8G+zzqCO8h14tk5b
 AKHVcq2Ij+3gtKYuW1v3seEJZsy0IEHD1XAHt0ST2jS74SdIxymfN4RdDmMYCPxL4f0pe42Dnj
 gdY=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Jun 2022 17:35:00 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4LNjql0YRMz1Rvlx
        for <linux-ide@vger.kernel.org>; Wed, 15 Jun 2022 17:34:59 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1655339698; x=1657931699; bh=KS5uLEm7MNinRJDaJienPXh/fDbYItx8+PG
        MUuwNNNs=; b=RiM6WqT7AHdiwKBJPsC+op3gcAmu0GTj/oKDLszzx1P0UtL2ilz
        aWgfIOmFWtOX/bMCl9TIw0BDLHggYcZwfhNl3/MOggs3MQuiCjC/pjxOyesUcGFw
        ANedf6OkAN9QeBSzd06B2bMwbB0RKFiCpM0YTl2EBcUEifg9ikMfUEtFsLDfCh6M
        5clI7Fk0cQBKlpaq319qkLu3olEc+OAJupC1cggJS900CEiEqv5M/NPgKXCCUb/S
        8euy2HXKBhUyIcOnW8kBW5Ydd7KinQhHg4cgMs1AtCh1XZKrZzS0/54uTqHIeb0Q
        AMPpW8LdTDG+voTtsj0Yz0C3lOcqfRBJBEg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id hFW-Ewy4xs6o for <linux-ide@vger.kernel.org>;
        Wed, 15 Jun 2022 17:34:58 -0700 (PDT)
Received: from [10.89.84.185] (c02drav6md6t.dhcp.fujisawa.hgst.com [10.89.84.185])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4LNjqj5zhrz1Rvlc;
        Wed, 15 Jun 2022 17:34:57 -0700 (PDT)
Message-ID: <6082771c-6bf7-bb34-4d2c-5199024dc4cc@opensource.wdc.com>
Date:   Thu, 16 Jun 2022 09:34:56 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.10.0
Subject: Re: [PATCH] ata: libata: add qc->flags in ata_qc_complete_template
 tracepoint
Content-Language: en-US
To:     Edward Wu <edwardwu@realtek.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, Hannes Reinecke <hare@suse.de>,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220616001615.11636-1-edwardwu@realtek.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220616001615.11636-1-edwardwu@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 2022/06/16 9:16, Edward Wu wrote:
> Add flags value to check the result of ata completion
> 
> Signed-off-by: Edward Wu <edwardwu@realtek.com>
> ---
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

Doesn't this need a Fixes tag ?

-- 
Damien Le Moal
Western Digital Research
