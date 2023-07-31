Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF3D4EB64DD
	for <linux-ide@archiver.kernel.org>; Mon, 31 Jul 2023 00:50:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229533AbjGaAuz (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sun, 30 Jul 2023 20:50:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjGaAuy (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sun, 30 Jul 2023 20:50:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCCB5E78
        for <linux-ide@vger.kernel.org>; Sun, 30 Jul 2023 17:50:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1A73360DFE
        for <linux-ide@vger.kernel.org>; Mon, 31 Jul 2023 00:50:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E613C433C8;
        Mon, 31 Jul 2023 00:50:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690764652;
        bh=IUgO5SAtNJMoIUd6NFu7Xra6yOFnnThgub8TtzuVEls=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=ClT1F5VLavPuVP0JGu6K00pXw8EuvyKc2xbmwQrPOwBeOz8J2R+jIAXsyxRKpSjJ8
         2W0xVQVfm6NEfhcXDJ5KMi0HFIwP5EIDf0Q/gLunGfy1NoyEGSaGAH8gyIb4NS/OhX
         Mmrxc9D4+WXYqzYRDMv+HGtWJ1soKnlmp8XwpSi0hMKempTIes5bi2y/hr8WeU2VVP
         VbQPidoJKR6/SmaqdMEKrN9VNT4lGb+dvt13/U8kkxdmSMRfM9+zvnUp4aWlnGjAOa
         of6pcyd/F+hsXYKqX+kGywtW9CIAmLUubwmvU22t/5ZzoWlLv7evgWq7tS5DcQ/rIE
         txL1cemTDW+0w==
Message-ID: <5c1cbcd3-2a63-b7cf-410d-ebb8f4219a8e@kernel.org>
Date:   Mon, 31 Jul 2023 09:50:51 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 0/8] Fix the remaining sloppy timeout typing in libata
Content-Language: en-US
To:     Sergey Shtylyov <s.shtylyov@omp.ru>, linux-ide@vger.kernel.org
References: <20230729201753.37600-1-s.shtylyov@omp.ru>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20230729201753.37600-1-s.shtylyov@omp.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 7/30/23 05:17, Sergey Shtylyov wrote:
> Here are 8 patches against the 'for-next' branch of Damien's 'libata.git' repo.
> 
> The libata code still often uses the 'unsigned long' type for the millisecond
> timeouts, while the kernel functions like msecs_to_jiffies() or msleep() only
> take 'unsigned int' parameters for those. I've started fixing the timeout types
> from ata_exec_internal[_sg]() that tripped the Svace static analyzer and posted
> couple patches, promising to post a large continuation series somewhat later...
> in my worst nightmare I couldn't imagine that this would take a whole year! :-(
> 
> Sergey Shtylyov (8):
>   ata: libata: fix parameter type of ata_deadline()
>   ata: libata-core: fix parameter types of ata_wait_register()
>   ata: libata-eh: fix reset timeout type
>   ata: fix debounce timings type
>   ata: libata-scsi: fix timeout type in ata_scsi_park_store()
>   ata: libahci: fix parameter type of ahci_exec_polled_cmd()
>   ata: ahci_xgene: fix parameter types of xgene_ahci_poll_reg_val()
>   ata: sata_sil24: fix parameter type of sil24_exec_polled_cmd()

Applied to for-6.6. Thanks !


-- 
Damien Le Moal
Western Digital Research

