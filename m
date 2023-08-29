Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 282B6C71153
	for <linux-ide@archiver.kernel.org>; Tue, 29 Aug 2023 06:11:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229802AbjH2GK6 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 29 Aug 2023 02:10:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231591AbjH2GKb (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 29 Aug 2023 02:10:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF0A41B1
        for <linux-ide@vger.kernel.org>; Mon, 28 Aug 2023 23:10:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 23E6B645E3
        for <linux-ide@vger.kernel.org>; Tue, 29 Aug 2023 06:09:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 457CBC433C8;
        Tue, 29 Aug 2023 06:09:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693289390;
        bh=kvkOCNnr0kvo/6zM4NJkINFgP+183xABBPFtGcJbAbc=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=OQ7aieNRX1OYvYBZCKvZjgL0Al6xSg9llBz/TFiZfCSHMFXERN3alkQoqeKW//TnG
         7deZY8XpRfLxAqWD/V07IEUSyhThHCFKNKdrnWqylnGRBoH/FB10iAv6gS5LVVkoeZ
         yrsjlOnQVVIGv0EiGi9LNqmnaLdg9uc4a/WLN7510NNM/ihoFLMafCcV5UYgKgPWdk
         MuY/ikDNMjptOfUcdLG0QQqv2qHtl+07R1xik86MPFNJ30R0AolKJOhwCIYTJpiuLy
         abx7tXp3O9x27ZJQzwj29f2BccPiqg6fIwQk2F93C905vHW9wWEXb4sUZ+GcbyvdRy
         /o+HO+zDRyb3Q==
Message-ID: <a74207b7-64e9-c01c-ee9a-5269c6be41af@kernel.org>
Date:   Tue, 29 Aug 2023 15:09:49 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] ata: Add Elkhart Lake AHCI controller
Content-Language: en-US
To:     Werner Fischer <devlists@wefi.net>, linux-ide@vger.kernel.org
References: <7728fa4b6027269d468f6a0665017c187471a9cd.camel@wefi.net>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <7728fa4b6027269d468f6a0665017c187471a9cd.camel@wefi.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 8/28/23 20:55, Werner Fischer wrote:
> Elkhart Lake is the successor of Apollo Lake and Gemini Lake. These
> CPUs and their PCHs are used in mobile and embedded environments.
> 
> With this patch I suggest that Elkhart Lake SATA controllers [1] should
> use the default LPM policy for mobile chipsets.
> The disadvantage of missing hot-plug support with this setting should
> not be an issue, as those CPUs are used in embedded environments and
> not in servers with hot-plug backplanes.
> 
> We discovered that the Elkhart Lake SATA controllers have been missing
> in ahci.c after a customer reported the throttling of his SATA SSD
> after a short period of higher I/O. We determined the high temperature
> of the SSD controller in idle mode as the root cause for that.
> 
> Depending on the used SSD, we have seen up to 1.8 Watt lower system
> idle power usage and up to 30°C lower SSD controller temperatures in
> our tests, when we set med_power_with_dipm manually. I have provided a
> table showing seven different SATA SSDs from ATP, Intel/Solidigm and
> Samsung [2].
> 
> Intel lists a total of 3 SATA controller IDs (4B60, 4B62, 4B63) in [1]
> for those mobile PCHs.
> This commit just adds 0x4b63 as I do not have test systems with 0x4b60
> and 0x4b62 SATA controllers.

Adding a mention about the other 2 IDs in a comment would be nice.

> I have tested this patch with a system which uses 0x4b63 as SATA
> controller.
> 
> [1] https://sata-io.org/product/8803
> [2] https://www.thomas-krenn.com/en/wiki/SATA_Link_Power_Management#Example_LES_v4
> 
> Signed-off-by: Werner Fischer <devlists@wefi.net>
> Cc: stable@vger.kernel.org
> 
> --- a/drivers/ata/ahci.c        2023-07-27 11:45:21.141511943 +0200
> +++ b/drivers/ata/ahci.c        2023-07-27 11:44:57.054711402 +0200
> @@ -421,6 +421,7 @@
>         { PCI_VDEVICE(INTEL, 0x34d3), board_ahci_low_power }, /* Ice Lake LP AHCI */
>         { PCI_VDEVICE(INTEL, 0x02d3), board_ahci_low_power }, /* Comet Lake PCH-U AHCI */
>         { PCI_VDEVICE(INTEL, 0x02d7), board_ahci_low_power }, /* Comet Lake PCH RAID */
> +       { PCI_VDEVICE(INTEL, 0x4b63), board_ahci_low_power }, /* Elkhart Lake AHCI */
>  
>         /* JMicron 360/1/3/5/6, match class to avoid IDE function */
>         { PCI_VENDOR_ID_JMICRON, PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID,
> 

-- 
Damien Le Moal
Western Digital Research

