Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77CCBC433F5
	for <linux-ide@archiver.kernel.org>; Tue,  4 Jan 2022 11:46:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230415AbiADLqi (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 4 Jan 2022 06:46:38 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:53008 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229886AbiADLqh (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 4 Jan 2022 06:46:37 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id C3BE521129;
        Tue,  4 Jan 2022 11:46:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1641296796; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UcCWQy5gRIBTag36TyQOJOfOKhytZBmxdV46m6QP0/s=;
        b=CMCgVHl3qV4W9D7Rv5Lo1kiDmK8+jysVnIVmOvfRNCj/GnygrmLC7YMsaLe7FLPbSiGcDl
        2oIs74b9TaGec0mrs86ohD7Y/C7xB8sT46ghAAETPrvNSuwBDLfw+omZx39EfwPu6HruaE
        HJ3Km9TKToKsJqSDiSJ59WTOXS/jOMc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1641296796;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UcCWQy5gRIBTag36TyQOJOfOKhytZBmxdV46m6QP0/s=;
        b=SJfHgvHp3fXK6JPOV+XAt0wGs9TEPSAedLaxqVkP4OUkFxW0DF3xqvrxe89Zvr8IN3e4wK
        vElDA0oyatlMuUCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BAF0D13AF4;
        Tue,  4 Jan 2022 11:46:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id XGtTLZwz1GF1QgAAMHmgww
        (envelope-from <hare@suse.de>); Tue, 04 Jan 2022 11:46:36 +0000
Subject: Re: [PATCH v2 21/22] ata: ahci_xgene: use correct type for port mmio
 address
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        linux-ide@vger.kernel.org
References: <20220104105843.1730172-1-damien.lemoal@opensource.wdc.com>
 <20220104105843.1730172-22-damien.lemoal@opensource.wdc.com>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <96ca46d6-b4db-80f6-7783-0318d1768e3f@suse.de>
Date:   Tue, 4 Jan 2022 12:46:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20220104105843.1730172-22-damien.lemoal@opensource.wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 1/4/22 11:58 AM, Damien Le Moal wrote:
> Sparse complains about an incorrect type for port_mmio pointer
> variables:
> 
> drivers/ata/ahci_xgene.c:196:41: warning: incorrect type in initializer
> (different address spaces)
> drivers/ata/ahci_xgene.c:196:41:    expected void *port_mmio
> drivers/ata/ahci_xgene.c:196:41:    got void [noderef] __iomem *
> 
> Fix this by declaring port_mmio as "void __iomem *" instead of "void *".
> 
> Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
> ---
>  drivers/ata/ahci_xgene.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		           Kernel Storage Architect
hare@suse.de			                  +49 911 74053 688
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Felix Imendörffer
