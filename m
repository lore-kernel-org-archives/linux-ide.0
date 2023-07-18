Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD742EB64DC
	for <linux-ide@archiver.kernel.org>; Tue, 18 Jul 2023 10:46:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229625AbjGRKqH (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 18 Jul 2023 06:46:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229811AbjGRKqG (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 18 Jul 2023 06:46:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C51F189;
        Tue, 18 Jul 2023 03:46:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CBD0D6150C;
        Tue, 18 Jul 2023 10:46:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6C48C433C7;
        Tue, 18 Jul 2023 10:46:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689677164;
        bh=NP8hk+WVflZAzc8MTekAOt7HnsMBveyW+5Dxwu+GBX0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=rRayySnLiFad+UOmpBaN2mLBnxnQh1wllU8eTCNLufhk78DLxJBFIdesN6gKVzT8D
         2QTNUxZ/mvaU9NW7feMxVB2RWb45upzDZp6ctvJVNjZjIyrnVXvW/l0i9VabOimkYY
         ngTF7morzLcEPF+E40V7aYYHxMFSa3G1O2RpoGRYepVY3xztihhQ5CBshdh1iq5dDq
         0VVpcaNIkbhnEos87Ubki5fW3izjRCVeM9qfeLwy1IXLsujPLTonRC8+SXNy0IzmXa
         FkClfe8Q5SjrbAf4Zx5l+ls3zATGyOhNdjHu53+jzzwADUnXRV6zhnAGEhIBB4VR4b
         CKgTSyyzBCqSA==
Message-ID: <da716584-253b-8c8e-ff28-7ba207d0bd7d@kernel.org>
Date:   Tue, 18 Jul 2023 19:46:02 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] ata: remove whitespace after '(' and before ')'
Content-Language: en-US
To:     hanyu001@208suo.com
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <tencent_6714ED434F83826DD33A8EE7B99064165309@qq.com>
 <07f7ac9c59d027f959a69836fee9940c@208suo.com>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <07f7ac9c59d027f959a69836fee9940c@208suo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 7/18/23 17:53, hanyu001@208suo.com wrote:
> This patch fixes the following checkpatch errors:

The subject should be:

ata: pata_sis: xxx

But in any case, the above message says that this is a warning from checkpatch.
But what are you patching to get this ? If you run checkpatch directly on
drivers/ata/pata_sis.c, you will get *a lot* more warnings than just this. And I
would not want patches to fix that, unless the warnings are also generated with
"make W=1" or "make C=1".

If you actually fix a bug in this driver that touches code around the lines you
touch, then it is fine to fix that to avoid the warnings, but not just for the
sake of it. libata code overall has a lot of code style issues that will trigger
checkpatch warnings. When code is changed, fixing the code style at the same
time is fine.

Exception to this is again if you see warnings with "make W=1" or "make C=1". I
applied a lot of patches recently to fix the code style in the pata_parport
protocol modules because they were generating compilation warnings.

> 
> ./drivers/ata/pata_sis.c:691: ERROR: space prohibited after that open 
> parenthesis '('
> ./drivers/ata/pata_sis.c:691: ERROR: space prohibited before that close 
> parenthesis ')'
> 
> Signed-off-by: Yu Han <	hanyu001@208suo.com>
> ---
>   drivers/ata/pata_sis.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/ata/pata_sis.c b/drivers/ata/pata_sis.c
> index 31de06b..2019777 100644
> --- a/drivers/ata/pata_sis.c
> +++ b/drivers/ata/pata_sis.c
> @@ -688,7 +688,7 @@ static void sis_fixup(struct pci_dev *pdev, struct 
> sis_chipset *sis)
> 
>       if (sis->info == &sis_info33) {
>           pci_read_config_byte(pdev, PCI_CLASS_PROG, &reg);
> -        if (( reg & 0x0F ) != 0x00)
> +        if ((reg & 0x0F) != 0x00)
>               pci_write_config_byte(pdev, PCI_CLASS_PROG, reg & 0xF0);
>           /* Fall through to ATA16 fixup below */
>       }

-- 
Damien Le Moal
Western Digital Research

