Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AA0FEB64DD
	for <linux-ide@archiver.kernel.org>; Mon, 17 Jul 2023 00:51:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230343AbjGQAvu (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sun, 16 Jul 2023 20:51:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbjGQAvt (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sun, 16 Jul 2023 20:51:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AC15F7
        for <linux-ide@vger.kernel.org>; Sun, 16 Jul 2023 17:51:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1D6D060EE2
        for <linux-ide@vger.kernel.org>; Mon, 17 Jul 2023 00:51:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35E21C433C8;
        Mon, 17 Jul 2023 00:51:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689555107;
        bh=NuqU8+lcC8YajnLpO88ZF82xcTUECrV3/qLpTqFdZeI=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=RjwGTQRZbTkblN7u3JOmEQNQxTHFWNVnsiuvhimMQsqDkWBtI3397n3IH+uBX+smv
         417tJr62s+s4ClZKy0MRrnDOo+pEduAXa7HxeWpOWZWO2tVS+B+Av9tX0J5rbuP+6L
         Rfb0BBy+Z+OX/Tk1hKxBR0vzgLaDylElxZMRoPaNhTANuW8mNvJRg/NShJ9j5L5BwX
         rux6WQCATXB6wWCYpqn7ljxniCeo9HyphNszh6NcI7/GOi3RjsMroZ63zFcGaCtTQX
         3zq1mCwKDo/rXtkxnHfiQ9RXzZz0BRBVs2gV8PLuecSlS0m+WnqpoPaeEw5cg0fywJ
         KAEwmYU5QHODA==
Message-ID: <076da05c-54ad-3a6a-ffbd-5cc08826a9a4@kernel.org>
Date:   Mon, 17 Jul 2023 09:51:46 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 0/8] Fix the remaining sloppy timeout typing in libata
Content-Language: en-US
To:     Sergey Shtylyov <s.shtylyov@omp.ru>, linux-ide@vger.kernel.org
References: <20230616194607.7351-1-s.shtylyov@omp.ru>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20230616194607.7351-1-s.shtylyov@omp.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 6/17/23 04:45, Sergey Shtylyov wrote:
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

Sergey,

This does not apply cleanly to for-6.6 branch. Could you rebase and resend please ?

-- 
Damien Le Moal
Western Digital Research

