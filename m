Return-Path: <SRS0=Xbu2=5X=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14518C2D0EC
	for <linux-ide@archiver.kernel.org>; Tue,  7 Apr 2020 20:45:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEF1D20730
	for <linux-ide@archiver.kernel.org>; Tue,  7 Apr 2020 20:45:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="E7ztmKn5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726453AbgDGUpu (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 7 Apr 2020 16:45:50 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:36894 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726444AbgDGUpu (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 7 Apr 2020 16:45:50 -0400
Received: by mail-pg1-f193.google.com with SMTP id r4so2287547pgg.4
        for <linux-ide@vger.kernel.org>; Tue, 07 Apr 2020 13:45:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=C88lZVacgBqVCx9fOOndyOqopaXcP4IkqPpQrquRUaE=;
        b=E7ztmKn5DIinrdB65ZxtV9BqWJ96hvR4RnwLJ3pVLBFcHhQYwlx8ErU4p03tVhzuaZ
         mdzMScU20+5lCgnkECaEDZoSUPr46fINUyYVMXHYw+gzhMFhs2nMHrPaJNk4SbOQ1DFW
         sfu63JKBWizzPmXipte4ZTNfEOS7OPwv2Gno42KUWG/Lq3j761JETDAOx9bINurCkeXk
         d8mMjHieRX8LdgfobuyIxxoJhz7/TUjN1qjjgBKjXWvyJDMOM/uiKgVwPLGoZdVtlQke
         s9akxu+THvX2r7Q9lAhX8wI5CB2h4NOiecnmknGZbxGZNKKci7BcOnN+ryuwrD1LFWg9
         qZoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=C88lZVacgBqVCx9fOOndyOqopaXcP4IkqPpQrquRUaE=;
        b=o8KtyC3LfHXIdo2PZzp2Yfm1OLcflGmmZUq1jWDWG2AvgUuqwgD9jkxKYUhzbrEVUU
         vQqIXPb2IXTmOLhqniCBdGBVTvvLzmeaTCuNA4+fcc4k8X6xdge/JwBKS2/NjqYnv8CY
         Fiw2zniFKv3lUnqSXvpxTLVSfuwWcbNo2aLZqsIYlSKO0ZA5wkWoS+U3ip/AxvL2w++P
         q9VXb/iQgmAYxUzHOP7uRhtGot5UuIWO1Sv7UEONdPwizFNsZlCP9uGROnqQvYpDcov7
         t6Xft7g1HYqiHgLKg5RxXCtLRPGBSG9ex27G4zqNR0skM1wznBWJ26AGzuZQqcEoN67c
         7ARQ==
X-Gm-Message-State: AGi0PuZMt6OwAx8JSgO3he2KB0UTFXg7cwV6fkscZEgkfN8LQNf9DXow
        tHYN1FV/GFkPC7PsVuv9kzrL4L3KffZtGw==
X-Google-Smtp-Source: APiQypImd7G6uhM36TiwPi1QL4r5mkuVWEgspW/FrthCdBwyFXKd9TRK8OWmMMLjrbizn6oSgnCKgg==
X-Received: by 2002:a63:5c01:: with SMTP id q1mr3627155pgb.177.1586292347981;
        Tue, 07 Apr 2020 13:45:47 -0700 (PDT)
Received: from ?IPv6:2605:e000:100e:8c61:ec7d:96d3:6e2d:dcab? ([2605:e000:100e:8c61:ec7d:96d3:6e2d:dcab])
        by smtp.gmail.com with ESMTPSA id t1sm2419726pjf.26.2020.04.07.13.45.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Apr 2020 13:45:47 -0700 (PDT)
Subject: Re: [PATCH] libata: Return correct rc status in
 sata_pmp_eh_recover_pm() pwhen ATA_DFLAG_DETACH is set
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
References: <20190327090254.10365-1-kai.heng.feng@canonical.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <fad442bc-792e-5e6b-4c8c-db932eec3c96@kernel.dk>
Date:   Tue, 7 Apr 2020 13:45:45 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20190327090254.10365-1-kai.heng.feng@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 3/27/19 2:02 AM, Kai-Heng Feng wrote:
> During system resume from suspend, this can be observed on ASM1062 PMP
> controller:
> <6>[12007.593358] ata10.01: SATA link down (SStatus 0 SControl 330)
> <6>[12007.593469] ata10.02: hard resetting link
> <6>[12007.908353] ata10.02: SATA link down (SStatus 0 SControl 330)
> <6>[12007.911149] ata10.00: configured for UDMA/133
> <0>[12007.972508] Kernel panic - not syncing: stack-protector: Kernel
> stack is corrupted in: sata_pmp_eh_recover+0xa2b/0xa40
> <0>[12007.972508]
> <4>[12007.972515] CPU: 2 PID: 230 Comm: scsi_eh_9 Tainted: P OE
> 4.15.0-46-generic #49-Ubuntu
> <4>[12007.972517] Hardware name: System manufacturer System Product
> Name/A320M-C, BIOS 1001 12/10/2017
> <4>[12007.972518] Call Trace:
> <4>[12007.972525] dump_stack+0x63/0x8b
> <4>[12007.972530] panic+0xe4/0x244
> <4>[12007.972533] ? sata_pmp_eh_recover+0xa2b/0xa40
> <4>[12007.972536] __stack_chk_fail+0x19/0x20
> <4>[12007.972538] sata_pmp_eh_recover+0xa2b/0xa40
> <4>[12007.972543] ? ahci_do_softreset+0x260/0x260 [libahci]
> <4>[12007.972545] ? ahci_do_hardreset+0x140/0x140 [libahci]
> <4>[12007.972547] ? ata_phys_link_offline+0x60/0x60
> <4>[12007.972549] ? ahci_stop_engine+0xc0/0xc0 [libahci]
> <4>[12007.972552] sata_pmp_error_handler+0x22/0x30
> <4>[12007.972554] ahci_error_handler+0x45/0x80 [libahci]
> <4>[12007.972556] ata_scsi_port_error_handler+0x29b/0x770
> <4>[12007.972558] ? ata_scsi_cmd_error_handler+0x101/0x140
> <4>[12007.972559] ata_scsi_error+0x95/0xd0
> <4>[12007.972562] ? scsi_try_target_reset+0x90/0x90
> <4>[12007.972563] scsi_error_handler+0xd0/0x5b0
> <4>[12007.972566] kthread+0x121/0x140
> <4>[12007.972567] ? scsi_eh_get_sense+0x200/0x200
> <4>[12007.972569] ? kthread_create_worker_on_cpu+0x70/0x70
> <4>[12007.972572] ret_from_fork+0x22/0x40
> <0>[12007.972591] Kernel Offset: 0xcc00000 from 0xffffffff81000000
> (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
> 
> Since sata_pmp_eh_recover_pmp() doens't set rc when ATA_DFLAG_DETACH is
> set, sata_pmp_eh_recover() continues to run. During retry it triggers
> the stack protector.
> 
> Set correct rc in sata_pmp_eh_recover_pmp() to let sata_pmp_eh_recover()
> jump to pmp_fail directly.

Applied, with the commit message and title fixed up a bit.

-- 
Jens Axboe

