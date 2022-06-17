Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 493A1C43334
	for <linux-ide@archiver.kernel.org>; Fri, 17 Jun 2022 03:26:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379695AbiFQD05 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 16 Jun 2022 23:26:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233449AbiFQD05 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 16 Jun 2022 23:26:57 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60C9E64BEC
        for <linux-ide@vger.kernel.org>; Thu, 16 Jun 2022 20:26:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1655436415; x=1686972415;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=8ctfFtmaA8Kx+E6xmFh3lcOlj9ZvelqXJoJObAR3Zwo=;
  b=Uh9B6TOUWvej1HI4lhp1zI7Nxy51zX+DbZEz1pZcUrIE/TpN8oya/Qkv
   /9pxQGe++elwaWqsTnPDqHPNNmVfK69zc0xen66tERpsWe0qat836E46A
   TydaME2eTAoQp3OpcqeMGSc0LDzNjUF0TXdK2GNR54m2s/wU2o3ZKyD2Q
   IL6TuDzYI6QQsfmqUiCcZpT0JFNfLzzv2QdEb/t/MP3NbkJm/ntXWHyH4
   Hh4ZDCqeVYMoac+tsLyzK/EnrwSFqqVB7sBA/Blgw8lZXKhQrub04x6cp
   GchOaOZmFBz5rO5AdHh0llsXTJGHwpBwUxLof5YhWOymF7GEkomhNJXmy
   g==;
X-IronPort-AV: E=Sophos;i="5.92,306,1650902400"; 
   d="scan'208";a="203390664"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 17 Jun 2022 11:26:55 +0800
IronPort-SDR: ST45rAEiABH12eLMnWw7LX0O3/AZeQ3b8eYXUBsA6ar9TWgqqkH15wk1I0UksdceORby5cQuBG
 SkpNG3XL1YyrTSEimbppxXXDEqlmYDYXgonA0uk5fKe/yvX3tezamOVkeMUxRYpMT6d0od46Nc
 s0N4yJuaLq3oZi6C0NRIkRQ2duEgeOV8xZgymePuqNIKCVZwPWfvRzkvxw7aAvepHBCWL2Rlvd
 8iZ46BbmIUcu3ZW9rBjuO4ZGGRX+tkATTZayvqP/ZL99RyvrfI701cXPqjWpBOtHen5RtZXYpF
 v08+WJwmd3l2Vy7cXQmSZ+wB
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Jun 2022 19:49:31 -0700
IronPort-SDR: 893T2tvjnfYh54SYtbCTDtBmDsOvGfsPiDRkIPSMbua6NY3eZHRNH0P5DBgYQk4rzd3Ljg7vv+
 j777yzmY3EtlhPYzq091KAyW8Y4pYoefQvNvyt97YrT9WpLc5LlkfIiLVuYKow6qwlaGKg6p1s
 t9OaZTFoH/zXcSSRP/cJvvqDNS1FLiUQdfzuAmT2wcZ83tqYRdelQeLkOokepkDy5tDCPW6ZWf
 ZzdSXrdLlruloZ1H2Jx8w2V2rBAuch3XY1r9YtIGmEhb5krku0aasmigOU8TogV/LgCwCCqyni
 bqc=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Jun 2022 20:26:56 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4LPPbg3BKTz1SHwl
        for <linux-ide@vger.kernel.org>; Thu, 16 Jun 2022 20:26:55 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1655436414; x=1658028415; bh=8ctfFtmaA8Kx+E6xmFh3lcOlj9ZvelqXJoJ
        ObAR3Zwo=; b=bbMPlCSkRVeacmi4OmtRlBGuMg9vRsr+r4F+7IyBAxbgdz5RUkR
        Pn9wYdApiMrYiLVtVj0qU8BUjR8n5gFmOWWCPvtrUq+iNAuSNx06e1fQe9F58gbb
        fxNazQK79sUy803nkPZ5eqqmmEPqbvdtXUgla/mLJ0ch10sppsLPV7qXHf8j20Gb
        fts5LCzx8oY0zPpbrjNjluX8iTMu911kccDU1j5suYJZ8YRPjZbAJIFTe5stcnmO
        y9uI1WBWS+YaDRJ8NhNNzIZVCpi4CfXAgIYzbHj7piFC8JHU1WFdPiATkzvelZ5/
        sWyimKJVNDLTVtJtdhoiME5T4Bi0WYRYD9A==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id l960xZ1ayR8Z for <linux-ide@vger.kernel.org>;
        Thu, 16 Jun 2022 20:26:54 -0700 (PDT)
Received: from [10.225.163.84] (unknown [10.225.163.84])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4LPPbd2snYz1Rvlc;
        Thu, 16 Jun 2022 20:26:53 -0700 (PDT)
Message-ID: <e8fe553b-53cb-1dee-36c7-f4f737c81e30@opensource.wdc.com>
Date:   Fri, 17 Jun 2022 12:26:51 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v3] ata: libata: add qc->flags in ata_qc_complete_template
 tracepoint
Content-Language: en-US
To:     Edward Wu <edwardwu@realtek.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, Hannes Reinecke <hare@suse.de>,
        Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220616001615.11636-1-edwardwu@realtek.com>
 <20220617030007.21768-1-edwardwu@realtek.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220617030007.21768-1-edwardwu@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 6/17/22 12:00, Edward Wu wrote:
> Add flags value to check the result of ata completion
> 
> Fixes: 255c03d15a29 ("libata: Add tracepoints")
> Cc: stable@vger.kernel.org
> Acked-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

Looks good. But please do not randomly add tags like the above ack. I
never sent that ! And since I will be applying this patch, I will add my
signed-of-by tag, not a acked-by tag.

> Signed-off-by: Edward Wu <edwardwu@realtek.com>
> ---
> Thanks for your kindly guiding.
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


-- 
Damien Le Moal
Western Digital Research
