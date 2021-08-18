Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF66FC4338F
	for <linux-ide@archiver.kernel.org>; Wed, 18 Aug 2021 13:20:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF1C26108E
	for <linux-ide@archiver.kernel.org>; Wed, 18 Aug 2021 13:20:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236676AbhHRNU4 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 18 Aug 2021 09:20:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235943AbhHRNUz (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 18 Aug 2021 09:20:55 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DE54C061764
        for <linux-ide@vger.kernel.org>; Wed, 18 Aug 2021 06:20:21 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id x4so2208202pgh.1
        for <linux-ide@vger.kernel.org>; Wed, 18 Aug 2021 06:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=MhAcwTmHxIAd4QFbOxVpg7wOWs84Q98Cer8hoXchdek=;
        b=NVOwObjdIFoEbxF1XKZPzChGZXuZE/g+BpaPO5TLr44UaP5tY8KjyfATi22pXQtWan
         aw7OAVz0spM5GoRwsIffIpkgUIcl496SJQ+z3rJbwuh5JFBWltsoom4HpdOb9LbU48Th
         atnFM2by41h6JmoCRwBucAb8RZzv/FnEkhxDXtL6/RtRkpLlj246jZxlnfnxJGuPGsM1
         nhRdYYwOegg8rd9/YzJGsm7+UyYBJU2G2gHNkbO607/25flTYRcDLzA+p+jAvUaUDPxH
         8gguDMfkZm1tP4k7b6YY3elYaxwj1E2M5cSX/Rrbx+iNe+kk1GrLabg4dzMyFGfe5jXQ
         yoow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MhAcwTmHxIAd4QFbOxVpg7wOWs84Q98Cer8hoXchdek=;
        b=mcal/7qc3ATws8XYCtepVu9RwkOiEHZnthKzM4oIMaRr+Ig3dx0XRTLvESlulPPXNr
         qCUTdS7n7wLQG4T6UWmza7lGRZzmpagxaPAPd+Ma5rbtjTqUevHIHRmITbICAA0DB7HL
         wyKb89oBMopdY34H95UgUWa2/8DnyKLbE7QpQJ7xj2JEltxOZF5Jm8t0XyE06026zZ5g
         Q87L0mKmkVbe84XzxiCLRMd9zITWZisWGqeFZ6rCiKrXFLiUjz9vdDgx4/48VnDIJwQO
         eez2R2+Mk41WpXzF+yABLcMS9+gbUZEvtBkug5txJL1ups+NTNtxMiqtZFmmm0EaeqgO
         jz3A==
X-Gm-Message-State: AOAM532Y31npKFzBRHKBamOWlVZAYzMboPGMtL/+ottxmeGFW0aZyyYZ
        2iks3pQ/RdzK9LUQGm5kimszrg==
X-Google-Smtp-Source: ABdhPJwffJWAKC4Zll3QD2/A3uRNlLIUf8tiqDSzFTiSEiVs5PPdbXEKBxCy/wINIbG/mXnGa7LcOA==
X-Received: by 2002:a05:6a00:a18:b029:382:e172:653e with SMTP id p24-20020a056a000a18b0290382e172653emr9394640pfh.19.1629292820948;
        Wed, 18 Aug 2021 06:20:20 -0700 (PDT)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id h24sm6657086pfn.180.2021.08.18.06.20.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Aug 2021 06:20:20 -0700 (PDT)
Subject: Re: [PATCH v7 00/11] libata cleanups and improvements
To:     Damien Le Moal <damien.lemoal@wdc.com>, linux-ide@vger.kernel.org
Cc:     linux-block@vger.kernel.org
References: <20210816014456.2191776-1-damien.lemoal@wdc.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <18c2f2e2-b7b6-b8b8-35ef-89ee59001cac@kernel.dk>
Date:   Wed, 18 Aug 2021 07:20:18 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210816014456.2191776-1-damien.lemoal@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 8/15/21 7:44 PM, Damien Le Moal wrote:
> The first three patches of this series fix sparse and kernel bot
> warnings (potential NULL pointer dereference and locking imbalance).
> 
> The following three patches cleanup libata-core code in the area of
> device configuration (ata_dev_configure() function).
> 
> Patch 7 improves ata_read_log_page() to avoid unnecessary warning
> messages and patch 8 adds an informational message on device scan to
> advertize the features supported by a device.
> 
> Path 9 adds the new sysfs ahci device attribute ncq_prio_supported to
> indicate that a disk supports NCQ priority.
> 
> Patch 10 and 11 update the ABI user documentation files.

Applied 2-11, thanks.

-- 
Jens Axboe

