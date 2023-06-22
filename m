Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFEA5EB64DA
	for <linux-ide@archiver.kernel.org>; Thu, 22 Jun 2023 23:49:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230237AbjFVXtQ (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 22 Jun 2023 19:49:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231282AbjFVXtP (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 22 Jun 2023 19:49:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E34BD2125
        for <linux-ide@vger.kernel.org>; Thu, 22 Jun 2023 16:49:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8097061935
        for <linux-ide@vger.kernel.org>; Thu, 22 Jun 2023 23:49:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A78B0C433C8;
        Thu, 22 Jun 2023 23:49:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687477753;
        bh=NgtpXHOz2UlRysL1SsmARbtKH4Rp3/d/XDOt/iR+xTw=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=SHx3HCAO7xtcD2OSZX4ADP5rTBy4HqXIO2KZ4lMKa8BkX14tpWTnUe/NkonewOWeq
         /CqvaKnjOsAX4e4p6o3RsPUDjMdRzkiPi//+T6SWO6z7g+hKj9fYYX3CDfUowvoGm+
         2vXqx8uE9t69ntIMcLSdNzACoikaFDkLsJt3N4yLWFtHFU+nzWUAhL6DRZvyfzfoZ4
         wY8giRcCudlaZPJIwj2kFi0wYFIZQ9QFCtvlb62hmX2sJBVjn6b8UO0Es0YnEKJ1B2
         a+wmPUFwva+GH39GoY4hyORDB7r4aQo4rNgYIvOb0+rHg1sjdxLxwe68fjhQLFSdUV
         hTICkR/OB8bbw==
Message-ID: <7f8b4eaf-e227-a069-a3c9-3deecf0e5c5a@kernel.org>
Date:   Fri, 23 Jun 2023 08:49:12 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
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

We could merge patches 1-5 together as core updates, followed by driver patches.

Anyway, looks all OK to me but we are a little too close to the merge window. So
I will apply this once we have 6.5-rc1.

> 
>  drivers/ata/ahci.c          |  2 +-
>  drivers/ata/ahci_qoriq.c    |  2 +-
>  drivers/ata/ahci_xgene.c    |  7 +++----
>  drivers/ata/libahci.c       |  7 ++++---
>  drivers/ata/libata-core.c   |  6 +++---
>  drivers/ata/libata-eh.c     |  6 +++---
>  drivers/ata/libata-sata.c   | 16 ++++++++--------
>  drivers/ata/libata-scsi.c   |  4 ++--
>  drivers/ata/libata-sff.c    |  2 +-
>  drivers/ata/sata_highbank.c |  2 +-
>  drivers/ata/sata_inic162x.c |  2 +-
>  drivers/ata/sata_mv.c       |  2 +-
>  drivers/ata/sata_nv.c       |  2 +-
>  drivers/ata/sata_sil24.c    |  4 ++--
>  include/linux/libata.h      | 24 ++++++++++++------------
>  15 files changed, 44 insertions(+), 44 deletions(-)
> 

-- 
Damien Le Moal
Western Digital Research

