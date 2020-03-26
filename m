Return-Path: <SRS0=jBxd=5L=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 447CCC2D0EC
	for <linux-ide@archiver.kernel.org>; Thu, 26 Mar 2020 16:29:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EC2A20787
	for <linux-ide@archiver.kernel.org>; Thu, 26 Mar 2020 16:29:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="pduojzUf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726163AbgCZQ27 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 26 Mar 2020 12:28:59 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:34251 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726175AbgCZQ26 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 26 Mar 2020 12:28:58 -0400
Received: by mail-pf1-f195.google.com with SMTP id 23so3048297pfj.1
        for <linux-ide@vger.kernel.org>; Thu, 26 Mar 2020 09:28:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=FOCLu4AARJuZ4ixem6J8zMfavgX09kkCrtdGa/hq7aU=;
        b=pduojzUfXYnFTQAEYPYEScZdl3/PD1+lplzovUfNR3/RAZahZS0elhCkWohRbmPIKJ
         y2crZpUW8OiCOhXEgM3l9Jp2rcxrkyWX3Kp6w4Bd+6H7vGqFvmFuUOyQkfpTiRHCyRbq
         aePyoA7++YZNqtL56JN4QaI2053GKgiEF3u+PDprwlQ71zYZBERTXfZ9Aa26Bt2Cq+yR
         B9984tMIeihWA41mj2FNon1rbx9zcXFu63b6TpXdJmLUxSXvyrdAiiThrupMvE5ac1Yl
         +sXxJyG6wEN/jIg7Oj0o0lkSZIkJ+V3T/gsb17ZAs7RvarWYfMucTsis4FFQ6P6qdel3
         i3+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FOCLu4AARJuZ4ixem6J8zMfavgX09kkCrtdGa/hq7aU=;
        b=tC5Byh0bZLgjf4ElAJygfo9M/unnJe9Y4c8rr4urooLGKVKQiXS5ySKE1mlrbQ3Yw6
         D4Vmp5IUexKkw37BzASJ8DlAATs6XVnCNsoSypotfPhqvisyqm6hN+smb23uUyorjgFj
         bl+DWTpr3+odlwzjq7upjCi8ZGQ7vJiwLPr46wi5Nda2MEQqyrxHfQu+5b1dut2na/hG
         W2d2nXA/2FPGocRuihqUV17X+X1mjU16ixp2biJErztFlTqcMRWwqWo/wmZYOez6Wrkp
         WNz0ua9gbn6saeNRnrJ410z8OvGTZJ2c0cJlXt+Mb2cbVDWS1RZLQbChQ29VHbrhjrWV
         p7HQ==
X-Gm-Message-State: ANhLgQ2vsu1DSV2ey6Sc2Gq3ZypAB/dkP+ikbozZP12cx0VTouY7gSSk
        xcacid/XKW8LFl1MID261RKs/w==
X-Google-Smtp-Source: ADFU+vvt6R7XeparInw83y2Wuxrc+y+PgkmfWrAG01DKaEv7PxF19icMldUkVrEvls4dAkWG6R889w==
X-Received: by 2002:aa7:82c9:: with SMTP id f9mr9939531pfn.168.1585240136843;
        Thu, 26 Mar 2020 09:28:56 -0700 (PDT)
Received: from [192.168.1.188] ([66.219.217.145])
        by smtp.gmail.com with ESMTPSA id k20sm1932086pgn.62.2020.03.26.09.28.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Mar 2020 09:28:56 -0700 (PDT)
Subject: Re: [PATCH v5 00/27] ata: optimize core code size on PATA only setups
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     Michael Schmitz <schmitzmic@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Christoph Hellwig <hch@lst.de>, linux-ide@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
References: <CGME20200326155838eucas1p2a1c1f5c08832410d1e2b5a5ea8226151@eucas1p2.samsung.com>
 <20200326155822.19400-1-b.zolnierkie@samsung.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <7f6f4944-5e3b-3a78-718a-c7faafab85fa@kernel.dk>
Date:   Thu, 26 Mar 2020 10:28:54 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200326155822.19400-1-b.zolnierkie@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 3/26/20 9:57 AM, Bartlomiej Zolnierkiewicz wrote:
> Hi,
> 
> There have been reports in the past of libata core code size
> being a problem in migration from deprecated IDE subsystem on
> legacy PATA only systems, i.e.:
> 
> https://lore.kernel.org/linux-ide/db2838b7-4862-785b-3a1d-3bf09811340a@gmail.com/
> 
> This patchset re-organizes libata core code to exclude SATA
> specific code from being built for PATA only setups.
> 
> The end result is up to 24% (by 23949 bytes, from 101769 bytes to
> 77820 bytes) smaller libata core code size (as measured for m68k
> arch using modified atari_defconfig) on affected setups.
> 
> I've tested this patchset using pata_falcon driver under ARAnyM
> emulator.

Thanks, applied.

-- 
Jens Axboe

