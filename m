Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35015C433EF
	for <linux-ide@archiver.kernel.org>; Wed,  5 Jan 2022 07:31:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238059AbiAEHba (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 5 Jan 2022 02:31:30 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:60462 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231343AbiAEHba (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 5 Jan 2022 02:31:30 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 3D5BE1F37F;
        Wed,  5 Jan 2022 07:31:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1641367889; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3azRTeXNrjUG38dYH82IHd0dX8VPEqydYLhXkrQeFjU=;
        b=ya3uaegf+TwTeBv6gu9iKaCtn66xWZ7RFduMtWpQY+xGGwBt5r5riDVsDbX3qyoUMSyx6K
        qp1ZYWyX36LSfuhgwjqGzwWg8zZx+iLYJGhk2voy8P0+D2DC9yhY9huO5QgyIBST4myB8N
        3Ln9aWLFxKCviyYjwG5esjxJ93pQmWo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1641367889;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3azRTeXNrjUG38dYH82IHd0dX8VPEqydYLhXkrQeFjU=;
        b=dxUshfmb/iNmaazBUe+AJmM1hbLZa0MxZA3JVmh4evTKaZeLAQOB1e/F79G0D66TLyqojk
        EUAzmIqQM4RIghAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 27C7213B8F;
        Wed,  5 Jan 2022 07:31:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id xIlFCFFJ1WFXDgAAMHmgww
        (envelope-from <hare@suse.de>); Wed, 05 Jan 2022 07:31:29 +0000
Message-ID: <67a3cdc2-378d-15c4-6562-d17061f379aa@suse.de>
Date:   Wed, 5 Jan 2022 08:31:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v3 22/22] ata: fix read_id() ata port operation interface
Content-Language: en-US
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        linux-ide@vger.kernel.org
References: <20220105051735.1871177-1-damien.lemoal@opensource.wdc.com>
 <20220105051735.1871177-23-damien.lemoal@opensource.wdc.com>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <20220105051735.1871177-23-damien.lemoal@opensource.wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 1/5/22 06:17, Damien Le Moal wrote:
> Drivers that need to tweak a device IDENTIFY data implement the
> read_id() port operation. The IDENTIFY data buffer is passed as an
> argument to the read_id() operation for drivers to use. However, when
> this operation is called, the IDENTIFY data is not yet converted to CPU
> endian and contains le16 words.
> 
> Change the interface of the read_id operation to pass a __le16 * pointer
> to the IDENTIFY data buffer to clarify the buffer endianness. Fix the
> pata_netcell, pata_it821x, ahci_xgene, ahci_ceva and ahci_brcm drivers
> implementation of this operation and modify the code to corretly deal
> with identify data words manipulation to avoid sparse warnings such as:
> 
> drivers/ata/ahci_xgene.c:262:33: warning: invalid assignment: &=
> drivers/ata/ahci_xgene.c:262:33:    left side has type unsigned short
> drivers/ata/ahci_xgene.c:262:33:    right side has type restricted __le16
> 
> Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
> ---
>   drivers/ata/ahci_brcm.c    |  2 +-
>   drivers/ata/ahci_ceva.c    |  5 ++---
>   drivers/ata/ahci_xgene.c   |  2 +-
>   drivers/ata/libata-core.c  |  6 +++---
>   drivers/ata/pata_it821x.c  | 23 +++++++++++------------
>   drivers/ata/pata_netcell.c |  5 +++--
>   include/linux/libata.h     |  5 +++--
>   7 files changed, 24 insertions(+), 24 deletions(-)
> Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
