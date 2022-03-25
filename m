Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85513C433EF
	for <linux-ide@archiver.kernel.org>; Fri, 25 Mar 2022 09:10:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354013AbiCYJMA (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 25 Mar 2022 05:12:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229940AbiCYJL5 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 25 Mar 2022 05:11:57 -0400
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB73CCD33F
        for <linux-ide@vger.kernel.org>; Fri, 25 Mar 2022 02:10:22 -0700 (PDT)
Received: from [192.168.0.7] (ip5f5aef76.dynamic.kabel-deutschland.de [95.90.239.118])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 8116061E64846;
        Fri, 25 Mar 2022 10:10:19 +0100 (CET)
Message-ID: <8933f892-aa56-cd21-8acc-744d9a89f66e@molgen.mpg.de>
Date:   Fri, 25 Mar 2022 10:10:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 4/4] ata: libata-sata: Improve sata_link_debounce()
Content-Language: en-US
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
References: <20220323081740.540006-1-damien.lemoal@opensource.wdc.com>
 <20220323081740.540006-5-damien.lemoal@opensource.wdc.com>
Cc:     linux-ide@vger.kernel.org
From:   Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20220323081740.540006-5-damien.lemoal@opensource.wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Dear Damien,


Am 23.03.22 um 09:17 schrieb Damien Le Moal:
> sata_link_debounce() polls the SStatus register DET field to ensure that
> a stable value is provided, to reliably detect device presence and PHY
> readiness. Polling is done for at least timing->duration if there is no
> device detected. For the device detected case, polling last up to

last*s*

> deadline to ensure that the PHY becomes ready.
> 
> However, the PHY ready state is actually never checked, leading to the
> poll loop duration always reaching the maximum duration.
> 
> For adapters that do not require a debounce delay (link flag
> ATA_LFLAG_DEBOUNCE_DELAY no set), add a check to test if DET indicates

no*t*?

> device present *and* PHY ready and bail out of the polling loop if it
> does.
> 
> While at it, add comments to clarify the various checks in
> sata_link_debounce() polling loop.

Were you able to verify that the check now terminates the loop on your 
devices earlier?

Are below the right lines to compare? On the Dell OptiPlex 5055 (AMD FCH 
SATA Controller [AHCI mode] [1022:7901]) I see:

Before (this very patch)

     [    0.428015] ata1: hard resetting link
     [    0.696316] ata1: SATA link up 6.0 Gbps (SStatus 133 SControl 300)

After:

     [    0.428907] ata1: hard resetting link
     [    0.648092] ata1: SATA link up 6.0 Gbps (SStatus 133 SControl 300)

So a decrease of (268 - 219 = 49) ms. Nice.

> Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
> ---
>   drivers/ata/libata-sata.c | 24 ++++++++++++++++++++++--
>   1 file changed, 22 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/ata/libata-sata.c b/drivers/ata/libata-sata.c
> index 87ad03c2e49f..15423723c9dd 100644
> --- a/drivers/ata/libata-sata.c
> +++ b/drivers/ata/libata-sata.c
> @@ -276,8 +276,27 @@ int sata_link_debounce(struct ata_link *link,
>   
>   		/* DET stable? */
>   		if (cur == last) {
> +			/*
> +			 * If the device presence was detected but PHY
> +			 * communication is not yet established, wait until
> +			 * deadline.
> +			 */
>   			if (cur == 1 && time_before(jiffies, deadline))
>   				continue;
> +
> +			/*
> +			 * If PHY is ready and the device is present, and the
> +			 * driver did not request debounce delay, bail out early
> +			 * assuming that the link is stable.
> +			 */
> +			if (cur == 3 &&
> +			    !(link->flags & ATA_LFLAG_DEBOUNCE_DELAY))
> +				return 0;
> +
> +			/*
> +			 * If DET value has remained stable for
> +			 * timing->duration, bail out.
> +			 */
>   			if (time_after(jiffies,
>   				ata_deadline(last_jiffies, timing->duration)))
>   				return 0;
> @@ -288,8 +307,9 @@ int sata_link_debounce(struct ata_link *link,
>   		last = cur;
>   		last_jiffies = jiffies;
>   
> -		/* Check deadline.  If debouncing failed, return
> -		 * -EPIPE to tell upper layer to lower link speed.
> +		/*
> +		 * If debouncing has not succeeded before dealine, return

dea*d*line

> +		 * -EPIPE to tell the upper layer to lower the link speed.
>   		 */
>   		if (time_after(jiffies, deadline))
>   			return -EPIPE;

One separate for the new check would have been nice, but looks good to 
me overall.


Kind regards,

Paul
