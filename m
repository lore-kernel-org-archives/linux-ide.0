Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0386CC77B7C
	for <linux-ide@archiver.kernel.org>; Mon, 22 May 2023 00:46:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229550AbjEVAqV (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sun, 21 May 2023 20:46:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjEVAqU (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sun, 21 May 2023 20:46:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E947CC5
        for <linux-ide@vger.kernel.org>; Sun, 21 May 2023 17:46:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 87EDF61856
        for <linux-ide@vger.kernel.org>; Mon, 22 May 2023 00:46:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A376BC433D2;
        Mon, 22 May 2023 00:46:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684716378;
        bh=cicWLSkkgem4nXK5eUmJQYSPhxT3PQJwZ6kuMgyRvJM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=T8TnEV6Q2/VOuSvEKKdw9nOQggEFvd/8QkpH/R4Jh140dLxxIfnH2hszia7ioPu3L
         4pDp4Xi1H5qcWuOz7r5fAyAXVW/eneEllcDnYi4QQg3y1vjJH1jCDRvdUhA2PyuCfB
         80Bhbt2gahLzBz+Gka2bV5gNeBxJrLcupvkdLbN9B8HZoEwQdjxaHJDVJ7xgZw0eXm
         xKs9wPDHs+ZqJhzmRt7BBF7i73aD57xM2QEJbI1QjuYJ19CnoqAyHjtuWG2y6W+Ezm
         0UwCVavQmnBx1ElMK7uOmSBRMtl9m7J1HF+AQS4EaEhqSqYNOvyByLHkd5U4VE8RaO
         ZXrAePw4oyQ/Q==
Message-ID: <a8083851-dc1e-25bd-9790-2c5f8a851c02@kernel.org>
Date:   Mon, 22 May 2023 09:46:17 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 0/6] libata: remove references to 'old' error handler
Content-Language: en-US
To:     Hannes Reinecke <hare@suse.de>
Cc:     linux-ide@vger.kernel.org
References: <20230510225211.111113-1-hare@suse.de>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20230510225211.111113-1-hare@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 5/11/23 07:52, Hannes Reinecke wrote:
> Hi all,
> 
> now that the ipr driver has been modified to not hook into libata
> all drivers now use the 'new' error handler, so we can remove any
> references to it. And do a general cleanup to remove callbacks
> which are no longer needed.

Hannes,

Are you sending a v2 to address the comments ?

> 
> Hannes Reinecke (6):
>   ata: remove reference to non-existing error_handler()
>   ata,scsi: remove ata_sas_port_{start,stop} callbacks
>   ata,scsi: remove ata_sas_port_destroy()
>   ata: remove ata_sas_sync_probe()
>   ata: inline ata_port_probe()
>   ata,scsi: cleanup ata_port_probe()
> 
>  drivers/ata/libata-core.c          | 166 +++++++++++------------------
>  drivers/ata/libata-eh.c            | 148 +++++++++++--------------
>  drivers/ata/libata-sata.c          |  77 -------------
>  drivers/ata/libata-scsi.c          |  21 +---
>  drivers/ata/libata-sff.c           |  32 +++---
>  drivers/ata/libata.h               |   2 -
>  drivers/scsi/libsas/sas_ata.c      |   6 +-
>  drivers/scsi/libsas/sas_discover.c |   2 +-
>  include/linux/libata.h             |   6 +-
>  9 files changed, 143 insertions(+), 317 deletions(-)
> 

-- 
Damien Le Moal
Western Digital Research

