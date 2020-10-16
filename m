Return-Path: <SRS0=V23L=DX=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A641EC433E7
	for <linux-ide@archiver.kernel.org>; Fri, 16 Oct 2020 15:33:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 446C8207C4
	for <linux-ide@archiver.kernel.org>; Fri, 16 Oct 2020 15:33:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="BwNX2GgL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410090AbgJPPdA (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 16 Oct 2020 11:33:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2410277AbgJPPcu (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 16 Oct 2020 11:32:50 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41BE2C0613D3
        for <linux-ide@vger.kernel.org>; Fri, 16 Oct 2020 08:32:49 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id gv6so1716226pjb.4
        for <linux-ide@vger.kernel.org>; Fri, 16 Oct 2020 08:32:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=qGdeYT3MiQwKX79eLQ/b7rznlfvba/UsEutEjQXYcRw=;
        b=BwNX2GgLB3+EPMYvB86xvOSo+D+yDOe6vQWybxXuycnnDbw09lPKB6ZNFRRn76EG1N
         +a+FOf9PbCPumM4w1i7u3gv/SM0i4bIkRdp5TU/yRTKrnVGkQaoPC3U5wPaWExnnI690
         PTnEFPfXgo5vqPNME5OPr10m2iAlzCJw5nAhL3CXv2iq9dxEOmv0kYwesfsMME4Ili0i
         L94JvtSezyXy7B29nFfS1pOp+3WtggJE4Lv9GH187tGRePR2hU+QlMGygWjM1Zdv1B0p
         31JZXa4Q27dgXy4sqGFWldTvpI+P8/3gilbfIiLd06tpssBIib2+m6h27W3UBRqo8y9t
         6r4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qGdeYT3MiQwKX79eLQ/b7rznlfvba/UsEutEjQXYcRw=;
        b=uHeGFOgAYsPy2jriWhZLCEkr1KAYeUKBpVb+z8NZkQSOlinhaP95v86jAyitYP/Zxt
         qQJ3iaBzYSett7Hy0LvDq/o+29UgftDAh8bRcTEgaGBD2TudHLwZSQNgHBMymf+rc82M
         9mWFuDJHXtcRRfgivV9HN8uqMfB1LQGIyS69BgnJ3+8otWXcz/2il+1OXPCeWIIWes+l
         zZOI+MOqv9OX0W3qku8fGPd/CGRZ/zgRoEbN7SszJGBMwN+V/Ih/VObAEWE9Gitc8mqM
         ggdrsbWG6NTwRbzKfomQxa2bcEv1l4KqOTBu5rcU/THD5judL1Oyv5/AiMsnPEg588Y2
         xZyw==
X-Gm-Message-State: AOAM533Xb26/Ki8RCvGDaoZfMRDA3RCCpXFEszuY18KBJSJociVO7Z7Z
        N+YfuQM7itNhr+OAo2OZt5MCG63A4tuvPcMx
X-Google-Smtp-Source: ABdhPJw2dgqLLhcauvMt2GOLvh+Ndd9jqu5UiMTATm0z7/s81PCLWvQUWsdVJtYomEFuLgMOx7E29w==
X-Received: by 2002:a17:90a:fd0f:: with SMTP id cv15mr4439472pjb.161.1602862368712;
        Fri, 16 Oct 2020 08:32:48 -0700 (PDT)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id x26sm3177157pfn.178.2020.10.16.08.32.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Oct 2020 08:32:48 -0700 (PDT)
Subject: Re: [PATCH v3] ata: sata_rcar: Fix DMA boundary mask
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>,
        Sergei Shtylyov <sergei.shtylyov@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        linux-ide@vger.kernel.org,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>,
        "Lad, Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20200917130920.6689-1-geert+renesas@glider.be>
 <CAMuHMdWQapEyvd=rpdfW5XHbwLtaiyLsnAXn5dM8zGCpc9VSFA@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <d7eefafb-5a63-8790-8d3e-6cb04edd5fdc@kernel.dk>
Date:   Fri, 16 Oct 2020 09:32:46 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAMuHMdWQapEyvd=rpdfW5XHbwLtaiyLsnAXn5dM8zGCpc9VSFA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 10/15/20 12:34 PM, Geert Uytterhoeven wrote:
> Hi Jens,
> 
> On Thu, Sep 17, 2020 at 3:09 PM Geert Uytterhoeven
> <geert+renesas@glider.be> wrote:
>> Before commit 9495b7e92f716ab2 ("driver core: platform: Initialize
>> dma_parms for platform devices"), the R-Car SATA device didn't have DMA
>> parameters.  Hence the DMA boundary mask supplied by its driver was
>> silently ignored, as __scsi_init_queue() doesn't check the return value
>> of dma_set_seg_boundary(), and the default value of 0xffffffff was used.
>>
>> Now the device has gained DMA parameters, the driver-supplied value is
>> used, and the following warning is printed on Salvator-XS:
>>
>>     DMA-API: sata_rcar ee300000.sata: mapping sg segment across boundary [start=0x00000000ffffe000] [end=0x00000000ffffefff] [boundary=0x000000001ffffffe]
>>     WARNING: CPU: 5 PID: 38 at kernel/dma/debug.c:1233 debug_dma_map_sg+0x298/0x300
>>
>> (the range of start/end values depend on whether IOMMU support is
>>  enabled or not)
>>
>> The issue here is that SATA_RCAR_DMA_BOUNDARY doesn't have bit 0 set, so
>> any typical end value, which is odd, will trigger the check.
>>
>> Fix this by increasing the DMA boundary value by 1.
>>
>> This also fixes the following WRITE DMA EXT timeout issue:
>>
>>     # dd if=/dev/urandom of=/mnt/de1/file1-1024M bs=1M count=1024
>>     ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 frozen
>>     ata1.00: failed command: WRITE DMA EXT
>>     ata1.00: cmd 35/00:00:00:e6:0c/00:0a:00:00:00/e0 tag 0 dma 1310720 out
>>     res 40/00:01:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
>>     ata1.00: status: { DRDY }
>>
>> as seen by Shimoda-san since commit 429120f3df2dba2b ("block: fix
>> splitting segments on boundary masks").
>>
>> Fixes: 8bfbeed58665dbbf ("sata_rcar: correct 'sata_rcar_sht'")
>> Fixes: 9495b7e92f716ab2 ("driver core: platform: Initialize dma_parms for platform devices")
>> Fixes: 429120f3df2dba2b ("block: fix splitting segments on boundary masks")
>> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>> Reviewed-by: Christoph Hellwig <hch@lst.de>
>> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> Reviewed-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
>> Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
>> Tested-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>> Tested-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
>> Cc: stable <stable@vger.kernel.org>
> 
> Can you please apply this patch?
> This is a fix for a regression in v5.7-rc5, and was first posted almost
> 5 months ago.

Applied, sorry that got missed.

-- 
Jens Axboe

