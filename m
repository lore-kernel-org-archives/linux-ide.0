Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C67D8C433EF
	for <linux-ide@archiver.kernel.org>; Thu,  9 Dec 2021 12:47:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232859AbhLIMvP (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 9 Dec 2021 07:51:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230094AbhLIMvO (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 9 Dec 2021 07:51:14 -0500
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64751C061746
        for <linux-ide@vger.kernel.org>; Thu,  9 Dec 2021 04:47:41 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id z8so8790928ljz.9
        for <linux-ide@vger.kernel.org>; Thu, 09 Dec 2021 04:47:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=QcaCyKxp/6Cbvw/6pcMmfrOR1SnYLtwQTxT8ktNlyuk=;
        b=pCXcORSU+AG8SffmYshPYGOjBwGuTXV4G+lgSwMK12pD9tsE7DebHgjJDy6EcpXG1J
         VtshaM+UWBcqfMy/koL5Cw1yBuhxI67TUo+9kGpRMfCWWNu77hd/t64Jti9QE63wNCkY
         2I4husHlKRJLMxcma3Vs/hdUgd05cGFa/oo8OB0RlBubhWDHrQveBNNKaiZs3SUfHmId
         4FfX9ci+8nXtwbtJLWvJtYbOUFL5GTX3RMJ4jLTtIiXPlC+OSbzr+C2a/m7l8TX7hVHB
         uf69Jn/lunxZkVcQVhtrkFRJbsrDTtGuC+c9LKITqZeDdvn2tf+aswrjBm+3yA8f4/7X
         GWYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=QcaCyKxp/6Cbvw/6pcMmfrOR1SnYLtwQTxT8ktNlyuk=;
        b=pI8Qvw3pIM2TbJRfbFbSVeWOSWK4IKu39DQvCFPu1OrHSwEerSQW4MEyNwzXkP5NrX
         cG49JXOF6KIRqjwq9gh4r7hV5xmGltwnq8U6+k6PXoeuyOYENLlysHD9dRkmXE9o/RqO
         KQgmsWL2a4RgD2/YHQS3XHEgh9kchj8pC9bE2aoTMN5L8a2Vhb7FGW0dEIH7biUwZXMM
         nPhHVWzbrFqudmJiwIhTwx/VHvHbJqQDNg3DfDUu+yeFdaVcCkoMuBu+ZsaPED7rpIO7
         2dck2GGUS6UyXfqZvaVTco7VB0w16hUw0v/qTUiPShtRYiBbM2IiFVjq0aIJA2QaWFT/
         0T1A==
X-Gm-Message-State: AOAM531mMGTJ0cRdMy2HQTH4gBO/Dpak1jfl6/KVIqlMax+sD4or9FOn
        ssfYl72FY9YUpiF+afVZN7g=
X-Google-Smtp-Source: ABdhPJy0CRHF9QEL4cR0lwHpdPbA/k7yul3I9RFdNz/lcdSlDPJ+BXWd9ILEh8VWrj3FX8LTszvCzw==
X-Received: by 2002:a05:651c:154a:: with SMTP id y10mr5922235ljp.314.1639054059646;
        Thu, 09 Dec 2021 04:47:39 -0800 (PST)
Received: from [192.168.1.100] ([31.173.80.35])
        by smtp.gmail.com with ESMTPSA id e3sm517891lfc.259.2021.12.09.04.47.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Dec 2021 04:47:39 -0800 (PST)
Message-ID: <5760a91e-042d-2b31-620c-4d69cc107b2c@gmail.com>
Date:   Thu, 9 Dec 2021 15:47:26 +0300
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
 <116f7933-5dbc-4aae-a300-fa544f0b1b0d@gmail.com>
 <3ccaa939-2a9a-e063-ff68-ed8b1eedb687@suse.de>
From:   Sergei Shtylyov <sergei.shtylyov@gmail.com>
Organization: Brain-dead Software
In-Reply-To: <3ccaa939-2a9a-e063-ff68-ed8b1eedb687@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 09.12.2021 14:14, Hannes Reinecke wrote:

[...]
>>> Add tracepoint for ata_qc_prep().
>>
>>     You're also adding a tracepoint for ata_qc_issue...
>>
> Actually, no.
> 
> I'm converting the existing tracepoint for ata_qc_issue into a template,
> and then adding tracepoints for ata_qc_prep and ata_qc_issue based on
> that template.
> 
> But I can make a note of this in the patch description.

    Please do. :-)

> Cheers,
> 
> Hannes

MBR, Sergei
