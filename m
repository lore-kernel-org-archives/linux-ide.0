Return-Path: <SRS0=2JnX=AB=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE969C433E0
	for <linux-ide@archiver.kernel.org>; Sat, 20 Jun 2020 08:22:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BFBB623A31
	for <linux-ide@archiver.kernel.org>; Sat, 20 Jun 2020 08:22:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="BDlK19t7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726950AbgFTIWB (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sat, 20 Jun 2020 04:22:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726838AbgFTIWB (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sat, 20 Jun 2020 04:22:01 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56041C0613EE
        for <linux-ide@vger.kernel.org>; Sat, 20 Jun 2020 01:22:00 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id a9so14031213ljn.6
        for <linux-ide@vger.kernel.org>; Sat, 20 Jun 2020 01:22:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=c/y32/xmjS/dZ8Lr7ipeYZOIjniqsMezUi4gC5eLVRo=;
        b=BDlK19t7jg+V/ha+/QAXVxZc3ydnHHYPY9GAQPZJGRizRatdOZ79z4BZ8PeCIRqNk/
         bFJj6vISllTC1CuJj51AaN7gd91J7TBKYzix06G/wviDvs5dwMZHlnsUsvFeRknLdlVx
         jswGNmPpNbCeuvhmwXDeG/UWhcjOs8hi9eO1PPBY7CQLEG2qN1M6uwthXVCqzNxQOjuw
         AKFFMG7LJ7IXaPPuxezpV8MZWH/9hidRYDst28apbVtuHdthY9nBkcP+MnhFb1cjfH7q
         IGczZCnqkr2uV7XtUsoC9baJPSkxB1aZgUWwdGjoW+ctJP6SVvpJlcmkvL/vMK1Nb2eH
         SCEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=c/y32/xmjS/dZ8Lr7ipeYZOIjniqsMezUi4gC5eLVRo=;
        b=Ap8pR6Pr/pCIWhkOxmT7fpJTPrLjNVBUJrmVBUZ9fjjNtR5ROUE8A9KnNntlX3rajo
         50rR7rEVTfKuvJjL90V/PHtzVvornPH63VZ6BZ96nPsFmeuKrf6PGZ4HGaUzaMw792na
         NE5ECbkanZM4vWYSvfCWiEa0XDwZgSV6vrTE8gl0IzNev9uSTkX8lKxDs2NAWRtNv3a3
         cIG6sfpPtaDdrBf8od4N4me5OZFBWZvPCk5c+3xqP2d1mZqcHyh73iAjU7oWTCe8DMf3
         +JhGxFLqnFlHUZq5ygsaQwWQFbJ5qPXMOK8jH44s4GNzBgag2v5xFX73zdiFZsenOqqM
         zlZw==
X-Gm-Message-State: AOAM5336mWNhc4Sl4pQyUehB0tpuK38GTw8tRHjMXz4THrtpFAiuqpFE
        v7kioS9NKSBk2VqJzviTm4cYm6WCt3teCA==
X-Google-Smtp-Source: ABdhPJzGszEfHPHtuah+MwhskgNx1h5qBNcVuyKWUU8C2TMGazLJVqq0dkOJm0p6+P90J15YIOJICA==
X-Received: by 2002:a2e:858c:: with SMTP id b12mr3517769lji.275.1592641318569;
        Sat, 20 Jun 2020 01:21:58 -0700 (PDT)
Received: from ?IPv6:2a00:1fa0:851:68cb:a8e4:b8:8a04:e903? ([2a00:1fa0:851:68cb:a8e4:b8:8a04:e903])
        by smtp.gmail.com with ESMTPSA id s25sm1581428ljj.119.2020.06.20.01.21.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 20 Jun 2020 01:21:57 -0700 (PDT)
Subject: Re: [PATCH] libata: fix the ata_scsi_dma_need_drain stub
To:     Christoph Hellwig <hch@lst.de>, martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, linux-ide@vger.kernel.org
References: <20200620071302.462974-1-hch@lst.de>
 <20200620071302.462974-2-hch@lst.de>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <3148ace5-2733-5d66-7c2f-6a967666ea79@cogentembedded.com>
Date:   Sat, 20 Jun 2020 11:21:41 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200620071302.462974-2-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 20.06.2020 10:13, Christoph Hellwig wrote:

> We don't only need the stub when libata is disable, but also if it

    Disabled. :-)

> is modular and there are built-in SAS drivers (which can happen when
> SCSI_SAS_ATA is disabled).
> 
> Fixes: b8f1d1e05817 ("scsi: Wire up ata_scsi_dma_need_drain for SAS HBA drivers")
> Signed-off-by: Christoph Hellwig <hch@lst.de>
[...]

MBR, Sergei
