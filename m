Return-Path: <SRS0=eHQz=6A=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A72A6C2BB55
	for <linux-ide@archiver.kernel.org>; Thu, 16 Apr 2020 16:27:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 743C020857
	for <linux-ide@archiver.kernel.org>; Thu, 16 Apr 2020 16:27:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="wUMC0iiC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387577AbgDPQ1X (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 16 Apr 2020 12:27:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728987AbgDPQ1W (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 16 Apr 2020 12:27:22 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2D5EC061A0C
        for <linux-ide@vger.kernel.org>; Thu, 16 Apr 2020 09:27:22 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id t8so7498217ilj.3
        for <linux-ide@vger.kernel.org>; Thu, 16 Apr 2020 09:27:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=5DsdlMWlvuKqdtofFGPhOBVDzjYRJgpB+utt/BhA+Gg=;
        b=wUMC0iiCB0tQ1cxYbtN02WiSpx8JmnyaLU5ZLLvSd1FVmiW0lGTTIM0Yc6qs5MfpYB
         /NnHD75ZXPbMPmND6SalTeHbMOH2QfztZ619tbR5Pr0OezsUZLYJ75KHQ2ISCusbNp3y
         Zoy3lFwZfvt5XHYCnUmTPrCcYusEZZsxDp60qXBJCrtGNe+sci7LBs6HDM8OjhPJ0Hyj
         1O5XGyw3A/7/pwTGUbS1t0dBgol6qHj+BU0c1J2/udEV5dkhApZ6GTi9YBFmsVljCujI
         X43Zsj85uzCfki6E3pI/dqd3K2blN6FnoG+nhHmcPgEdRBg2doNye7GZYCUdNU48RtDn
         fvTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5DsdlMWlvuKqdtofFGPhOBVDzjYRJgpB+utt/BhA+Gg=;
        b=hz8Z81a/wuqPl6B/meVcqM5Ndggbd97gIufYzD5bjuUFgcfczowrffBVIU1fDxO399
         /zqnJsyXN4f5RpKfMBhy27BibsyHGdsV3r/V41ekmTy3HSbGPjdrPPDcoC5M2teXeNfW
         rVqqcfruwwzNIfhJbQ6/G3FKHFT58YoLt7BvDHqydfvuMlJM/3arBmkud1HEIhzniSW4
         83v31oskhxgNhMQMqQ0QK0zmTX4JoxMOdICHUr8DtBUBTEt3IVuRM4rGV1vFdz6t5qVI
         cEmU4xOH2yI4NHxNTevhoCxhlrKVfBgnITNle9daKtp64enSfTPMDQXBKn+16sbyDxnP
         CCtg==
X-Gm-Message-State: AGi0PuYe7fYI14vdiU/0Pq/7ezQKSvjEmsBpH9EgOotLsAWpnrGnAzJ9
        s9assRTSsgTBzBlP+aze1MuSamfT9PxKbA==
X-Google-Smtp-Source: APiQypJ0dfbckQxr1NrwNvt7cHhmbz6qQidF/3io3d3O3dqzN970+sNdaHNdcctW3wgajOCqL3gYuA==
X-Received: by 2002:a92:d44e:: with SMTP id r14mr9721711ilm.244.1587054442072;
        Thu, 16 Apr 2020 09:27:22 -0700 (PDT)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id d10sm7251313ilu.46.2020.04.16.09.27.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Apr 2020 09:27:21 -0700 (PDT)
Subject: Re: [PATCH] ahci: Add Intel Comet Lake PCH-U PCI ID
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     "open list:LIBATA SUBSYSTEM (Serial and Parallel ATA drivers)" 
        <linux-ide@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20200416063540.30462-1-kai.heng.feng@canonical.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <8b04c4e8-32f1-216e-055d-5ba2e1052750@kernel.dk>
Date:   Thu, 16 Apr 2020 10:27:20 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200416063540.30462-1-kai.heng.feng@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 4/16/20 12:35 AM, Kai-Heng Feng wrote:
> Add Intel Comet Lake PCH-U PCI ID to the list of supported controllers.
> 
> Set default SATA LPM so the SoC can enter S0ix.

Applied, thanks.

-- 
Jens Axboe

