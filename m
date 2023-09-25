Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3496CE7A81
	for <linux-ide@archiver.kernel.org>; Mon, 25 Sep 2023 09:09:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232574AbjIYJJL (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 25 Sep 2023 05:09:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232570AbjIYJJK (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 25 Sep 2023 05:09:10 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C6B0C0
        for <linux-ide@vger.kernel.org>; Mon, 25 Sep 2023 02:09:04 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 348F6C433C9;
        Mon, 25 Sep 2023 09:09:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695632943;
        bh=9TDoXCpiSQ/fdgN7iAQWOdd3o49qrknWA8BRwWH0l2U=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=hPt5X2//G63I3AFSBYR1F04yhIp3xU+W/lyCat4bqIWQwQPnrRJR0L8lwRgoRuS5j
         /+Bhm5BLWokdPiojfAW5tPJYfIU9Zr8JM7nXfyZDlfu1Qn/XkaelTjIN9Hgls/yFgf
         R6SmT2kgek3nRYH6jEFHsuU4yXPB69DZ44gr1PUX/fleHUFKtZ33HKvDpuYi4RvWYv
         6OggT9uMGq/EzuuIvl+T60JD20bRiHLbFGvqkgoYM0bcnYTLMkeY4cL8EElhdCD447
         OpgxoOpFgAvm9mJSnNJ4fh5nxAixY2O+4tb4RGq3DxSaUhNbh+vHk5x74Gn0Jw+UHK
         1YWl8cG4l/THw==
Message-ID: <e58ddf0f-3b7e-9599-dd7d-c6ed322d1184@kernel.org>
Date:   Mon, 25 Sep 2023 11:09:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH] ata: ahci: Add Intel Alder Lake-P AHCI controller to low
 power chipsets list
Content-Language: en-US
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     linux-ide@vger.kernel.org, Koba Ko <koba.ko@canonical.com>
References: <20230925080538.2894982-1-mika.westerberg@linux.intel.com>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20230925080538.2894982-1-mika.westerberg@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 2023/09/25 10:05, Mika Westerberg wrote:
> Intel Alder Lake-P AHCI controller needs to be added to the mobile
> chipsets list in order to have link power management enabled. Without
> this the CPU cannot enter lower power C-states making idle power
> consumption high.
> 
> Cc: Koba Ko <koba.ko@canonical.com>
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Looks OK, but given that there is a tendency of the low power stuff to be buggy,
was this well tested ? Also, does this need a Fixes/CC stable tag ? If not, I
will queue this for 6.7.

> ---
>  drivers/ata/ahci.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
> index 08745e7db820..d96f80b6ff5d 100644
> --- a/drivers/ata/ahci.c
> +++ b/drivers/ata/ahci.c
> @@ -423,6 +423,7 @@ static const struct pci_device_id ahci_pci_tbl[] = {
>  	{ PCI_VDEVICE(INTEL, 0x02d7), board_ahci_low_power }, /* Comet Lake PCH RAID */
>  	/* Elkhart Lake IDs 0x4b60 & 0x4b62 https://sata-io.org/product/8803 not tested yet */
>  	{ PCI_VDEVICE(INTEL, 0x4b63), board_ahci_low_power }, /* Elkhart Lake AHCI */
> +	{ PCI_VDEVICE(INTEL, 0x7ae2), board_ahci_low_power }, /* Alder Lake-P AHCI */
>  
>  	/* JMicron 360/1/3/5/6, match class to avoid IDE function */
>  	{ PCI_VENDOR_ID_JMICRON, PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID,

-- 
Damien Le Moal
Western Digital Research

