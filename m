Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E668AEB8FAD
	for <linux-ide@archiver.kernel.org>; Wed,  6 Sep 2023 09:30:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234142AbjIFJaZ (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 6 Sep 2023 05:30:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235994AbjIFJaY (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 6 Sep 2023 05:30:24 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FDDE1719
        for <linux-ide@vger.kernel.org>; Wed,  6 Sep 2023 02:29:40 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id D569722443;
        Wed,  6 Sep 2023 09:29:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1693992561; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZUxV8egm0We5+8rUJPvQPFrvmGXcZNy+Frq47r/fAY8=;
        b=V05zQI0CDKHAgZ0e4qSsTE7nXHor+wEFkOIlLRV5+kBa4vQxAD/ddp9l7rjGV4RTbVEmvd
        TPqfG7DlAzf5uV2sJ3bhvqLKi5NstGkqE64VwU2xROjE2fPajslnX5xxk6afVKfaAmoabM
        C4zZtfWpz4304Vm7xJr7lkFKULxsE8Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1693992561;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZUxV8egm0We5+8rUJPvQPFrvmGXcZNy+Frq47r/fAY8=;
        b=aRtVTcL2piTBIS9vhVX79oerl7dLUvZ5BDXCoAKfWwdgWiAZInfSqK9XktodW4QxPwJYq5
        oh6fUr+7ZiGPFcCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B9E801333E;
        Wed,  6 Sep 2023 09:29:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 2w4wLHFG+GQTDwAAMHmgww
        (envelope-from <hare@suse.de>); Wed, 06 Sep 2023 09:29:21 +0000
Message-ID: <5755ea72-ec44-4f2f-b0da-8069cb169fe9@suse.de>
Date:   Wed, 6 Sep 2023 11:29:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ata: ahci: print the lpm policy on boot
Content-Language: en-US
To:     Niklas Cassel <nks@flawful.org>,
        Damien Le Moal <dlemoal@kernel.org>
Cc:     Niklas Cassel <niklas.cassel@wdc.com>, linux-ide@vger.kernel.org
References: <20230905124909.3334046-1-nks@flawful.org>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <20230905124909.3334046-1-nks@flawful.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 9/5/23 14:49, Niklas Cassel wrote:
> From: Niklas Cassel <niklas.cassel@wdc.com>
> 
> The target LPM policy can be set using either a Kconfig or a kernel module
> parameter.
> 
> However, if the board type is set to anything but board_ahci_low_power,
> then the LPM policy will overridden and set to ATA_LPM_UNKNOWN.
> 
> Additionally, if the default suspend is suspend to idle, depending on the
> hardware capabilities of the HBA, ahci_update_initial_lpm_policy() might
> override the LPM policy to either ATA_LPM_MIN_POWER_WITH_PARTIAL or
> ATA_LPM_MIN_POWER.
> 
> All this means that it is very hard to know which LPM policy a user will
> actually be using on a given system.
> 
> In order to make it easier to debug LPM related issues, print the LPM
> policy on boot.
> 
> One common LPM related issue is that the device fails to link up.
> Because of that, we cannot add this print to ata_dev_configure(), as that
> function is only called after a successful link up. Instead, add the info
> using ata_port_desc(). The port description is printed once during boot.
> 
> Before changes:
> ata1: SATA max UDMA/133 abar m524288@0xa5780000 port 0xa5780100 irq 170
> ata2: SATA max UDMA/133 abar m524288@0xa5780000 port 0xa5780180 irq 170
> 
> After changes:
> ata1: SATA max UDMA/133 abar m524288@0xa5780000 port 0xa5780100 lpm-pol 4 irq 170
> ata2: SATA max UDMA/133 abar m524288@0xa5780000 port 0xa5780180 lpm-pol 4 irq 170
> 
> Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>
> ---
>   drivers/ata/ahci.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
> index abb5911c9d09..541f6ec7f395 100644
> --- a/drivers/ata/ahci.c
> +++ b/drivers/ata/ahci.c
> @@ -1898,6 +1898,7 @@ static int ahci_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
>   			ap->em_message_type = hpriv->em_msg_type;
>   
>   		ahci_update_initial_lpm_policy(ap, hpriv);
> +		ata_port_desc(ap, "lpm-pol %d", ap->target_lpm_policy);
>   
>   		/* disabled/not-implemented port */
>   		if (!(hpriv->port_map & (1 << i)))

Hmm. Not very instructive ('pol 4' ?).
Please use a string mapping here to translate it into something 
human-readable.
Also one might consider a sysfs attribute to retrieve the information
from userspace.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman

