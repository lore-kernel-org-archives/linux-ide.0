Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96DBAC433F5
	for <linux-ide@archiver.kernel.org>; Fri,  3 Sep 2021 12:35:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 74ED461057
	for <linux-ide@archiver.kernel.org>; Fri,  3 Sep 2021 12:35:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349388AbhICMgS (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 3 Sep 2021 08:36:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349409AbhICMgQ (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 3 Sep 2021 08:36:16 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C205C061575
        for <linux-ide@vger.kernel.org>; Fri,  3 Sep 2021 05:35:17 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id i13so5058059ilm.4
        for <linux-ide@vger.kernel.org>; Fri, 03 Sep 2021 05:35:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=19ZonWhnZs25geJXFccYzETRyk9HF/SPK9+6RaQVORE=;
        b=VIMWPwNH7I8r6Pqe9bZrJQqz8qjP1KDNYW7UT8nKu8ueh5Ffdoj1KOp7fLp1CHrand
         TIzSfkWqvA9IQCYgu9kQf3e9X3ehx5eV35k7xAw2scriAxIuEwtR+CHAGCh50GFOiI4e
         zLsN9f77mNzQF0pkIH+AoZRVsHWAyZJZ1Ap3wh8vpLAKVZsTORd267B+mBTZQOBvSoDz
         lY6/U6G26RDH3Syyavp/IlwCaUsUVk4kgQ6eu6RfeeIq5qT8rKT6uk+nXJB4fR9Ea8Lk
         sJdvFqN8J6NgLPYk9vsE6VdRBTzDBOBfXxHq9cxmlWowyYyVak2a+e25Wkj7Di1QK7fF
         LKaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=19ZonWhnZs25geJXFccYzETRyk9HF/SPK9+6RaQVORE=;
        b=QAoVYRdl1TaKqIAHX2RkfrKXiYShZrqE0ZGZEEMG4nHKPjkPcqYGM6vNEcoyVFD3AR
         yhLPeUXcBeg3FybF7g+388NmKjqqUrS5MCfbSZxDqcZpdpBGuUUYRf79mqcBC9I8NPu6
         X4R2rL3TKw5V0bQH3ny27ktJp9l1aDWssuLXHBA1Ucj2tK76RLicPU7K+0SeRRQncGJl
         o1TpFGhhg/00jQKK2QTfljcXn376+E/Lw0Vh/8FlNaxHOt03/jEVLfkH6XC29UBvF30+
         3lBOoPZgAR+VWly+VsA23O7ecqyBtp+cv5hWS3BBqIC5iRSF8OtdHsiddkJFIeTPxDNF
         N5Xg==
X-Gm-Message-State: AOAM533Sddsr5Ivz6Sy3i+AKg4StsQvM8ElaSav0ehONBcBnIyhVKQ95
        7xsczBQL7mpxDg74Tb4aYvKYSw==
X-Google-Smtp-Source: ABdhPJzDfge/RwXAW4QEv0XENl9/u8T/rbNmbXTit5WcYtZVnPO0bizRWY7KLY5dYSH55MjMuGEwRw==
X-Received: by 2002:a92:c94d:: with SMTP id i13mr2457039ilq.292.1630672516482;
        Fri, 03 Sep 2021 05:35:16 -0700 (PDT)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id 12sm2579066ilq.37.2021.09.03.05.35.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Sep 2021 05:35:15 -0700 (PDT)
Subject: Re: [PATCH v6] libata: Add ATA_HORKAGE_NO_NCQ_ON_ATI for Samsung 860
 and 870 SSD.
To:     Kate Hsuan <hpa@redhat.com>, Hans de Goede <hdegoede@redhat.com>,
        Damien Le Moal <damien.lemoal@wdc.com>
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210903094411.58749-1-hpa@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <d3488035-d269-2a63-f958-746f371cf490@kernel.dk>
Date:   Fri, 3 Sep 2021 06:35:12 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210903094411.58749-1-hpa@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 9/3/21 3:44 AM, Kate Hsuan wrote:
> Many users are reporting that the Samsung 860 and 870 SSD are having
> various issues when combined with AMD/ATI (vendor ID 0x1002)  SATA
> controllers and only completely disabling NCQ helps to avoid these
> issues.
> 
> Always disabling NCQ for Samsung 860/870 SSDs regardless of the host
> SATA adapter vendor will cause I/O performance degradation with well
> behaved adapters. To limit the performance impact to ATI adapters,
> introduce the ATA_HORKAGE_NO_NCQ_ON_ATI flag to force disable NCQ
> only for these adapters.
> 
> Also, two libata.force parameters (noncqati and ncqati) are introduced
> to disable and enable the NCQ for the system which equipped with ATI
> SATA adapter and Samsung 860 and 870 SSDs. The user can determine NCQ
> function to be enabled or disabled according to the demand.
> 
> After verifying the chipset from the user reports, the issue appears
> on AMD/ATI SB7x0/SB8x0/SB9x0 SATA Controllers and does not appear on
> recent AMD SATA adapters. The vendor ID of ATI should be 0x1002.
> Therefore, ATA_HORKAGE_NO_NCQ_ON_AMD was modified to
> ATA_HORKAGE_NO_NCQ_ON_ATI.

What's this patch against?

-- 
Jens Axboe

