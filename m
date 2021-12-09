Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBFB7C433F5
	for <linux-ide@archiver.kernel.org>; Thu,  9 Dec 2021 08:42:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235036AbhLIIqW (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 9 Dec 2021 03:46:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235019AbhLIIqV (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 9 Dec 2021 03:46:21 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9218AC061746
        for <linux-ide@vger.kernel.org>; Thu,  9 Dec 2021 00:42:48 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id c32so10624414lfv.4
        for <linux-ide@vger.kernel.org>; Thu, 09 Dec 2021 00:42:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=uzNJnXLH9ZUvNxPl4Jf+tO532cstdbrGCUjXE5IEgL0=;
        b=LCl6i1h8qD4Htv1gkyPFKjIBOl2oJv911GxtwuvvVQAFAMMp6wvjvBMXj6yXjlaXZz
         VPZOg4MmuqX2XSWldnN/J4SJyP/l47ty1vshg+ylrPYXZ2m7oPKmiIhetFkJftb7+vnj
         q8dwxrXXEkZTT5aJRSrvw9nbCPMXnMfnHBU1LinkOvwjII8DslslhNoT8MKODGCt5xoS
         cTIWT2xOiOEjw2Sa6LWc7a6ze+yxvFSDQZNSeQLPve0CCrLjpaYgNzMuHB9f9a64QpA+
         xwZ8ZqaDRUe9EJnhkvbfSVMmi9ujoGLzXUW0NPkzWhudhlD8ydR+wq+3ybEc7jQGq2w8
         2l2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=uzNJnXLH9ZUvNxPl4Jf+tO532cstdbrGCUjXE5IEgL0=;
        b=yMD82ravQmkh22fhUWxLnWVoBBA6KGH49FJfK7xEigqxRJRz6XHDATxP4ux56mIrtL
         hYzoBU2149NyjMvipvb9CE+YdMA4YYLA0yxjC2+6Gu5dl0Y41CPJEhwHCRsS9oU+KLCA
         2uIN6xa6kEnsOrdEC/1pVfb5Ia0odD/lZRH/NbLiH1gLyaJAu7ildBx8FKzGwRTXTjmi
         Q4W3iraxe9aAYoGirmSgFu+OVR1Hd/TXGk/L9DoZriqzVVQJ0VTOdUIj/Jyq+kLffm51
         2RrLNHZIe7iY6fmnqRF9Pn3Nw+nkUI95UPh3y6evzD24HUoXDy+o46xBEfYh7LErYVby
         C4iA==
X-Gm-Message-State: AOAM531dkSwnIxKgwUfNSbtCCsAcRlA0jqlk2Rmc71q0SzjqnVeZ9YiU
        057kRhsBFgg71VW4f4Z81+4=
X-Google-Smtp-Source: ABdhPJwBhLU27gKKIKdOUR7JgwCcwg2UAsyjdAuyVzq7YTzAc2d3SJUPZ8QhnCPfICTsbHP4FJuBgg==
X-Received: by 2002:a05:6512:405:: with SMTP id u5mr4538955lfk.271.1639039366901;
        Thu, 09 Dec 2021 00:42:46 -0800 (PST)
Received: from [192.168.1.100] ([178.176.78.201])
        by smtp.gmail.com with ESMTPSA id f17sm465291lfk.145.2021.12.09.00.42.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Dec 2021 00:42:46 -0800 (PST)
Message-ID: <116f7933-5dbc-4aae-a300-fa544f0b1b0d@gmail.com>
Date:   Thu, 9 Dec 2021 11:42:34 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH 22/73] libata: add qc_prep tracepoint
Content-Language: en-US
To:     Hannes Reinecke <hare@suse.de>,
        Damien LeMoal <damien.lemoal@wdc.com>
Cc:     linux-ide@vger.kernel.org
References: <20211208163255.114660-1-hare@suse.de>
 <20211208163255.114660-23-hare@suse.de>
From:   Sergei Shtylyov <sergei.shtylyov@gmail.com>
Organization: Brain-dead Software
In-Reply-To: <20211208163255.114660-23-hare@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 08.12.2021 19:32, Hannes Reinecke wrote:

> Add tracepoint for ata_qc_prep().

    You're also adding a tracepoint for ata_qc_issue...

> Signed-off-by: Hannes Reinecke <hare@suse.de>
> ---
>   drivers/ata/libata-core.c     |  1 +
>   include/trace/events/libata.h | 10 +++++++++-
>   2 files changed, 10 insertions(+), 1 deletion(-)

[...]
> diff --git a/include/trace/events/libata.h b/include/trace/events/libata.h
> index 7d48e804b889..360f99980b44 100644
> --- a/include/trace/events/libata.h
> +++ b/include/trace/events/libata.h
[...]
> @@ -235,6 +235,14 @@ TRACE_EVENT(ata_qc_issue,
>   		  __entry->dev)
>   );
>   
> +DEFINE_EVENT(ata_qc_issue_template, ata_qc_prep,
> +	     TP_PROTO(struct ata_queued_cmd *qc),
> +	     TP_ARGS(qc));
> +
> +DEFINE_EVENT(ata_qc_issue_template, ata_qc_issue,
> +	     TP_PROTO(struct ata_queued_cmd *qc),
> +	     TP_ARGS(qc));
> +
>   DECLARE_EVENT_CLASS(ata_qc_complete_template,
>   
>   	TP_PROTO(struct ata_queued_cmd *qc),

MBR, Sergey
