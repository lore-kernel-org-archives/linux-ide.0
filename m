Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28EF4CDB482
	for <linux-ide@archiver.kernel.org>; Fri, 13 Oct 2023 15:14:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232297AbjJMPOL (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 13 Oct 2023 11:14:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232273AbjJMPOL (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 13 Oct 2023 11:14:11 -0400
Received: from vps.thesusis.net (vps.thesusis.net [34.202.238.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6128CBB
        for <linux-ide@vger.kernel.org>; Fri, 13 Oct 2023 08:14:10 -0700 (PDT)
Received: by vps.thesusis.net (Postfix, from userid 1000)
        id A6F3E144856; Fri, 13 Oct 2023 11:14:09 -0400 (EDT)
From:   Phillip Susi <phill@thesusis.net>
To:     Damien Le Moal <dlemoal@kernel.org>, linux-ide@vger.kernel.org
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 2/2] ata: libata-core: Improve ata_dev_power_set_active()
In-Reply-To: <20231012071800.468868-3-dlemoal@kernel.org>
References: <20231012071800.468868-1-dlemoal@kernel.org>
 <20231012071800.468868-3-dlemoal@kernel.org>
Date:   Fri, 13 Oct 2023 11:14:09 -0400
Message-ID: <87y1g6ftby.fsf@vps.thesusis.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Damien Le Moal <dlemoal@kernel.org> writes:
>  /**
>   *	ata_dev_power_set_active -  Set a device power mode to active
>   *	@dev: target device
> @@ -2065,6 +2092,13 @@ void ata_dev_power_set_active(struct ata_device *dev)
>  	if (!ata_dev_power_init_tf(dev, &tf, true))
>  		return;
>  
> +	/*
> +	 * Check the device power state & condition and force a spinup with
> +	 * VERIFY command only if the drive is not already ACTIVE or IDLE.
> +	 */
> +	if (ata_dev_power_is_active(dev))
> +		return;
> +
>  	ata_dev_notice(dev, "Entering active power mode\n");
>  
>  	err_mask = ata_exec_internal(dev, &tf, NULL, DMA_NONE, NULL, 0, 0);

This bit didn't apply cleanly to what I just pulled from Linus.  It
seems there are soem differences in how the tf is set up.  Why not move
this check to before the tf is set up?  There isn't much point in
setting it up if it isn't going to be used.
